
# Defining the Resource group that will host the deployment (resources will not be deployed to this resource grop, just deployment)
$deployRG = 'RG-Management'
# Getting the value of subscription from pipeline variables 
$subscriptionID = ${env:SUBSCRIPTIONID}
# Getting the value of common variables from pipeline variables 
# like environment, location and location codes etc
# these are to be set in the pipelines and NOT modified here
$envCode = ${env:ENVCODE}
$location = ${env:LOCATION}
$ownerteam = ${env:OWNERTEAM}
$assetowner = ${env:ASSETOWNER}
$criticality = ${env:CRITICALITY}
$projectCode = ${env:PROJECTCODE}
$locationCode = ${env:LOCATIONCODE}
$classification = ${env:CLASSIFICATION}
$purposeShortRG = ${env:PURPOSESHORTRG} 
$detailedPurposeRG = ${env:DETAILEDPURPOSERG}

$sequenceKV = ${env:SEQUENCEKV}
$detailedPurposeKV = ${env:DETAILEDPURPOSEKV}

$sequenceNSG = ${env:SEQUENCENSG}
$detailedPurposeNSG = ${env:DETAILEDPURPOSENSG}

$sequenceVNET = ${env:SEQUENCEVNET}
$detailedPurposeVNET = ${env:DETAILEDPURPOSEVNET}

$sequencePIP = ${env:SEQUENCEPIP}
$detailedPurposePIP = ${env:DETAILEDPURPOSEPIP}

$sequenceSVNET = ${env:SEQUENCESVNET}
$vnetAddressPrefix = ${env:VNETADDRESSPREFIX}
$subnetPrefix = ${env:SUBNETPREFIX}



# Deploy new Resource group
$newrg = New-AzResourceGroupDeployment `
-Name "Deploy_RG" `
-TemplateFile .\SampleDeploymentPipeline\BOS-Sample-IaC-Deploy-withPowershell-and-PipelineVariables\resourcegroupDeploy.bicep `
-envCode $envCode `
-location $location `
-ownerteam $ownerteam `
-SubscriptionID $subscriptionID `
-assetowner $assetowner `
-criticality $criticality `
-projectCode $projectCode `
-ResourceGroupName $deployRG `
-purposeShort $purposeShortRG `
-classification $classification `
-detailedPurpose $detailedPurposeRG


# Deploy rest of the resources to the new resource groups.
New-AzResourceGroupDeployment `
-Name "Deploy_resources_to_RG" `
-TemplateFile .\SampleDeploymentPipeline\BOS-Sample-IaC-Deploy-withPowershell-and-PipelineVariables\OtherResourcesDeploy-withscope.bicep `
-ResourceGroupName $newrg.Outputs.scopeResourceGroupName.Value `
-envCode $envCode `
-location $location `
-ownerteam $ownerteam `
-assetowner $assetowner `
-criticality $criticality `
-projectCode $projectCode `
-locationCode $locationCode `
-classification $classification `
-sequenceKV $sequenceKV `
-detailedPurposeKV $detailedPurposeKV `
-sequenceNSG $sequenceNSG `
-detailedPurposeNSG $detailedPurposeNSG `
-sequenceVNET $sequenceVNET `
-detailedPurposeVNET $detailedPurposeVNET `
-sequencePIP $sequencePIP `
-detailedPurposePIP $detailedPurposePIP `
-vnetAddressPrefix $vnetAddressPrefix `
-sequenceSVNET $sequenceSVNET `
-subnetPrefix $subnetPrefix