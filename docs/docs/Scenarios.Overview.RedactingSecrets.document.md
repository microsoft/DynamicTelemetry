---
author: "Chris Gray"
status: ReviewLevel1b
---

# Improving Your Security and Privacy Posture

![image](../orig_media/RedactingSecrets.banner.png){width="5.5in"
height="1.261111111111111in"}

Dropping or redacting portions of a log involves selectively removing or
obscuring specific data within log entries to protect sensitive information or
reduce noise. This practice is crucial for maintaining privacy and security, as
logs often contain personal or confidential data such as email addresses, credit
card numbers, or API keys. Additionally, dropping unnecessary log entries helps
in managing log storage efficiently and ensures that only relevant data is
retained for analysis. This process can be automated using tools and scripts
that identify and redact sensitive data patterns, ensuring that logs remain
useful for monitoring and troubleshooting without compromising security

## Introducing Your Tools : [Filtering](./Architecture.Components.FiltersRoutersAndAdapters.document.md)

Redacting portions of logs using durable IDs and structured payloads involves
several technical steps to ensure that sensitive information is effectively
removed while maintaining the integrity and usability of the logs.

Durable IDs are unique identifiers that remain consistent across different log
entries and sessions. They act like a GPS for debugging and analysis, allowing
you to trace logs back to the exact line of code in the source. This consistency
is crucial for accurately identifying and redacting sensitive information
without losing the context of the log entries.

Structured payloads refer to the organization of log data into a well-defined
format, possibly a binary format, or as JSON or XML. This structure makes it
easier to identify and redact specific fields within the log entries. For
example, instead of having a flat log message, a structured payload might
separate different pieces of information into distinct fields, such
asuser_id,transaction_id, andtimestamp. This separation allows for more precise
redaction of sensitive data, such as email addresses or credit card numbers,
without affecting other parts of the log.

## Understanding by Example : Mechanics of Secret Redaction

The process typically involves the following steps:

1. **Identification**: Using durable IDs, the system identifies the specific log
   entries that contain sensitive information.

1. **Redaction**: The structured payloads are then parsed to locate the fields
   that need to be redacted. This can be done using regex patterns or predefined
   rules that match sensitive data types.

1. **Replacement**: The sensitive data is replaced with a placeholder or removed
   entirely. This ensures that the logs remain useful for analysis while
   protecting sensitive information.

1. **Validation**: The redacted logs are validated to ensure that the redaction
   process did not introduce any errors or inconsistencies.

By combining durable IDs and structured payloads, organizations can achieve a
more efficient and reliable redaction process, ensuring compliance with privacy
regulations and reducing the risk of data breaches

## Methods of Redacting Secrets

Should you find yourself in the unenviable position where your OpenTelemetry
logs/traces contain secrets, or privacy information you face a complicated
journey.

First, you have to fix the code, retest, redeploy, (potentially wait for a
ringed deployment), and then go scrub your databases.

Dynamic Telemetry offers no solution to database scrubbing, but it does offer
solutions into scrubbing.  Several in fact!

In broad strokes, the two most common are

1. Dynamically Toggling Off Logs;  dropping an entire log row
1. Payload Scrubbing;  scrubbing portions of a log

### [Dynamically Toggle Off Logs](./PositionPaper.DynamicallyToggleLogs.document.md)

Dynamically turning off individual logs using core operating system features
such asuser_events (Linux)or Event Tracing for Windows (ETW, on Windows)
involves leveraging the inherent capabilities of these systems to manage logging
efficiently. This method is particularly useful for high-performance
applications where logging overhead needs to be minimized.

\*\*Event Tracing for Windows (ETW)\*\*is a high-performance, low-overhead
tracing framework built into the Windows operating system. It allows for the
dynamic enabling and disabling of event tracing without requiring application or
system restarts. ETW operates with minimal performance impact due to its
efficient buffering and non-blocking logging mechanisms. It uses per-processor
buffers that are written to disk by a separate thread, ensuring that logging
does not interfere with the application's main operations.

**user_events**is a powerful feature built into the Linux kernel, that has some
characteristics of ETW on Windows Dynamic Telemetry. It allows for the insertion
of user-defined events into the standard Linux kernel mode logging streams,
which can be enabled or disabled, in user mode, or keren mode - as needed. This
flexibility is crucial for maintaining high performance, as it ensures that only
relevant logs are captured, reducing unnecessary data collection and
processing2.

The process typically involves the following steps:

1. **Initialization**: Register the logging providers and define the events that
   need to be traced. This can be done using ETW APIs or user-defined events.

1. **Dynamic Control**: Use controllers to start, stop, or update the tracing
   sessions. Controllers like Xperf, PerfView, or Logman can be used to manage
   ETW sessions dynamically.

1. **Buffer Management**: Utilize in-memory circular buffers to store log data
   temporarily. This data is only written to disk or processed further if
   specific conditions are met, such as an error occurring.

1. **Filtering and Aggregation**: Apply filters to capture only the necessary
   events and aggregate data to reduce the volume of logs. This can be done
   using query language processors or state machine processors within Dynamic
   Telemetry.

1. **Validation and Analysis**: Validate the captured logs to ensure they are
   accurate and useful for analysis. This step may involve converting verbose
   logs into metrics for easier interpretation and reduced storage
   requirements6.

By leveraging these fundamental operating system capabilities, you can achieve
efficient and high-performance logging. This ensures that only critical data is
captured and processed, thereby maintaining optimal system performance.

### Scrub variable payloads

Scrubbing payloads can be performed in various Processor locations within a
system to ensure that sensitive information is protected and compliance requirements
are met.

![hi](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png)

1. In the usermode portion of an app or agent, scrubbing can occur before data
   is transmitted, ensuring that any sensitive information is removed or
   obfuscated at the source.
2. In the kernel mode memory buffer, scrubbing can be implemented to clean data
   as it is being processed, providing an additional layer of security before it
   reaches usermode components.
3. The usermode aggregator and network transmitter can also perform scrubbing to
   ensure that aggregated data sent to backend systems is free of sensitive
   information.
4. In the backend, scrubbing can be done at a. the point of ingest, where data
   is first received and processed, or b. within the database, where stored data
   is periodically reviewed and cleaned to maintain data integrity and security.

Each of these locations offers unique advantages and challenges, and the choice
of where to implement scrubbing depends on the specific requirements and
constraints of the system.
