using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Http.Extensions;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo1_Introduction.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private Counter<int> _getCounter;

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            var meter = meterFactory.Create("DynamicTelemetry.Sample1.IndexModel");
            _getCounter = meter.CreateCounter<int>("OnGet");
            _logger = logger;
        }

        public void OnGet()
        {
            _getCounter.Add(1);

            string url = HttpContext.Request.GetDisplayUrl();
            LogGet(_logger, url);
        }

        static partial void LogGet(ILogger logger, string url);
    }
}
