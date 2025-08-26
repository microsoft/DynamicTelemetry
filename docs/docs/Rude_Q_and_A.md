---
author: "Chris Gray"
status: ReviewLevel2
---

# "Rude" Questions and Answers

This section addresses commonly asked questions that are challenging or
difficult. It is called "Rude Q and A" because it encourages asking tough,
awkward, or uncomfortable questions.

Please be polite when asking questions here, but do not feel the need to create
a false sense of harmony. This page is for addressing difficult problems
directly.

## Deployment; too fast = accelerated problems, too slow = decelerated solution

The rate of deployment is a double-edged sword. On one hand, deploying quickly
can help scale solutions, such as scrubbing a security credential. On the other
hand, if your attempt to diagnose or scrub itself has an error, you can end up
increasing risks to a user.

This section of Rude Q and A covers deployments in this dilemma.

### Q1: Don't deployments carry risks

Deployments carry risks; code or configuration - doesn't Dynamic Telemetry
encourage accelerated deployments, and won't that carry risks?

#### A1: Yes, there are risks; but there is also a taxonomy for understanding

The [Observer Effect](./PositionPaper.ObserverEffect.document.md) document
covers this topic at a high level. It's important to know that 100% of all
Probes, Actions, and Processors in Dynamic Telemetry are intentionally
read-only. This is not to say that Dynamic Telemetry's implementation is
bug-free. However, by design and intent, no part of Dynamic Telemetry should
alter your system state.

An interesting discussion should be started about where the line is and if it
can be enforced technically, or if it's strictly a business problem that can be
solved through policy and taxonomy. As a thought experiment, consider a database
that has update policies that are run on ingestion and used for versioning. Most
reasonable people can agree that this is a useful feature of a database and is
something that an administrator can apply nearly instantaneously. To reject the
ability for Dynamic Telemetry to have dynamic deployments is akin to rejecting
this capability. The question only seems to be where the balance is and how to
map that balance into the business needs.

Unfortunately, there are cases where risks are present. For example, CPU
sampling can impact performance, memory dumps will pause your threads, and
extracting memory can pose security risks.

Dynamic Telemetry offers
[a taxonomy of risk measurement](./PositionPaper.ProbeRiskLevels.document.md)
used in actions and probes. This taxonomy clearly communicates the risks to
business decision-makers, allowing them to choose which probes and actions are
permissible in their environment and under what deployment constraints.

______________________________________________________________________

## Security

A serious concern in Dynamic Telemetry is that an adversary who gains the
ability to deploy dynamic probes into a memory space potentially has the ability
to extract sensitive information such as passwords, tokens, and credentials.
Another attack vector could be enabling a row of logging that had been
previously suppressed or set at a lower capture level.

This section covers those topics.

### Q2: Can memory extraction probes be used by an adversary to extract memory?

#### A2: Potentially. Care must be taken

A memory extraction probe is one of the more flexible and useful tools in
Dynamic Telemetry. Built upon technologies such as DTrace, Ptrace, uprobes, and
kprobes, it allows for detailed memory analysis. However, if an adversary
compromises the deployment of Dynamic Telemetry configuration, they may be able
to extract memory, potentially leading to a system compromise.

This is similar to being in control of any form of system deployment or CI/CD
pipeline.

An attacker would also need access to the backend databases to harvest the
extracted memory.

Use of a memory extraction probe should be done in a contained environment,
using secure workstations, and following extra processes and procedures that
likely include audits.

## Potentially Confused Topics

The section below focuses less on security, privacy, or logistical deployment
risks and more on the architecture and potential conflicts in design. For
example, it appears contradictory to state that Dynamic Telemetry does not have
rigid schemas while simultaneously offering capabilities built upon rigid
schemas.

### Q3 : Dynamic Telemetry takes a position of no rigid schemas??

....isn't this at odds with the value prop of Design Patterns?

[reading material](./PositionPaper.SharingDataAmongStakeHoldersIsHard.document.md)

#### A3: Maybe... it's something we should discuss

A keen reader of the Dynamic Telemetry documentation will notice potential
incongruity found in the design pattern documentation. Specifically, the design
patterns discussed have rigid schemas as their core value proposition. This is
potentially something that should be further discussed if the design patterns
are included in Dynamic Telemetry or built atop it.

### Q4: Without any form of rigid schemas, can we trust logs that longs wont change?

#### A4: It's a valid concern, but flexibility and consistency can coexist

Ultimately, the balance between flexibility and consistency lies in adopting
practices that allow for evolution while maintaining trust and reliability in
the data. Implemented to monitor and control changes to log structures. This
ensures that any modifications are deliberate, documented, and aligned with
organizational objectives.

The (valid) concern is that the structure of logs may evolve, backward
compatibility and durability of dashboards may suffer.

Ideas to solve this include:

1. Rigid Schema enforcement
1. Compiler assist in identifier generation

______________________________________________________________________

## Compatibility

### Q5: Does Dynamic Telemetry have it's own protocol?

Will Dynamic Telemetry invent a new protocol?

#### Q5 : No, Dynamic Telemetry operates within OpenTelemetry (OTLP, gRPC, etc)

Dynamic Telemetry adheres to the principles and protocols established by
OpenTelemetry. While there may be opportunities to enhance schema usage within
OpenTelemetry payloads, any such enhancements must remain fully compliant with
OpenTelemetry's standard protocols and specifications.

[https://github.com/open-telemetry/opentelemetry-proto/](https://github.com/open-telemetry/opentelemetry-proto/)

Where there could be some struggles; and something to monitor, is that Dynamic
Telemetry makes use of triggering
[Actions](./Architecture.Actions.Overview.document.md). These Actions benefit
from ability to decode and understand logging.

Where Dynamic Telemetry may find itself

Please see Q3 above, join a live
[Discussion](https://github.com/microsoft/DynamicTelemetry/discussions/40) or
study reading material below.

Reading Material:
[Stake Holder Documents](./PositionPaper.SharingDataAmongStakeHoldersIsHard.document.md)
[Clear Failure Schemas](./PositionPaper.ClearFailuresViaSchema.document.md)

### Q6: What is the Change Approach

Are we hoping to see lots of experimentation, or is this a community standards
approach, like IETF?

#### A6: Experimentation and Collaboration mostly - but it's a little of both

Dynamic Telemetry aims to provide a holistic vision and historical ledger for
observability and telemetry practices. While it is not explicitly designed to
dictate standards, it serves as a foundation for exploring innovative approaches
and fostering discussions around best practices. At the time of writing, it
remains uncertain whether specific implementations will emerge directly from
Dynamic Telemetry, but its role as a conceptual framework is clear.

Standards are more likely to emerge from established organizations such as IETF,
OpenTelemetry, and CNCF. These bodies are well-positioned to define and
formalize community-driven protocols and specifications. Dynamic Telemetry
complements these efforts by offering insights and ideas that could influence
the evolution of standards in the broader observability ecosystem.
