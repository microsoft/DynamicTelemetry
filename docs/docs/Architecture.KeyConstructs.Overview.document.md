---
author: "Chris Gray"
status: ReviewLevel1b
---

# Survey: Filters, Flight Recorders, and Actions

![](../orig_media/KeyConstructs.banner.png)

If there is any aspect of Dynamic Telemetry that requires thorough
understanding, it is the critical distinction between static telemetry and
Dynamic Telemetry. At its core, this distinction represents the transition from
hard-coded, static assets to more versatile and reconfigurable Dynamic
Telemetry. This distinction forms the foundation of Dynamic Telemetry.

The four Constructs of Dynamic Telemetry are

1. a [Probe](./Architecture.Probes.Overview.document.md)
1. a [Filter](./Architecture.Components.FiltersAndRouters.document.md)
1. a [Flight Recorder](./Architecture.FlightRecorder.Overview.document.md)
1. a [Action](./Architecture.Actions.Overview.document.md)

## What is a Probe{.unlisted .unnumbered}

A Dynamic Telemetry Probe is a lightweight mechanism that emits events (logs)
within a running system. A Probe is usually specific to the operating system and
native to that environment. For example, it could be the Event Tracing for
Windows (ETW) system within Windows, user events within Linux syslog, or even
OpenTelemetry on cross-platforms.

### Examples of Dynamic Probes{.unlisted .unnumbered}

Dynamic Probes can take various forms depending on the system and requirements.
Examples include uprobes or kprobes, which are used in Linux for tracing
user-space and kernel-space events, respectively. Software breakpoints are
another type of probe, often used in debugging to halt program execution at a
specific point. Hardware breakpoints, on the other hand, leverage the
processor's debugging facilities to monitor memory access or code execution.
Additionally, eBPF (extended Berkeley Packet Filter) programs provide a powerful
and flexible way to insert dynamic probes into the Linux kernel, enabling
detailed performance monitoring and security analysis.

In essence, a Probe is a logging event emitter. In a static telemetry system, it
represents the legacy-based approach where logging events are hard-coded into
the application. This means that any changes to what is logged or how it is
logged require modifications to the source code and a subsequent redeployment of
the application. Dynamic Telemetry Probes by contrast offer a more flexible and
adaptable solution. They allow for the insertion, modification, and removal of
logging events without altering the application code. This dynamic nature enables
real-time adjustments to telemetry data collection, facilitating more responsive
and efficient monitoring and diagnostics.

## What is a Flight Recorder{.unlisted .unnumbered}

A Flight Recorder is essentially a ring buffer of logs with a unique identifier
or name. It acts as a designated collector of routed logging data. In its
simplest form, a Flight Recorder might be a memory buffer. In other
implementations, it could be a file on disk.

The two key characteristics of a Flight Recorder are:

1. that it is uniquely identifiable
1. that it contains logs

## What is a Filter/Router/Adapter{.unlisted .unnumbered}

Imagine an OpenTelemetry pipeline as a pipe of water. Cutting the pipe and
adding a filter or diverter would allow you to control the flow. A fully
blocking filter could be considered a valve. The use of filters and routers
allows the dynamic shaping and routing of telemetry - much like valves and
filters in a water system.

Dynamic Telemetry Filters, Routers, and Adapters can be thought of as specific
purpose, narrowly focused, subcategories of OpenTelemetry {connector,
exporter, processor, and router}.

??? info "Help Needed From OpenTelemetry experts"
    Dynamic Telemetry is trying to describe core architectural components like
    Filter / Router / Adapter, in a way that can span into operating system tech
    as well as within OpenTelemetry

    We realize there is some name overloading with standard OpenTelemetry, as
    well as within the OTel-Arrow project

    [Please Join This Discussion to provide advice](https://github.com/microsoft/DynamicTelemetry/discussions/38)

    We need to contrast / align with the following (among others):

    * [otel-arrow Processor](https://github.com/lquerel/otel-arrow/blob/dataflow-doc/rust/beaubourg/docs/dataflow-design.md#processors)
    * [otel-Processor](https://opentelemetry.io/docs/collector/architecture/#processors)
    * [otel-Exporter](https://opentelemetry.io/docs/collector/architecture/#exporters)
    * [otel-Receiver](https://opentelemetry.io/docs/collector/architecture/#receivers)
    * [otel-Routing Connector](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/connector/routingconnector)
    * [otel-failoverconnector](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/connector/failoverconnector)

*Dynamic Telemetry Terms:*

* A filter is a Dynamic Telemetry construct used to filter and route logging
  that is already inside an OpenTelemetry pipeline.
* A Router is a dynamic telemetry construct that allows the data pipeline to be
  cut and forked. For example, it can connect two different processors, perhaps
  one that streams into an OpenTelemetry backend while the other goes into a
  Flight Recorder.
* An Adapter allows the adaptation of existing non-OpenTelemetry and often
  platform-specific telemetry into the OpenTelemetry pipeline. For example,
  syslog, LTTng, or ETW on Windows.

## What is a Processor{.unlisted .unnumbered}

A Processor is the dynamic component of Dynamic Telemetry where various
scenarios and applications are manifested. The simplest way to think of a
Processor is as a place for compute to be applied with dynamic configuration
that sits inside the OpenTelemetry data feed.

Simple examples of a Processor include:

- Counting and aggregating log messages.
- Auditing Logging for PII or unintentional secret egress.
- Converting verbose logs into metrics.
- Monitoring logs to invoke an Action when a problem occurs.

## What is an Action{.unlisted .unnumbered}

An Action is an architectural construct that performs tasks based on the logging
data it observes passing through a pipeline.

Consider a log message indicating a failure in some business logic, such as a
multi-step transaction failure. If a listener of this log message decides to
take action, for example, by collecting a memory dump or starting a CPU sample,
this actor would be referred to as an Action.

Actions can manipulate constructs like Filters, Probes, and Flight Recorders.
For example, by configuring a Filter to detect memory management logs, you can
direct those logs to a specialized Flight Recorder Action designed for
diagnosing memory leaks. This Flight Recorder can capture snapshots of heap
usage or detailed allocation patterns whenever the filter's trigger conditions
are met. This enables quick identification of problematic regions within the
application's memory footprint without continuously running resource-intensive
diagnostics.
