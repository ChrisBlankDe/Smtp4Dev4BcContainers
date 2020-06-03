$ModulPath = (split-path $PSCommandPath)
$ModuleName = 'Smtp4Dev4BcContainers'

#region ValidateThatModuleIsImportable
Import-Module $ModulPath -Force
#region ValidateThatModuleIsImportable
