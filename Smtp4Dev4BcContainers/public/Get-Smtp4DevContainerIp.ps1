<#
.SYNOPSIS
    Gets the IP of the smtp4dev container
.DESCRIPTION
    Inspect the smtp4dev Container and return the IP Address of the first network.
.EXAMPLE
    Get-Smtp4DevContainerIp
#>
function Get-Smtp4DevContainerIp {
    [CmdletBinding()]
    param()
    process {
        $Networks = (docker inspect $Smtp4DevContainerName | ConvertFrom-Json).NetworkSettings.Networks
        $Networks | get-member -MemberType NoteProperty | Select-Object Name | ForEach-Object {
            ($Networks | Select-Object -ExpandProperty $_.Name).IPAddress
        }
    }
}
