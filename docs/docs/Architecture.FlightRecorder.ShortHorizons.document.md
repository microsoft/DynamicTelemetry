---
author: "Chris Gray"
status: ReviewLevel1b
---

# Short Horizon Flight Recorder

Short Horizon Flight Recorder is a focused logging strategy designed to capture and preserve data within bound memory limits. Rather than collecting lengthy histories,
over a long time span, it employs broad and loosely filtered logs to collect as much
logging as possible For several minutes leading into a problem. . Its approach emphasizes gathering as much telmeetyr as possible, for a few minutes prior to a failure - which can be particularly useful when probing difficult-to-reproduce bugs.

By capturing high-volume telemetry right before events like crashes or lockups, the Short Horizon recorder streamlines failure analysis. It empowers engineering teams to isolate race conditions, examine deadlocks, or retrieve critical logs without excessive overhead or wasted storage. This targeted method contrasts with “Long Horizons,” which rely on more extended data retention  (with less telemetry volume), for root cause analysis.

Adopting a Short Horizon approach offers operational benefits and an extra layer of confidence.

A well-implemented Short Horizon Flight Recorder can be thought of as a vault or an airplane's flight recorder, capturing all problems regardless of the situation.

When used this way, the Short Horizon Flight Recorder becomes the developer's best friend and a communication tool for project managers.

Expectations can be set with development, test, and operations teams so that anytime a problem occurs, it is always expected that this short horizon flight record will be collected.

This consistency is what management and finance teams will encourage development teams to invest in as cost-saving pressures increase.

By ensuring that every incident is logged and analyzed, teams will build trust
and develop custom diagnostic processors around the Flight Recorder. he Short Horizon Flight Recorder fosters a culture of accountability and continuous improvement. Teams can review logs to understand what went wrong, learn from mistakes, and implement better practices. This iterative process enhances overall software quality and
when used well, will encourage cost reduction, privacy improvements, and security hardening.

**This is because a log that is not emitted is the most cost-effective, private, and secure log.**


## Criteria (and differentiators from 'Long Horizons')

While the exact memory budget and sampling criteria for a Short Horizon Flight Recorder can vary, there are some established guidelines that have proven effective over time. These criteria help ensure that the recorder captures useful data without overwhelming system resources. Key considerations include:

- Fixed memory budget: Typically, a predefined limit such as 32MB is set to ensure that the recorder does not consume excessive memory.
- Broad collection scope: The recorder should capture a wide range of events, but focus on a narrow set of critical events to avoid unnecessary data.
- Performance impact: The recorder may affect system performance, so it is often used in conjunction with filters to manage the volume of collected data.

These guidelines help create an efficient and effective Short Horizon Flight Recorder that balances comprehensive data collection with system performance and resource constraints.

## Sample Applications

There are numerous applications for a Short Horizon Flight Recorder. Here are a few personal favorites of the author:

1. Excellent for creating management processes around diagnosing failures and standardizing diagnostic procedures.
2. Useful for zooming into problematic areas to catch bugs with a 'net' [as detailed here](./PositionPaper.ProceduralizeNets.document.md).
3. Ideal for high-volume logging when verbosity is needed prior to an event, such as a crash.
4. Effective for identifying race conditions, deadlocks, and other concurrency issues.
5. Provides emotional relief for engineers by offering a reliable tool during cost-saving initiatives.


