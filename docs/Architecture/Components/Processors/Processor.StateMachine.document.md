# PROCESSOR : State Machine

## Introduction to State Machine Processor
The State Machine processor, the most basic type of Processor, functions
akin to a Directed Graph, where transitions occur upon the detection of
specific logs by the Processor. This state machine Processor is employed
for operations such as timing, counting, and measuring in contexts that
present challenges otherwise. The state machine is frequently
accompanied by various actions and is utilized to initiate complex or
resource-intensive operations.

A state model processor operates similarly to a directed graph; its
primary function is to transition between states based on the detection
and study of specific log events. Initially, the state machine begins in
an unknown state and then dynamically adjusts its state in response to
the events it processes. This approach is particularly useful for tasks
such as timing, counting, and measuring in challenging contexts.

To illustrate, consider a contrived example - generating unique hashs of
a file. Perhaps data files or images JPEG image.

## Simple Code Example; hashing files

``` cdocs

{% include "../../../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs"
    start="//<!--start-ImageHashExample-->"
    end="//<!--end-ImageHashExample-->"
%}
```

## Sample Code Overview

In this example you'll notice that the example code

1.  Log when we begin hashing
2.  Hash the file; or otherwise perform business logic
3.  Log when we've completed the hashing of the file

This workflow outlines a typical sequence of operations for a developer.
Log messages may be disabled before entering production, used during
diagnostics, or employed to indicate failure and success in traditional
testing.

## Modeling Live System Behavior, with a State Machine Processor

For instance, when a JPEG file is opened and identified, the state
machine enters the \"processing JPEG\" state. Subsequently, when the
file is closed, the state machine reverts to the unknown state. This
transition allows for various actions to be initiated upon entering the
\"processing JPEG\" state, such as enabling additional telemetry,
collecting registry keys, or starting CPU sampling.

The utility of this functionality lies in its ability to add context to
logs. By attaching state-related information to future logs, the state
machine enhances the logs\' value. This enriched information can be
immediately useful in backend databases, providing instant awareness and
facilitating more informed decision-making and analysis.

Lets look at a few examples, as they likely will help tell the tale

Image a piece of code that looks something like this:

``` mermaid
    flowchart TD
        Unknown((Unknown))
        HashingFile((HashingFile))
        Unknown --> | LogStartingFileHash | HashingFile
        HashingFile--> |LogEndFileHash | Unknown
```

## Introducing Actions to the Dynamic Telemetry State Machine

## Useful Actions
-   [CPU Sampling](../../Actions/Action.CPUSample.document.md)
-   [Verbose Logs](../../Actions/Action.VerboseLogs.document.md)
-   [Memory Dump](../../Actions//Action.MemoryDump.document.md)

## Example Scenarios


{% include "../../../bib.md" %}