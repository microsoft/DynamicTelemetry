---
author: "Chris Gray"
status: ReviewLevel2
description : Introduction to DynamicTelemetry
---

# Dynamic Telemetry

![image](../orig_media/DynamicTelemetry.logo.png){width="5.5in"
height="1.261111111111111in"}

Introducing DynamicTelemetry, an OpenSource, diagnostic compliment to
OpenTelemetry.

The DynamicTelemetry development team wants to make debugging highly
scaled production software as easy and enjoyable as debugging one
application locally. We want you to be able to diagnose and explore
live production systems without compromising reliability,
performance, or customer privacy. 

In this introduction, you will learn about DynamicTelemetry, an
open-source diagnostic tool that blends traditional symbolic
debuggers with advanced new complements to your existing
OpenTelemetry assets and workflows. You will be presented with five
architectural components that, when used together, bring the peace
and calm of local debugging into the distributed cloud. 

Before diving into the overall architecture, let's watch a quick
demonstration that will showcase the end-to-end workflow. 

In this high-level demonstration, we've added DynamicTelemetry to
the standard OpenTelemetry Kubernetes sample but otherwise have not
modified (or even recompiled) any code from the OpenTelemetry
sample. 

After the demo, please 'choose your own adventure' by continuing to
read along one of the four tracks found below. 

## DynamicTelemetry Intro Demo

[Introduction Demo](./Demos.HighLevel.Overview.md)

<iframe src="https://microsoft-my.sharepoint.com/personal/chgray_microsoft_com/_layouts/15/embed.aspx?UniqueId=b4075e2f-89c5-4907-94ed-966cded40b4f&embed=%7B%22ust%22%3Atrue%2C%22hv%22%3A%22CopyEmbedCode%22%7D&referrer=StreamWebApp&referrerScenario=EmbedDialog.Create" width="640" height="360" frameborder="0" scrolling="no" allowfullscreen title="DynamicTelemetry_IntroVideo.mp4"></iframe>


<!--![type:video](../DynamicTelemetry_IntroVideo.mp4)){: style='width: 100%'}
[Introduction Demo #1](./Demos.1_IntroDemo.md)-->

## Usage Personas

DynamicTelemetry is a diagnostic system useful to many different
audiences, each of whom have similar, but different interests. 

To better cater our introductory documentation to each of these
audiences, we've broken the content into personas and scenarios.
This is only to simplify understanding, by presenting content in
different orders. We will make use of URL's to cross reference
content that may be interesting to multiple personas. 

## Personas

<div class="grid cards" markdown>

-   :material-human: [**Developer**](./Persona_Developer.document.md)

    A programmer of Cloud Scale services, who is looking to add
    diagnostic probing, to their use of OpenTelemetry.

-   :material-microsoft-azure-devops: [**DevOps**](./Persona_DevOps.document.md)

    Someone monitoring a cloud service may want to gain insights without
    involving their development team. They may want to suppress chatty
    events, turn events into metrics, or suppress erroneous logs,
    metrics, or events.

-  :scientist: [**Data Analyst**](./Persona_DataAnalysis.document.md)

    Someone who would value better understanding of a Developers intent.
    For example how many items should be on a queue, what response
    latencies were expected when a piece of code was authored. 

-   :material-store: [**Project Manager**](./Persona_ProjectManager.document.md)

    Someone responsible for planning, executing, and overseeing projects
    to ensure they are completed on time, within scope, and within
    budget. 

</div>

## Scenarios

<div class="grid cards" markdown>

-   :material-speedometer: [**Performance and Diagnostics**](./Scenarios.Overview.DeepDiagnostics.document.md)

    Disable diagnostic telemetry when systems are stable; enable it when
    they are not. Quickly trigger memory dumps or collect CPU samples
    during production issues. Deploy observers to monitor telemetry and
    gather extra diagnostic data, only when needed. 

-   :shield: [**Privacy and Security**](./Scenarios.Overview.RedactingSecrets.document.md)

    Detect and immediately suppress sensitive (or expensive) fields
    within Logs, should they inadvertently contain sensitive information
    such as PATs, IP addresses, user information, or crypto keys. Remove
    these, at their source, instantly - without rebuild or redeploy. 


-   :fontawesome-solid-dog: [**Reliability**](./Scenarios.Overview.Reliability.document.md)

    Test your services more effectively; make your Production code self
    diagnose. Couple the self diagnostics with Actions that toggle up
    and down telemetry volume, collect memory dumps, and CPU samples. 

-   :material-view-dashboard: [**Durability - Dashboards and Alerts**](./Scenarios.Overview.DurableDashboards.Alerts.document.md)

    Develop flexible schemas in your logs, metrics, and traces that
    enhance the durability of your dashboards and streamline
    communication between coworkers. Enable AI to find problems on your
    behalf. 

-  :moneybag: [**Cost Reduction**](./Scenarios.Overview.CostReduction.document.md)

    Convert verbose logs into concise metrics, suppress large payloads,
    or drop unnecessary logs. 

    </div>
