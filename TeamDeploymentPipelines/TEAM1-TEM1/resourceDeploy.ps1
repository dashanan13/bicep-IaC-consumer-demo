
# Defining the Resource group that will host the deployment (resources will not be deployed to this resource grop, just deployment)
$deployRG = 'RG-Management'
# Getting the value of subscription from pipeline variables 
$subscriptionID = ${env:SUBSCRIPTIONID}
# Getting the value of common variables from pipeline variables 
# like environment, location and location codes etc
# these are to be set in the pipelines and NOT modified here
$envCode = 'dev'
$location = 'norwayeast'
$ownerteam = 'TEAM1'
$assetowner = 'mohit sharma'
$criticality = 'Low'
$projectCode = 'TEM1'
$locationCode = 'noe'
$classification = 'Public'

$purposeShortRGNet = 'Network'
$detailedPurposeRGNet = 'resource group created to host network resources'
$purposeShortRGSec = 'Security'
$detailedPurposeRGSec = 'resource group created to host security resources'

$sequenceNSG = '001'
$detailedPurposeNSG = 'NSG created for testing the templates'

$sequenceVNET = '001'
$detailedPurposeVNET = 'VNET created for testing the templates'

$sequenceSVNET = '001'

$subscriptionID = '60afef65-a07c-4c0d-9325-1a01d861eb85'


# Deploy new Resource group
$newrg = New-AzResourceGroupDeployment `
-Name "Deploy_RG" `
-TemplateFile .\TeamDeploymentPipelines\DARS-DRS\DARS-DRS-ResourceGroups.bicep `
-envCode $envCode `
-location $location `
-ownerteam $ownerteam `
-assetowner $assetowner `
-criticality $criticality `
-projectCode $projectCode `
-ResourceGroupName $deployRG `
-classification $classification `
-SubscriptionID $subscriptionID `
-purposeShortRGNet $purposeShortRGNet `
-detailedPurposeRGNet $detailedPurposeRGNet `
-purposeShortRGSec $purposeShortRGSec `
-detailedPurposeRGSec $detailedPurposeRGSec

$newrg


# Deploy rest of the resources to the new resource groups.
New-AzResourceGroupDeployment `
-Name "Deploy_resources_to_RG" `
-TemplateFile .\TeamDeploymentPipelines\DARS-DRS\DARS-DRS-OtherResources.bicep `
-ResourceGroupName 'RG-Management' `
-ScopeResourceGroupName1 $newrg.Outputs.scopeRGSec.Value `
-ScopeResourceGroupName2 $newrg.Outputs.scopeRGNet.Value `
-envCode $envCode `
-location $location `
-ownerteam $ownerteam `
-assetowner $assetowner `
-criticality $criticality `
-projectCode $projectCode `
-locationCode $locationCode `
-classification $classification `
-sequenceNSG $sequenceNSG `
-detailedPurposeNSG $detailedPurposeNSG `
-sequenceVNET $sequenceVNET `
-detailedPurposeVNET $detailedPurposeVNET `
-sequenceSVNET $sequenceSVNET `
-SubscriptionID $subscriptionID
