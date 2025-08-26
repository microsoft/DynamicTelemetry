---
author: "Chris Gray"
status: ReviewLevel1b
---

# The Two Types of Telemetry; files and streaming

## Introduction

DynamicTelemetry defines two types of telemetry - STREAMING, and FILE_BASED.

- STREAMING : typical Observability - intended for immediate egress, flowing
  into backend databases.
- FILE_BASED : telemetry that doesn't stream well, memory dumps, CPU samples,
  packet captures, or FLIGHT_RECORDERS - only transmitted upon a failure

## STREAMING Telemetry

OpenTelemetry is the recommended Observability API surface for DynamicTelemetry.
The essence of STREAMING telemetry is to capture observations/logs and upload
them to a network-connected backend as soon as possible.

STREAMING telemetry has three common subtypes: Logs, Metrics, and Traces. These
subtypes share the common goal of egressing the telemetry data as quickly as
possible.

A key differentiator between STREAMING telemetry and FILE_BASED telemetry is
that STREAMING telemetry is always emitted, whereas FILE_BASED telemetry is only
transmitted upon request, usually in the event of a failure.

[OpenTelemetrys website](https://OpenTelemetry.io/) is a great resource to
better understand STREAMING telemetry.

## FILE_BASED Telemetry

FILE_BASED telemetry is similar to STREAMING telemetry in that it can emit logs,
metrics, and traces. However, the key difference lies in its ability to capture
high-fidelity content, such as memory dumps, packet captures, or CPU samples.

Unlike STREAMING telemetry, which is continuously emitted, FILE_BASED telemetry
is only uploaded when necessary, typically in the event of a failure.
