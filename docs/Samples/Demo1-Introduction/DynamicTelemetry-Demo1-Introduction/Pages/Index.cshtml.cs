using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Http.Extensions;
using SkiaSharp;
using System.Diagnostics.Metrics;
using Microsoft.AspNetCore.Mvc;

namespace DynamicTelemetry_Demo1_Introduction.Pages
{
    public partial class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private Counter<int> _getCounter;
        private Random _rand = new Random();
        private string _version = "0.0.1";

        public IndexModel(ILogger<IndexModel> logger, IMeterFactory meterFactory)
        {
            var meter = meterFactory.Create("DynamicTelemetry.Sample1.IndexModel");
            _getCounter = meter.CreateCounter<int>("OnGet");
            _logger = logger;

            LogLaunch(_logger, _version);
        }

        public void OnGet(int iterations)
        {
            _getCounter.Add(1);

            string url = HttpContext.Request.GetDisplayUrl();
            LogGet(_logger, url, iterations);

            FibHelper(2);
        }

        public IActionResult OnGetLoadImageFile()
        {
            int width = 100;
            int height = 100;
            SKColor backgroundColor = new SKColor((uint)_rand.Next());

            LogImageRequested(_logger, width, height);

            using (var bitmap = new SKBitmap(width, height))
            {
                LogStep(_logger, 1);

                for (int x = 0; x < bitmap.Width; ++x)
                {
                    for (int y = 0; y < bitmap.Height; ++y)
                    {
                        //LogPixel(_logger, x, y);
                        bitmap.SetPixel(x, y, backgroundColor);
                    }
                }

                // Save the bitmap to a file
                using (var image = SKImage.FromBitmap(bitmap))
                using (var data = image.Encode(SKEncodedImageFormat.Png, 10))
                using (MemoryStream ms = new MemoryStream())
                {
                    data.SaveTo(ms);
                    return File(ms.GetBuffer(), "image/png");
                }
            }
        }

        private int FibHelper(int n)
        {
            if (n < 2)
            {
                return n;
            }
            return FibHelper(n - 1) + FibHelper(n - 2);
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "LogGet({url}, iterations={iterations})")]
        static partial void LogGet(ILogger logger, string url, int iterations);

        [LoggerMessage(Level = LogLevel.Information, Message = "Pixel x={x}, y={y}")]
        static partial void LogPixel(ILogger logger, int x, int y);

        [LoggerMessage(Level = LogLevel.Information, Message = "Image Download Requested width={width}, height={height}")]
        static partial void LogImageRequested(ILogger logger, int width, int height);

        [LoggerMessage(Level = LogLevel.Information, Message = "Exception")]
        static partial void LogException(ILogger logger, Exception ex);

        [LoggerMessage(Level = LogLevel.Information, Message = "Launch,  ver={version}")]
        static partial void LogLaunch(ILogger logger, string version);

        [LoggerMessage(Level = LogLevel.Information, Message = "Progress,  step={step}")]
        static partial void LogStep(ILogger logger, int step);
    }
}
