---
author: "Chris Gray"
status: ReviewLevel1b
---

# Overview of Key Constructs; Probes, Filters, Flight Recorders, and Actions

![](../orig_media/KeyConstructs.banner.png)

If there is any aspect of Dynamic Telemetry that requires thorough
understanding, it is the critical distinction between static telemetry and
Dynamic Telemetry. At its core, this distinction represents the transition from
hard-coded, static assets to more versatile and reconfigurable Dynamic
Telemetry. This concept forms the foundation of Dynamic Telemetry.

A deeper discussion will be presented in subsequent subsections, for each
construct, but for now lets look into each.

The four Constructs of Dynamic Telemetry are

1. a Probe
1. a Filter
1. a Flight Recorder
1. a Action

## What is a Probe

A Dynamic Telemetry Probe is a lightweight mechanism that emits events (logs)
within a running system. A Probe is usually specific to the operating system and
native to that environment. For example, it could be the Event Tracing for
Windows (ETW) system within Windows, user events within Linux syslog, or even
OpenTelemetry on cross-platforms.

In essence, a Probe is a logging event. In a static telemetry system, it
represents the legacy-based approach.

## What is a Filter/Router

A filter is a Dynamic Telemetry construct used to filter and route logging that
is already inside an OpenTelemetry pipeline.

Imagine an OpenTelemetry pipeline as a pipe of water. Cutting the pipe and
adding a filter or diverter would allow you to control the flow. A fully
blocking filter could be considered a valve. This valve or diverter acts as a
filter or router.

## What is a Flight Recorder

A flight recorder is an identified collector of routed logging. In a simple
case, a flight recorder might be a memory buffer. In other systems, it could be
a file on disk.

The two key characteristics of a flight recorder are:

1. that it is uniquely identifiable
1. that it contains logs

## What is an Action

An Action is a architectural construct that can do work based on logging that it
sees Passing through a pipe.

You can imagine a Log message that indicates that a transAction fails, If a
listener. Of this Log message decides to take Action, for example collecting a
memory dump or starting a CPU sample. This actor would be called an Action.

By configuring a Filter to detect memory management logs, you can then direct
those logs to a specialized Flight Recorder Action built for diagnosing memory
leaks. This Flight Recorder can capture snapshots of heap usage or detailed
allocation patterns whenever the filter's trigger conditions are met, enabling
quick identification of problematic regions within the application's memory
footprint without continuously running resource-intensive diagnostics.
