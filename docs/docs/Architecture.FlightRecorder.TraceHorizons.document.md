---
author: "Chris Gray"
status: ReviewLevel1
---

# Understanding Trace Horizons
The concept of a trace horizon is straightforward. It refers to the amount of time that can typically be stored in a circular buffer.

Think of this as your contract. You would say, "Our trace horizon is expected to be about five minutes in the P50."

All these words are easy to say, but there is some complexity in providing this guarantee.

In play are the following:

1. The amount of memory provided to the Flight Recorder.
1. The verbosity of logs that have been sampled in by the filter.
1. The runtime characteristics of the machine, which can be dynamic.

Imagine a simple example where your software is running smoothly, and the Flight Recorder is operating nominally. Suddenly, the code goes into a failure mode where the logging for errors dramatically spikes up.

Because the amount of memory provided to the Flight Recorder is fixed, this dramatic spike will result in a shorter time horizon found in the log.

While this may sound bad, it usually is not. A decision must be made, and this is the decision: Should the log be egressed due to an action, the developer will inspect the logs and realize that they are in that failure mode and will have more clues as to what is going wrong.

They will then reconfigure the Filter leading into the Flight Recorder, to simmer down the verbose logs.  Options at their
dispsoal would include

1. Filtering (dropping) out the chatty logs
1. Converting [the chatty logs into a Metric](./Scenarios.ConvertLogsToMetrics.document.md)
1. Increasing the memory dedicated to the Flight Recorder
1. Removing logs that are no long interesting


The key takeaway for this section is that the trace horizon is a critical aspect of Dynamic Telemetry.

1. Dev + Ops teams specify their desired trace horizon along with their memory budgets.
1. This is enforced with the Dynamic Telemetry filter that routes log messages into the Flight Recorder.
1. It is expected that the trace horizon will be within a reasonable tolerance of the desired value. However, predicting which log messages will be chatty, especially in a failure condition, can be challenging.
