---
author: "Chris Gray"
status: ReviewLevel1
---

# DynamicTelemetry Persona : DEVELOPER Persona

DynamicTelemetry personas are intended as an organizational aid to group
capabilities and usability of common usage scenarios. Browsing between scenarios
is recommended, for the personas are intended only as an aid.

## Introduction

The DEVELOPER Persona in DynamicTelemetry:

1. *Authors code*, firsthand
1. Understands *technical details* like data schemas, instruction pointers, and
   can differentiate logs/traces from metrics.
1. Comfortable with *core operating system concepts*, like threads, heaps, and
   stacks
1. Understands *symbolic debuggers*, code offsets, and symbols
1. Is well versed and comfortable with the differences between security and
   privacy. Knows how to protect users.

## Notes (To Be Deleted)

```mermaid
mindmap
    root(Developer)
        Triggers(Triggered Actions)
            Collect Flight Recorder
            Toggle Flight Recorder Verbosity

            Actions

        Probes(Probe Types)
            OpenTelemetry
                Vadim
                Logs
                Metrics
                Traces
            OS_Telemetry
                Linux
                    eBPF
                    DTrace
                    strace
                    syslog
                Windows
                    ETW
            API(DynamicTelemetry API)
                A/B Feature Testing
                Asserts

        Actions(Actions)
            File_Collections
            Process_Memory_Dumps
            CPU_Sampling
            Flight_Recorders
```
