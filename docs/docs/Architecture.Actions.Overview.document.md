---
author: "Chris Gray"
status: ReviewLevel1b
---

# Understanding Actions

Understanding an action in Dynamic Telemetry is crucial for grasping its
workflows. An action involves diagnostic operations that do not alter system
state and can be dynamically enabled or disabled using a provided program.

Unlike mitigation actions, these do not modify system state.

Examples of actions unsuitable for Dynamic Telemetry include restarting a
service, rebooting a machine, writing to a file, or changing a config setting.

Suitable actions might involve enabling CPU sampling, which could impact
performance but doesn't intentionally modify system state.

The following sections will discuss sample actions within the scope of Dynamic
Telemetry, such as collecting configurations, enabling CPU sampling, managing
Flight Recorders, inducing memory dumps, and collecting other state types.
