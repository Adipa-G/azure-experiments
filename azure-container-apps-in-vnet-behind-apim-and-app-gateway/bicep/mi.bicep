param location string
param miName string 

resource mi 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name: miName
  location: location
}

output identityName string = mi.name
