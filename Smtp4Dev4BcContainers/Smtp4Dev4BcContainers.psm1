$Smtp4DevDataFolder = "C:\ProgramData\Smtp4Dev"
$Smtp4DevContainerName = "smtp4dev"
$ShortcutTitle = "smtp4dev"

. (Join-Path $PSScriptRoot "public\Get-Smtp4DevContainerIp.ps1")
. (Join-Path $PSScriptRoot "public\New-Smtp4DevContainer.ps1")
. (Join-Path $PSScriptRoot "public\Remove-Smtp4DevContainer.ps1")
. (Join-Path $PSScriptRoot "public\Set-Smtp4DevInBcContainer.ps1")
. (Join-Path $PSScriptRoot "public\Test-Smtp4DevContainer.ps1")