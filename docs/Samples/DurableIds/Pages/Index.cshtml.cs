// StartExample:ContrastDurableID
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_DurableIds.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private static string _version = "0.0.1";
       
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
            //
            _logger.LogInformation($"Launch,  ver={_version}");
        }
        // EndExample:NoDurableId


        // StartExample:DurableId
        private void LogWithDurableID()
        {
            //
            // Log a message without a DurableID;  while simple, this log will provide struggles later
            //
            _logger.LogInformation($"Launch,  ver={_version}");
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch,  ver={version}")]
        static partial void LogLaunch(ILogger logger, string version);
        // EndExample:DurableId
    }
}
// EndExample:ContrastDurableID