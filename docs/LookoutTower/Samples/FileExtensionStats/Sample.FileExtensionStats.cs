<!--start-->
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

<!--end-->
