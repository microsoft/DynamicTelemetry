---
author: "Chris Gray"
status: ReviewLevel1
---

#

![image](../LookoutTower.logo.png)

Interactive Observability

## Setup

```bash
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
```

## Scenario #1 : reduce log volume by dropping 5x events

* OpenTelemetry configured to emit at some level (Info?)
* OpenTelemetry configured to emit into Kusto
* Launch Kusto, do | summarize count() by eventId
* find 5 events that can be silenced
* in under 5 seconds, suppress those 5 events, and the expensive fields from the 3 other events
* in ~5 minutes (Kusto ingestion lag) verify the correct things happened

## Scenario #2 : improve privacy, by dropping 3x event fields

* OpenTelemetry configured to emit at some level (Info?)
* OpenTelemetry configured to emit into Kusto
* Launch Kusto, locate 3x events that contain a field that should not be egressed for privacy (or data size) reasons
* find 3 events that have a very expensive field
* in under 5 seconds, suppress just the 3x fields - all other fields should remain
* in ~5 minutes (Kusto ingestion lag) verify the correct things happened

## Scenario #3 : count the number of errors, bucketed by error code, but only when we're in a particular state

## Installation Notes

```bash
https://minikube.sigs.k8s.io/docs/start/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```
