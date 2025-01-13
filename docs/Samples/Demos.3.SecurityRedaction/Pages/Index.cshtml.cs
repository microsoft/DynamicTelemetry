// StartExample:RedactSecret
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_3_SecurityRedactions.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            _logger = logger;
        }

        // StartFunction:MistakenEmission
        public string WelcomeBanner
        {
            get
            {
                DateTimeOffset time = DateTimeOffset.UtcNow;

                string secret = GetSecret(); ;
                LogWelcomeBanner(_logger, secret);

                return $"Welcome : {time}";
            }
        }
        // EndFunction:MistakenEmission

        private string GetSecret()
        {
            return Guid.NewGuid().ToString();
        }


        // StartSearchExample:LogWelcomeBanner
        [LoggerMessage(Level = LogLevel.Information, Message = "Welcome Banner with accidentlly emitted secret = {secret}")]
        static partial void LogWelcomeBanner(ILogger logger, string secret);
        // EndSearchExample:LogWelcomeBanner
        
    }
}
// EndExample:RedactSecret