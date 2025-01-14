Welcome to this demonstration of Dynamic Telemetry. In this demo, we
will quickly take a broad survey of Dynamic Telemetry, highlighting key
usage scenarios and important architectural points.

## Overview of Dynamic Telemetry

Dynamic Telemetry is an open-source diagnostic tool that complements
OpenTelemetry. It aims to make debugging live production systems as easy
and enjoyable as debugging a single application locally. Our goal is to
allow you to diagnose and explore live production systems while
minimizing risks to reliability, performance, or customer privacy.

## Value Proposition

Dynamic Telemetry builds on top of OpenTelemetry to provide advanced
features for debugging, performance measurement, privacy and security
hardening, as well as cost reduction. This overview will give you a
broad understanding, with deeper dives into each of these scenarios
available in later sections of this documentation.

## Demonstration

In this demonstration, we're going to how case the broad architecture
points found in added Dynamic Telemetry. We'll build on the standard
OpenTelemetry Kubernetes sample without modifying or recompiling any
code. This showcases the seamless integration and powerful capabilities
of Dynamic Telemetry.

It is assumed that you already have an OpenTelemetry pipeline in place
that houses your Logs, Metrics, and Traces in your preferred database.
While our samples will utilize Azure technology, you are welcome to use
any technology stack that suits your needs.

## Key Architectural Concept

Dynamic Telemetry, in short, is a dynamically controlled diagnostic
control, that is inserted into one of four architectural locations in
your existing Open Telemetry pipeline.

Each insertion point, also called a Processor, accepts configuration
from a remote configuration deployment server, and intercepts all open
telemetry logs metrics and traces that are being emitted and passed
through that architectural point in the below diagram.

### Standard OpenTelmetry Architectural Overview

In the diagram below, you will observe a typical OpenTelemetry
architecture, where multiple agents transmit their telemetry data
through the kernel of their host operating system.

In some OpenTelemetry architectures, the aggregation process and kernel
are omitted in favor of direct ingestion from an agent. These
architectures are usually employed in small to medium-sized
installations. Although they function similarly, these variations are
not the focus of this demonstration.

![](../orig_media/Architecture.Boxes.No.DynamicTelemetry.drawio.png){width="5.5in"
height="2.185044838145232in"}

### Addition on all four Dynamic Telemetry Processors

The diagram below shows the installation of dynamic telemetry processors
in four different architectural locations.

1.  In process of the emitting agent

2.  In the kernel of the Operation System hosting the agent

3.  In the aggregation process that is about to emit to the ingestion
    gateway

4.  At the point of ingestion

The Processor section of this document expands upon these four different
insertion points more thoroughly but in short each of them have benefits
and costs and while functionally similar some care needs to be taken to
make sure the correct one is chosen.

![](../orig_media/Architecture.Boxes.Yes.DynamicTelemetry.drawio.png){width="5.5in"
height="2.185044838145232in"}

### Capabilities of Dynamic Telemetry

With a basic understanding of where architecturally dynamic telemetry
can be inserted into the open telemetry pipeline it\'s important to
understand the types of operations that dynamic telemetry can offer.

1.  Dropping Logs or Metrics

2.  Adding Logs or Metrics

3.  Converting Logs into Metrics

4.  Dropping fields in Logs

5.  Adding fields to Logs

6.  Maintaining state / awareness

#### Sample KQL Filter dropping fields in a Log

#### Sample Log to Metric conversion

#### Sample eBPF Log Drop

### Including Configuration Deployment Service

Since every deployment environment has unique characteristics and
tolerances for risk, dynamic telemetry leverages the inherent code and
configuration of the infrastructure\'s deployment systems. Further
details on this topic are provided in subsequent sections. It is
essential to consider configuration deployment as the most efficient
mechanism that ensures responsible usage within the hosted environment.

![](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png){width="5.5in"
height="3.0075524934383204in"}

## Conclusion

Thank you for watching this demonstration of Dynamic Telemetry. We hope
you see the immense value it brings to your debugging and diagnostic
processes. For more information, please explore the detailed
documentation and scenarios provided.
