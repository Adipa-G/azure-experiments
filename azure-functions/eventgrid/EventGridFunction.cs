using System;
using Microsoft.ApplicationInsights;
using Microsoft.Azure.EventGrid.Models;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;

namespace eventgrid
{
    public static class EventGridFunction
    {
        [FunctionName("eventgridfunction")]
        public static void EventGridTest([EventGridTrigger]EventGridEvent eventGridEvent, ILogger log)
        {
            var telemetryClient = new TelemetryClient();
            log.LogInformation($"C# Event Grid trigger function executed at: {DateTime.Now}");
            telemetryClient.TrackEvent("EventGrid_Trigger");
        }
    }
}
