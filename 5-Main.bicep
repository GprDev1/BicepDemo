param pLocation string = 'eastasia' 
param pAppServicePlanName string = 'azbicepasp1' 
param pAppServiceName string  = 'WebBicepApp1'
param pAppServiceInsightsName string = 'WebBicepApp1insights'

param pSqlServerName string = 'azbicepsqlserver'
param pSqlServerDatabaseName string = 'caseworx'
param pSqlServerFirewallRuleName string = 'caseworxIpRule'

module AppServicePlan '3-AppServicePlan.bicep' = {
  name: 'myAppServicePlan'
  params: {
    pLocation: pLocation
    pAppServicePlanName: pAppServicePlanName
    pAppServiceName: pAppServiceName
    pInstrumentationKey: AppInsights.outputs.appInsightsKey 
  }
}

module AppInsights '6-AppInsights.bicep' = {
  name: 'myAppInsights'
  params: {
    pAppServiceInsightsName: pAppServiceInsightsName
    pLocation: pLocation
  }
}

module SQLDatabase '4-SQLServer.bicep' = {
  name: 'SQLDatabase'
  params: {
    pSqlServerName: pSqlServerName
    pSqlServerDatabaseName: pSqlServerDatabaseName
    pSqlServerFirewallRuleName: pSqlServerFirewallRuleName
    pLocation: pLocation
  }
}
