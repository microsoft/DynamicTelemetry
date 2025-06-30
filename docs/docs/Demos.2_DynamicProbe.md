---
author: "Chris Gray"
status: ReviewLevel1b
---

# DynamicTelemetry : Demo 1, adding Telemetry dynamically

In this demonstration, well be utilizing DynamicTelemetry to generate telemetry
for code thats already been deployed in a Production environment.

Consider a scenario where a certain piece of code is operational within a
Production Kubernetes cluster. A quick review of this code reveals a complete
absence of telemetry. ...and a curiosity that we'll explore!

Please quickly study this code; it's a simple "Tower of Hanoi" problem, like
every college freshman studies in CS101. Unique to this code, you will notice
the absence of telemetry and certainly no OpenTelemetry.

To address this issue, we will establish a dynamic probe and connect it to the
active process. This probe utilizes technology akin to what's found in symbolic
debuggers such as Visual Studio, windbg, or gdb. Its function is to gather
minimal amounts of memory, transform them into standard OpenTelemetry Logs, and
then directly feed them into your existing OpenTelemetry pipelines.

Once emitted, these new Logs will work no differently to any other
OpenTelemetry. All your Grafana, Prometheus, or Azure Dev Explorer tooling will
work as they do today.

To set up the dynamic probe, we just need to highlight the interesting function
and press F9 key in Visual Studio Code. After that, we switch to the
DynamicTelemetry. If our security and privacy guidelines allow this kind of
probing, it will then be implemented on the targeted machines.

Within minutes, the new OpenTelemetry Logs and Metrics will be emitted to your
existing OpenTelemetry pipeline. You'll see the values appear for use within
Grafana, Azure Data Explorer, or any other OpenTelemetry compatible services you
have installed.
