// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

//start
using Microsoft.Extensions.Logging;
using System.Security.Cryptography;
using System.Text;

internal partial class TriggeringOnQueue
{
    static void Main(string[] args)
    {
        using ILoggerFactory factory = LoggerFactory.Create(builder => builder.AddConsole());
        ILogger logger = factory.CreateLogger("Program");

        Random random = new Random();
        ExampleWorkerAgent worker = new ExampleWorkerAgent(logger);
        ThreadPool.QueueUserWorkItem( x => {worker.ProcessWorkQueue();});

        for(; ; )
        {
            int depth = worker.EnqueueWork(new Work());
            if (depth > 10000)
                Thread.Sleep(5000);
        }
    }

    private partial class Work
    {
        public void DoWork()
        {
            Thread.Sleep(1000);
        }
    }

    private partial class ExampleWorkerAgent
    {
        private readonly ILogger m_logger;
        private object m_lock = new object();
        private Semaphore m_workItemReadySemaphore = new Semaphore(0, int.MaxValue);
        private Queue<Work> m_WorkQueue = new Queue<Work>();

        public ExampleWorkerAgent(ILogger logger)
        {
            m_logger = logger;
        }

        public int EnqueueWork(Work work)
        {
            lock (m_lock)
            {
                m_WorkQueue.Enqueue(work);
                m_workItemReadySemaphore.Release();
                LogEnqueueWork(m_logger, m_WorkQueue.Count);
                return m_WorkQueue.Count;
            }
        }

        //start-SampleWorkQueue
        public void ProcessWorkQueue()
        {
            for (; ; )
            {
                m_workItemReadySemaphore.WaitOne();
                Work myWork;
                lock (m_lock)
                {
                    myWork = m_WorkQueue.Dequeue();
                    LogDequeueWork(m_logger, m_WorkQueue.Count);
                }
                myWork.DoWork();
            }
        }

        [LoggerMessage(Level = LogLevel.Information, Message = "Dequeue depth={depth}")]
        static partial void LogDequeueWork(ILogger logger, int depth);

        [LoggerMessage(Level = LogLevel.Information, Message = "Enqueue depth={depth}")]
        static partial void LogEnqueueWork(ILogger logger, int depth);
        //end-SampleWorkQueue

#if false
        //start-PseudoExample-Language-Processor-VerifyHash
        void OnLog(LogMessage log)
        {
            // Skip all logs, but the ending hash
            if(log.LogId == "LogEndFileHash")
            {
                string hashGeneratedInProduction = log.GetValue("hashValue");
                string file = log.GetValue("fileName");

                string comparisonHash = GenerateVerificationHash(file);

                if (hashGeneratedInProduction != comparisonHash)
                {
                    m_Actions.GenerateNewLog(file, hashGeneratedInProduction, comparisonHash);
                }
            }
        }

        [LoggerMessage(Level = LogLevel.Error, Message = "ERROR: Language Processor detected production hash bug {fileName}")]
        static partial void ErrorInProductionHash(ILogger logger, string fileName, string productHash, string comparisonHash);

        //end-PseudoExample-Language-Processor-VerifyHash
#endif
    }
}

//end
