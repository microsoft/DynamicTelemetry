---
author: "Chris Gray"
status: ReviewLevel1
---

# Coming Soon

## Notes (Dynamic / Breakpoint Probe)

A Dynamic / Breakpoint probe is a type of probe that utilizes a software or hardware
breakpoint, depending on the programming language.

This is a riskier probe type because the instruction pointer will transfer into
the underlying kernel facilities. However, it is not as risky as a traditional
debugger, as the instruction pointer will not be frozen. Instead, it will simply
collect the memory and exit using standard OpenTelemetry.

Some types of Dynamic / Breakpoint Probes may include.

1. [uProbe](./Architecture.Probe.uprobes.document.md)
1. dotnet
1. [pTrace](./Architecture.Probe.ptrace.document.md)
1. [dtrace](./Architecture.Probe.DTrace.document.md) (etc)
