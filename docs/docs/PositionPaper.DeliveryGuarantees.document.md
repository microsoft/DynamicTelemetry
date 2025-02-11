---
author: "Chris Gray"
status: ReviewLevel1b
---

# Delivery Guarantees of Dynamic Telemetry (and OpenTelemetry)

1. Telemetry must always be lossy;  when push comes to shove
1. Telemetry should never be lost, unless push has come to shove

In simpler terms:

1. It's never okay to lose telemetry on machines that have surplus memory
1. It's usually not a good idea to store telemetry on disk, except in dire emergency
1. A delivery guarantee cannot be given to the users of telemetry - telemetry is not a replacement for transaction processing

Reason:

1. Assume a service is operating nominally, servicing business needs
1. Assume the telemetry backend locks up - perhaps a network outage
1. A good telemetry system should queue, first to RAM, and maybe to disk
1. As telemetry collects, at some point, a decision must be made
    1. start dropping telemetry
    1. stop servicing customer workloads

The right answer is to continue servicing customer loads, and to stop dropping telemetry
