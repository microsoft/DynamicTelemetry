---
author: "Chris Gray"
status: ReviewLevel1
---

# Definitions

| TERM | DEFINITION |
| -- | -- |
| <a name="BUGBEACON">BUGBEACON</A>|A library of 'active comments' - an SDK that emits on schematized OpenTelemetry, to maximize the impact of in-place  bservability. Simplifying and maximizing use with  ynamicTelemetry. |

|<a name="PROBE"> PROBE</A> | In DynamicTelemetry a [PROBE](./Architecture.Probes.Overview.document.md) is the base case abstraction
for all means of measure.PROBES extract information from the working system, and
convert them into a schematized OpenTelemetry Log, Metric, or Trace. Comfortable
(and common) examples include ETW, SYSLOG, USER_EVENTS. More advanced examples
include UPROBES and DTRACE.|

 |<a name="ETW">ETW = Event Tracing, Windows</A> |
[Windows in box tracing](https://docs.kernel.org/6.1/trace/uprobetracer.html).
There are a few 'flavors' of ETW -
[TraceLogging](https://learn.microsoft.com/en-us/windows/win32/tracelogging/trace-logging-portal)
is the preferred flavor for DynamicTelemetry, because it's internally
manifested' and its events are self describing, such that they can be decoded
without manifest.|

 | <a name="PROBE">UPROBE</A> |
[kernel.org](https://docs.kernel.org/6.1/trace/uprobetracer.html). Basically a
kernel supported breakpoint mechanism.|

|<a name="DTRACE">DTRACE</A> |
[msdn](hhttps://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/dtrace)|
|<a name="SYSLOG">SYSLOG</A>|TBD| |<a name="USER_EVENTS">USER_EVENTS</A>|TBD|
