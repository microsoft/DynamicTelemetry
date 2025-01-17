// StartExample:RedactSecret
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_3_SecurityRedactions.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        static byte _buggyValue = 0;
        private byte localValue = 0; 

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            _logger = logger;
        }

        public void OnGet(string fileName)
        {
            ++_buggyValue;
            ++localValue;
        }

        public string WelcomeBanner
        {
            get
            {
                return "Msg: " + _buggyValue + ", " + localValue;
            }
        }
        
        // StartSearchExample:LogWelcomeBanner
        [LoggerMessage(Level = LogLevel.Information, Message = "Welcome Banner with accidentlly emitted secret = {secret}")]
        static partial void LogWelcomeBanner(ILogger logger, string secret);
        // EndSearchExample:LogWelcomeBanner



    }
}
// EndExample:RedactSecret