
param pEnv string

param pLocation string
param pAppServicePlanName string
param pAppServiceName string
param pAppServiceInsightsName string

param pSqlServerName string
param pSqlServerDatabaseName string
param pSqlServerFirewallRuleName string
param pSqlServerAdminLogin string

@allowed(['S1', 'B1', 'B2', 'B3'])
param pSkuname string = (pEnv == 'dev') ? 'S1' : 'B1'

@minValue(1)
@maxValue(10)
param pSkucapacity int = (pEnv == 'dev') ? 1 : 2


resource TestPraveenVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' existing  = {
  name: 'test-praveen'
}

module AppServicePlan '3-AppServicePlan.bicep' = {
  name: 'myAppServicePlan'
  params: {
    pLocation: pLocation
    pAppServicePlanName: pAppServicePlanName
    pAppServiceName: pAppServiceName
    pInstrumentationKey: AppInsights.outputs.appInsightsKey 
    pSkuname: pSkuname
    pSkucapacity: pSkucapacity
    pEnv: pEnv
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
    pSqlServerAdminLogin: pSqlServerAdminLogin
    pSqlServerAdminPassword: TestPraveenVault.getSecret('sqlpassword')
  }
}
