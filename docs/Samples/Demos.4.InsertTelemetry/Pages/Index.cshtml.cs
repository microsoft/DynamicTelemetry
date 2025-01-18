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

        // StartExample:InsertTelemetryOnGet
        public void OnGet(string variable="")
        {
            _me = _cache.GetOrCreate(variable, entry => {
                entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30);
                return new CachedObject();
            });

            _me?.AddUsage();
        }
        // EndExample:InsertTelemetryOnGet
    }

    public class CachedObject
    {
        private int _usage = 0;
        public int Usage { get { lock (this) { return _usage; } } }
                    
        public void AddUsage()
        {
            lock (this) { ++_usage; }
        }
    }
}
// EndExample:InsertTelemetry