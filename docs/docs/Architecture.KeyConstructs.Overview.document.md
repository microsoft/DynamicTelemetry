---
author: "Chris Gray"
status: ReviewLevel1b
---

# Overview of Key Constructs; Actions and Probes

If there is any aspect of Dynamic Telemetry that requires thorough
understanding, it is the critical distinction between static telemetry and
Dynamic Telemetry. At its core, this distinction represents the transition from
hard-coded, static assets to more versatile and utilitarian Dynamic Telemetry.
This concept forms the foundation of Dynamic Telemetry.

There are two crucial classifications of enhancements applied to telemetry:
traditional telemetry markers. These classifications are: (1) the **Action**,
and (2) the **Probe**.

A deeper discussion will be presented in subsequent subsections. Generally, a
probe refers to an element that can be added to software, emitting information
that can be dynamically used and modeled during runtime in ways unanticipated by
the original programmer.

The second concept involves actions---when a probe identifies something of
interest, a state machine can be dynamically deployed and attached to the
running system without compromising its security and privacy. An action involves
collecting information that was not previously gathered before the
implementation of Dynamic Telemetry.
