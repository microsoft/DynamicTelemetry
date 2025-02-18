---
author: "Chris Gray"
---

# Interesting Application : FlightRecorder into Memory Dump

## Scenario Summary

Imagine a long-running Flight Recorder that collects 100 times the logging that
would normally stream through something similar to OpenTelemetry.

This logging would be very verbose, containing information like function entry
and exit, web requests, queue lengths, open file pointers, file indexes, and so
on.

Normally, this type of information would clutter up a backend database and be
useless in most contexts.

However, when collected during a process crash, this information is sufficiently
inexpensive and can significantly boost productivity.

A Flight Recorder like this is not free; the logs will have to go into a
circular buffer, which does cause CPU load. But when done well, for example,
using something similar to ETW or user events on Linux, this CPU load can be
very inexpensive compared to other techniques.

When the process crashes, this log can be collected and will serve as a set of
breadcrumbs leading to that process crash.

Pretty fantastic.

This approach also has a positive impact on the developer's mindset. Developers
often struggle with the need to suppress logging messages due to cost, security,
and privacy concerns imposed by business and finance teams.

With the availability of Flight Recorders, developers can feel reassured.
Knowing that in the event of a process crash, they will have access to the
critical logs leading up to the incident, alleviates their concerns and allows
them to focus on more productive tasks.

## Scenario Expansion
