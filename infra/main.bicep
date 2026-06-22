param location string = resourceGroup().location
param appServicePlanName string = 'asp-sanjana-demo-bicep'
param webAppName string = 'sanjana-bicep-demo-2026'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'NODE|22-lts'
      appCommandLine: 'npm start'
    }
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'