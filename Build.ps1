$ModulPath = (split-path $PSCommandPath)
$ModuleName = 'Smtp4Dev4BcContainers'

#region ValidateThatModuleIsImportable
Import-Module $ModulPath -Force
#region ValidateThatModuleIsImportable

#region SetModuleVersion
$ManifestPath = (join-path $ModulPath -ChildPath "$ModuleName.psd1")
$Manifest = Test-ModuleManifest -Path (join-path $ModulPath -ChildPath "$ModuleName.psd1")
$newMajor = $Manifest.Version.Major
$newMinor = $Manifest.Version.Minor
$newBuild = get-date -Format "yyMMdd"
$newRevision = get-date -Format "HHmmss"
$NewVersion = New-Object System.Version -ArgumentList @($newMajor,$newMinor,$newBuild,$newRevision)
Update-ModuleManifest -Path $ManifestPath -ModuleVersion $NewVersion -Verbose
#endregion SetModuleVersion

#region RunScriptAnalyzer
if (-not (Get-InstalledModule PSScriptAnalyzer)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}
gci (Join-Path $ModulPath $ModuleName) -filter "*.ps1" -Exclude "*.tests.ps1" -Recurse | Invoke-ScriptAnalyzer -Fix
#endregion RunScriptAnalyzer

#region ValidateThatModuleIsImportable
#Do this again since we changed some files in the Build Process
Import-Module $ModulPath -Force
#region ValidateThatModuleIsImportable
