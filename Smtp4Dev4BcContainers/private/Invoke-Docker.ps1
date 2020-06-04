#Src: https://github.com/microsoft/navcontainerhelper/blob/master/HelperFunctions.ps1
function Invoke-Docker {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$imageName,
        [ValidateSet('run', 'start', 'pull', 'restart', 'stop')]
        [string]$command = "run",
        [switch]$silent,
        [string[]]$parameters = @()
    )

    $result = $true
    $arguments = ("$command " + [string]::Join(" ", $parameters) + " $imageName")
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "docker.exe"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = $arguments
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $pinfo
    $null = $process.Start()

    $errtask = $process.StandardError.ReadToEndAsync()
    $err = ""
    
    do {
        Start-Sleep -Milliseconds 100
    } while (!($process.HasExited))
    
    $err = $errtask.Result
    $process.WaitForExit();

    if ($process.ExitCode -ne 0) {
        $result = $false
        if (!$silent) {
            $err = $err.Trim()
            $errorMessage = ""
            if ("$err" -ne "") {
                $errorMessage += "$err`r`n"
            }
            $errorMessage += "ExitCode: " + $process.ExitCode + "`r`nCommandline: docker $arguments"
            Write-Error -Message $errorMessage
        }
    }
    $result
}