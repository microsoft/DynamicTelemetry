# PROCESSOR : Language


## Introduction to Language Processor

## Simple Code Example; hashing files

``` cdocs

{% include "../../../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs"
    start="//<!--start-ImageHashExample-->"
    end="//<!--end-ImageHashExample-->"
%}
```

## Sample Code Overview

In this example you'll notice that the example code

1.  Logs when we begin hashing
2.  Hashs the file; or otherwise perform business logic
3.  Logs when we've completed the hashing of the file

This workflow outlines a typical sequence of operations for a developer.
Log messages may be disabled before entering production, used during
diagnostics, or employed to indicate failure and success in traditional
testing.

## Modeling Live System Behavior, with a Language Processor

Consider the state model processor as a tool to quickly and safely
understand the system\'s operational characteristics after deployment.

The state machine processor is typically beneficial in scenarios where
software has been deployed into a production environment, and it cannot
be rapidly altered or redeployed. It should be viewed as a diagnostic
tool that can be employed extensively without affecting user security,
privacy, or performance.

After a conclusion is reached by the state machine processor, the
production code is frequently modified to implement a more suitable and
permanent solution. Consequently, the state machine processor can be
deactivated once the revised deployment is completed.

Lets look at a few examples, as they likely will help tell the tale

Image a piece of code that looks something like this:

``` mermaid
    flowchart TD
        Unknown((Unknown))
        HashingFile((HashingFile))
        Unknown --> | LogStartingFileHash | HashingFile
        HashingFile--> |LogEndFileHash | Unknown
```

## Introducing Actions to the Dynamic Telemetry Language Processor

## Useful Actions

-   [CPU Sampling](../../Actions/Action.CPUSample.document.md)
-   [Verbose Logs](../../Actions/Action.VerboseLogs.document.md)
-   [Memory Dump](../../Actions//Action.MemoryDump.document.md)

## Example Scenarios

{% include "../../../bib.md" %}
