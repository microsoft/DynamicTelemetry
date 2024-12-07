---
author: "Chris Gray"
status: ReviewLevel1
---

# FILE vs. STREAMING Telemetry

## Introduction

DynamicTelemetry defines two types of telmeetry - STREAMING, and FILE_BASED.

* STREAMING : typical Observablity - intended for immediate egress, flowing into backend databases.
* FILE_BASED : telemetry that doesnt stream well, memory dumps, CPU samples, packet captures, or  FLIGHT_RECORDERS.

## STREAMING Telemetry:

OpenTelemetry is the recommened Observablity API surface for DynamicTelemetry.  The gist of STREAMING telemetry is to take observations/logs and to upload to a network connected backend, as soon as possible.

STREAMING telemetry has three common subtypes {Logs, Metrics, and Traces} that share the common desire to egress the telemetry as soon as possible.

[OpenTelemetry’s website](https://opentelemetry.io/) is a great resource to better understand STREAMING telemetry.


## FILE_BASED Telemetry:

## References

1. [Flight Recorder](./FlightRecorder.document.md)
