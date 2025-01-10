// StartExample:ContrastDurableID
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_DurableIds.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private static string _version = "0.0.3";
       
        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {            
            _logger = logger;

            // On Launch emit two logs - seemingly identical, one has a DurableID
            LogWithDurableID();
            LogWithoutDurableID();
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
            _logger.LogInformation($"Launch, ver={_version}");
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
            LogLaunch(_logger, _version);
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch, ver={version}")]
        static partial void LogLaunch(ILogger logger, string version);
        // EndExample:DurableId
    }
}
// EndExample:ContrastDurableID