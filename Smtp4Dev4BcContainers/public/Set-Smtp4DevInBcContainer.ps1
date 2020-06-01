<#
.SYNOPSIS
    Sets the smtp4dev connection data in the given container
.DESCRIPTION
    Gets the smtp configuration from your smtp4dev container and inserts it into all tenants and all companies whithin the given container
.PARAMETER ContainerName
    Name of the container where you want to configure the smtp mail setup.
    Default is 'navserver'
.EXAMPLE
    Set-Smtp4DevInBcContainer
.EXAMPLE
    Set-Smtp4DevInBcContainer -ContainerName 'AnyBcContainer'
#>
function Set-Smtp4DevInBcContainer {
    [CmdletBinding()]
    [Alias("Set-Smtp4DevInNavContainer")]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline)]
        [string]$ContainerName = 'navserver'
    )
    begin {
        function Set-InDatabase {
            param($containerName, $DatabaseName)
            $Tables = (Invoke-ScriptInBCContainer -containerName navserver { param($DatabaseName) Invoke-Sqlcmd -Query "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%SMTP Mail Setup%'" -Database $DatabaseName } -argumentList @($DatabaseName)).TABLE_NAME
            foreach ($Table in $Tables) {
                Write-Verbose "Found Table '$Table'"
                Write-Verbose "Read current Configuration"
                $query = 'select * from [{0}]' -f $Table
                Write-Host "Current Configuration for Table '$Table' in Database '$DatabaseName'"
                Write-Verbose "Execute Query: $query"
                $CurrentConfig = Invoke-ScriptInBCContainer -containerName $containerName -scriptblock { param($Query, $DatabaseName)Invoke-Sqlcmd -Query $Query -Database $DatabaseName } -argumentList @($query, $DatabaseName)
                $CurrentConfig

                Write-Verbose "Write new Configuration"
                $SmtpServerName = Get-Smtp4DevContainerIp
                $query = "UPDATE [{0}] SET [SMTP Server] = '{1}',[Authentication] = 0,[SMTP Server Port]=25,[Secure Connection] = 0" -f $Table, $SmtpServerName
                Write-Verbose "Execute Query: $query"
                Invoke-ScriptInBCContainer -containerName $containerName -scriptblock { param($Query, $DatabaseName)Invoke-Sqlcmd -Query $Query -Database $DatabaseName } -argumentList @($query, $DatabaseName)
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
    }
}