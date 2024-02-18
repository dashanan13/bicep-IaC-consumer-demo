
// Common parameters
param envCode string
param location string
param ownerteam string
param assetowner string
param criticality string
param projectCode string
param locationCode string
param classification string
// Parameters specific to KV
param detailedPurposeKV string
param sequenceKV string
// Parameters specific to NSG
param detailedPurposeNSG string
param sequenceNSG string
// Parameters specific to VNet
param detailedPurposeVNET string
param sequenceVNET string


// Parameters specific to PIP
param detailedPurposePIP string
param sequencePIP string

param sequenceSVNET string
param vnetAddressPrefix string
param subnetPrefix string


// Deploying KeyVault
module stgkeyvault 'br:templatestore13.azurecr.io/keyvault:0.1.20240207.2' = {
    name: 'defaultkv'
  params: {
    assetowner: assetowner
    classification: classification
    criticality: criticality
    detailedPurpose: detailedPurposeKV
    envCode: envCode
    location: location
    locationCode: locationCode
    ownerteam: ownerteam
    projectCode: projectCode
    sequence: sequenceKV
  }
}


// Deploying Network Security Groups
module stgnsg 'br:templatestore13.azurecr.io/networksecuritygroup:0.1.20240115.1' = {
  name: 'defaultnsg'
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
module stgvnet 'br:templatestore13.azurecr.io/virtualnetwork:0.1.20240208.3' = {
  name: 'defaultvnet'
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
module stgvsubnet 'br:templatestore13.azurecr.io/virtualnetworksubnet:0.1.20240208.3' = {
  name: 'defaultsubnet'
  params: {
    envCode: envCode
    locationCode: locationCode
    networkName: stgvnet.outputs.virtualNetworkName
    networkSecurityGroupId: stgnsg.outputs.networkSecurityGroupId
    projectCode: projectCode
    sequence: sequenceSVNET
    subnetPrefix: subnetPrefix
  }
  dependsOn: [
    stgnsg
    stgvnet
  ]
}

// Deploying Public IP
module stgpip 'br:templatestore13.azurecr.io/publicipaddress:0.1.20240207.2' = {
  name: 'defaultpip'
  params: {
    assetowner: assetowner
    attachedto: 'someResource'
    classification: classification
    criticality: criticality
    detailedPurpose: detailedPurposePIP
    envCode: envCode
    location: location
    locationCode: locationCode
    ownerteam: ownerteam
    projectCode: projectCode
    sequence: sequencePIP
  }
}

