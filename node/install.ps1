$DOTFILES_ROOT = (Get-Item $PSScriptRoot).Parent.FullName

function Init() {
    if (Get-Module -ListAvailable -Name DotFiles) {
    } else {
        Import-Module $(Join-Path $DOTFILES_ROOT script/DotFilesModule.psm1)
    }
}

function InstallNvm() {
    # Install nvm
    LogStart -Message "Install nvm module"

    LogInfo -Message "Installing nvm module"
    Install-Module nvm -Force
    LogSuccess -Message "Installed nvm module"

    LogInfo -Message "Importing nvm module"
    Import-Module nvm
    LogSuccess -Message "Imported nvm module"

    LogInfo -Message "Installing Node 16"
    Install-NodeVersion 16
    LogSuccess -Message "Installed Node 16"

    LogInfo -Message "Installing Node 14"
    Install-NodeVersion 14
    LogSuccess -Message "Installed Node 14"

    LogInfo -Message "Setting Node 14 as default"
    Set-NodeVersion 14
    LogSuccess -Message "Set Node 14 as default"

    LogEnd -Message "nvm module installed"
}

Init
InstallNvm
