
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

// Parameters specific to RG-Network
param purposeShortRGNet string
param detailedPurposeRGNet string

// Parameters specific to RG-Security
param purposeShortRGSec string
param detailedPurposeRGSec string

module drsrgsec 'br:templatestore13.azurecr.io/resourcegroup:0.1.20240207.2' = {
  scope: subscription(SubscriptionID)
  name: 'DRS-RG-Network'
  params: {
    envCode: envCode
    location: location
    ownerteam: ownerteam
    assetowner: assetowner
    projectCode: projectCode
    criticality: criticality
    classification: classification
    purposeShort: purposeShortRGNet
    detailedPurpose: detailedPurposeRGNet
  }
}


module drsrgnet 'br:templatestore13.azurecr.io/resourcegroup:0.1.20240207.2' = {
  scope: subscription(SubscriptionID)
  name: 'DRS-RG-Security'
  params: {
    envCode: envCode
    location: location
    ownerteam: ownerteam
    assetowner: assetowner
    projectCode: projectCode
    criticality: criticality
    classification: classification
    purposeShort: purposeShortRGSec
    detailedPurpose: detailedPurposeRGSec
  }
}

output scopeRGSec string = drsrgsec.outputs.resourcegroupName
output scopeRGNet string = drsrgnet.outputs.resourcegroupName
