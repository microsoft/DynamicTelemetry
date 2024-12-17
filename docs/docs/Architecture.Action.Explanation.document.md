Understanding an action in dynamic telemetry is crucial for grasping its
workflows. An action involves diagnostic operations that do not alter
system state and can be dynamically enabled or disabled using a provided
program.

```cdocs
 printf(*hello world");
```

Unlike mitigation actions, these do not modify system state.

Examples of actions unsuitable for dynamic telemetry include restarting
a service, rebooting a machine, writing to a file, or changing a config
setting.

Suitable actions might involve enabling CPU sampling, which could impact
performance but doesn\'t intentionally modify system state.

The following sections will discuss sample actions within the scope of
dynamic telemetry, such as collecting configurations, enabling CPU
sampling, managing flight recorders, inducing memory dumps, and
collecting other state types.
