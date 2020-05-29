<#
.SYNOPSIS
    Gets the IP of the smtp4dev container
.DESCRIPTION
    Long description #TODO
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
