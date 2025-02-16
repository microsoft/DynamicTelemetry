---
author: "Chris Gray"
status: ReviewLevel1
---

# Flight Recorder Overview

Flight recorders depend on both streaming and file-based telemetry to capture information at different times and scales. Streaming approaches provide continual updates, which is critical when immediate insights (metrics) are required. File-based telemetry collects data in a locally stored format, resembling the way an airplane's black box safeguards flight parameters.

Many modern systems rely heavily on streaming telemetry for near real-time monitoring. This approach fulfills Observability needs by enabling on-the-fly analysis and rapid response. Continuous data inflow also makes it simpler to spot trends or anomalies as they emerge.

File-based telemetry stores self-contained data segments for post-event examination. Similar in concept to safeguarded flight data recorders or fire safes, this method is especially valuable for incident reconstruction. It preserves past states, which helps ensure that system insights remain available even when live connections are not.


### What is a flight recorder?
A flight recorder comprises a ring buffer with fixed capacity, typically residing in memory or on disk, that continually overwrites older data with newer entries. This design is naturally lossy, yet it captures essential insights about system events and states in near real time.

Each flight recorder instance can be uniquely identified by a dedicated tag or name. This allows for quick recognition among multiple data sources and ensures streamlined retrieval when logs must be merged or compared.

On-demand egress is another core feature, enabling data extraction whenever deeper investigation is necessary. By preserving a snapshot of the overwritten data, the flight recorder helps diagnose issues by making past telemetry accessible for post-mortem analysis.

## How to collect a flight recorder

A flight recorder augments standard streaming telemetry by ingesting data from multiple probes, such as OpenTelemetry logging, ETW (Windows), user_events, or syslog. This option delivers deeper insights than streaming alone, leveraging the strengths of both real-time and localized data gathering.

By storing high-verbosity traces in local storage, a flight recorder preserves critical details for retrospective analysis. Each recorder needs a unique identifier, enabling swift retrieval for investigations. This makes diagnosing system issues more straightforward in the aftermath of an incident.

Flight recorders can also be uploaded through an Action triggered by other probes, ensuring on-demand availability of essential historical information. This simplifies root cause analysis and promotes a more resilient workflow for collecting and reviewing telemetry data.

## Introduction

## References

1. [File and Streaming](./PositionPaper.FileAndStreaming.document.md)

2. [Telemetry Umbilical](./PositionPaper.TelemetryUmbilical.document.md)
