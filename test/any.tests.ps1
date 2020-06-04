Describe "Procedures" {
    BeforeAll {
        Import-Module (join-path (split-path $PSCommandPath) '..\Smtp4Dev4BcContainers') -Force
    }
    It "New-Smtp4DevContainer" {
        New-Smtp4DevContainer   
    }   
    It "New-Smtp4DevContainer -Reset" {
        New-Smtp4DevContainer -Reset
    }
    It "Get-Smtp4DevContainerIp" {
        New-Smtp4DevContainer   
        Get-Smtp4DevContainerIp
    }
    It "Test-Smtp4DevContainer" {
        New-Smtp4DevContainer   
        Test-Smtp4DevContainer
    }
    It "Remove-Smtp4DevContainer" {
        New-Smtp4DevContainer   
        Remove-Smtp4DevContainer
    }
    AfterAll {
        try { Remove-Smtp4DevContainer }catch { }
    }

}