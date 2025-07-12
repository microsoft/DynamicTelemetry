---
author: "Chris Gray"
status: ReviewLevel1b
---

# Filters, Routers, and Adapters

Filters, Routers, and Adapters are inline Processors that create dynamic
capabilities within the OpenTelemetry pipelines.

Each of the three can dynamically listen to and take action on log messages that
pass through. However, each serves a unique purpose and operates uniquely.

## Filters

Filters rely on durable IDs and do not create logs themselves. They have the
capability to drop entire logs or parts of logs based on predefined criteria.

Filters can also be influenced by Actions, which are predefined rules or
triggers. For example, an Action can be set to Filter out logs from a specific
service during a maintenance window, or to exclude logs containing sensitive
information such as user credentials. Another application could be to Filter
logs based on severity levels, ensuring that only critical errors are logged
during high-traffic periods to reduce noise and focus on important issues.

Using Filters can also help save costs by reducing the volume of logs that need
to be stored and processed. By Filtering out unnecessary or redundant log
entries, organizations can lower their storage requirements and decrease the
amount of data that needs to be analyzed, leading to cost savings in both
storage and processing resources.

Additionally, Filters provide programmers with flexibility by allowing them to
dynamically adjust which logs are collected. This means that while they can
Filter out less critical logs to save costs now, they retain the ability to
quickly modify the Filters to collect more detailed logs in the future if
needed. This dynamic Filtering capability ensures that cost savings do not come
at the expense of losing valuable log data when it is most needed.

## Routers

Routers allow multiple destinations for logs, metrics, and traces, providing
flexibility in how telemetry data is managed and utilized. For example, logs can
be routed to Flight Recorders, which are specialized storage systems designed to
capture and retain detailed telemetry data for later analysis. This is
particularly useful in scenarios where comprehensive post-mortem analysis is
required, such as after a system failure or security incident.

Additionally, Routers can direct telemetry data to other Processors within the
OpenTelemetry pipeline. This enables the application of further processing, such
as aggregation, transformation, or enrichment, before the data reaches its final
destination. For instance, logs can be routed to a Processor that aggregates
data points over time, providing a summarized view of system performance that
can be used for monitoring and alerting purposes.

Routers also support routing telemetry data to other OTLP endpoints, allowing
users to change environments seamlessly. For example, telemetry and logging data
can be forked at the point of origin to be sent to different database types.
This capability ensures that telemetry data can be directed to the most
appropriate storage or processing system based on current needs, enhancing
flexibility and adaptability in managing telemetry data. This flexibility
affords quick environment shifting, enabling teams to rapidly switch between
different environments for testing, development, or production without code
change. Additionally, it allows for quick diagnostic operations by
directing telemetry data to specialized diagnostic tools or environments,
facilitating faster issue identification and resolution.

 For instance, it can be used to audit and trace the sources of potential
 credential leaks or unintentional PII exposure, ensuring that any sensitive
 information is identified and addressed promptly (perhaps by adding a Filter).
Additionally, this configuration can tally the types of logs passing through the
system, which is  beneficial for cost savings by identifying redundant logs,
enhancing security by pinpointing vulnerabilities, and facilitating seamless
environment shifts by providing a clear overview of log data distribution.

When combined with a Filter or a Processor, a Router becomes an incredibly
powerful concept.

## Adapters

Adapters provide an on-ramp into Dynamic Telemetry and OpenTelemetry from legacy
systems such as syslog or LTTNG. They serve as a bridge, allowing older telemetry
data to be integrated seamlessly into modern telemetry pipelines. By doing so,
Adapters ensure that valuable data from legacy systems is not lost and can be
utilized alongside newer telemetry data for comprehensive monitoring and
analysis.

Adapters work by "listening" for legacy telemetry data and then enveloping it
into a format compatible with OpenTelemetry. This process involves capturing the
legacy data, transforming it as needed, and then injecting it into the
OpenTelemetry pipeline. This transformation ensures that the data retains its
original context and meaning while being made compatible with modern telemetry
systems.

One of the key benefits of using Adapters is their ability to adapt legacy
telemetry data without requiring changes to the legacy systems themselves. This
means that organizations can continue to use their existing infrastructure while
gradually transitioning to a more modern telemetry solution. Adapters provide a
flexible and cost-effective way to enhance the observability of legacy systems
without the need for extensive re-engineering.

Additionally, Adapters can be configured to handle various types of legacy
telemetry data, making them a versatile tool for integrating a wide range of
systems into the OpenTelemetry ecosystem. Whether it's syslog messages, LTTNG
events, or other legacy telemetry formats, Adapters ensure that all relevant
data is captured and made available for analysis, providing a unified view of
system performance and behavior.

Not all is without challenges. In some cases, once adapted, certain capabilities
may be lost. For example, in systems such as STDIO, each row of telemetry may
not have a durable identifier. It is the responsibility of the Adapter creator
to address these limitations and ensure that the adapted telemetry data remains
useful and meaningful within the OpenTelemetry pipeline.
