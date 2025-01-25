---
author: "Chris Gray"
status: ReviewLevel1
---

This section is intended to address commonly asked questions that are challenging or difficult. It is called "Rude Q and A" because it encourages asking tough, awkward, or uncomfortable questions.

Please be polite when asking questions here, but do not feel the need to create a false sense of harmony. This page is for addressing difficult problems directly.

## Q1: Dont deployments carry risks?
Deployments carry risks; code or configuration - doesn't Dynamic Telemetry encourage accelerated deployments, won't that carry risks?

### A1: Yes, there are risk; but there is also an taxonomy for understanding
The [Observer Effect](./PositionPaper.ObserverEffect.document.md) document covers this topic at a high level. It's important to know that 100% of all Probes, Actions, and Processors in Dynamic Telemetry are intentionally read-only. This is not to say that Dynamic Telemetry's implementation is bug-free. However, by design and intent, no part of Dynamic Telemetry should alter your system state.

There are cases where risks are present. For example, CPU sampling can impact performance, memory dumps will pause your threads, and extracting memory can pose security risks.

Dynamic Telemetry offers [a taxonomy of risk measurement](./PositionPaper.ProbeRiskLevels.document.md) used in actions and probes. This taxonomy clearly communicates the risks to business decision-makers, allowing them to choose which probes and actions are permissible in their environment and under what deployment constraints.




## Q3 : Dynamic Telemetry takes a position of no rigid schemas - isnt this at odds with the value prop of Design Patterns?

[reading material](./PositionPaper.SharingDataAmongStakeHoldersIsHard.document.md)

### A3 : Maybe.. it's something we should discuss
A keen reader of the Dynamic Telemetry documentation will notice potential incongruity found in the design pattern documentation. Specifically, the design patterns discussed have rigid schemas as their core value proposition. This is potentially something that should be further discussed if the design patterns are included in Dynamic Telemetry or built atop it.