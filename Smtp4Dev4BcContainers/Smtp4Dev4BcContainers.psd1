@{
    RootModule        = 'Smtp4Dev4BcContainers.psm1'
    ModuleVersion     = '1.1.0.0'
    # CompatiblePSEditions = @()
    GUID              = '40db8432-1e45-47d6-82f7-b1084f02c25c'
    Author            = 'Chris Blank'
    CompanyName       = ''
    Copyright         = '(c) 2020 Chris Blank. All rights reserved.'
    Description       = 'PowerShell module for a easy handling of smtp4dev together with Business Central (BC) Containers'
    # PowerShellVersion = ''
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    RequiredModules   = @()
    # RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    # NestedModules = @()
    FunctionsToExport = 'Get-Smtp4DevContainerIp', 'New-Smtp4DevContainer', 'Remove-Smtp4DevContainer', 'Set-Smtp4DevInBcContainer', 'Test-Smtp4DevContainer'
    CmdletsToExport   = @()
    # VariablesToExport = @()
    AliasesToExport   = @()
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData       = @{
        PSData = @{
            # Tags = @()
            LicenseUri = 'https://github.com/ChrisBlankDe/Smtp4Dev4BcContainers/blob/master/LICENSE'
            ProjectUri = 'https://github.com/ChrisBlankDe/Smtp4Dev4BcContainers'
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
            # RequireLicenseAcceptance = $false
            # ExternalModuleDependencies = @()
        }
    }
    HelpInfoURI       = 'https://github.com/ChrisBlankDe/Smtp4Dev4BcContainers/issues'
    # DefaultCommandPrefix = ''
}
