---
author: "Chris Gray"
status: ReviewLevel1b
---

# Interesting Application : FlightRecorder into Memory Leak

## Scenario Summary

Even in managed languages, determining why memory is being consumed can be a
complicated matter. We've all encountered a linked list that holds a pointer to
memory and doesn't shrink as it should. While some may argue whether this
constitutes a memory leak, the system inevitably starts to slow down and thrash
as memory pressure exceeds the hardware's capabilities.

A powerful use of a Flight Recorder is to track the insertion or deletion from
such a list, or the add reference and release, or malloc() and free() operations
in unmanaged languages.

This is achieved either through standard logging or by inserting a dynamic probe
on the malloc() and free() calls.

By using a probe that indicates the amount of memory load on a machine, coupled
with an action to collect this type of memory Flight Recorder, a developer can
obtain a high-fidelity glimpse into the machine's memory usage over a long
duration without negatively impacting performance.

Best of all, once the project is complete and the memory leak is understood,
dynamic telemetry can disable all of this logging, including the flight
recorder, allowing the machines to operate at high speed.

## Scenario Expansion
