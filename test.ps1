Import-Module -Name Datum -Scope Global
. .\build\Get-FilteredConfigurationData.ps1
. .\build\Get-DatumNodesRecursive.ps1
. .\build\Split-Array.ps1
. .\build\FlattenArray.ps1

$Datum = New-DatumStructure -DefinitionFile .\dsc_configdata\Datum1.json
$ConfigurationData = Get-FilteredConfigurationData -Filter {}

$ConfigurationData.AllNodes |
    Where-Object Name -ne * |
    ForEach-Object {
        $nodeRSOP = Get-DatumRsop -Datum $Datum -AllNodes ([ordered]@{ } + $_)
        $nodeRSOP | ConvertTo-Json -Depth 40
    }
