---
author: "Chris Gray"
status: ReviewLevel2
---

# Processor

A Dynamic Telemetry Processor is a small piece of software that resides in the
OpenTelemetry data stream and reads telemetry as it passes. The Processor
connects various architectural components, such as an action or a probe,
enabling the transformation of a log into a metric, the removal of a log, or the
removal of a field within a log.

Dynamic Telemetry categorizes Processors into three distinct types, each with
varying levels of complexity and associated risk. These types are a Language
Processor, a Query Language Processor, and a State Machine Processor.

Before delving into the differences among these three types, it is essential to
discuss the four different locations that can house a query Processor.

## Locations in OpenTelemetry that may contain a Processor

![](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png)

## Processor Types

It's expected within Dynamic Telemetry that multiple different Processor types
are created over the course of time because there are requirements on the
Processor in order to meet other obligations, such as safety and performance,
all Processors must meet certain set of requirements, specifically in the event
they are running out of specification they are all configured to automatically
disable.

There are three different types of Processors each with varying degrees of
complexity first is a simple query language Processor where the durable
identifier structure payloads are utilized to simply drop or simply transform a
log message.

The second is a state model Processor, which is similar to a query language
Processor but introduces actions and probes. These capabilities include
triggering CPU sampling, performing memory dumps, or temporarily toggling the
verbosity of logging and sampling.

The third component is a language Processor, which is the most complex of the
three. A language Processor introduces scriptability or programming capabilities
in line with the production of telemetry. Due to the requirements on the
Processor (discussed further below), it is likely that language Processors will
resemble something similar to eBPF. These Processors execute within a sandbox
that restricts both the memory accessed and the number of instructions executed.

### Query Language Processor

[A Query Language Processor](./Architecture.Processor.QueryLanguage.document.md)
is the simplest type of Processor. It acts as a filter that is applied directly
to the OpenTelemetry data stream, allowing for straightforward transformations
or the removal of specific log messages.

As demonstrated in the example from our
[sample using the Kusto Query Language (KQL)](./Demos.HighLevel.Overview.md), we
identify and drop an individual log message.

```cdocs_include
{{ CSharp_Include("../Samples/Demos.3.SecurityRedaction/Pages/Index.cshtml.cs",
    "// StartKQL:FilterWholeLog",
    "// EndKQL:FilterWholeLog")
}}
```

In the example below, we are modifying the log message to drop a particular
field.

```cdocs_include
{{ CSharp_Include("../Samples/Demos.3.SecurityRedaction/Pages/Index.cshtml.cs",
    "// StartKQL:FilterField",
    "// EndKQL:FilterField")
}}
```

By using your imagination, you can see many opportunities for this KQL language.
For example, you could filter out logs that are not relevant to a specific
analysis, transform log data to fit a particular schema, or even aggregate data
to generate metrics on the fly.

### State Model Processor

[A State Model Processor](./Architecture.Processor.StateMachine.document.md)
is our next most sophisticated and complex Processor. Similar to a Query
Language Processor, the State Model Processor uses a simple configuration file.
However, instead of merely providing filtering and aggregation, it allows for
the construction of simple state machines that operate on the code as it runs.

The State Model Processor also introduces the concept of
[probes](./Architecture.Probes.Overview.document.md) and
[actions](./PositionPaper.Actions.document.md), which are discussed in further
sections.

Simple applications of a State Model Processor might include the dynamic
enablement and disablement of verbose logs in specific situations. For example,
when an error occurs, you may wish to enable higher volume telemetry for a
period of five minutes.

Other actions include the ability to capture a memory dump. For instance, you
might capture a memory dump if a particular error is emitted in a log.

### Language Processor

[The Language Processor](./Architecture.Processor.Language.md) is the
most complex type of Processor. In addition to the ability to dynamically
migrate state transitions, it introduces the capability to allocate small
amounts of memory and perform simple computations and calculations.

Like other Processors, the Language Processor is governed and managed according
to the strict requirements found in Dynamic Telemetry. You can read more about
the taxonomy that Dynamic Telemetry uses to classify and manage risks in this
[section of the documentation](./PositionPaper.ProbeRiskLevels.document.md).

Dynamic Telemetry proposes using a technology similar to eBPF, where a sandboxed
virtual machine is employed to ensure performance and reliability guarantees.

## Requirements on a Processor

A Processor is more complicated than it may seem at first blush. Simply
injecting code in line to a telemetry pipeline sounds great at first, but there
can be real risks as described in the
[Observer Effect](./PositionPaper.ObserverEffect.document.md) section of this
documentation.

In short, the Observer Effect is a reality where the act of observing a system
can actually result in changes to the system, often with detrimental irony.

To address this, a Processor must meet the following requirements:

1. By design, it does not modify the system state.
1. Each pillar in [Probe Risk](./Architecture.Probes.Overview.document.md) is
   supported by a measurement mechanism.
1. Each measurement is communicated to the user in a simple and understandable
   manner.
1. Each measurement has an upper bound or ceiling that is always enforced in
   conjunction with the Processor.
1. Should the upper bound be exceeded, the Processor will automatically disable.

These requirements are serious and will influence how Dynamic Telemetry is used
in practice.

There will be scenarios where Dynamic Telemetry could be useful that will not be
applicable as a result. And this is OK.

It is the belief of Dynamic Telemetry's designers that having limitations to the
application is necessary in order to provide a trustworthy diagnostic system
that is suitable for use within a large cloud environment.

In short, we take the
[Observer Effect](./PositionPaper.ObserverEffect.document.md) seriously.
