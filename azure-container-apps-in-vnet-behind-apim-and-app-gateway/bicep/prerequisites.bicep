param location string = resourceGroup().location
param environmentName string = 'test'
param keyVaultName string = '${environmentName}-001-kv'
param miName string = '${environmentName}-mi'
param logAnalyticsWorkspaceName string = '${environmentName}-logs'
var acrName = '${environmentName}0apps0acr'

module acrModule 'acr.bicep' = {
  name: 'acrDeploy'
  params: {
    acrName: acrName
    location: location
  }
}

module miModule 'mi.bicep' = {
  name: 'miDeploy'
  params: {
    miName: miName
    location: location
  }
}

module kvModule 'kv.bicep' = {
  name: 'kvDeploy'
  params: {
    keyVaultName: keyVaultName
    location: location
    identityName: miModule.outputs.identityName
  }
  dependsOn:[miModule]
}

module diagModule 'diag.bicep' = {
  name: 'diagDeploy'
  params: {
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    location: location
  }
}
