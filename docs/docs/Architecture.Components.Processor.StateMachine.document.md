---
author: "Chris Gray"
status: ReviewLevel2
---

# Processor : State Machine

The State Machine
[Processor](./Architecture.Components.Processor.Overview.document.md) is a
relatively simple yet highly effective component within Dynamic Telemetry.
Essentially, this Processor listens to all log messages that pass by,
identifying significant events and managing a state machine based on those
events. When the state machine Processor detects an interesting log message, it
transitions to a new state, potentially initiating an action as part of this
transition.

## Introduction to State Machine Processor

The State Machine Processor operates as a Directed Graph, where transitions
occur upon the observation of specific logs by the Processor. This state machine
is employed for tasks such as timing, counting, and measuring in contexts that
pose significant challenges. The state machine is often accompanied by various
actions and is utilized to initiate complex or resource-intensive operations.

Its primary function is to monitor logs and transition between states based on
the analysis of log names and parameters. Initially, the state machine starts in
an undefined state and then dynamically adjusts its state in response to the
events it processes. This method is particularly effective for tasks such as
timing, counting, and measuring in difficult contexts.

To provide an example, consider generating unique hashes of a file, such as data
files or JPEG images.

## Simple Code Example; hashing files

```cdocs_include
{{ CSharp_Include("../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs",
    "//start-ImageHashExample",
    "//end-ImageHashExample")
}}
```

## Sample Code Overview

In this example you'll notice that the example code

1. Logs when we begin hashing
1. Hashes the file; or otherwise perform business logic
1. Logs when we've completed the hashing of the file

This workflow outlines a typical sequence of operations for a developer. Log
messages may be disabled before entering production, used during diagnostics, or
employed to indicate failure and success in traditional testing.

## Modeling Live System Behavior, with a State Machine Processor

Consider the state model Processor as a tool to quickly and safely understand
the system's operational characteristics after deployment.

The state machine Processor is typically beneficial in scenarios where software
has been deployed into a production environment, and it cannot be rapidly
altered or redeployed. It should be viewed as a diagnostic tool that can be
employed extensively without affecting user security, privacy, or performance.

After a conclusion is reached by the state machine Processor, the production
code is frequently modified to implement a more suitable and permanent solution.
Consequently, the state machine Processor can be deactivated once the revised
deployment is completed.

Lets look at a few examples, as they likely will help tell the tale

Imagine a piece of code that looks something like this:

```mermaid
    flowchart TD
        Unknown((Unknown))
        HashingFile((HashingFile))
        Unknown --> | LogStartingFileHash | HashingFile
        HashingFile--> |LogEndFileHash | Unknown
```

## Introducing Actions to the Dynamic Telemetry State Machine

## Useful Actions

- [CPU Sampling](./Architecture.Action.CPUSample.document.md)
- [Verbose Logs](./Architecture.Action.VerboseLogs.document.md)

## Example Scenarios
