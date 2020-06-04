
$ModuleName = 'Smtp4Dev4BcContainers'
$repoRootDir = (split-path $PSCommandPath)
$ModulPath = join-path $repoRootDir -ChildPath $ModuleName 

#region ValidateThatModuleIsImportable
Write-Host "ValidateThatModuleIsImportable"
Import-Module $ModulPath -Force
#region ValidateThatModuleIsImportable

#region SetModuleVersion
Write-Host "SetModuleVersion"
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
Write-Host "RunScriptAnalyzer"
if (-not (Get-InstalledModule PSScriptAnalyzer -ErrorAction SilentlyContinue)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}
gci $ModulPath -filter "*.ps1" -Recurse | Invoke-ScriptAnalyzer -Fix
#endregion RunScriptAnalyzer

#region RefreshDocs
Write-Host "RefreshDocs"
if (-not (Get-InstalledModule platyPS -ErrorAction SilentlyContinue)) {
    Install-Module -Name platyPS -Scope CurrentUser
}
Import-Module platyPS
$DocsPath = Join-Path $repoRootDir -ChildPath "docs\"
$null = mkdir $DocsPath -ErrorAction SilentlyContinue
if(gci $DocsPath -filter "*.md"){
    $null = Update-MarkdownHelpModule -Path $DocsPath -RefreshModulePage -UpdateInputOutput
} else {
    New-MarkdownHelp -Module $ModuleName -OutputFolder $DocsPath -HelpVersion $NewVersion -WithModulePage
}

#Fix mixed language due to my german system
$DocFiles = $DocsPath | gci -filter "*.md"
foreach($DocFile in $DocFiles){
    ($DocFile | get-content -Raw).Replace('### BEISPIEL','### EXAMPLE') | Set-Content -Path $DocFile.FullName
}
#endregion RefreshDocs

#region ValidateThatModuleIsImportable
Write-Host "ValidateThatModuleIsImportable"
#Do this again since we changed some files in the Build Process
Import-Module $ModulPath -Force
#region ValidateThatModuleIsImportable

#region RunTests
<#
Write-Host "RunTests"
if (-not (Get-InstalledModule Pester -ErrorAction SilentlyContinue)) {
    Install-Module -Name Pester -Scope CurrentUser
}
Import-Module Pester
foreach($TestScript in (gci -Path (Join-Path $repoRootDir -ChildPath "test") -Filter "*.tests.ps1" ).FullName){
    Write-Host "Run Tests in $TestScript"
    Invoke-Pester -Path $TestScript -Output Detailed
}
#>
#endregion RunTests
