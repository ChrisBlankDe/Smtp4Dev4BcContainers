<#
.SYNOPSIS
    Creates a new container with smtp4dev
.DESCRIPTION
    # Long description #TODO
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
     
        Remove-Smtp4DevContainer
        Write-Verbose "Pull Container"
        docker pull rnwood/smtp4dev:v3 
        if ($Reset) {
            Write-Verbose "Remove Data dir '$smtp4devDataFolder'"
            remove-item $smtp4devDataFolder -Force -Recurse
        }
        Write-Verbose "Create Data dir '$smtp4devDataFolder' if not exists"
        $null = mkdir $smtp4devDataFolder -ErrorAction SilentlyContinue
   
        #docker run -d -p 3000:80 -p 2525:25 --name smtp4dev -v $smtp4devDataFolder:c:/smtp4dev rnwood/smtp4dev 
         
        Write-Verbose "Create Container"
        docker run -d -p 3000:80 -p 2525:25 --name smtp4dev -v C:\ProgramData\smtp4dev:C:\smtp4dev rnwood/smtp4dev 
        #Write-Error "bla"
    }
}
