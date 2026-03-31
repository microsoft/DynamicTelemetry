# Event-Based Throttling Design

## Leveraging Durable IDs, Flight Recorder Pattern, and .NET Log-Buffering APIs

---

## 1. Conceptual Mapping

This design maps Dynamic Telemetry's architecture onto concrete .NET 9+ APIs:

| Dynamic Telemetry Concept | .NET Realization |
|---|---|
| **Durable ID** | `[LoggerMessage]`-generated `EventId` + `EventName` |
| **Flight Recorder** | `GlobalLogBuffer` / `PerRequestLogBuffer` (circular in-memory ring buffer) |
| **Trigger** | A condition that calls `buffer.Flush()` — the bridge between observation and emission |
| **Valve / Toggle** | `LogBufferingFilterRule` entries added/removed at runtime via `IOptionsMonitor<T>` |
| **Counter / Aggregation** | Custom `LoggingSampler` subclass tracking per-Durable-ID hit rates |
| **Query Processor** | `LogBufferingFilterRule` matching on `CategoryName`, `LogLevel`, `EventId`, `EventName`, `Attributes` |
| **Probe** | `ILogger` call site — each `[LoggerMessage]` partial method is a static probe |

---

## 2. Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│  Application Code                                               │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  [LoggerMessage] Probes (Durable IDs)                    │   │
│  │  EventId=1001 "OrderCreated"                             │   │
│  │  EventId=1002 "PaymentProcessed"                         │   │
│  │  EventId=1003 "InventoryChecked"   ← each is a stable   │   │
│  │  EventId=2001 "CacheEviction"        identity            │   │
│  │  EventId=9001 "TransactionFailed"                        │   │
│  └────────────────────┬─────────────────────────────────────┘   │
│                       │ ILogger.Log(...)                        │
│                       ▼                                         │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Throttling Pipeline (in ILogger provider chain)         │   │
│  │                                                          │   │
│  │  ┌─────────────┐  ┌──────────────┐  ┌────────────────┐  │   │
│  │  │ Log Sampler  │→ │ Log Buffer   │→ │ Trigger Engine │  │   │
│  │  │ (per-ID     │  │ (Flight      │  │ (Flush         │  │   │
│  │  │  throttle)  │  │  Recorder)   │  │  Decisions)    │  │   │
│  │  └─────────────┘  └──────────────┘  └────────────────┘  │   │
│  │                                                          │   │
│  │  Rules keyed by Durable ID (EventId / EventName)         │   │
│  └──────────────────────────────────────────────────────────┘   │
│                       │                                         │
│                       ▼                                         │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  OpenTelemetry / Azure Monitor Exporter                  │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Probe emits** — `[LoggerMessage]` call writes a structured log with a Durable ID.
2. **Sampler evaluates** — A custom `LoggingSampler` checks per-Durable-ID throttle rules.
   Events that pass sampling proceed; others are dropped permanently.
3. **Buffer captures** — `LogBufferingFilterRule` matches determine if the log is held in the
   Flight Recorder (ring buffer) or emitted immediately.
4. **Trigger evaluates** — The Trigger Engine observes the stream. When a trigger condition
   fires, it calls `buffer.Flush()`, emitting all buffered context.
5. **Export** — Flushed (or non-buffered) logs flow to OpenTelemetry exporters.

---

## 3. Durable ID Foundation

Every log event MUST use source-generated `[LoggerMessage]` to guarantee a stable identity:

```csharp
public static partial class ApplicationEvents
{
    // Each method = one Durable ID = one throttle-addressable event
    [LoggerMessage(EventId = 1001, Level = LogLevel.Information,
        Message = "Order created for customer {CustomerId}, total={Total}")]
    public static partial void OrderCreated(ILogger logger, string customerId, decimal total);

    [LoggerMessage(EventId = 1002, Level = LogLevel.Information,
        Message = "Payment processed txn={TransactionId}")]
    public static partial void PaymentProcessed(ILogger logger, string transactionId);

    [LoggerMessage(EventId = 2001, Level = LogLevel.Debug,
        Message = "Cache eviction key={CacheKey} reason={Reason}")]
    public static partial void CacheEviction(ILogger logger, string cacheKey, string reason);

    [LoggerMessage(EventId = 9001, Level = LogLevel.Error,
        Message = "Transaction failed txn={TransactionId} error={ErrorCode}")]
    public static partial void TransactionFailed(ILogger logger, string transactionId, int errorCode);
}
```

**Why this matters for throttling:**
- `EventId = 2001` ("CacheEviction") can be throttled to 1% sampling independently
- `EventId = 9001` ("TransactionFailed") can be a trigger that flushes the Flight Recorder
- Rules reference `EventId` or `EventName`, never fragile message text

---

## 4. Flight Recorder via .NET Log Buffering

The .NET `GlobalLogBuffer` IS a Flight Recorder — a circular in-memory ring buffer that
holds logs until explicitly flushed or silently discarded.

### Configuration

```csharp
builder.Logging.AddGlobalBuffer(options =>
{
    // --- Flight Recorder sizing (controls "trace horizon") ---
    options.MaxBufferSizeInBytes = 64 * 1024 * 1024;  // 64 MB ring buffer
    options.MaxLogRecordSizeInBytes = 32 * 1024;       // 32 KB per record cap

    // After flush, temporarily disable buffering so post-incident
    // logs stream in real-time (the "auto-verbose window")
    options.AutoFlushDuration = TimeSpan.FromSeconds(30);

    // --- Per-Durable-ID buffer rules ---

    // Buffer ALL Information-level logs from our app (short-horizon recorder)
    options.Rules.Add(new LogBufferingFilterRule(
        categoryName: "MyApp",
        logLevel: LogLevel.Information));

    // Buffer chatty cache events specifically (high-volume, low-value)
    options.Rules.Add(new LogBufferingFilterRule(eventId: 2001));

    // Buffer debug-level diagnostics (verbose short-horizon recorder)
    options.Rules.Add(new LogBufferingFilterRule(
        categoryName: "MyApp",
        logLevel: LogLevel.Debug));

    // Note: Error/Critical are NOT in any rule → emitted immediately, always
});
```

### Per-Request Flight Recorder (ASP.NET Core)

```csharp
builder.Logging.AddPerIncomingRequestBuffer(options =>
{
    options.AutoFlushDuration = TimeSpan.FromSeconds(5);

    // Buffer request-scoped Information logs
    options.Rules.Add(new LogBufferingFilterRule(
        categoryName: "MyApp.Controllers",
        logLevel: LogLevel.Information));

    // Buffer by specific Durable ID — e.g., chatty middleware events
    options.Rules.Add(new LogBufferingFilterRule(eventId: 3001));
});
```

### Mapping to Dynamic Telemetry Flight Recorder Concepts

| Flight Recorder Concept | .NET Log Buffering Realization |
|---|---|
| **Short Horizon** | Small `MaxBufferSizeInBytes` + generous `LogLevel` filter → captures minutes of verbose history |
| **Long Horizon** | Large `MaxBufferSizeInBytes` + restrictive filter (only key events) → captures hours of essential state |
| **Trace Horizon** | Determined by `MaxBufferSizeInBytes` ÷ average event rate. Dynamically tunable by adjusting rules at runtime |
| **Ring Buffer semantics** | Built-in: when buffer fills, oldest entries are silently dropped |
| **Collection** | `buffer.Flush()` — the Flight Recorder is "collected" |
| **Auto-disable** | `AutoFlushDuration` — after flush, buffering pauses so all logs emit (the "verbose window") |

---

## 5. What Is a Trigger? (Definition)

> **A Trigger is a runtime condition, evaluated against the telemetry stream,
> that causes an Action to execute — most commonly flushing a Flight Recorder.**

A trigger bridges *observation* and *reaction*. In the Dynamic Telemetry model,
a Processor watches the log stream for patterns identified by Durable IDs and
fires Actions when conditions are met.

### Trigger Taxonomy

#### 5a. Event-Identity Triggers (simplest)
Fire when a specific Durable ID appears in the stream.

```
IF EventId == 9001 ("TransactionFailed")  →  Flush Flight Recorder
```

#### 5b. Threshold / Counter Triggers
Fire when a per-Durable-ID counter exceeds a limit within a time window.

```
IF count(EventId == 2001) > 1000  IN  last 60s  →  Flush + alert
IF count(EventId == 4001) > 50    IN  last 10s  →  Suppress further (valve close)
```

#### 5c. State-Machine Triggers
Fire on state transitions, modeled as the Dynamic Telemetry State Machine Processor.

```
State: Idle  →  [EventId=1001 "OrderCreated"]  →  State: Processing
State: Processing  →  [EventId=9001 "TransactionFailed"]  →  State: Failed  →  FLUSH
State: Processing  →  [EventId=1002 "PaymentProcessed"]  →  State: Idle  (no flush)
```

#### 5d. Payload-Conditional Triggers
Fire when a Durable ID appears AND a structured field meets a condition.

```
IF EventId == 1002 AND attributes["latencyMs"] > 5000  →  Flush
IF EventId == 2001 AND attributes["reason"] == "pressure"  →  Flush
```

#### 5e. Absence / Timeout Triggers
Fire when an expected Durable ID does NOT appear within a deadline.

```
IF EventId == 1001 seen  AND  EventId == 1002 NOT seen within 30s  →  Flush
```

#### 5f. Composite Triggers
Boolean combinations of the above.

```
IF (EventId == 9001) OR (count(EventId == 4001) > 100 IN 60s)  →  Flush
```

---

## 6. Trigger Engine — .NET Implementation

### 6a. Core Abstraction

```csharp
/// <summary>
/// Evaluates incoming log events against configured trigger rules.
/// When a trigger fires, it flushes the associated Flight Recorder (log buffer).
/// </summary>
public interface ITriggerEngine
{
    /// <summary>
    /// Called for every log event that passes the sampling stage.
    /// Implementations must be thread-safe and fast (nanosecond budget).
    /// </summary>
    void Evaluate(LogEntry entry);
}

/// <summary>
/// A single trigger rule bound to a Durable ID.
/// </summary>
public abstract class TriggerRule
{
    /// <summary>Durable ID(s) this rule watches.</summary>
    public required int[] WatchEventIds { get; init; }

    /// <summary>Optional: category prefix filter.</summary>
    public string? CategoryPrefix { get; init; }

    /// <summary>The action to perform when the trigger fires.</summary>
    public required TriggerAction Action { get; init; }

    /// <summary>Evaluate whether this rule fires for the given log entry.</summary>
    public abstract bool ShouldFire(LogEntry entry, TriggerState state);
}

public enum TriggerAction
{
    FlushGlobalBuffer,
    FlushPerRequestBuffer,
    FlushAll,
    EnableVerboseLogging,
    SuppressEvent,
    EmitMetric
}
```

### 6b. Event-Identity Trigger

```csharp
public class EventIdentityTrigger : TriggerRule
{
    public override bool ShouldFire(LogEntry entry, TriggerState state)
    {
        // Fire immediately when the watched Durable ID appears
        return WatchEventIds.Contains(entry.EventId);
    }
}
```

### 6c. Threshold Trigger (Counter-based)

```csharp
public class ThresholdTrigger : TriggerRule
{
    public required int Threshold { get; init; }
    public required TimeSpan Window { get; init; }

    public override bool ShouldFire(LogEntry entry, TriggerState state)
    {
        if (!WatchEventIds.Contains(entry.EventId))
            return false;

        // Thread-safe sliding window counter, keyed by Durable ID
        int count = state.IncrementAndCount(entry.EventId, Window);
        return count >= Threshold;
    }
}
```

### 6d. Integration with .NET Log Buffering

```csharp
public class DynamicTelemetryTriggerEngine : ITriggerEngine
{
    private readonly GlobalLogBuffer _globalBuffer;
    private readonly PerRequestLogBuffer? _requestBuffer;
    private readonly IReadOnlyList<TriggerRule> _rules;
    private readonly TriggerState _state;

    public DynamicTelemetryTriggerEngine(
        GlobalLogBuffer globalBuffer,
        IEnumerable<TriggerRule> rules,
        PerRequestLogBuffer? requestBuffer = null)
    {
        _globalBuffer = globalBuffer;
        _requestBuffer = requestBuffer;
        _rules = rules.ToList();
        _state = new TriggerState();
    }

    public void Evaluate(LogEntry entry)
    {
        foreach (var rule in _rules)
        {
            if (rule.ShouldFire(entry, _state))
            {
                ExecuteAction(rule.Action);
                // A trigger firing is itself a notable event
                DynamicTelemetryMetrics.TriggerFired(rule, entry.EventId);
            }
        }
    }

    private void ExecuteAction(TriggerAction action)
    {
        switch (action)
        {
            case TriggerAction.FlushGlobalBuffer:
                _globalBuffer.Flush();
                break;

            case TriggerAction.FlushPerRequestBuffer:
                _requestBuffer?.Flush(); // Also flushes global per .NET docs
                break;

            case TriggerAction.FlushAll:
                _requestBuffer?.Flush();
                _globalBuffer.Flush();
                break;
        }
    }
}
```

---

## 7. Per-Durable-ID Throttling via Custom Sampler

The .NET `LoggingSampler` API allows a custom sampling strategy that makes
per-Durable-ID throttle decisions — the **Valve** pattern from Dynamic Telemetry.

```csharp
/// <summary>
/// A sampler that applies per-Durable-ID rate policies.
/// This is the "valve" in the Dynamic Telemetry pipeline.
/// </summary>
public sealed class DurableIdThrottleSampler : LoggingSampler
{
    private readonly IOptionsMonitor<DurableIdThrottleOptions> _options;
    private readonly ConcurrentDictionary<int, SlidingWindowCounter> _counters = new();

    public DurableIdThrottleSampler(IOptionsMonitor<DurableIdThrottleOptions> options)
    {
        _options = options;
    }

    public override bool ShouldSample(LogEntry entry)
    {
        var rules = _options.CurrentValue.Rules;

        // Find the most specific rule for this Durable ID
        if (!TryGetRule(entry.EventId, rules, out var rule))
            return true; // No rule → emit

        return rule.Strategy switch
        {
            ThrottleStrategy.Probability => EvalProbability(rule),
            ThrottleStrategy.RateLimit   => EvalRateLimit(entry.EventId, rule),
            ThrottleStrategy.Suppress    => false,  // Valve fully closed
            ThrottleStrategy.PassThrough => true,   // Valve fully open
            _ => true
        };
    }

    private bool EvalProbability(ThrottleRule rule)
    {
        return Random.Shared.NextDouble() < rule.Probability;
    }

    private bool EvalRateLimit(int eventId, ThrottleRule rule)
    {
        var counter = _counters.GetOrAdd(eventId, _ => new SlidingWindowCounter(rule.Window));
        return counter.TryAcquire(rule.MaxPerWindow);
    }
}
```

### Throttle Configuration

```csharp
public class DurableIdThrottleOptions
{
    public List<ThrottleRule> Rules { get; set; } = new();
}

public class ThrottleRule
{
    /// <summary>The Durable ID (EventId) this rule targets.</summary>
    public int EventId { get; set; }

    /// <summary>Optional: also match by EventName.</summary>
    public string? EventName { get; set; }

    /// <summary>The throttle strategy to apply.</summary>
    public ThrottleStrategy Strategy { get; set; }

    /// <summary>For Probability strategy: 0.0 = drop all, 1.0 = keep all.</summary>
    public double Probability { get; set; } = 1.0;

    /// <summary>For RateLimit strategy: max events per window.</summary>
    public int MaxPerWindow { get; set; }

    /// <summary>For RateLimit strategy: the sliding window duration.</summary>
    public TimeSpan Window { get; set; }
}

public enum ThrottleStrategy
{
    PassThrough,   // Valve: open
    Probability,   // Valve: partially open (random sampling)
    RateLimit,     // Valve: partially open (deterministic cap)
    Suppress       // Valve: closed
}
```

### appsettings.json (runtime-reloadable via IOptionsMonitor)

```json
{
  "DurableIdThrottle": {
    "Rules": [
      {
        "EventId": 2001,
        "EventName": "CacheEviction",
        "Strategy": "Probability",
        "Probability": 0.01
      },
      {
        "EventId": 3001,
        "EventName": "HealthCheckPing",
        "Strategy": "RateLimit",
        "MaxPerWindow": 10,
        "Window": "00:01:00"
      },
      {
        "EventId": 4001,
        "EventName": "MetricHeartbeat",
        "Strategy": "Suppress"
      }
    ]
  },

  "Logging": {
    "GlobalLogBuffering": {
      "MaxBufferSizeInBytes": 67108864,
      "MaxLogRecordSizeInBytes": 32768,
      "AutoFlushDuration": "00:00:30",
      "Rules": [
        { "CategoryName": "MyApp", "LogLevel": "Information" },
        { "EventId": 2001 },
        { "EventId": 1001 }
      ]
    }
  },

  "TriggerEngine": {
    "Rules": [
      {
        "Type": "EventIdentity",
        "WatchEventIds": [9001],
        "Action": "FlushAll"
      },
      {
        "Type": "Threshold",
        "WatchEventIds": [5001],
        "Threshold": 100,
        "Window": "00:01:00",
        "Action": "FlushGlobalBuffer"
      }
    ]
  }
}
```

---

## 8. Registration / Wiring

```csharp
var builder = WebApplication.CreateBuilder(args);

// ──── Layer 1: Sampling / Throttling (Valve) ────
builder.Logging.AddSampler<DurableIdThrottleSampler>();
builder.Services.Configure<DurableIdThrottleOptions>(
    builder.Configuration.GetSection("DurableIdThrottle"));

// ──── Layer 2: Flight Recorder (Buffer) ────
builder.Logging.AddGlobalBuffer(
    builder.Configuration.GetSection("Logging"));

builder.Logging.AddPerIncomingRequestBuffer(options =>
{
    options.AutoFlushDuration = TimeSpan.FromSeconds(5);
    options.Rules.Add(new LogBufferingFilterRule(
        categoryName: "MyApp.Controllers",
        logLevel: LogLevel.Information));
});

// ──── Layer 3: Trigger Engine ────
builder.Services.AddSingleton<ITriggerEngine, DynamicTelemetryTriggerEngine>();
builder.Services.Configure<TriggerEngineOptions>(
    builder.Configuration.GetSection("TriggerEngine"));

// ──── Layer 4: Export ────
builder.Services.AddOpenTelemetry().UseAzureMonitor();

var app = builder.Build();
```

---

## 9. End-to-End Scenario: Order Processing

```
Timeline:
  t=0s   OrderCreated (1001)         → Buffered (Flight Recorder holds it)
  t=1s   InventoryChecked (1003)     → Buffered
  t=1s   CacheEviction (2001) x200   → 99% sampled away, 2 buffered
  t=2s   PaymentProcessed (1002)     → Buffered
  t=3s   CacheEviction (2001) x500   → 99% sampled away, 5 buffered
  t=4s   TransactionFailed (9001)    → Emitted immediately (Error level)
                                        ↓
                                     Trigger fires! (EventIdentity: 9001)
                                        ↓
                                     buffer.Flush()
                                        ↓
                                     ALL buffered logs emitted:
                                       - OrderCreated context
                                       - InventoryChecked context
                                       - The 7 surviving CacheEviction samples
                                       - PaymentProcessed context
                                        ↓
                                     AutoFlushDuration=30s starts
                                     (all logs emit immediately for 30s)
  t=34s  Buffering resumes normally
```

**Without the Flight Recorder:** You'd only see `TransactionFailed` and whatever
wasn't sampled away. The surrounding context would be lost.

**With the Flight Recorder + Trigger:** You get the full diagnostic narrative
leading up to the failure, despite aggressive throttling during normal operation.

---

## 10. Potential Triggers — Catalog

| Trigger Type | Example | Durable ID Role | When to Use |
|---|---|---|---|
| **Error Event** | `EventId=9001` TransactionFailed | Identity match | Any error that warrants full context |
| **Latency Spike** | `EventId=1002` AND `latencyMs > 5000` | Identity + payload | SLA violations, slow paths |
| **Queue Depth** | `EventId=6001` AND `depth > 10000` | Identity + payload | Backpressure, stalls |
| **Rate Anomaly** | `count(EventId=2001) > 1000/min` | Counter per ID | Chatty event becoming pathological |
| **State Timeout** | `EventId=1001 seen`, `1002 absent in 30s` | State machine on IDs | Stuck transactions, deadlocks |
| **Exception Type** | `EventId=9002` AND `exceptionType=OutOfMemory` | Identity + payload | Memory pressure events |
| **Circuit Breaker** | `EventId=7001` CircuitOpened | Identity match | Downstream dependency failure |
| **Health Degradation** | `count(EventId=9xxx) > 50 in 5min` | Wildcard counter | Systemic issues |
| **Security Signal** | `EventId=8001` AuthFailure × 10 in 1min | Counter per ID | Brute-force detection |
| **Business Rule** | `EventId=1005` AND `orderTotal > 100000` | Identity + payload | High-value transaction monitoring |

---

## 11. Safety: Bounded Impact (Think Like RTOS)

Per the Dynamic Telemetry philosophy, every component must have bounded cost:

| Component | Bound | Auto-disable Mechanism |
|---|---|---|
| **Flight Recorder (buffer)** | `MaxBufferSizeInBytes` | Oldest entries silently dropped when full |
| **Sampler** | O(1) per log entry | If sampler throws, log emits normally (fail-open) |
| **Trigger Engine** | Finite rule count, O(n) per entry | If evaluation exceeds time budget, skip remaining rules |
| **AutoFlush window** | `AutoFlushDuration` ceiling | Buffering automatically resumes after window expires |
| **Counter memory** | One counter per active Durable ID | Counters expire with their sliding window |
| **Config reload** | `IOptionsMonitor` debounce | Invalid config → retain previous valid config |

---

## 12. Runtime Reconfiguration (Dynamic Control)

All three layers support live reconfiguration without restart:

```
┌──────────────────┐     IOptionsMonitor<T>     ┌──────────────────┐
│  appsettings.json│  ──────────────────────►   │  Running App     │
│  (or remote       │                            │                  │
│   config store)   │   Hot-reload triggers:     │  • Sampler rules │
│                   │   • Throttle rules change  │  • Buffer rules  │
│                   │   • Buffer rules change    │  • Trigger rules │
│                   │   • Trigger rules change   │                  │
└──────────────────┘                             └──────────────────┘
```

**Examples of runtime changes:**
- Suppress a newly-discovered chatty event: add `{ "EventId": 5555, "Strategy": "Suppress" }`
- Open the valve for debugging: change `"Probability": 0.01` → `"Probability": 1.0`
- Add a new trigger: append to TriggerEngine.Rules
- Adjust trace horizon: increase `MaxBufferSizeInBytes`

---

## 13. Metrics and Observability of the Throttle Itself

The throttling system must be observable (avoiding observer-effect recursion):

```csharp
public static class DynamicTelemetryMetrics
{
    private static readonly Meter s_meter = new("DynamicTelemetry.Throttle");

    // How many events each Durable ID produced (pre-throttle)
    private static readonly Counter<long> s_eventsReceived =
        s_meter.CreateCounter<long>("dt.throttle.events_received");

    // How many were dropped by sampling
    private static readonly Counter<long> s_eventsSampled =
        s_meter.CreateCounter<long>("dt.throttle.events_sampled_out");

    // How many were buffered into the Flight Recorder
    private static readonly Counter<long> s_eventsBuffered =
        s_meter.CreateCounter<long>("dt.throttle.events_buffered");

    // How many triggers fired
    private static readonly Counter<long> s_triggersFired =
        s_meter.CreateCounter<long>("dt.throttle.triggers_fired");

    // Current buffer utilization
    private static readonly ObservableGauge<long> s_bufferBytes =
        s_meter.CreateObservableGauge<long>("dt.throttle.buffer_bytes", () => ...);

    public static void EventReceived(int eventId)
        => s_eventsReceived.Add(1, new KeyValuePair<string, object?>("event_id", eventId));

    public static void TriggerFired(TriggerRule rule, int eventId)
        => s_triggersFired.Add(1,
            new KeyValuePair<string, object?>("trigger", rule.GetType().Name),
            new KeyValuePair<string, object?>("event_id", eventId));
}
```

---

## 14. Summary

```
                    Durable ID
                   (EventId + EventName)
                        │
            ┌───────────┼───────────┐
            │           │           │
        ┌───▼───┐  ┌────▼────┐  ┌──▼──────────┐
        │Sampler│  │ Buffer  │  │   Trigger    │
        │(Valve)│  │(Flight  │  │   Engine     │
        │       │  │Recorder)│  │              │
        │Per-ID │  │Ring buf │  │Watches for   │
        │rules: │  │with per-│  │Durable IDs   │
        │• prob │  │ID rules │  │and fires     │
        │• rate │  │         │  │Actions:      │
        │• suppress│         │  │• Flush()     │
        └───┬───┘  └────┬────┘  │• Alert       │
            │           │       │• Toggle      │
            ▼           ▼       └──────────────┘
        Dropped    Held until
        forever    Trigger → Flush()
                   or silently expired
```

**The key insight:** Durable IDs turn the log stream from an opaque river of text
into an addressable, per-event-type control plane. Each `EventId`/`EventName` becomes
a handle that the Sampler, Buffer, and Trigger Engine can independently grip.
The .NET log-buffering API provides the Flight Recorder mechanics natively; the
custom `LoggingSampler` provides the per-ID valve; and the Trigger Engine provides
the intelligence to flush the recorder exactly when diagnostic context matters.
