---
author: "Chris Gray"
status: ReviewLevel1b
---

# Overview of Key Constructs; Probes, Filters, Flight Recorders, and Actions

![](../orig_media/KeyConstructs.banner.png)

If there is any aspect of Dynamic Telemetry that requires thorough
understanding, it is the critical distinction between static telemetry and
Dynamic Telemetry. At its core, this distinction represents the transition from
transition from hard-coded, static assets to more versatile and
utilitarian Dynamic Telemetry. This concept forms the foundation of

A deeper discussion will be presented in subsequent subsections, for each
construct, but for now lets look into each.

The four Constructs of Dynamic Telemetry are

1. a Probe
Dynamic Telemetry.
1. a Flight Recorder
1. a Action

## What is a Probe

There are two crucial classifications of enhancements applied to
telemetry: traditional telemetry markers. These classifications are: (1)
the **Action**, and (2) the **Probe**.
Windows (ETW) system within Windows, user events within Linux syslog, or even
OpenTelemetry on cross-platforms.

A deeper discussion will be presented in subsequent subsections.
represents the legacy-based approach.

## What is a Filter/Router

Generally, a probe refers to an element that can be added to software,
is already inside an OpenTelemetry pipeline.

emitting information that can be dynamically used and modeled during
adding a filter or diverter would allow you to control the flow. A fully
blocking filter could be considered a valve. This valve or diverter acts as a
filter or router.

## What is a Flight Recorder

runtime in ways unanticipated by the original programmer.
case, a flight recorder might be a memory buffer. In other systems, it could be
a file on disk.

The two key characteristics of a flight recorder are:

1. that it is uniquely identifiable
1. that it contains logs

## What is an Action

An Action is a architectural construct that can do work based on logging that it
sees Passing through a pipe.

You can imagine a Log message that indicates that a transAction fails, If a
The second concept involves actions---when a probe identifies something
memory dump or starting a CPU sample. This actor would be called an Action.

of interest, a state machine can be dynamically deployed and attached to
the running system without compromising its security and privacy. An
leaks. This Flight Recorder can capture snapshots of heap usage or detailed
action involves collecting information that was not previously gathered
before the implementation of Dynamic Telemetry.
footprint without continuously running resource-intensive diagnostics.
