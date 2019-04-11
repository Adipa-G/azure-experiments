# Azure Functions

This folder contains sample implementations of Azure functions. The yaml build definition for Azure DevOps build (`azure-devops-build.yaml`) and ARM templates for deployment (`azuredeploy.json`) are also included.

Each function app is attached to App Insights to facilitate monitoring.

## Ping

This function is a liveness check endpoint triggered via a http request. The ARM template demonstrate hosting using a consumption plan.

## Timer

This function demonstrates the timer trigger. The ARM template demonstrate hosting using an app service plan.

## Setting up

* Clone this repository and create connected Azure DevOps pipeline with name "Azure-Functions-CI" (if you choose to use a different name make sure to update the paths in the release pipeline). Select the file `azure-devops-build.yaml` as the build definition.
* Create a [service connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azdevops) to Azure subscription from Azure DevOps.
* Create a resource group in your Azure subscription
* Run the build and make sure it succeeds.
* Create a release pipeline from successful build and add following steps
 
  1. Azure resource group deployment  

	   *  Title : `Ping - Azure Deployment:Create Or Update Resource Group` 
       *  Azure subscription : < Select the service connection >
       *  Action :  < Select "Create or update resource group" option >
       *  Resource group : Enter the resource group name created before
       *  Location : Select the desired location (this will not be used as ARM templates will use the location of the resource group)
       *  Template location : < Select "Linked Artifact" option >
       *  Template : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/ping/azuredeploy.json`
       *  Override template parameters : `-appInsightsName function-apps-insights -functionAppName ping-fa`
       *  Deployment mode : < Select "Incremental" option >

  2. Azure resource group deployment  (select the same options as previous step except for following) 
       
	   *  Title : `Timer - Azure Deployment:Create Or Update Resource Group` 	
       *  Template : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/timer/azuredeploy.json`
       *  Override template parameters : `-hostingPlanName function-apps-asp -appInsightsName function-apps-insights -storageAccountName function0apps0st -functionAppName timer-fa`

  3. Azure resource group deployment  (select the same options as previous step except for following)

	   *  Title : `Event Grid- Azure Deployment:Create Or Update Resource Group` 	
	   *  Template : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/eventgrid/azuredeploy.json`
	   *  Override template parameters : `-appInsightsName function-apps-insights -storageAccountName function0apps0st -functionAppName event-grid-fa`

	   
  4. Azure app service deployment

	   *  Title : `Azure App Service Deploy: ping-fa` 
	   *  Azure subscription : < Select the service connection >
       *  App Type : < Select "FunctionApp" option >
       *  App Service name : ping-fa
       *  Package or folder : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/ping`
    

  5. Azure app service deployment (select the same options as previous step except for following)
       
	   *  Title : `Azure App Service Deploy: timer-fa` 
	   *  App Service name : timer-fa
       *  Package or folder : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/timer`
	   
  6. Azure app service deployment (select the same options as previous step except for following)
       
	   *  Title : `Azure App Service Deploy: event-grid-fa` 
	   *  App Service name : event-grid-fa
       *  Package or folder : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/eventgrid`
	   
  7. Azure PowerShell
       
	   *  Title : `Azure PowerShell script: Register Event Grid Provider` 
	   *  Azure connection type : Azure resource manager
       *  Azure subscription : < Select the service connection >
       *  Script type : Inline
	   *  Inline script : `Register-AzureRmResourceProvider -ProviderNamespace “Microsoft.EventGrid”`

  8. Azure PowerShell
       
	   *  Title : `Azure PowerShell script: Get Function Master Key` 
	   *  Azure connection type : Azure resource manager
       *  Azure subscription : < Select the service connection >
       *  Script type : Script File Path
	   *  Script Path : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/eventgrid/get-function-host-mater-key.ps1`
	   *  Script Arguments : `function-apps-rg event-grid-fa`
	   	  
  9. Azure resource group deployment  (select the same options as previous step 1 except for following)
	
	   *  Title : `Event Grid Subscription - Azure Deployment:Create Or Update Resource Group` 
	   *  Template : `$(System.DefaultWorkingDirectory)/Azure-Functions-CI/drop/eventgrid/azuredeploy-subscribe-event-grid.json`
	   *  Override template parameters : `-functionAppName event-grid-fa -functionName eventgridfunction -functionHostMasterKey $(EventGridFunctionMasterKey) -storageAccountName function0apps0st`
		  
 *  Queue a release build.
   

## References

Functions : 
1. https://docs.microsoft.com/en-us/azure/azure-functions/
2. https://azure.microsoft.com/en-au/resources/videos/get-started-with-azure-functions/
 

Azure Quick Start Templates : https://github.com/Azure/azure-quickstart-templates

Timer Cron Jobs : https://codehollow.com/2017/02/azure-functions-time-trigger-cron-cheat-sheet/

Event Grid Function Trigger : https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid

