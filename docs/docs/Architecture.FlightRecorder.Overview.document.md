---
author: "Chris Gray"
status: ReviewLevel1b
---

# Flight Recorder Overview

Flight recorders depend on both streaming and file-based telemetry to
capture information at different times and scales. Streaming approaches
provide continual updates, which is critical when immediate insights
(metrics) are required. File-based telemetry collects data in a locally
stored format, resembling the way an airplane's black box safeguards
flight parameters.

Many modern systems rely heavily on streaming telemetry for near
real-time monitoring. This approach fulfills Observability needs by
enabling on-the-fly analysis and rapid response. Continuous data inflow
also makes it simpler to spot trends or anomalies as they emerge.

File-based telemetry stores self-contained data segments for post-event
examination. Similar in concept to safeguarded flight data recorders or
fire safes, this method is especially valuable for incident
reconstruction. It preserves past states, which helps ensure that system
insights remain available even when live connections are not.

## What is a flight recorder?

A flight recorder comprises a ring buffer with fixed capacity, typically
residing in memory or on disk, that continually overwrites older data
with newer entries. This design is naturally lossy, yet it captures
essential insights about system events and states in near real time.

Each flight recorder instance can be uniquely identified by a dedicated
tag or name. This allows for quick recognition among multiple data
sources and ensures streamlined retrieval when logs must be merged or
compared.

On-demand egress is another core feature, enabling data extraction
whenever deeper investigation is necessary. By preserving a snapshot of
the overwritten data, the flight recorder helps diagnose issues by
making past telemetry accessible for post-mortem analysis.

## How to collect a flight recorder

A flight recorder augments standard streaming telemetry by capturing
data from multiple probes, such as OpenTelemetry logging, ETW (Windows),
user_events, or syslog into a circular buffer. Logs remain local unless
triggered to leave the machine, delivering deeper insights through
real-time and localized data analysis.

By storing high-verbosity traces locally, a flight recorder retains
critical details for post-event analysis. Logs remain accessible when
needed, even if they might not be retained long-term.

This solution can provide both performance benefits and cost savings. To
learn more, refer to the position papers on
[scarcity](./PositionPaper.ScarcityAndHumans.md) and [triggered flight
recorders](./PositionPaper.TriggeredFlightRecorder.document.md).

The basic steps to collect a flight recorder are to know through some
mechanism its identifier and then to use a triggering action to collect
it.

**Steps Involved in Collecting a Flight Recorder**

    1. Route high volume Logging to a Flight Recorder
    2. Note its Identifier
    3. Use the Flight Recorder egress action, to collect the flight recorder

## Trace 'Horizons'

Flight recorders often collect high volume logs that remain local until
a triggering event prompts upload. This approach introduces different
trace horizons. One horizon might capture logs leading to a process
crash or other diagnostic event. Because these logs can be high in
volume, ring buffers overwrite older data frequently. This arrangement
is commonly referred to as a "short-horizon" flight recorder.

In contrast, some logging applies only to specific failures that may
take minutes or days to occur. Examples include Bluetooth sessions on a
client operating system, long-running transactions, or writing data to a
slow medium like tape. These scenarios require maintaining a flight
recorder over an extended period, ensuring that all pertinent logs
remain accessible when needed.

These lower volume but long duration flight recorders are known as
long-horizon flight recorders. They are designed to capture and retain
logs over extended periods, ensuring that all relevant data is available
for analysis when needed.

## Interesting Applications of Flight Recorders

Flight recorders are an extremely interesting and fun concept. As you
gain proficiency in using them, you'll find applications everywhere.

Blur some of this author's favorite uses.

### Information leading into a process crash.

{%
    include-markdown "./Applications.FlightRecorder.PriorToCrash.document.md",
    start="## Scenario Summary",
    end="## Scenario Expansion"
%}


### Memory Leak Tracking

{%
    include-markdown "./Applications.FlightRecorder.MemoryLeak.document.md",
    start="## Scenario Summary",
    end="## Scenario Expansion"
%}

## References

1.  [File and Streaming](./PositionPaper.FileAndStreaming.document.md)

2.  [Telemetry
    Umbilical](./PositionPaper.TelemetryUmbilical.document.md)

3.  [Scarcity and Humans](./PositionPaper.ScarcityAndHumans.md)

4.  [triggered flight
    recorders](./PositionPaper.TriggeredFlightRecorder.document.md).
