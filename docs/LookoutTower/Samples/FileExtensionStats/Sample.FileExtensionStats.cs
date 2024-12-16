//<!--start-->
using Microsoft.Extensions.Logging;
using System.Security.Cryptography;


internal partial class Program
{
    static void Main(string[] args)
    {
        using ILoggerFactory factory = LoggerFactory.Create(builder => builder.AddConsole());
        ILogger logger = factory.CreateLogger("Program");

        Random random = new Random();
        ImageExample imageProcessor = new ImageExample(logger);
        for(; ; )
        {
            int delay = random.Next(1000);       
            imageProcessor.HashImage("");
        }
    }

    private partial class ImageExample : IDisposable
    {
        private readonly ILogger m_logger;
        private readonly SHA256 m_SHA256;

        public void Dispose() => m_SHA256.Dispose();

        public ImageExample(ILogger logger)
        {
            m_logger = logger;
            m_SHA256 = SHA256.Create();
        }

        //<!--start-ImageHashExample-->
        public byte[] HashFile(string imageName)
        {            
            try
            {
                LogStartingFileHash(m_logger, imageName);
                using (FileStream fileStream = File.OpenRead(imageName))
                {
                    byte[] hashValue = m_SHA256.ComputeHash(fileStream);
                    return hashValue;
                }
            }
            catch (Exception e)
            {
                ErrorHashing(m_logger, imageName, e);
                throw;
            }
            finally
            {
                LogEndFileHash(m_logger, imageName);
            }
        }
        

        [LoggerMessage(Level = LogLevel.Information, Message = "Starting FileHash {imageName}.")]
        static partial void LogStartingFileHash(ILogger logger, string imageName);

        [LoggerMessage(Level = LogLevel.Information, Message = "Ending FileHash {imageName}.")]
        static partial void LogEndFileHash(ILogger logger, string imageName);

        [LoggerMessage(Level = LogLevel.Warning, Message = "Unable to hash image {imageName}")]
        static partial void ErrorHashing(ILogger logger, string imageName, Exception e);
        //<!--end-ImageHashExample-->
    }
}
//<!--end-->