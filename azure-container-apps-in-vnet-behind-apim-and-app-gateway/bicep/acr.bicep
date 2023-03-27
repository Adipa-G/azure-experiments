@minLength(5)
@maxLength(50)
@description('Name of the azure container registry (must be globally unique)')
param acrName string
param location string

@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param acrSku string = 'Basic'

// azure container registry
resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = acr.properties.loginServer

