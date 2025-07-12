---
author: "Chris Gray"
status: ReviewLevel1b
---

# Long Horizon Flight Recorder

![](../orig_media/LongHorizon.banner.png)

A Long Horizon Flight Recorder is a specialized type of Flight Recorder designed
to study long-running issues that are typically very difficult to understand and
capture. For example, imagine a long-running asynchronous operation that takes
hours or days to complete, such as writing the entirety of a large tape or
managing client operating system metadata attached to a long-running Bluetooth
connection.

In these situations, you would prefer not to emit all of the logging into the
back ends due to volume, data costs, and potential security and privacy
concerns.

Instead, you'd like to have verbose logging localized to a particular
transaction, but only collect / harvest this logging should that transaction
fail.

Using a combination of [Probes](./Architecture.Probes.Overview.document.md) that
log into a Long Horizon Flight Recorder and
[Actions](./Architecture.Actions.Overview.document.md) that initiate the
egress of that recorder upon transaction failure, very interesting and novel
diagnostic situations can often be created.

We often call these ["nets"](./PositionPaper.ProceduralizeNets.document.md) as
an analogy to fishing, where a net is cast over the side of a boat and collects
only what is too big to fit through the net (e.g., the action).

## Criteria (and differentiators from 'Long Horizons')

Just like a Short Horizon Flight Recorder. Or really any Flight Recorder.
There's no preset criteria to differentiate them. The primary purpose in having
a long and a short horizon Flight Recorder is to initiate a conversation about
how this recorder will be used in practice.

Typically a Long Horizon Flight Recorder will Have

1. A large memory buffer.
1. A very restrictive filter. That is very selective in what is captured.

## Long Horizon Flight Recorders in the Cloud

A keen observer may realize that the value proposition of a Long Horizon flight
recorder in a cloud system may not be very significant. This is true because a
Long Horizon Flight Recorder has a very restrictive filter on the logs that are
placed into the Flight Recorder. By design, the Flight Recorder will not be very
chatty and therefore may be suitable for immediate streaming using standard
stream-based telemetry.

Without question, a Long Horizon Flight Recorder is not something every engineer
utilizes in their day-to-day work. It is a specialized tool designed for
specific scenarios where long-running processes need detailed logging and
diagnostics. Its use is typically reserved for complex systems where
understanding and troubleshooting extended operations is crucial.

However, this does not mean that a Long Horizon Flight Recorder is of no value.
There are some situations where one can be beneficial:

1. When a Long Horizon Flight Recorder is dynamically
   [created and triggered](./Architecture.Action.FlightRecorder.document.md)
   based on the starting and stopping of a transaction. In this case, there are
   many Long Horizon Flight Recorders, and the sum of all would be prohibitive
   to emit.
1. In an operating system, where it is considered best practice to emit very
   little telemetry that is not of a diagnostic nature.

This likely will not be the case in aAn operating system.

## Sample Applications and Use Cases

1. Following long running transactions, where logs are only desirable should the
   transaction fails
1. Long running sessions; bluetooth, TCP, etc

Long Horizon Flight Recorders are ideally suited for diagnosing problems that
develop gradually over extended periods or under complex, long-running
conditions. They capture logs and metrics selectively, focusing on events
important for troubleshooting systemic issues that wouldn't manifest in
real-time. As a result, they can be a powerful complement to Short Horizon
Flight Recorders when an organization needs both short-term bursts of data
collection and deeper, continuous insight.

Common Use Cases:

- Monitoring days-long or multi-week processes where intermittent bugs may crop
  up.
- Collecting critical trace points for applications performing bulk data
  operations (like large file syncs, or tape transactions).
- Capturing persistent system logs for embedded or industrial software that runs
  24/7.

By limiting their scope to just the essential data, Long Horizon recorders avoid
overwhelming (or undesirable) storage costs while still offering critical
coverage. They also provide a "rolling window" of vital analytics, maintaining
an ongoing record to pinpoint when and why an anomaly occurred.

## When You Should Consider a Long Horizon Flight Recorder

- You need historical context that spans multiple machine states or workflow
  phases.
- You're operating in an environment requiring strict cost management but still
  need essential traces for in-depth root cause analysis.
- You have a pipeline of analytics jobs that need periodic or event-based data
  snapshots over days or weeks.

They may not be the default choice for every developer, but in the right
circumstances, Long Horizon Flight Recorders offer unmatched visibility into
hidden or slow-growing system behaviors. By tuning logs and collection intervals
carefully, teams can strike the right balance between detail and performance
overhead.
