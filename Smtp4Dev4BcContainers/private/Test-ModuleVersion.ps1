function Test-ModuleVersion {
    process {
        $name = $MyInvocation.MyCommand.Module
        Write-Verbose "Current Module Name is '$name'"
        $installedVersion = (get-installedmodule -Name Smtp4Dev4BcContainers | Sort-Object -Property Version | select -Last 1).Version #$MyInvocation.MyCommand.Module.Version does not work while module loading
        Write-Verbose "Current Module Version is '$installedVersion'"
        $Response = Invoke-WebRequest -Uri "https://www.powershellgallery.com/api/v2/Packages?`$filter=Id eq '$name' and IsLatestVersion"
        $OnlineVersion = ([xml]($Response.Content)).feed.entry.properties.Version
        Write-Verbose "Online Module Version is '$OnlineVersion'"
        if ([Version]::new($OnlineVersion) -gt $installedVersion) {
            Write-Warning "You are not using the latest version of $name. Your Version is $installedVersion, available is $OnlineVersion."
            return $false
        }
        return $true
       
    }
}
