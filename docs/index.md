---
author: "Chris Gray"
status: ReviewLevel1_Phase1
description : Introduction to DynamicTelemetry
---
#

![image](./orig_media/DynamicTelemetry.logo.png)

Introducing DynamicTelemetry, an OpenSource, diagnostic compliment to
OpenTelemetry.

The DynamicTelemetry development team wants to make debugging highly
scaled production software as easy and enjoyable as debugging one
application locally. We want you to be able to diagnose and explore live
production systems without compromising reliability, performance, or
customer privacy.

In this introduction, you will learn about DynamicTelemetry, an
open-source diagnostic tool that blends traditional symbolic debuggers
with advanced new complements to your existing OpenTelemetry assets and
workflows. You will be presented with five architectural components
that, when used together, bring the peace and calm of local debugging
into the distributed cloud.

Before diving into the overall architecture, lets watch a quick
demonstration that will showcase the end to end workflow.

In this high-level demonstration, we've added DynamicTelemetry to the
standard OpenTelemetry Kubernetes sample, but otherwise have not
modified (or even recompiled) any code from the OpenTelemetry sample.

After the demo, please 'choose your own adventure' by continuing to read
along one of the four tracks found below.

## \[TODO\] DynamicTelemetry Intro Demo

[Introduction Demo #1](./docs/Demos.1_IntroDemo.md)

## Usage Personas

DynamicTelemetry is a diagnostic system useful to many different
audiences, each of whom have similar, but different interests.

To better cater our introductucory documentation to each of these
audiences, we've broken the content into personas and scenarios. This is
only to simplify understanding, by presenting content in different
orders. We will make use of URL's to cross reerence content that may be
interesting to muttiple personas.

## Personas

<div class="grid cards" markdown>

- [**DEVELOPER**](./docs/Persona_Developer.document.md)



   A programmer of Cloud Scale services, who is looking to add
    diagnostic probing, to their use of OpenTelemetry.



-   [**DEVOPS**](./docs/Persona_DevOps.document.md)


    Someone monitoring a cloud service may want to gain insights without
    involving their development team. They may want to suppress chatty
    events, turn events into metrics, or suppress erroneous logs,
    metrics, or events.



-   [**DATA_ANALYST**](./docs/Persona_DataAnalysis.document.md)


    Someone who would value better understanding of a Developers intent.
    For example how many items should be on a queue, what response
    latencies were expected when a piece of code was authored.



-   [**PROJECT_MANAGER**](./docs/Persona_ProjectManager.document.md)



    Someone who wants to understand a developer's intent may want to
    know how many items should be on a queue or what response latencies
    were expected when a piece of code was authored.

</div>


## Scenarios

<div class="grid cards" markdown>

-   [**Cost Reduction**](./docs/Scenarios.CostReduction.document.md)

    Learn to dynamically turn chatty Logs into compact Metrics, to suppress large payloads
    or to even drop unnecessary logs.

-   [**Performance Improvements**](./docs/Scenarios.PerformanceImprovements.document.md)

    Learn to use Dynamic Telemetry to initiate CPU sampling, when your services are misbehaving.  Or Toggle off large swaths of diagnsotic telemetry, when your systems are operating Nominally.

-   [**Redacting Secrets**](./docs/Scenarios.RedactingSecrets.document.md)

    In the rare case that you've discovered Logs/Metrics/Spans that contain secrets (PATs, keys, etc) use Dynamic Telemetry to silence them at the source; with a speed faster than a rebuild/redeploy.

-   [**Deep Diagnostics**](./docs/Scenarios.DeepDiagnostics.document.md)

    Learn advanced diagnostic tricks to trap your bugs;  initiate memory dumps when your leaking memory, start CPU sampling when you're operating slowly, or dynamically toggle up telemetry volume when your system is misbehaving.

-   [**Reliability**](./docs/Scenarios.Reliability.document.md)

    Use Dynamic Telemetry to cleverly test your services;  author tests that use your Logging to spot issues - both before AND after you deploy.

-   [**Durable Dashboards and Alerts**](./docs/Scenarios.DurableDashboards.Alerts.document.md)

    Dynamic Telemetry can make your dashboards and alerts far more durable than using logs.  Take advantage of flexible schemas, to connect your dashboards and your tests - spot issues before and in production.

</div>