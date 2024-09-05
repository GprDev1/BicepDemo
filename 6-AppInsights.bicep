
param pLocation string  
param pAppServiceInsightsName string 

resource azbicepaits 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: pAppServiceInsightsName
  location: pLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output appInsightsKey string = azbicepaits.properties.InstrumentationKey
