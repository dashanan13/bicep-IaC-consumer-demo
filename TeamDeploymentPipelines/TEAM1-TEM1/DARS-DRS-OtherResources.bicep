// Common parameters
param envCode string
param location string
param ownerteam string
param assetowner string
param criticality string
param projectCode string
param locationCode string
param classification string


// Parameters to get the names of RG
param SubscriptionID string
param ScopeResourceGroupName1 string
param ScopeResourceGroupName2 string

// Parameters specific to NSG
param detailedPurposeNSG string
param sequenceNSG string
// Parameters specific to VNet
param detailedPurposeVNET string
param sequenceVNET string
param vnetAddressPrefix string
// Parameters specific to Subnet
param sequenceSVNET string
param subnetPrefix string



// Deploying Network Security Groups
module drsnsg 'br:templatestore13.azurecr.io/networksecuritygroup:0.1.20240208.3' = {
  scope:  resourceGroup(SubscriptionID, ScopeResourceGroupName1)
  name: 'drs-nsg'
  params: {
    assetowner: assetowner
    classification: classification
    criticality: criticality
    detailedPurpose: detailedPurposeNSG
    envCode: envCode
    location: location
    locationCode: locationCode
    ownerteam: ownerteam
    projectCode: projectCode
    sequence: sequenceNSG
  }
}


// Deploying Virtual Network
module drsvnet 'br:templatestore13.azurecr.io/virtualnetwork:0.1.20240208.3' = {
  scope:  resourceGroup(SubscriptionID, ScopeResourceGroupName2)
  name: 'drs-vnet'
  params: {
    assetowner: assetowner
    classification: classification
    criticality: criticality
    detailedPurpose: detailedPurposeVNET
    envCode: envCode
    location: location
    locationCode: locationCode
    ownerteam: ownerteam
    projectCode: projectCode
    sequence: sequenceVNET
    vnetAddressPrefix: vnetAddressPrefix
  }
}

// Deploying Virtual Network Subnet
module drsvsubnet 'br:templatestore13.azurecr.io/virtualnetworksubnet:0.1.20240208.3' = {
  scope:  resourceGroup(SubscriptionID, ScopeResourceGroupName2)
  name: 'drs-subnet1'
  params: {
    envCode: envCode
    locationCode: locationCode
    networkName: drsvnet.outputs.virtualNetworkName
    networkSecurityGroupId: drsnsg.outputs.networkSecurityGroupId
    projectCode: projectCode
    sequence: sequenceSVNET
    subnetPrefix: subnetPrefix
  }
}
