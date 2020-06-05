Describe "Module" {
    It "Import-Module" {
        Import-Module (join-path (split-path $PSCommandPath) '..\Smtp4Dev4BcContainers') -Force
    }
}