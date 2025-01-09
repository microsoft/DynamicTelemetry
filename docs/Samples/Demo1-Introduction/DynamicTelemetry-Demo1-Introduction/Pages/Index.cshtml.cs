using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo1_Introduction.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private Counter<int> _getCounter;
        private string _version = "0.0.1";

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            var meter = meterFactory.Create("DynamicTelemetry.Sample1.IndexModel");
            _getCounter = meter.CreateCounter<int>("OnGet");
            _logger = logger;
            LogLaunch(_logger, _version);
        }

        public string WelcomeBanner { 
            get
            {
                DateTimeOffset time = DateTimeOffset.UtcNow;
                LogWelcomeBanner(_logger, time);
                return $"Welcome : {time}";
            }
        }       

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch,  ver={version}")]
        static partial void LogLaunch(ILogger logger, string version);

        [LoggerMessage(Level = LogLevel.Information, Message = "Welcome Banner Requested at {time}")]
        static partial void LogWelcomeBanner(ILogger logger, DateTimeOffset time);
    }
}
