// param pLocation string //= 'westus' //resourceGroup().location
// param pAppServicePlanName string // = 'azbicepasp1' 
// param pAppServiceName string // = 'WebBicepApp1'
// param pAppServiceInsightsName string // = 'WebBicepApp1insights'

param pLocation string  
param pAppServicePlanName string  
param pAppServiceName string  
param pInstrumentationKey string

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
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'azbicepasp1')
  }
  dependsOn: [
    azbicepasp1
  ]
}

//Web App Service App Settings
resource azbiceppas1setting 'Microsoft.Web/sites/config@2021-01-15' = {
  name: 'web'
  parent: azbicepas1
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pInstrumentationKey
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
} 


//key: 76e83bc7-7cf9-414c-a5ff-240217fa3451

