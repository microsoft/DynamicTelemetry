---
author: "Chris Gray"
status: ReviewLevel1_Phase1
---


# Interactive UI

## Introduction

DynamicTelemetry is a tool that helps you diagnose and solve tough cloud problems. It is not intended to offer a wholistic user interface, but rather connects your existing technologies, on both Linux and Windows, to give you diagnostic insights into the health, reliability, and user experience of your applications.

DynamicTelemetry is designed to serve four different user personas: project managers, data analysts, developers, and DevOps professionals. Each persona can use the same technology in different ways, depending on their specific needs and goals.

Please read over the [philosophy of DynamicTelemetry](./Architecture.Overview.document.md) to better understand where we favor existing technolgoies, over creating from scratch.

## Interactive UI Tenants

1. **Privacy and Security matter**;  we make every attempt to egress Observablity into preexisting, and compliant, pipelines.
1. **Latency matters**;  as a rule of thumb we like to see sub 15 second responce times

## References

1. [Architecture](./Architecture.Overview.document.md)

1. [Probe Risks](./PositionPaper.ProbeRiskLevels.document.md)

1. [Configuration Deployments](./PositionPaper.ConfigurationDeployment.document.md)
