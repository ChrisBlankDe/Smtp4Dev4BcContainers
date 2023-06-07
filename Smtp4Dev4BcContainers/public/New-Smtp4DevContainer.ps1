<#
.SYNOPSIS
    Creates or recreates a new container with smtp4dev
.DESCRIPTION
    Creates a new container based on the latest smtp4dev image
.PARAMETER Shortcut
    Defines where to create the shortcut
.PARAMETER Reset
    Removes all the Cache from your local machine before recreating a new smtp4dev container
.PARAMETER LocalUiPort
    Defines to what local port the smtp4dev UI will be redirected
.PARAMETER LocalSmtpPort
    Defines to what local port smtp will be redirected
.EXAMPLE
    New-Smtp4DevContainer
.EXAMPLE
    New-Smtp4DevContainer -Reset
.EXAMPLE
    New-Smtp4DevContainer -Shortcut CommonStartMenu
.EXAMPLE
    New-Smtp4DevContainer -LocalSmtpPort 25 -LocalUiPort 80
#>
function New-Smtp4DevContainer {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateSet('None', 'Desktop', 'StartMenu', 'Startup', 'CommonDesktop', 'CommonStartMenu', 'CommonStartup', 'DesktopFolder', 'CommonDesktopFolder')]
        [string]$Shortcut = "Desktop",
        [parameter(Mandatory = $false)]
        [switch]$Reset,
        [parameter(Mandatory = $false)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32]$LocalUiPort = 3000,
        [parameter(Mandatory = $false)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32]$LocalSmtpPort = 2525
    )
    process {
        #region CheckIfNavContainerHelperIsInstalled
        if (-not (Get-InstalledModule -Name bccontainerhelper -ErrorAction SilentlyContinue)) {
            Write-Error "bccontainerhelper is not installed." -ErrorAction Stop
        }
        #endregion CheckIfNavContainerHelperIsInstalled

        Remove-Smtp4DevContainer

        Write-Verbose "Pull Container"
        $null = Invoke-Docker -imageName "rnwood/smtp4dev" -command pull
        if ($Reset) {
            Write-Verbose "Remove Data dir '$smtp4devDataFolder'"
            remove-item $smtp4devDataFolder -Force -Recurse
        }
        Write-Verbose "Create Data dir '$smtp4devDataFolder' if not exists"
        $null = mkdir $smtp4devDataFolder -ErrorAction SilentlyContinue
        Write-Verbose "Create Container"
        $null = Invoke-Docker -imageName "rnwood/smtp4dev" -command run -parameters @("-p $($LocalUiPort):80", "-p $($LocalSmtpPort):25", "-v C:\ProgramData\smtp4dev:C:\smtp4dev", "--name $Smtp4DevContainerName", "--hostname $Smtp4DevContainerName", "--detach")
        #$null = docker run -d -p $($LocalUiPort):80 -p $($LocalSmtpPort):25 --name smtp4dev -v C:\ProgramData\smtp4dev:C:\smtp4dev rnwood/smtp4dev

        Write-Verbose "Create Shortcut"
        $ShortcutTarget = "http://localhost:$LocalUiPort"

        try {
            $IconLocation = Join-Path -Path $smtp4devDataFolder -ChildPath "icon.ico"
            Invoke-WebRequest -OutFile $IconLocation -Uri "https://raw.githubusercontent.com/rnwood/smtp4dev/v2.0.10/Rnwood.Smtp4dev/Resources/Icon1.ico" -TimeoutSec 5
        }
        catch {
            Write-Verbose "Icon Download failed for some reason. Fallback to iex icon"
            $IconLocation = "C:\Program Files\Internet Explorer\iexplore.exe, 3"
        }
        New-DesktopShortcut -Name $ShortcutTitle -TargetPath $ShortcutTarget -Shortcuts $Shortcut -IconLocation $IconLocation
    }
}
