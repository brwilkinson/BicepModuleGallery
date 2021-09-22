cd .\BicepModuleGallery\  # <-- set path to root of project

$RGName = 'ACU1-BRW-AOA-RG-D2'
$registryTemplate = 'D:\Repos\BicepModuleGallery\setup\registry.bicep'
$registryName = 'myuniqueName54'

#region create registry

$Params = @{
    ResourceGroupName = $RGName
    TemplateFile      = $registryTemplate
    Verbose           = $true
    registryName      = $registryName
}

New-AzResourceGroupDeployment @Params
#endregion

#region publish the module
$env:BICEP_REGISTRY_ENABLED_EXPERIMENTAL = 'true'

# need the nightly build of bicep
bicep --version

#> Bicep CLI version 0.4.881 (d2239bd868)

bicep publish setup/module1.bicep --target "br:$registryName.azurecr.io/module1/module1:v1"
#endregion

#region consume the module from the BicepModuleGallery

bicep build ./consume/main.bicep

#endregion