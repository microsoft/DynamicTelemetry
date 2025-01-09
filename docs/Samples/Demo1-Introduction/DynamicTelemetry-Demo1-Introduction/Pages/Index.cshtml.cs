using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Http.Extensions;
using SkiaSharp;
using System.Diagnostics.Metrics;
using Microsoft.AspNetCore.Mvc;
using System.Drawing;
using System.Numerics;
using System.Diagnostics;

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

                int max = 0;

                for (int x = 0; x < bitmap.Width; ++x)
                {
                    for (int y = 0; y < bitmap.Height; ++y)
                    {
                        double a = (x - width / 2.0) * 4.0 / width;
                        double b = (y - height / 2.0) * 4.0 / height;
                        Complex c = new Complex(a, b);
                        Complex z = new Complex(0, 0);
                        int iterations = 0;
                        int maxIterations = 1000;
                        float steps = 255 / maxIterations;
                                              
                        while (z.Magnitude < 2 && iterations < maxIterations)
                        {
                            z = z * z + c;
                            iterations++;
                        }

                        if (iterations > max)
                            max = iterations;

                        double t = (double)iterations / 1000;
                        byte r = (byte)(9 * (1 - t) * t * t * t * 255);
                        byte g = (byte)(15 * (1 - t) * (1 - t) * t * t * 255);
                        byte bColor = (byte)(8.5 * (1 - t) * (1 - t) * (1 - t) * t * 255);

                        SKColor black = new SKColor(r, g, bColor);

                        bitmap.SetPixel(x, y, black);
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

        class Complex
        {
            public double Real { get; }
            public double Imaginary { get; }

            public Complex(double real, double imaginary)
            {
                Real = real;
                Imaginary = imaginary;
            }

            public static Complex operator +(Complex a, Complex b) =>
                new Complex(a.Real + b.Real, a.Imaginary + b.Imaginary);

            public static Complex operator *(Complex a, Complex b) =>
                new Complex(a.Real * b.Real - a.Imaginary * b.Imaginary, a.Real * b.Imaginary + a.Imaginary * b.Real);

            public double Magnitude => Math.Sqrt(Real * Real + Imaginary * Imaginary);
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
