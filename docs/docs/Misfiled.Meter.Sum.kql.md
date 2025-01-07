---
author: "Chris Gray"
status: ReviewLevel1
---

# DELETE_ME : Notes on using OpenTelemetry/C# sum in Kusto

```csharp
Logs
| where ingestion_time() > ago(60m)
| where value contains "Ticks"
| extend service_namespace = tostring(value["service.namespace"])
| extend service_name = tostring(value["service.name"])
| extend service_instance_id = tostring(value["service.instance.id"])
| extend meterName = tostring(value["Name"])
| extend sum = todynamic(dynamic_to_json(todynamic(value["Sum"])))
| extend dp = sum.DataPoints[0]
| extend StartTime = unixtime_nanoseconds_todatetime(todouble(dp.StartTimeUnixNano))
| extend Value = toint(dp.AsInt)
| project service_namespace, service_name, service_instance_id, meterName, StartTime, Value, timestamp
| order by timestamp
| summarize arg_max(timestamp, *) by service_instance_id, meterName, StartTime

```
