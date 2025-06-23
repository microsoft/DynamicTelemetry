---
author: "Chris Gray"
status: ReviewLevel1b
---

# Costs Reduction

![image](../orig_media/CostSavings.banner.png)

Dynamic Telemetry is a powerful tool that can be used to significantly reduce
costs by converting logs into metrics dynamically. This capability allows
organizations to gain valuable insights without the overhead of storing and
processing large volumes of log data. By transforming logs into metrics,
businesses can focus on the most critical data points, leading to more efficient
resource utilization and cost savings.

One of the key features of Dynamic Telemetry is its ability to measure and
suppress chatty telemetry. Chatty telemetry refers to the excessive and often
redundant logging that can occur in a system, leading to increased storage and
processing costs. With Dynamic Telemetry, organizations can rapidly turn off and
turn on chatty logs, ensuring that only the most relevant data is captured and
analyzed. This dynamic control over telemetry helps in maintaining a balance
between comprehensive monitoring and cost efficiency.

By leveraging Dynamic Telemetry, businesses can not only optimize their logging
practices but also enhance their overall observability and diagnostics. This
approach ensures that resources are allocated effectively, reducing unnecessary
expenditures and improving the bottom line.

![type:video](../orig_media/DynamicTelemetry_CostSavings.mp4)

## Introducing Your Tools : [Filtering](./Architecture.Components.FiltersRoutersAndAdapters.document.md), [Flight Recorders](./Architecture.FlightRecorder.Overview.document.md), and [Converting Logs to Metrics](./Architecture.Components.Processor.Overview.document.md)

Converting logs into metrics is a powerful technique used in Dynamic Telemetry
to optimize monitoring and reduce the overhead associated with storing and
processing large volumes of log data. This process involves several key steps:

1. **Log Collection**: The first step is to collect logs from various sources
   within the system. These logs contain detailed information about events and
   operations occurring within the system.

1. **Log Filtering and Aggregation**: Once the logs are collected, they are
   filtered and aggregated to extract meaningful data. This is where the query
   language processor comes into play. It integrates into the logging stream,
   monitoring events by applying straightforward query language filtering and
   aggregate functions. This helps in reducing the volume of data by focusing on
   the most critical information.

1. **Metric Conversion**: After filtering and aggregation, the relevant log data
   can be converted into metrics.

1. **Metric Emission**: The final step is to emit the metrics into your standard
   and existing metrics solution / dashboard. These metrics provide a high-level
   overview of the system's performance and can be used to track key performance
   indicators (KPIs) and other important metrics.

By converting logs into metrics, you can gain valuable insights without the
overhead of storing and processing large volumes of log data. This approach
ensures that resources are allocated effectively, reducing unnecessary costs,
improving search performance, and improving the bottom line.

## Understanding By Example

### Organize Chatty Diagnostic Logs into Toggle Traces

Toggle Traces are perhaps one of the most interesting features of Dynamic
Telemetry. Toggle traces refer to the ability to dynamically enable or disable
specific tracing points within a system. This feature is particularly useful in
scenarios where you need to control the verbosity of logging without redeploying
or restarting the application. By dynamically toggling traces on and off, you
can focus on capturing the most relevant data for diagnostics and performance
monitoring, while suppressing unnecessary or "chatty" logs that can lead to
increased storage and processing costs.

The on/off switch doesn't have to be manually flipped; telemetry can be bundled
into themes, and these themes can be toggled on/off based on system observation.

In the context of Dynamic Telemetry, toggle traces allow you to:

1. **Enable or Disable Tracing Points**: You can turn on or off specific tracing
   points based on the current diagnostic needs. This helps in reducing the
   overhead associated with continuous logging.

1. **Control Log Verbosity**: By toggling traces, you can adjust the level of
   detail captured in the logs. This is useful for isolating issues without
   being overwhelmed by excessive log data.

1. **Dynamic Adjustments**: Toggle traces provide the flexibility to make
   real-time adjustments to the logging configuration. This means you can
   respond to issues as they arise without waiting for a new deployment cycle.

For example, if you notice that a particular component is generating too many
logs, you can dynamically disable the tracing for that component. Conversely, if
you need more detailed information about a specific operation, you can enable
additional tracing points to capture that data.

This approach ensures that you have the right balance between comprehensive
monitoring and cost efficiency, allowing you to maintain optimal system
performance while still gathering the necessary diagnostic information.

### Drop Chatty / Unused Logs

Not all telemetry data remains valuable over time. Chatty telemetry, which
refers to excessive and often redundant logging, can become a burden rather than
a benefit. Initially, this type of telemetry might have been useful for
diagnosing issues and understanding system behavior, but as the system evolves,
the relevance of such detailed logs can diminish.

Dropping chatty telemetry that once was useful but now is not can lead to
significant improvements in system performance and cost efficiency. By
eliminating unnecessary logs, organizations can reduce the storage and
processing overhead associated with handling large volumes of data. This not
only frees up resources but also enhances the overall observability and
diagnostics of the system. With fewer logs to sift through, it becomes easier to
focus on the most critical data points, leading to more effective monitoring and
quicker issue resolution.

Moreover, the dynamic control over telemetry allows for a more flexible and
responsive approach to system monitoring. By selectively enabling or disabling
specific tracing points, businesses can maintain a balance between comprehensive
monitoring and cost efficiency. This approach ensures that only the most
relevant data is captured and analyzed, reducing the noise and improving the
signal-to-noise ratio in the telemetry data. Ultimately, dropping chatty
telemetry that is no longer useful helps in maintaining optimal system
performance while still gathering the necessary diagnostic information1.

## A Deeper Understanding : Removing the Worry of Scarcity in your Dev Team

The fear of not having enough telemetry can be a significant source of anxiety
for engineers and administrators. Telemetry data is crucial for understanding
the health and performance of a system, and the absence of sufficient data can
lead to a feeling of uncertainty and worry. This fear often stems from the
concern that without adequate telemetry, it may be challenging to identify and
resolve issues promptly, potentially leading to system downtime or degraded
performance.

Safe deployment practices, such as deploying software in rings gradually over
time, can inadvertently exacerbate this anxiety. While these practices are
designed to minimize the risk of widespread issues by releasing updates to a
small subset of users before a broader rollout, they can also heighten the fear
of missing critical telemetry during the initial deployment phases. This
incremental approach may compel engineers to enable extensive logging to capture
every possible issue that might arise in the early rings, fearing that any gap
in data could lead to undetected problems. Consequently, the drive to ensure
comprehensive monitoring in these controlled environments can result in an
overwhelming volume of log data, compounding the challenges of managing and
analyzing telemetry effectively.

This anxiety can drive individuals to overvalue individual logs, believing that
every piece of log data is critical for diagnostics. As a result, there is a
tendency to collect and retain vast volumes of log data, regardless of its
relevance or usefulness. This approach, while well-intentioned, can lead to
several negative consequences. The sheer volume of logs can become overwhelming,
making it difficult to sift through the data to find meaningful insights.
Additionally, the storage and processing of excessive log data can incur
significant costs, both in terms of infrastructure and operational overhead.

Moreover, the overemphasis on individual logs can detract from a more strategic
approach to telemetry. Instead of focusing on the most relevant and actionable
data, the emphasis on quantity over quality can lead to inefficiencies and
missed opportunities for optimization. By prioritizing the collection of
high-value telemetry and leveraging tools like Dynamic Telemetry to convert logs
into metrics and suppress chatty telemetry, organizations can achieve a more
balanced and cost-effective approach to system diagnostics.

In conclusion, while the fear of insufficient telemetry is understandable, it is
essential to adopt a measured and strategic approach to data collection. By
focusing on the most critical data points and utilizing advanced telemetry
tools, organizations can mitigate the risks associated with inadequate telemetry
while avoiding the pitfalls of excessive log collection.
