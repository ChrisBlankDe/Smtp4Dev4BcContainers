<#
.SYNOPSIS
    Creates or recreates a new container with smtp4dev
.DESCRIPTION
    Creates a new container based on the latest smtp4dev image
.PARAMETER Reset
    Removes all the Cache from your local machine before recreating a new smtp4dev container
.EXAMPLE
    New-Smtp4DevContainer
.EXAMPLE
    New-Smtp4DevContainer -Reset
#>
function New-Smtp4DevContainer {
    [CmdletBinding()]
    param(
        [switch]$Reset
    )
    process {
        #region CheckIfNavContainerHelperIsInstalled
        if (-not (Get-InstalledModule -Name navcontainerhelper -ErrorAction SilentlyContinue)) {
            Write-Error "navcontainerhelper is not installed." -ErrorAction Stop
        }
        #endregion CheckIfNavContainerHelperIsInstalled

        Remove-Smtp4DevContainer
        
        Write-Verbose "Pull Container"
        $null = docker pull rnwood/smtp4dev 
        if ($Reset) {
            Write-Verbose "Remove Data dir '$smtp4devDataFolder'"
            remove-item $smtp4devDataFolder -Force -Recurse
        }
        Write-Verbose "Create Data dir '$smtp4devDataFolder' if not exists"
        $null = mkdir $smtp4devDataFolder -ErrorAction SilentlyContinue
   
        #docker run -d -p 3000:80 -p 2525:25 --name smtp4dev -v $smtp4devDataFolder:c:/smtp4dev rnwood/smtp4dev 
         
        Write-Verbose "Create Container"
        $null = docker run -d -p 3000:80 -p 2525:25 --name smtp4dev -v C:\ProgramData\smtp4dev:C:\smtp4dev rnwood/smtp4dev 
    }
}
