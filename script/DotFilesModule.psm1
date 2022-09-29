$LOG_DEBUG = $false
$LOG_INFO = $true

function Check-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)

    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Output $true
    } else {
        Write-Output $false
    }
}

function LogDebug {
    param ([String]$Message)

    if ($LOG_DEBUG -eq $true) {
        Write-Host -NoNewline "`n  [ "
        Write-Host -NoNewline -ForegroundColor Magenta "DBG"
        Write-Host " ] $Message"
    }
}

function LogEnd {
    param ([String]$Message)
    Write-Host -NoNewline "`n[ "
    Write-Host -NoNewline -ForegroundColor Green "END"
    Write-Host " ] $Message"
}

function LogFail {
    param ([String]$Message, [String]$Exception)
    Write-Host -NoNewline "`n  ["
    Write-Host -NoNewline -ForegroundColor Red "ERROR"
    Write-Host "] $Message"
    Write-Host `n$Exception
}

function LogInfo {
    param ([String]$Message)

    if ($LOG_INFO -eq $true) {
        Write-Host -NoNewline "`n  [ "
        Write-Host -NoNewline -ForegroundColor Blue "INF"
        Write-Host " ] $Message"
    }
}

function LogStart {
    param ([String]$Message)
    Write-Host -NoNewline "`n["
    Write-Host -NoNewline -ForegroundColor Green "START"
    Write-Host "] $Message"
}

function LogSuccess {
    param ([String]$Message)
    Write-Host -NoNewline "`n  [ "
    Write-Host -NoNewline -ForegroundColor Green "OK"
    Write-Host " ] $Message"
}

function LogUser {
    param ([String]$Message)
    Write-Host -NoNewline "  [ "
    Write-Host -NoNewline -ForegroundColor Yellow "???"
    return Read-Host " ] $Message "
}

Export-ModuleMember -Variable $LOG_DEBUG
Export-ModuleMember -Variable $LOG_INFO

Export-ModuleMember -Function LogDebug
Export-ModuleMember -Function LogEnd
Export-ModuleMember -Function LogFail
Export-ModuleMember -Function LogInfo
Export-ModuleMember -Function LogStart
Export-ModuleMember -Function LogSuccess
Export-ModuleMember -Function LogUser
