---
author: "Chris Gray"
status: ReviewLevel1b
---

# Flight Recorder Overview

![](../orig_media/FlightRecorders.banner.png)

A Flight Recorder is essentially a ring buffer that stores logging
data that is only uploaded to a backend, when instructed by a triggering
[Action](./Architecture.Actions.Overview.document.md).  Unlike standard
streaming telemetry, this telemetry is only emitted when instructed, usually on
failure.

In this capacity, it serves as an alternative and complement to standard
[Streaming](./PositionPaper.FileAndStreaming.document.md) Observability.  In
fact, users of Flight Recorders. Typically report that their presence turns the
frustrating act of debugging a live system into something a lot more fun and
interactive, almost like a video game.

A quick recap:

1. A [Probe](./Architecture.Probes.Overview.document.md) is a form of logging
   that flows into OpenTelemetry
1. A [Filter or Router](./Architecture.Components.FiltersAndRouters.document.md)
   is a piece of code situated in the middle of an OpenTelemetry pipe that
   routes or filters logs
1. A Flight Recorder is a circular log that is never emitted unless there's a
   reason
1. An [Action](./Architecture.Actions.Overview.document.md) provides the
   reason

Think of a Flight Recorder as a way to enhance your logging capabilities. It
provides flexibility and additional options for addressing complex issues.
Imagine needing a specific log when something goes wrong

A Flight Recorder offers a unique approach where logs are collected but not
uploaded unless a problem arises. The challenge and creative opportunity lie in
defining the triggering Action for when the issue you're monitoring occurs.

Now we're playing cat and mouse with our bugs and that is a lot of fun.

## What is a Flight Recorder?

Technically, a Flight Recorder comprises a ring buffer with fixed capacity,
typically residing in memory or (maybe) on disk, such that the data continually
overwrites older data with newer entries. This design is naturally lossy, yet it
captures essential insights about system events and states in near real time.

What is contained in a Flight Recorder, is simply redirected standard Logging -
this be from any [Probe](./Architecture.Probes.Overview.document.md) technology
that emits into OpenTelemetry.

Think of a Flight Recorder as just routed Observability, that goes nowhere,
unless asked. If you imagine
[the pipe analogy](./PositionPaper.TelemetryUmbilical.document.md) in the
Umbilical document, a Flight Recorder is just a cut Observability pipe, that is
redirected into a circular buffer, instead of streamed directly to a a backend.

## Special Characteristics of a Flight Recorder

In Dynamic Telemetry, one one machine, there can be hundreds - if not thousands
of Flight Recorders. Some are as small as a log record or two, others may
contain megabytes of Logs, any of which can be collected as instructed by an
Action.

The most special characteristic of a Flight Recorder, is that each can be
***uniquely identified*** by a dedicated tag or name. This allows for quick
recognition among multiple data sources and ensures streamlined retrieval when
logs need to be collected by an Action.

This on-demand egress is a core feature, enabling data extraction whenever
deeper investigation is necessary. By preserving a snapshot of the overwritten
data, the Flight Recorder helps diagnose issues by making past telemetry
accessible for post-mortem analysis.

## How to collect a Flight Recorder

A Flight Recorder augments standard streaming telemetry by capturing data from
multiple probes, such as OpenTelemetry logging, ETW (Windows), user_events, or
syslog into a circular buffer. Logs remain local unless triggered to leave the
machine, delivering deeper insights through real-time and localized data
analysis.

By storing high-verbosity traces locally, a Flight Recorder retains critical
details for post-event analysis. Logs remain accessible when needed, even if
they might not be retained long-term.

This solution can provide both performance benefits and cost savings. To learn
more, refer to the position papers on
[scarcity](./PositionPaper.ScarcityAndHumans.md) and
[triggered Flight Recorders](./PositionPaper.TriggeredCollections.document.md).

The basic steps to collect a Flight Recorder are to know through some mechanism
its identifier and then to use a triggering action to collect it.

Steps Involved in Collecting a Flight Recorder

1. Route high volume Logging to a Flight Recorder
1. Note its Identifier
1. Use the Flight Recorder egress action, to collect the Flight Recorder

## Trace 'Horizons'

Flight Recorders often collect high volume logs that remain local until a
triggering event prompts upload. This approach introduces different trace
horizons. One horizon might capture logs leading to a process crash or other
diagnostic event. Because these logs can be high in volume, ring buffers
overwrite older data frequently. This arrangement is commonly referred to as a
"short-horizon" Flight Recorder.

In contrast, some logging applies only to specific failures that may take
minutes or days to occur. Examples include Bluetooth sessions on a client
operating system, long-running transactions, or writing data to a slow medium
like tape. These scenarios require maintaining a Flight Recorder over an
extended period, ensuring that all pertinent logs remain accessible when needed.

These lower volume but long duration Flight Recorders are known as long-horizon
Flight Recorders. They are designed to capture and retain logs over extended
periods, ensuring that all relevant data is available for analysis when needed.

## Interesting Applications of Flight Recorders

Flight Recorders are an extremely interesting and fun concept. As you gain
proficiency in using them, you'll find applications everywhere. They offer a
unique way to capture and analyze telemetry data, providing insights that are
not possible with traditional logging methods.

Below are some of our favorite applications:

### Recording Information leading into a process crash

{% include-markdown "./Applications.FlightRecorder.PriorToCrash.document.md",
start="## Scenario Summary", end="## Scenario Expansion" %}

### Tracking Memory Leaks

{% include-markdown "./Applications.FlightRecorder.MemoryLeak.document.md",
start="## Scenario Summary", end="## Scenario Expansion" %}
