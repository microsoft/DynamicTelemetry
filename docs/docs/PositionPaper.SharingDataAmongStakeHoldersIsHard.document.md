---
author: "Chris Gray"
status: ReviewLevel1b
---

# Sharing data between stake holders is tough;  roles and responsibly breakdowns

Points:

1. Dynamic Telemetry takes a hard position on rigid schema - "no"
1. Dynamic Telemetry takes a hard position on
   [Durable ID and structured payloads](./PositionPaper.DurableIds_StructuredPayloads.document.md)
   \- "YES"

Dynamic Telemetry requires the ability to identify and decode a log, metric, or
trace. However, it does not enforce that the structured payload conforms to a
schema.

This enforcement is useful in many applications but needs to be enforced at a
higher level than Dynamic Telemetry.

If a user of Dynamic Telemetry desires a rigid schema, this is totally
acceptable. They should look for, or author, a
[language processor](./Architecture.Processor.Language.md) to fulfill
this task.

A keen reader of the Dynamic Telemetry documentation will notice potential
incongruity found in the design pattern documentation. Specifically, the design
patterns discussed have rigid schemas as their core value proposition. This is
potentially something that should be further discussed if the design patterns
are included in Dynamic Telemetry or built atop it.

Please see [Rude Q&A for more information](./Rude_Q_and_A.md)
