---
author: "Chris Gray"
status: ReviewLevelb
---


In Dynamic Telemetry, [Probes](Architecture.Probes.Overview.document.md) and [Actions](./Architecture.Probes.Overview.document.md) play crucial roles in monitoring and diagnosing system behavior. Probes, for example any Log produced in OpenTelemetry, are read by a Dynamic Telemetry ["Processor"](./Architecture.Components.Processor.Overview.document.md) as dynamic elements that can be used in interesting ways, dynamically, to help better undersand the runtime characteristics of the system;  providing another layer of depth to your software - useful and valuable in analysis and troubleshooting. Probes, and the accompanying Processor are designed to operate transparently within the system without causing measurable disruption to performance, or reliability. Probes can be either static, always active and continuously monitoring the system, or dynamic, which can be enabled or disabled as needed.

Actions, on the other hand, involve diagnostic operations that do not alter the system state and can be dynamically enabled or disabled6. Suitable actions might include enabling CPU sampling, collecting configurations, managing flight recorders, inducing memory dumps, and collecting other state types.

When combined, Probes and Actions can create a powerful mechanism to "Cast Nets" that catch bugs.

As an example;  imagine a situation where a PRoduction system works great in testing and when not under load.  Hwoever, when udner load, CPU contention seems to be higher than expected.  The developers believe it coudl be the case that the machine is entering receive livelock, but do not know why.

If only they could predict the computer that would next exhibit the problem, they could turn on CPU sampling when the problem hits.  The problem they face is once the problem hits, it's over before they can

1. Collect a memmory dump to inspect the work queue
1. Enable CPU sampling to inspect which code is hot
1. Enable verbose diagnostic traces

## Casting 'Nets'

The Diagnsostic Teleemtry solution to this problem - is to cast broad 'nets' on multiple machiens who are expected to experience this situiaton.

Each net is very lightweight;  negligable perofmrance or relialblity concerns.

The 'nets' are simply configuraitons for a Dynanmic Telemetry ["Processor"](./Architecture.Components.Processor.Overview.document.md) that lay in wait, the values of selected Logging, waiting for a triggering Condition.

Once found;  the trigger will provide the desired diagnostic infomriatn.

 By configuring the Processor to dynamically monitor these log messages, it can track the queue depth in real-time. If the queue length exceeds predefined criteria set in the Processor's configuration, the Processor can trigger various diagnostic actions such as capturing a memory dump, enabling CPU sampling, or activating more verbose logging2. This dynamic monitoring allows for proactive detection and response to potential issues, ensuring that abnormalities are caught and addressed promptly, thereby maintaining system stability and performance3.

Probes are deployed to monitor specific aspects of the system and emit data when certain conditions are met. For example, a probe might monitor the return value of a particular function or track the occurrence of specific events.

When a probe detects something of interest, it can trigger an Action. This action might involve collecting additional data, enabling more detailed logging, or capturing a memory dump.

By dynamically enabling and disabling probes and actions, you can create a flexible and responsive system that adapts to changing conditions and captures valuable diagnostic information when needed