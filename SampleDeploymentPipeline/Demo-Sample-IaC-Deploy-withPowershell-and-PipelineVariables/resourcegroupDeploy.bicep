
// Common parameters
param envCode string
param location string
param ownerteam string
param assetowner string
param criticality string
param projectCode string
param classification string

@description('''
Provide the Subscription ID of the subscription targeted
The subscription ID can be found on the subscription overview page
''')
param SubscriptionID string

// Parameters specific to RG
param purposeShortRG string
param detailedPurposeRG string


module stgrgp 'br:templatestore13.azurecr.io/resourcegroup:0.1.20240207.2' = {
  scope: subscription(SubscriptionID)
  name: 'randomname_totest'
  params: {
    envCode: envCode
    criticality: criticality
    projectCode: projectCode
    ownerteam: ownerteam
    location: location
    classification: classification
    assetowner: assetowner
    purposeShort: purposeShortRG
    detailedPurpose: detailedPurposeRG
  }
}

output ScopeResourceGroupName string = stgrgp.outputs.resourcegroupName
