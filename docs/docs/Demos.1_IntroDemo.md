---
author: "Chris Gray"
status: ReviewLevel1
---

# DynamicTelemetry : Introduction Demo

1. Showcase each of the big pieces
1. Line of code along with a OpenTelemetry log
1. UI to configure a trigger
1. deploy
1. view results in Grafana and Kusto

## Architectural Overview Video #2

Introducing DynamicTelemetry, an OpenSource, diagnostic compliment to OpenTelemetry.

The DynamicTelemetry development team wants to make debugging production software as
 easy and enjoyable as debugging locally. We want you to be able to diagnose and
  explore live production systems without compromising reliability, performance,
   or customer privacy.

In this video, we will give you an overview of the main architectural components
 of DynamicTelemetry. As you watch the video, please pay attention to the
 following points:

- DynamicTelemetry builds on popular open source tools and libraries like
OpenTelemetry, Grafana, and Prometheus
- DynamicTelemetry lets you dynamically reshape your existing OpenTelemetry, without
redploying.

- Lets dive into some scenario demos.  Each of these demos is additive,


   * Suppress all or portions of Logs and Traces, convert Logs into Metrics
   * Create new Logs, based on dynamically applied state machines
   * Or even create Telemetry, where it doesnt exist - by applying a dynamic
   probe
