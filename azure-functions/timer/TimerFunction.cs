using System;
using Microsoft.ApplicationInsights;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;

namespace timer
{
    public static class TimerFunction
    {
        [FunctionName("TimerFunction")]
        public static void Run([TimerTrigger("*/30 * * * * *")]TimerInfo myTimer, TraceWriter log)
        {
            var telemetryClient = new TelemetryClient();
            log.Info($"C# Timer trigger function executed at: {DateTime.Now}");
            telemetryClient.TrackEvent("TimerFunction_Trigger");
        }
    }
}
