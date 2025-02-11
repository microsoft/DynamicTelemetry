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


        //
        // In the WelcomeBanner, for purposes of demo, we emit a 'secret'
        //    the below KQL can be attached to any DynamicTelemetry 'Processor', to remove the secret
        //
#if false
        //
        // Drop the entire Log row
        //
        // StartKQL:FilterWholeLog
        traces
        | where customDimensions.EventName != "LogWelcomeBanner"
        // EndKQL:FilterWholeLog

        //
        // StartKQL:FilterField
        traces
        | extend customDimensions = iif(customDimensions.EventName == "LogWelcomeBanner",
            bag_remove_keys(customDimensions, dynamic(['secret'])), customDimensions)
        // EndKQL:FilterField
#endif





        // StartSearchExample:LogWelcomeBanner
        [LoggerMessage(Level = LogLevel.Information, Message = "Welcome Banner with accidentally emitted secret = {secret}")]
        static partial void LogWelcomeBanner(ILogger logger, string secret);
        // EndSearchExample:LogWelcomeBanner


        private string GetSecret()
        {
            return Guid.NewGuid().ToString();
        }

    }
}
// EndExample:RedactSecret
