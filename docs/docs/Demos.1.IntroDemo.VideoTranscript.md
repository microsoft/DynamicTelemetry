---
author: "Chris Gray"
status: ReviewLevel1b
---

"Hi everyone! Today, I'm going to show you how to use Dynamic Telemetry
to save money and reduce storage and database costs, by suppressing a
chatty log message."

This sample is functional, but dramatically simplified to help focus on
Dynamic Telemetry, with full source code provided.

We\'ll focus on using Microsoft Azure Monitor and Log Analytics, using
C#. The methods will work the same with any OpenTelemetry database or
language.

We\'ll start by looking at our Log telemetry usage, seeking out one of
our more expensive log messages.

In the screenshot, you\'ll see the relative ranking of messages over
time. Remember that each message costs roughly the same, and that cost
isn\'t dependent on its utility.

Ah-ha! Did you notice that the log message for the welcome banner isn\'t
cheap? It\'s one of those sneaky little costs that can add up over time.
