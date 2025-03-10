---
author: "Chris Gray"
status: ReviewLevel1
---

# OnBox Observer: Coming Soon

![](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png)

The processor runs in user mode on the machine being observed, but it is not in
the kernel. This is the final protocol conversion between the kernel's telemetry
system and the remote processor. In OpenTelemetry, the OLTP protocol is
utilized; however, gRPC or other protocols may also be used.
