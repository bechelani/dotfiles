$DOTFILES_INSTALL_PATH = Join-Path $HOME .dotfiles
$global:DEBUG = $false

function LogDebug {
    param ([String]$Message)

    if ($global:DEBUG -eq $true) {
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
    Write-Host -NoNewline "`n  [ "
    Write-Host -NoNewline -ForegroundColor Blue "INF"
    Write-Host " ] $Message"
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

try {
    Push-Location   # we will pop the location in the finally block.

    LogStart -Message "Starting configure.ps1"

    #################################
    ## PRE-REQUISITES              ##
    #################################
    LogInfo -Message "Installing pre-requisites"

    # Install Git
    $isGitInstalled = $null -ne ( (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*) + (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*) | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains('Git') })
    if ($isGitInstalled -ne $true) {
        &winget install -e --id Git.Git
    }

    # Update PowerShellGet
    Install-Module PowerShellGet -Force

    # Install oh-my-posh
    Install-Module oh-my-posh -Force

    # Install PSReadLine
    Install-Module PSReadLine -AllowPrerelease -Force

    # Install Terminal-Icons
    Install-Module Terminal-Icons -Force

    #################################
    ## Pull down personal dotfiles ##
    #################################

    LogInfo -Message "Now pulling down bechelani dotfiles..."

    LogDebug -Message "DOTFILES_INSTALL_PATH: $DOTFILES_INSTALL_PATH"

    &git clone https://github.com/bechelani/dotfiles.git $DOTFILES_INSTALL_PATH --quiet

    Set-Location $DOTFILES_INSTALL_PATH
    LogInfo -Message "Switched to .dotfiles dir..."

    LogInfo -Message "Checking out windows branch..."
    &git checkout windows --quiet
    
    LogInfo -Message "Now configuring symlinks..."
    $BootstrapScript = Join-Path $DOTFILES_INSTALL_PATH script\bootstrap.ps1
    & $BootstrapScript

    LogEnd -Message "Finished configure.ps1"
} catch {
    LogFail -Message "configure.ps1 terminated with error" -Exception $_
} finally {
    Pop-Location
}
