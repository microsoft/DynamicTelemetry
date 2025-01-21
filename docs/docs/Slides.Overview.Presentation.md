---
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
author: "Chris Gray"
status: ReviewLevel1
---

![](../orig_media/DynamicTelemetry.CoPilot.Image.png)

# Dynamic Telemetry

---

# Our Challenge

* Privacy, Security, Cost, and Diagnostics is tough in a fragmented ecosystem
* Countless Tools
* Multiple OS's  (2x)
* Multiple Languages (11x)
* Multiple Databases (>5x)
* Multiple Visualizations and Alerting (>5x)
* Multiple Hosting Environments (>5x)
* Multiple Usage Models


---

# Our Opportunity

* OpenTelemetry seeks to tackle the API / Language problem
* Dynamic Telemetry seeks to tackle the connections, using Scenarios as golden paths

---

# Actions

* Seek Community Agreement on Workflow; Scenarios
* Clear architectural connection points (Probe, Action, Processors)
* Make it easier to 'bolt in' than to replicate    
* Turn Key, Golden Paths

---

# Bridging
    * Open Telemetry
    * uProbes / kProbes
    * eBPF
    * DTrace
    * ETW (Windows) and user_events (Linux)

---

# Durable ID's and Structured Payloads

```cpp
printf("oh no, transaction error. err=%d", error);
```
vs.

```cpp
LogTransactionError(error);

[LoggerMessage(Level = LogLevel.Error, Message = "oh no, transaction error. err={error}")]
static partial void LogStartingFileHash(ILogger logger, int error);
```

---

# Why DurableID's and structured payloads are helpful

* Regular Expressions are fragile, confusing, and expensive
* Durable ID provides a sort of 'GPS' to find the file and line
* Structured Payloads allow easier reasoning over data

---

# Examples

* Security and Privacy
* Cost Reduction
* Deep Diagnostics
* New Opportunities for AI

---

# Security and Privacy

* in SFI/Azure we've had problems with embedded PATs, certs
* in GDPR/Client we've had problems with IP addresses, MAC/BSSID/SSID's

---

# Cost Reduction

* Logging is expensive
* Not all Logs are great or always needed
* Through positive identification
    * we can toggle
    * we can drop/modify

---

# Diagnostics (aka Touch Reduction)

* DurableID's and Structured Payloads can be used to Trigger
* Memory Dumps, CPU samples, more verbose Logging

---

# Opens up new Opportunities for AI

* With Strings being CHEAP - more options
* Reduce Volume
* Reduce Costs
* Reduce Privacy / Security Exposure