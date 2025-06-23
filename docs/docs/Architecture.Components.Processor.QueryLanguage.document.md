---
author: "Chris Gray"
status: ReviewLevel2
---

# Processor : Query Language

The Query Language
[Processor](./Architecture.Components.Processor.Overview.document.md) is one of
the most straightforward available. It presents minimal risk while still
providing valuable capabilities for dynamic modeling and system understanding.
The query language Processor can be likened to command line tools found on all
operating systems, which manipulate standard IO subsystems.

## Introduction to Query Language Processor

The query language Processor integrates into the logging stream, monitoring
events by applying straightforward query language filtering and aggregate
functions. Unlike other Processors within dynamic telemetry, the query language
Processor is designed solely for filtering and aggregating data. It does not
enable the invocation of actions, which significantly reduces its associated
risks in the risk taxonomy.

## Simple Code Example; hashing files

```cdocs_include
{{ CSharp_Include("../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs",
    "//start-ImageHashExample",
    "//end-ImageHashExample")
}}
```

## Query Language Overview

In this example you'll notice that the example code

1. Logs when we begin hashing
1. Hashs the file; or otherwise perform business logic
1. Logs when we've completed the hashing of the file

This workflow outlines a typical sequence of operations for a developer. Log
messages may be disabled before entering production, used during diagnostics, or
employed to indicate failure and success in traditional testing.

## Modeling Live System Behavior, with a Query Language Processor

An example use of the query language Processor is to suppress highly chatty
events. Suppose we find that we are hashing many files and want to keep track of
the count without needing file names or statuses. This often happens after
deployment when it's realized that such functionality costs more than
anticipated.

To address this, a simple aggregate function can be sent to the Dynamic
Telemetry Query Language Processor to filter these events or aggregate in-memory
statistics if they are still needed.

### Suppressing Unneeded / Chatty Events

### Aggregating Chatty Events

Lets look at a few examples, as they likely will help tell the tale

Imagine a piece of code that looks something like this:

```mermaid
    flowchart TD
        Unknown((Unknown))
        HashingFile((HashingFile))
        Unknown --> | LogStartingFileHash | HashingFile
        HashingFile--> |LogEndFileHash | Unknown
```

## Example Scenarios
