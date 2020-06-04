<#
.SYNOPSIS
    Tests the smtp4dev container
.DESCRIPTION
    checks if container is running, reachable and send a test mail to smtp4dev
.EXAMPLE
    Test-Smtp4DevContainer
#>
function Test-Smtp4DevContainer {
    [CmdletBinding()]
    param(
    )
    process {
        $result = docker ps -a --format "{{.Names}}" | Where-Object { $_ -eq $Smtp4DevContainerName }
        if ($result) {
            Write-Verbose "Container '$Smtp4DevContainerName' does exist."
        }
        else {
            Write-Error "Container '$Smtp4DevContainerName' does not exist." -ErrorAction Stop
        }
        $Inspect = docker inspect $Smtp4DevContainerName | ConvertFrom-Json
        if ($Inspect.State.Status -eq "running") {
            Write-Verbose "Container '$Smtp4DevContainerName' is running."
        }
        else {
            Write-Error "Container '$Smtp4DevContainerName' is not running. Current status is '$($Inspect.State.Status)'."
        }

        try {
            Write-Verbose "Sending a test mail"
            Send-MailMessage -SmtpServer $(Get-Smtp4DevContainerIp) -Port 25 -Subject "Smtp4Dev4BcContainers Test Mail" -Body "Hope you like it :)" -To "receiver@Smtp4Dev4BcContainers.io" -From "sender@Smtp4Dev4BcContainers.io"
            Write-Verbose "Seems like everything works fine"
        }
        catch {
            throw
        }

    }
}
