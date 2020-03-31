# Azure Functions

This folder contains sample implementations of Azure functions. The yaml build definition for Azure DevOps build (`azure-devops-build.yaml`) and ARM templates for deployment (`azuredeploy.json`) are also included.

Each function app is attached to App Insights to facilitate monitoring.

## Ping

This function is a liveness check endpoint triggered via a http request. The ARM template demonstrate hosting using a consumption plan.

## Timer

This function demonstrates the timer trigger. The ARM template demonstrate hosting using an app service plan. The funtion logs an event to Application insights.

## Event Grid

This function demonstrates the event grid trigger. When a file is uploaded into the blob storage, the function is triggerd using Event Grid. The funtion logs an event to Application insights.


## Setting up

* Clone this repository and create a multi-stage pipeline from the yaml file "pipeline/pipeline.yaml".
* Create a [service connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azdevops) to Azure subscription from Azure DevOps and name it "subscription-service-connection".
* Create a resource group in your Azure subscription named "function-apps-rg"
* Run the multi-stage pipeline.
   
## References

Functions : 
1. https://docs.microsoft.com/en-us/azure/azure-functions/
2. https://azure.microsoft.com/en-au/resources/videos/get-started-with-azure-functions/
 

Azure Quick Start Templates : https://github.com/Azure/azure-quickstart-templates

Timer Cron Jobs : https://codehollow.com/2017/02/azure-functions-time-trigger-cron-cheat-sheet/

Event Grid Function Trigger : https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid

