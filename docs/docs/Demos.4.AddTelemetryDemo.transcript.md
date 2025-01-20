---
author: "Chris Gray"
status: ReviewLevel1b
---

This guide demonstrates how to add logging or metrics to production code without requiring changes or redeployment.

We will identify code sections that need additional logging, insert a log, trace it using OpenTelemetry, and observe the results in Application Insights.

Our DevOps team has observed an increase in server memory load, which may be due to a misconfigured Memory Cache affecting user load behaviors.

The graph illustrates consistent page loads over time.

Switching back to Visual Studio Code, we will add a Memory Probe to include the Cache Count in a new log message. If you're familiar with Conditional Breakpoints, this process is similar.

We now wait for our problem to occur. When it does, we'll revisit the graph in our database and notice a spike in the Cache Count, even though the pages loaded over time remained constant.

As you can see, Dynamic Telemetry allowed us to quickly gain an understanding of the operations of our product, without modifying and redeploying code.
