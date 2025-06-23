---
author: "Chris Gray"
status: ReviewLevel1b
---

# Architectural Survey

DynamicTelemetry is an articulation of the embodiment of a suite of
Observability tools, designed to manage, control, and reshape telemetry in
[Production](./PositionPaper.DefiningProduction.document.md) systems.

Essentially, DynamicTelemetry is a set of enforced conventions that enable
various sophisticated diagnostic systems to work in harmony. It ensures
compatibility with user privacy and security needs. Simultaneously,
DynamicTelemetry provides businesses with the ability to adjust their
Observability based on necessity. This allows resources to be allocated when
needed and restricts telemetry when it's not required.

By using Dynamic Telemetry, developers will have less guessing to do when
deciding how much logging verbosity to utilize, as they can late bind the
decision by deploying refining telemetry after code deployment.

This document aims to delve into the philosophy of DynamicTelemetry, exploring
the intricate balance between complex realities. While this document serves as a
comprehensive spiritual guide, some readers might find it beneficial to start
with the usage [scenarios](./Scenarios.Overview.document.md) to get a better
understanding of the system.

## Dynamic Telemetry, in a nutshell{.unlisted .unnumbered}

[Demos](./Demos.1.DropChattyLog.md) are a great way to go hands on with
DynamicTelemetry, but before diving in to the complex realities
DynamicTelemetry, it's important to have a general understanding of usage.

Image yourself as a [DEVELOPER](./Persona_Developer.document.md). You're focused
on the latest business needs from your
[PROJECTMANAGER](./Persona_ProjectManager.document.md). You're worried about
solving business problems, keeping costs in check, being able to diagnose after
deployment (and in crisis) as well as preserving the privacy and security of
your users content.

Many of these items are mutually exclusive. For example, if you add more logs,
you can diagnose issues better. However, this will increase costs and may
introduce privacy and security risks.

Dynamic Telemetry treats your telemetry like water in a holistic pipeline that
can be filtered, routed, stored, and accessed on demand. Even better, your logs
can actively participate in the process. They can be used to detect problems,
adjust the verbosity of other logs, or even trigger advanced data collections.
