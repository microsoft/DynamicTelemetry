// StartExample:InsertTelemetry
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Caching.Memory;
using System.Diagnostics.Metrics;

namespace DynamicTelemetry_Demo_3_SecurityRedactions.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private IMemoryCache _cache;
        public CachedObject ? _me;

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory, IMemoryCache cache)
        {
            _logger = logger;
            _cache = cache;
        }

        // StartExample:InsertTelemetry
        public void OnGet(string variable="")
        {
            _me = _cache.GetOrCreate(variable, entry => {
                entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30);
                return new CachedObject();
            });

            _me?.AddUsage();
        }
        // EndExample:InsertTelemetry
    }

    public class CachedObject
    {
        public int Usage { get; private set; } = 0;
        public void AddUsage()
        {
            ++Usage;
        }
    }
}
// EndExample:InsertTelemetry