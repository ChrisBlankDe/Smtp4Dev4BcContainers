Describe "Module" {
    It "Import-Module" {
        Import-Module (join-path (split-path $PSCommandPath) '..')
    }
}