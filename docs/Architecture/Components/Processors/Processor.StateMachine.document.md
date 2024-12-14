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

To illustrate, consider the need to track a particular type of
operation, such as processing a specific file type like a JPEG image.
When the state machine processor detects the log message indicating that
a JPEG file has been opened, it transitions from the unknown state to a
user-defined state, such as the \"processing JPEG\" state. This
transition is based on the pre-configured, and dynamically deployed,
criteria within the state machine.

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

```cdocs

{% include "../../../LookoutTower/Samples/FileExtensionStats/Program.cs" %}

```


```csharp
using Microsoft.Extensions.Logging;

internal partial class Program
{
    static void Main(string[] args)
    {

        using ILoggerFactory factory = LoggerFactory.Create(builder => builder.AddConsole());
        ILogger logger = factory.CreateLogger("Program");
        LogStartupMessage(logger, DateTimeOffset.Now);

        Random random = new Random();
        for(; ; )
        {
            int delay = random.Next(1000);
            LogWork(logger, delay);
            Thread.Sleep(delay);
        }
    }

    [LoggerMessage(Level = LogLevel.Information, Message = "Starting Process {workAmount}.")]
    static partial void LogWork(ILogger logger, int workAmount);

    [LoggerMessage(Level = LogLevel.Information, Message = "Starting Process {startTime}.")]
    static partial void LogStartupMessage(ILogger logger, DateTimeOffset startTime);
}
```



``` mermaid
    flowchart TD
        Unknown((Unknown))
        JpegOpened((JpegOpened))
        Unknown --> | LogOpeningFile | JpegOpened
        JpegOpened--> |LogClosed | Unknown
```

XYZ

Actions of Interest:

-   [CPU Sampling](../../Actions/Action.CPUSample.document.md)
-   [Verbose Logs](../../Actions/Action.VerboseLogs.document.md)
-   [Memory Dump](../../Actions//Action.MemoryDump.document.md)
