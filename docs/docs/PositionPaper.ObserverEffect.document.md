---
author: "Chris Gray"
status: ReviewLevel1b
---

# The Observer Effect

The Observer Effect in physics refers to the phenomenon where the act of
observing a system inevitably alters its state. This effect is often due to the
instruments used for measurement, which can interfere with the system being
observed. A classic example is the double-slit experiment in quantum mechanics,
where the presence of a detector changes the behavior of particles.,

Telemetry involves the collection of data that can influence the system being
monitored. One of the main risks of telemetry is the potential for reliability
and performance issues, as without care, its possible for the telemetry itself
to negatively influence the performance of the system -- and in some cases even
create crashes or failures. Both telemetry and the Observer Effect demonstrate
the balance between gaining insights and the unintended consequences of
measurement.

Comparing the two, while the Observer Effect is a fundamental concept in physics
that underscores the limitations of measurement at a quantum level, telemetry's
risks are more practical and immediate, impacting system performance and
reliability. In both cases, the challenge lies in minimizing the impact of
observation to ensure accurate and reliable data collection. Techniques such as
using less intrusive measurement tools in physics or implementing robust privacy
safeguards in telemetry can help mitigate these risks.

## Probes and Actions

Different probes used in telemetry and diagnostics come with their own set of
risks. For instance,**dynamic probes**in DynamicTelemetry can introduce
performance overhead, potentially affecting the system's efficiency and
reliability. These probes gather minimal amounts of memory and transform them
into standard OpenTelemetry Logs, which can then be fed into existing telemetry
pipelines. However, the process of setting up these probes, such as using
software or hardware breakpoints and eBPF may not always align with the
performance and reliability of their destination environment.

### Reliability Concerns

Of particular concern is the possibility that certain probe types may
inadvertently alter the **reliability characteristics** of a monitored system.
In some embodiments of telemetry, such as Event Tracing for Windows (ETW), it is
possible that merely listening to an event could cause the telemetry producer to
crash, hang, or otherwise enter a failing system state.

### Performance Concerns

Lastly, the**impact on system performance**is a significant concern. Probes,
especially those that enable CPU sampling or induce memory dumps, can introduce
latency and affect the overall performance of the system This is particularly
true for **actions** that involve diagnostic operations, which, while not
altering the system state, can still impact performance. Therefore, it is
essential to balance the need for detailed telemetry with the potential
performance costs.

## Taxonomy for Evaluating Probe and Action Risk

The Dynamic Telemetry system has developed a comprehensive taxonomy for both
probes and **actions**, recognizing that perceptions of operational risk vary
among different usage [personas](./Personas.Overview.document.md), and hosting
environments. This taxonomy enables DevOps teams, program managers, and
developers to collaboratively assess risks in a manner tailored to their
specific environmental needs.

Due to the extensive nature and potential changes in this taxonomy, a dedicated
section in the architecture documents covers dynamic telemetry. This section
will comprehensively describe how to quantify, measure, and communicate the
risks to different [personas](./Personas.Overview.document.md). Each of the
various probes and actions can be evaluated using a spider chart similar to, but
not identical to, the example below.

![](../orig_media/Risk.ETW.png){width="2.334905949256343in"
height="1.367047244094488in"}
![](../orig_media/Risk.eBPF.png){width="1.7892180664916886in"
height="0.9232370953630796in"}

In the above charts you'll see that the more area is shaded the more risk the
particular probe or action type brings. ETW (Windows), when configured
incorrectly may inadvertency modify system behavior - whereas eBPF intentionally
modifies system behavior, and therefore presents more risks to the different
user [personas](./Personas.Overview.document.md).

It is often also the case that with more risk comes more performance or more
flexibility.

**Dynamic Telemetry mandates** that a ***probe must not intentionally alter
system state***. This does not preclude the use of a probe type
akin to the ETW event in Windows with Dynamic Telemetry; however, it does mean
that the application of ETW within dynamic telemetry must not modify the system
state. Although this may initially seem prohibitively costly during a quick read
of this chapter; further details and expansion can be found within the linked
architecture section.

## Implications on Deployment

Implementations of Dynamic Telemetry must clearly communicate these requirements
at the configuration deployment stage using suitable gates, deployment rings,
and communication systems for the hosting environment.

