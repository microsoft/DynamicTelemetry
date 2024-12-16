//<!--start-->
using Microsoft.Extensions.Logging;
using System.Security.Cryptography;
using System.Text;


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
            string tempFile = Path.GetTempFileName();
            try
            {
                using (FileStream outFile = File.OpenWrite(tempFile))
                {
                    byte[] buffer = new byte[4096];
                    random.NextBytes(buffer);
                    outFile.Write(buffer);
                }

                //BUGBUG: create a sample file that is hashed
                imageProcessor.HashFile(tempFile);
            }
            finally
            {
                if (File.Exists(tempFile))
                    File.Delete(tempFile);
            }
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
        public string HashFile(string imageName)
        {
            try
            {
                // 1. Log the start of the hashing process
                LogStartingFileHash(m_logger, imageName);

                // 2. Open the file and hash it
                using (FileStream fileStream = File.OpenRead(imageName))
                {
                    string hashValue = Convert.ToBase64String(m_SHA256.ComputeHash(fileStream));

                    // 3. Log the end of the hashing process
                    LogEndFileHash(m_logger, imageName, hashValue);
                    return hashValue;
                }
            }
            catch (Exception e)
            {
                // Log any exceptions that occur
                ErrorHashing(m_logger, imageName, e);
                throw;
            }
        }


        [LoggerMessage(Level = LogLevel.Information, Message = "Starting FileHash {imageName}.")]
        static partial void LogStartingFileHash(ILogger logger, string imageName);

        [LoggerMessage(Level = LogLevel.Information, Message = "Ending FileHash {imageName}, hash={hashValue}.")]
        static partial void LogEndFileHash(ILogger logger, string imageName, string hashValue);

        [LoggerMessage(Level = LogLevel.Warning, Message = "Unable to hash image {imageName}")]
        static partial void ErrorHashing(ILogger logger, string imageName, Exception e);
        //<!--end-ImageHashExample-->
    }
}
//<!--end-->