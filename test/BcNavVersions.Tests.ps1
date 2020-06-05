function TestWithImage {
    param([String]$Image, [switch]$MultiTenant)
    $ContainerCred = New-Object System.Management.Automation.PSCredential ("Admin", (ConvertTo-SecureString "Start2018" -AsPlainText -Force))
    New-NavContainer -accept_eula -containerName test -imageName $Image -Credential $ContainerCred -multitenant:$MultiTenant #| Select-WriteHost -Quiet
    Set-Smtp4DevInBcContainer -ContainerName test -Force
}
function Select-WriteHost {
    #Src: https://latkin.org/blog/2012/04/25/how-to-capture-or-redirect-write-host-output-in-powershell/
    [CmdletBinding(DefaultParameterSetName = 'FromPipeline')]
    param(
        [Parameter(ValueFromPipeline = $true, ParameterSetName = 'FromPipeline')]
        [object] $InputObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'FromScriptblock', Position = 0)]
        [ScriptBlock] $ScriptBlock,
        [switch] $Quiet
    )
    begin {
        function Cleanup {
            remove-item function:write-host -ea 0
        }
        function ReplaceWriteHost([switch] $Quiet, [string] $Scope) {
            $metaData = New-Object System.Management.Automation.CommandMetaData (Get-Command 'Microsoft.PowerShell.Utility\Write-Host')
            $proxy = [System.Management.Automation.ProxyCommand]::create($metaData)

            $content = if ($quiet) {
                $proxy -replace '(?s)\bbegin\b.+', '$Object' 
            }
            else {
                $proxy -replace '($steppablePipeline.Process)', '$Object; $1'
            }  
            Invoke-Expression "function ${scope}:Write-Host { $content }"
        }
        Cleanup
        if ($pscmdlet.ParameterSetName -eq 'FromPipeline') {
            ReplaceWriteHost -Quiet:$quiet -Scope 'global'
        }
    }
    process {
        if ($pscmdlet.ParameterSetName -eq 'FromScriptBlock') {
            . ReplaceWriteHost -Quiet:$quiet -Scope 'local'
            & $scriptblock
        }
        else {
            $InputObject
        }
    }
    end {
        Cleanup
    }  
}

Describe "BcNavVersions" {
    BeforeAll {
        . $(Join-path -path (Split-Path $PSCommandPath) -ChildPath 'HelperFunctions.ps1')
        Import-Module (join-path (split-path $PSCommandPath) '..\Smtp4Dev4BcContainers') -Force
        New-Smtp4DevContainer -Shortcut None
    }
    It "Test with BC onPrem 1810 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1810"
    }
    It "Test with BC onPrem 1810 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1810" -MultiTenant
    }
    It "Test with BC onPrem 1904 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1904"
    } 
    It "Test with BC onPrem 1904 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1904" -MultiTenant
    }
    It "Test with BC onPrem 1910 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1910"
    }
    It "Test with BC onPrem 1910 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:1910" -MultiTenant
    }
    It "Test with BC onPrem 2004 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:2004"
    } 
    It "Test with BC onPrem 2004 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/onprem:2004" -MultiTenant
    }
    It "Test with BC sandbox SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/sandbox"
    }
    It "Test with BC sandbox MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/businesscentral/sandbox" -MultiTenant
    }
    It "Test with NAV 2018 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2018"
    }
    It "Test with NAV 2018 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2018" -MultiTenant
    }
    It "Test with NAV 2017 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2017"
    } 
    It "Test with NAV 2017 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2017" -MultiTenant
    }
    It "Test with NAV 2016 SingleTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2016"
    } 
    It "Test with NAV 2016 MultiTenant" {
        TestWithImage -Image "mcr.microsoft.com/dynamicsnav:2016" -MultiTenant
    }

    AfterAll {
        try { Remove-Smtp4DevContainer }catch { }
        try { Remove-NavContainer test }catch { }

    }

}