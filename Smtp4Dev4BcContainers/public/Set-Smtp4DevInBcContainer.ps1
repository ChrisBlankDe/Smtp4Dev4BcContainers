<#
.SYNOPSIS
    Sets the smtp4dev connection data in the given container
.DESCRIPTION
    Gets the smtp configuration from your smtp4dev container and inserts it into all tenants and all companies whithin the given container
.PARAMETER ContainerName
    Name of the container where you want to configure the smtp mail setup.
    Default is 'navserver'
.PARAMETER Force
    Avoid asking if Server Instances should be restarted, just do it.
.EXAMPLE
    Set-Smtp4DevInBcContainer
.EXAMPLE
    Set-Smtp4DevInBcContainer -ContainerName 'AnyBcContainer' -Force
#>
function Set-Smtp4DevInBcContainer {
    [CmdletBinding()]
    [Alias("Set-Smtp4DevInNavContainer")]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline)]
        [string]$ContainerName = 'navserver',
        [Switch]$Force
    )
    begin {
        function Set-InDatabase {
            param($containerName, $DatabaseName)
            $Tables = (Invoke-ScriptInNavContainer -containerName $ContainerName { param($DatabaseName) Invoke-Sqlcmd -Query "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%SMTP Mail Setup%'" -Database $DatabaseName } -argumentList @($DatabaseName)).TABLE_NAME
            foreach ($Table in $Tables) {
                Write-Verbose "Found Table '$Table'"
                Write-Verbose "Read current Configuration"
                $query = 'select * from [{0}]' -f $Table
                Write-Verbose "Current Configuration for Table '$Table' in Database '$DatabaseName'"
                Write-Verbose "Execute Query: $query"
                $CurrentConfig = Invoke-ScriptInNavContainer -containerName $containerName -scriptblock { param($Query, $DatabaseName)Invoke-Sqlcmd -Query $Query -Database $DatabaseName } -argumentList @($query, $DatabaseName)
                $CurrentConfig

                Write-Verbose "Write new Configuration"
                $query = "UPDATE [{0}] SET [SMTP Server] = '{1}',[Authentication] = 0,[SMTP Server Port]={2},[Secure Connection] = 0" -f $Table, $Smtp4DevContainerName, 25
                Write-Verbose "Execute Query: $query"
                Invoke-ScriptInNavContainer -containerName $containerName -scriptblock { param($Query, $DatabaseName)Invoke-Sqlcmd -Query $Query -Database $DatabaseName } -argumentList @($query, $DatabaseName)
            }
        }
    }
    process {
        if (Get-NavContainerServerConfiguration -ContainerName $containerName | ForEach-Object { $_.Multitenant }) {
            Write-Verbose "Container '$containerName' hast multitenant configuration."
            foreach ($tenant in (Get-NavContainerTenants -containerName $containerName)) {
                Write-Verbose "Found Tenant '$($tenant.id)' with Database $($tenant.DatabaseName)"
                Set-InDatabase -containerName $containerName -DatabaseName $tenant.DatabaseName
            }
        }
        else {
            Write-Verbose "Container '$containerName' hast singletenant configuration."
            Set-InDatabase -containerName $containerName -DatabaseName (Get-NavContainerServerConfiguration -ContainerName $containerName).DatabaseName
        }
        if (-not $force) {
            $title = "Restart Server Instance"
            $message = "To avoid caching issues in the SMTP Setup Page the Server Instance should be restarted. Use -Force to avoid this prompt. Restart all Server Instances in container '$containerName'?"
            $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
            $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
            $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
            $choice = $host.ui.PromptForChoice($title, $message, $options, 0)
            if ($choice -eq 0) {
                Write-Verbose "User decided: Yes"
                Invoke-ScriptInNavContainer -containerName $containerName -scriptblock { $null = Get-NavServerInstance | Restart-NavServerInstance -Verbose:$Verbose }
            }
            else {
                Write-Verbose "User decided: No"
            }
        }
    }
}