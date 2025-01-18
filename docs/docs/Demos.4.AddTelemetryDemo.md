---
author: "Chris Gray"
status: ReviewLevel1
---

# Diagnostic Demo : Dynamically Adding a Row of Telemetry
In a live production system, diagnostics and debugging can be challenging due to log [scarcity](./PositionPaper.ScarcityAndHumans.md). This often leaves developers guessing about the behavior of their code. Sometimes, simply knowing the value of a variable or two can provide significant insights into the problem.

In this example, we will use dynamic telemetry probes to insert a specialized breakpoint into our code. This will allow us to dynamically extract small amounts of memory and insert it into our existing OpenTelemetry pipelines.

## Demo Overview

In short this demo will

1. Use a Breakpoint Probe to dynamically insert a row of telemetry to emit the contents of a variable into our standard OpenTelemetry pipelines.
2. Deploy this Dynamic Telemetry probe to a small number of machines that we expect to be impacted.
3. Connect to Application Insights and View / Graph / Alert this value.


# Dynamically insert a row of telemetry to emit the contents of a variable into our standard OpenTelemetry pipelines.

For this demo, we will make use of the [Breakpoint Probe](./Architecture.Probe.Breakpoint.document.md) concept in Dynamic telemetry, Our [Action](./Architecture.Action.Explanation.document.md). Will not be a complicated action such as collecting a memory dump, starting a CPU sample, or toggling on or off diagnostic logs, even though Each of these are a possibility.

For our application, we simply want to know the value of a memory variable when our probe is

To achieve a good developer workflow. We will use the Visual Studio Code source editor To locate the line of code where we wish to Extract some memory.

Please quickly scan over the following piece of code. You don't need to understand all of it, just get a general idea of the page model. The key observation is that in the `OnGet` method, we receive a variable from the user and use that variable as a key in the cache, which is kept 30 minutes.

Every time `OnGet` is called, a counter on the cached object will be incremented via the `AddUsage` function.

```cdocs_include
{{ CSharp_Include("../Samples/Demos.4.InsertTelemetry/Pages/Index.cshtml.cs",
    "// StartExample:InsertTelemetry",
    "// EndExample:InsertTelemetry")
}}
```

Please recall this sample is just that, a sample. To illustrate the use case, let's assume that as our system scales, we notice performance issues. Our development team suspects that the cache is getting full, causing paging issues on our drives. They are considering investigating the 30-minute time span, as it might be too long.

To better understand the problem, the developers would like to know how many items are in the cache while under load. One of the developers got the idea to use dynamic telemetry to simply emit the cache size as a telemetry variable and then graph it using their standard OpenTelemetry pipelines.

```cdocs_include
{{ CSharp_Include("../Samples/Demos.4.InsertTelemetry/Pages/Index.cshtml.cs",
    "// StartExample:InsertTelemetryOnGet",
    "// EndExample:InsertTelemetryOnGet")
}}
```


# Deploy this Dynamic Telemetry probe to a small number of machines that we expect to be impacted.

Deployment into your environment is flexible, as Dynamic Telemetry
offers various configuration methods. Depending on your needs, you may
choose different techniques and deployment speeds.

For instance, a large cloud provider might prefer a gradual deployment
of Dynamic Telemetry configurations. In contrast, small or medium-sized
companies might find benefits in deploying them instantaneously.

This decision is largely personal, and the necessary information and
knowledge to make an informed choice are detailed further in other
sections of this documentation.

For our purposes, we will deploy this rapidly for demonstration
purposes.


## Connect to Application Insights and View / Graph / Alert this value.

Because the break point probe conforms to a dynamic telemetry specification. The memory that is is collected will be emitted into a standard open telemetry. Logging message. That includes the. Desired contents.
