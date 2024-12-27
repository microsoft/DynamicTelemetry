---
author: "Chris Gray"
status: ReviewLevelb
---

{{ ProvideFeedback(page.file.src_uri) }}


# Using Dynamic Telemetry for Deep Diagnostics, at Scale

In Dynamic Telemetry, Probes and Actions play crucial roles in
monitoring and diagnosing system behavior. Probes, such as any Log
produced in OpenTelemetry, are read by a Dynamic Telemetry Processor as
dynamic elements that can be used in various ways to better understand
the runtime characteristics of the system. This approach provides an
additional layer of depth to your software, which is useful and valuable
for analysis and troubleshooting. The Probes and accompanying Processor
are designed to operate transparently within the system without causing
measurable disruption to performance or reliability. Probes can either
be static, always active and continuously monitoring the system, or
dynamic, enabled or disabled as needed.

Actions, on the other hand, involve diagnostic operations that do not
alter the system state and can be dynamically enabled or disabled.
Suitable actions might include enabling CPU sampling, collecting
configurations, managing flight recorders, inducing memory dumps, and
collecting other types of state data.

When combined, Probes and Actions create a powerful mechanism to "cast
nets" that catch bugs.

## Simple Example : dialing up Logging/Diagnostics when something goes wrong

For example, consider a situation where a production system works well
during testing and under light load but experiences unexpectedly high
CPU contention from time to time. Developers have many theories, and
little data -- they suspect the machine could be entering receive
livelock but are unsure why.

If they could predict which computer would next exhibit the problem,
they could turn on CPU sampling when the issue occurs. The challenge is
that once the problem arises, it is resolved before they're able to:

-   Collect a memory dump to inspect work queues

-   Enable CPU sampling to determine which code is heavily utilized,

-   Enable verbose diagnostic traces.

By using Dynamic Telemetry effectively, teams can proactively manage and
resolve such issues, improving overall system stability and performance.

## Casting 'Nets'

The Diagnostic Telemetry solution to this class of problem involves
casting broad 'nets' on multiple machines expected to encounter this
situation. Each net is very lightweight, with negligible performance or
reliability concerns.

These nets are simply configurations for a Dynamic Telemetry Processor
that remain mostly dormant, monitoring selected logging values while
waiting for a triggering condition. Once a triggered, an "Action" is
called; which in turn provides the desired diagnostic information
necessary for a root cause.

## An Example

By configuring the Processor to dynamically monitor these log messages,
it can track the queue depth in real-time. If the queue length exceeds
predefined criteria set in the Processor's configuration, the Processor
can initiate various diagnostic actions such as capturing a memory dump,
enabling CPU sampling, or activating more verbose logging. This dynamic
monitoring allows for proactive detection and response to potential
issues, ensuring abnormalities are promptly addressed, thereby
maintaining system stability and performance.

Probes are deployed to monitor specific aspects of the system and emit
data when certain conditions are met. For example, a probe might monitor
the return value of a particular function or track the occurrence of
specific events. When a probe detects something noteworthy, it can
trigger an action. This action may involve collecting additional data,
enabling more detailed logging, or capturing a memory dump.

By dynamically enabling and disabling probes and actions, you can create
a flexible and responsive system that adapts to changing conditions and
captures valuable diagnostic information when needed.


``` cdocs

{% include "../LookoutTower/Samples/TriggeringOnQueue/TriggeringOnQueue.cs"
    start="//<!--start-SampleWorkQueue-->"
    end="//<!--end-SampleWorkQueue-->"
%}

```