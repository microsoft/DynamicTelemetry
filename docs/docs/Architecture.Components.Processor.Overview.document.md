---
author: "Chris Gray"
status: ReviewLevel2
---

# Processor

A Dynamic Telemetry processor is a small piece of software that resides
in the OpenTelemetry data stream and reads telemetry as it passes. The
processor connects various architectural components, such as an action
or a probe, enabling the transformation of a log into a metric, the
removal of a log, or the removal of a field within a log.

Dynamic Telemetry categorizes processors into three distinct types, each
with varying levels of complexity and associated risk. These types are a
Language Processor, a Query Language Processor, and a State Machine
Processor.

Before delving into the differences among these three types, it is
essential to discuss the four different locations that can house a query
processor.

## Locations in OpenTelemetry that may contain a Processor.

![](../orig_media/Architecture.Boxes.Yes.DynamicTelemetry.drawio.png)


## Processor Types

It\'s expected within dynamic telemetry that multiple different
processor types are created over the course of time because there are
requirements on the processor in order to meet other obligations, such
as safety and performance, all processors must meet certain set of
requirements, specifically in the event they are running out of
specification they are all configured to automatically disable.

There are three different types of processors each with varying degrees
of complexity first is a simple query language processor where the
durable identifier structure payloads are utilized to simply drop or
simply transform a log message.



The second is a state model processor, which is similar to a query
language processor but introduces actions and probes. These capabilities
include triggering CPU sampling, performing memory dumps, or temporarily
toggling the verbosity of logging and sampling.

The third component is a language processor, which is the most complex
of the three. A language processor introduces scriptability or
programming capabilities in line with the production of telemetry. Due
to the requirements on the processor (discussed further below), it is
likely that language processors will resemble something similar to eBPF.
These processors execute within a sandbox that restricts both the memory
accessed and the number of instructions executed.

### Query Language Processor

### State Model Processor

### Language Processor

## Requirements on a Processor
