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

# TLDR;  What is Dynamic Telemetry

1. Single Architecture
1. That Connects bespoke telemetry / diagnostic tools
1. Solving and Connecting
1. 'Golden Path' scenarios
    1. Performance and Diagnostics
    1. Security and Privacy
    1. Dashboard and Alert Durability
    1. Cost Reductions
1. Creating Opportunities for AI

---

# Our Challenge

![](../orig_media/ChallengeMatrix.drawio.png)

---

# Our Opportunity

* Organize API's; Language, OS under Open Telemetry
* Tackle the connections under 'Dynamic Telemetry';  using Scenarios as golden paths

---

# My Ask

1. If these scenarios come up, I'd love to help guide the implementation as described in this presentation.

1. Let me know if you're excited about this!

---

# Actions

* Seek Community Agreement on Scenario Workflow; 'Golden Paths'
* Create architectural connection points (Probe, Action, Processors, DurableID's)
* Manage and Maintain Samples; ensuring collaboration is easier than replication

---

# Why DurableID's and structured payloads are helpful

* Regular Expressions are fragile, confusing, and expensive
* Durable ID provides a sort of 'GPS' to find the file and line
* Structured Payloads allow easier reasoning over data

---

# Risks

---

# Scenarios

* Performance and Diagnostics
* Security and Privacy
* Reliability
* Durable Dashboards and Alerts
* Cost Reduction
* Opportunities for AI

---

# Architecture

![](../orig_media/Architecture.Boxes.Full.DynamicTelemetry.drawio.png)

---

# Diagnostics (aka Touch Reduction)

* DurableID's and Structured Payloads can be used to Trigger
* Memory Dumps, CPU samples, more verbose Logging

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

# Opens up new Opportunities for AI

* With Strings being CHEAP - more options
* Reduce Volume
* Reduce Costs
* Reduce Privacy / Security Exposure