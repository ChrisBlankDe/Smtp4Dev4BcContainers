$ErrorActionPreference = 'Stop' #Thanks to scoping in posh this should only affect procedures in this module

$Smtp4DevDataFolder = "C:\ProgramData\Smtp4Dev"
$Smtp4DevContainerName = "smtp4dev"
$ShortcutTitle = "Smtp4Dev4BcContainers"

. (Join-Path $PSScriptRoot "private\Test-ModuleVersion.ps1")
. (Join-Path $PSScriptRoot "private\Invoke-Docker.ps1")

. (Join-Path $PSScriptRoot "public\Get-Smtp4DevContainerIp.ps1")
. (Join-Path $PSScriptRoot "public\New-Smtp4DevContainer.ps1")
. (Join-Path $PSScriptRoot "public\Remove-Smtp4DevContainer.ps1")
. (Join-Path $PSScriptRoot "public\Set-Smtp4DevInBcContainer.ps1")
. (Join-Path $PSScriptRoot "public\Test-Smtp4DevContainer.ps1")

try { Test-ModuleVersion } catch { }