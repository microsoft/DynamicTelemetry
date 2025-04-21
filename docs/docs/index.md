---
author: "Chris Gray"
status: ReviewLevel2
description : Introduction to DynamicTelemetry
---

# Introduction to Dynamic Telemetry

![image](../orig_media/DynamicTelemetry.logo.png){width="5.5in"
height="1.261111111111111in"}

Introducing DynamicTelemetry, an OpenSource, diagnostic complement to
OpenTelemetry.

**The DynamicTelemetry project aims to make debugging highly scaled
production software as easy and enjoyable as debugging a single application
locally.** Engineers should be able to diagnose and explore live production
systems without compromising reliability, performance, or customer privacy.
***Dynamic Telemetry is a collaborative effort and a shared vision***; We are
actively exploring it and we welcome your contributions.

Historically telemetry has focused on collecting large volumes of statically
configured information, then mining it later in hopes that it is useful.
This often leads to storing vast amounts of rarely used data 'just in case', yet
failing to anticipate other data that will be needed in the future. We want to let
engineers reconfigure the telemetry being sent by production systems in real-time,
creating tight feedback loops and more useful telemetry.

In this introduction, lets explore a hypothetical new telemetry experience
that blends traditional symbolic debuggers with advanced new complements to
your existing OpenTelemetry assets and workflow. You will be
presented with five architectural components that, when used together, bring the
peace and calm of local debugging into the distributed cloud.

Before diving into the overall architecture, let's watch a quick demonstration
that will showcase the end-to-end workflow.

In this high-level demonstration, we've added DynamicTelemetry to the standard
OpenTelemetry Kubernetes sample but otherwise have not modified (or even
recompiled) any code from the OpenTelemetry sample.

After the demo, please 'choose your own adventure' by continuing to read along
one of the five scenarios themes found below.

## Common Scenarios {.unlisted .unnumbered}

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
