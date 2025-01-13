---
author: "Chris Gray"
status: ReviewLevel1b
---


Welcome to this demonstration of Dynamic Telemetry. In this demo, we will quickly take a broad survey of Dynamic Telemetry, highlighting key usage scenarios and important architectural points.

## Overview of Dynamic Telemetry

Dynamic Telemetry is an open-source diagnostic tool that complements OpenTelemetry. It aims to make debugging live production systems as easy and enjoyable as debugging a single application locally. Our goal is to allow you to diagnose and explore live production systems while minimizing risks to reliability, performance, or customer privacy.

## Value Proposition

Dynamic Telemetry builds on top of OpenTelemetry to provide advanced features for debugging, performance measurement, privacy and security hardening, as well as cost reduction. This overview will give you a broad understanding, with deeper dives into each of these scenarios available in later sections of this documentation.

## Demonstration

In this demonstration, we're going to how case the broad architecture points found in added Dynamic Telemetry.  We'll build on the standard OpenTelemetry Kubernetes sample without modifying or recompiling any code. This showcases the seamless integration and powerful capabilities of Dynamic Telemetry.

It is assumed that you already have an OpenTelemetry pipeline in place that houses your Logs, Metrics, and Traces in your preferred database. While our samples will utilize Azure technology, you are welcome to use any technology stack that suits your needs.

## Key Architectural Concept

Dynamic Telemetry, in short, is a dynamically controlled diagnostic control, that is inserted into
one of four location in your Open Telemetry pipeline.

Each insertion point, also called a Processor, accepts 

### Standard OpenTelmetry Architectural Overview



![](../orig_media/Architecture.Boxes.No.DynamicTelemetry.drawio.png)


### Addition on all four Dynamic Telemetry Processors

![](../orig_media/Architecture.Boxes.Yes.DynamicTelemetry.drawio.png)


### Capabilities of Dynamic Telemetry

1. KQL Filtering and Aggregation
1.

### Including Configuration Deployment Service

![](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png)

## Conclusion

Thank you for watching this demonstration of Dynamic Telemetry. We hope you see the immense value it brings to your debugging and diagnostic processes. For more information, please explore the detailed documentation and scenarios provided.