<#
.SYNOPSIS
    Removes the smtp4dev container
.DESCRIPTION
    Removes the smtp4dev container
.EXAMPLE
    Remove-Smtp4DevContainer
#>
function Remove-Smtp4DevContainer {
    [CmdletBinding()]
    param()
    process {
        $existingContainer = (docker ps -a --format "{{.Names}}") | Where-Object { $_ -eq $Smtp4DevContainerName }
        if ($existingContainer) {
            Write-Verbose "Removing existing smtp4dev Container"
            $null = docker rm $existingContainer -f
        }
        Remove-DesktopShortcut -Name $ShortcutTitle
    }
}
