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
            LogLaunch(_logger, _version);
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch,  ver={version}")]
        static partial void LogLaunch(ILogger logger, string version);
    }
}
