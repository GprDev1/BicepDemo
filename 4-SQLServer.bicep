param pSqlServerName string  
param pSqlServerDatabaseName string  
param pSqlServerFirewallRuleName string  
param pLocation string 

param pSqlServerAdminLogin string
@secure()
param pSqlServerAdminPassword string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: pSqlServerName
  location: pLocation
  properties: {
    administratorLogin: pSqlServerAdminLogin
    administratorLoginPassword: pSqlServerAdminPassword
  }
}
resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: pSqlServerFirewallRuleName
  properties: {
    startIpAddress: '1.1.1.1'
    endIpAddress: '1.1.1.1'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: pSqlServerDatabaseName
  location: pLocation
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}



