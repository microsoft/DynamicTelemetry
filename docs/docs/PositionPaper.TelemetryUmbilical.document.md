---
author: "Chris Gray"
status: ReviewLevel1b
---

# Telemetry Umbilical; Migrating, splicing, and filtering your telemetry

## Talking Points

1. Two Types of Telemetry
   [{file, streaming}](./PositionPaper.FileAndStreaming.document.md)
1. All telemetry for a partition {container, VM, or Host} must only use 2x
   sockets - multiple apps need to be aggregated / multiplexed
1. The 'umbilical' is a choke point; that has standard 'pipe fittings'
1. The umbilical can be 'cut' and rerouted - such that there are only two
   locations per 'partition' {container, VM, Host} to be cut, should
   (re)routing, filtering, need to occur
