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
            LogWelcome(_logger);

            _me = _cache.GetOrCreate(variable, entry => {
                entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30);
                return new CachedObject();
            });

            _me?.AddUsage();
        }
        // EndExample:InsertTelemetryOnGet

        [LoggerMessage(Level = LogLevel.Information, Message = "OnGet:Welcome")]
        static partial void LogWelcome(ILogger logger);

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

/*
// StartExample:KQL_Monitor
//
// Sample KQL query to monitor the CacheCount
//
traces
| extend EventName = tostring(customDimensions.EventName)
| project EventName, message, customDimensions, timestamp
| extend CacheCount=toint(customDimensions.cacheLength)
| summarize countif(EventName == "LogWelcome"), max(CacheCount) by bin(timestamp, 1m)
| render timechart
// EndExample:KQL_Monitor
*/


//
//  Notes: this sample dynamically simluates adding the below log message
//LogCacheLength(_logger, ((MemoryCache)_cache).Count);
//[LoggerMessage(Level = LogLevel.Information, Message = "CacheCount={cacheLength}")]
//static partial void LogCacheLength(ILogger logger, int cacheLength);
