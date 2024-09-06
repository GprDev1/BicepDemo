param pLocation string  
param pAppServicePlanName string  
param pAppServiceName string  
param pInstrumentationKey string

@description('''
Please provide the SKU name for the App Service Plan
  - S1
  - B1
  - B2
  - B3
''')
@allowed(['S1', 'B1', 'B2', 'B3'])
param pSkuname string 


param pSkucapacity int = 1

//Web App Service Plan
resource azbicepasp1 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: pAppServicePlanName
  location: pLocation
  sku: {
    name: pSkuname
    tier: 'Standard'
    capacity: pSkucapacity
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
