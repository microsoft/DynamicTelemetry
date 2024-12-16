# PROCESSOR : Language

The language processor is one of the most versatile and capable
processors within dynamic telemetry; however, it also poses certain
risks. The language processor in dynamic telemetry enables the insertion
of programming language into the telemetry and logging stream of a
process. These instructions will have the full functionality of the
supporting programming language and runtime.

## Introduction to Language Processor

By incorporating a programming model into a telemetry stream, advanced
observability and diagnostics can be achieved. For example, memory
variables can be created, aggregates can be managed, individual threads
can be monitored, and references can be tracked.

Additionally, complex triggering scenarios can be established, such as
capturing a memory dump of a process when a reference count exceeds
nominal and expected values.

## Simple Code Example; hashing files

``` cdocs
{% include "../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs"
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

## Modeling Live System Behavior, with a Language Processor.

In this scenario, where a file is being hashed, assume there is a bug in
the hashing algorithm. For example, the implementation of the hashing
algorithm might have race conditions or, in exceptional cases, memory
misalignment. If one of these issues occurs, the hash for the input file
will be incorrect, making it challenging to debug in a production
system.

A Dynamic Telemetry Language Processor could be particularly useful for
advanced diagnostics and tracking of this faulty hashing algorithm.

in this example one could imagine the pseudo code below being utilized
in a randomized pattern and deployed using dynamic telemetry into a
production environment as you can see in the pseudo code periodically
the hash of a file will be doubly computed once in the production code
and secondarily in the telemetry code

when or if hash is detected to be incorrect the dynamic telemetry
language processor is able to emit extra to diagnostic telemetry that
indicates to the programmer who is monitoring the back end databases
that in fact the hashing algorithm is failing

Lets look at a few examples, as they likely will help tell the tale

Image a piece of code that looks something like this:

``` mermaid
    flowchart TD
        Unknown((Unknown))
        HashingFile((HashingFile))
        Unknown --> | LogStartingFileHash | HashingFile
        HashingFile--> |LogEndFileHash | Unknown
```

### Verifying Hash Algorithm

``` cdocs
{% include "../LookoutTower/Samples/FileExtensionStats/Sample.FileExtensionStats.cs"

    start="//<!--start-PseudoExample-Language-Processor-VerifyHash-->"

    end="//<!--end-PseudoExample-Language-Processor-VerifyHash-->"
%}
```

## Introducing Actions to the Dynamic Telemetry Language Processor

## Useful Actions

-   [CPU Sampling](../../Actions/Action.CPUSample.document.md)
-   [Verbose Logs](../../Actions/Action.VerboseLogs.document.md)
-   [Memory Dump](../../Actions//Action.MemoryDump.document.md)

## Example Scenarios

{% include "./bib.md" %}
