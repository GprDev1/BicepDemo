param pLocation string = 'eastasia' 
param pAppServicePlanName string = 'azbicepasp1' 
param pAppServiceName string  = 'WebBicepApp1'

//Web App Service Plan
resource azbicepasp1 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: pAppServicePlanName
  location: pLocation
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
}

//Web App Service 
resource azbicepas1 'Microsoft.Web/sites@2021-01-15' = {
  name: pAppServiceName
  location: pLocation
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', pAppServicePlanName)
  }
  dependsOn: [
    azbicepasp1
  ]
}
