---
author: "Chris Gray"
status: ReviewLevel1b
---

# Kernel Observer: Coming Soon

![](../orig_media/Architecture.Boxes.Yes.DynamicTelemetry.drawio.png)

This observer runs in the kernel of a monitored machine. It accepts telemetry from multiple processes or services within the same machine and has the unique ability to drop and modify telemetry data. This is done with the scope of the entire user mode of the machine.

This is an [excellent location for flight recorders.](./PositionPaper.FlightRecorder.document.md)
