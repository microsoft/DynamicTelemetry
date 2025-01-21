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


## Scenarios

<div class="grid cards" markdown>

-   :material-speedometer: [**Performance and Diagnostics**](./Scenarios.Overview.DeepDiagnostics.document.md)

    Disable diagnostic telemetry when systems are stable; enable it when
    they are not. Quickly trigger memory dumps or collect CPU samples
    during production issues. Deploy observers to monitor telemetry and
    gather extra diagnostic data, only when needed. 

    ![type:video](../orig_media/DynamicTelemetry_DiagnosticVideo.mp4)

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

    ![type:video](../orig_media/DynamicTelemetry_CostSavings.mp4)
</div>