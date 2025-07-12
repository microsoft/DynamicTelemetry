// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// StartExample:ContrastDurableID
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_DurableIds.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private static string _version = "0.0.4";
        private Guid _instanceID = Guid.NewGuid();

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            _logger = logger;

            //var meter = meterFactory.Create("DynamicTelemetry.Metric.Conversion");
            //_getCounter = meter.CreateCounter<int>("LogLaunch");

            // On Launch emit two logs - seemingly identical, one has a DurableID
            //_getCounter.Add(1);
            LogWithDurableID();
            LogWithoutDurableID();


            // START : LoopRandomGUID
            // Generate some data that will be tough to aggregate
            for (int i = 0; i < 1000; i++)
            {
                _logger.LogInformation($"Loop, random ID={Guid.NewGuid()}");
                LogRandomGuid(_logger, Guid.NewGuid());
            }
            // END : LoopRandomGUID
        }

        // StartExample:NoDurableId
        private void LogWithoutDurableID()
        {
            //
            // Log a message without a DurableID;  while simple, this log will provide struggles later
            //    because while we receive a property bag of the variables (_version), we will not know
            //    which line of code emitted the telemetry - as our only identtifer will be the
            //    'flattened' payload string
            //
            // NOTE: adding the _instanceID is to showcase how, once 'flattened' this unrecommendable
            //    method of logging makes for tricky (and expensive) backend searching
            //
            _logger.LogInformation($"Launch, ver={_version}, instantion={_instanceID}");
        }
        // EndExample:NoDurableId


        // StartExample:DurableId
        private void LogWithDurableID()
        {
            //
            // Log a message with a DurableID; 'behind the scenes' the dotnet compiler will
            //     generate two ID's - one numerical, and one a string
            //
            // Behind the scenes, the compiler uses this syntax to create identifiers that are included
            //     into the telemetry row, that can be used visually, and in automation, to map
            //     from row of telemetry, to line of code - very useful when extending the capabilities
            //     of your telemetry assets
            //
            // NOTE: adding the _instanceID is to showcase how, we can more easily locate this line
            //     of code, as compared with the earlier 'flattened' version.  The compiler will attach
            //     an 'EventName' property with the value of our function name "LogLaunch".  We can use this
            //     instead of regular expressions to locate and aggregate
            //
            LogLaunch(_logger, _version, _instanceID);
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch, ver={version}, instantion={instantionID}")]
        static partial void LogLaunch(ILogger logger, string version, Guid instantionID);
        // EndExample:DurableId


        // START_DEFINE : LogRandomGuid
        [LoggerMessage(Level = LogLevel.Information, Message = "Loop, random ID={guid}")]
        static partial void LogRandomGuid(ILogger logger, Guid guid);
        // END_DEFINE : LogRandomGuid
    }
}
// EndExample:ContrastDurableID
