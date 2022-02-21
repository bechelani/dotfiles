# bootstrap installs things

$DOTFILES_ROOT = (Get-Item $PSScriptRoot).Parent.FullName

$script:OverwriteAll = $false
$script:BackupAll = $false
$script:SkipAll = $false

function Init() {
    if (Get-Module -ListAvailable -Name DotFiles) {
    } else {
        Import-Module $(Join-Path $DOTFILES_ROOT script/DotFilesModule.psm1)
    }
}

function SetupGitConfig() {
    if ((Test-Path -Path git/gitconfig.local.symlink -PathType Leaf) -eq $false) {
        LogInfo -Message "Setup gitconfig"

        $GitCredential='cache'

        $GitAuthorName = LogUser -Message " - What is your GitHub author name?"
        $GitAuthorEmail = LogUser -Message " - What is your GitHub author email?"

        ((((Get-Content -Path git/gitconfig.local.symlink.example -Raw) -Replace 'AUTHORNAME', $GitAuthorName) -Replace 'AUTHOREMAIL', $GitAuthorEmail) -Replace 'GIT_CREDENTIAL_HELPER', $GitCredential) | Set-Content -Path git/gitconfig.local.symlink

        LogSuccess -Message "gitconfig"
    }
}

function SetupGitSymLinks() {
    LogInfo -Message "Symlink git files"

    LinkFile -Source (Join-Path $DOTFILES_ROOT "git/gitconfig.symlink") -Destination $HOME/.gitconfig
    LinkFile -Source (Join-Path $DOTFILES_ROOT "git/gitconfig.local.symlink") -Destination $HOME/.gitconfig.local
    LinkFile -Source (Join-Path $DOTFILES_ROOT "git/gitignore.symlink") -Destination $HOME/.gitignore

    LogSuccess -Message "Symlink git files"
}

function SetupPowerShellSymLinks() {
    LogInfo -Message "Symlink PowerShell files"

    # check for $Home/dev/ayahealthcare
    if ((Test-Path $HOME/.config/PowerShell) -eq $false) {
        LogInfo -Message "Creating $HOME/.config/PowerShell directory"
        New-Item -Path $HOME/.config/PowerShell -ItemType Directory
        LogSuccess -Message "Created $HOME/.config/PowerShell directory"
    }

    LinkFile -Source (Join-Path $DOTFILES_ROOT "powershell/Microsoft.PowerShell_profile.ps1.symlink") -Destination $HOME/.config/PowerShell/Microsoft.PowerShell_profile.ps1

    LogSuccess -Message "Symlink PowerShell files"
}

function LinkFile([string]$Source, [string]$Destination) {
    LogInfo -Message "Linking $Destination -> $Source"

    if ((Test-Path $Destination) -eq $true) {
        LogDebug -Message "Test-Path $Destination -eq $true"

        $Overwrite
        $Backup
        $Skip

        LogDebug -Message "Destination : $Destination"
        LogDebug -Message ""
        LogDebug -Message "OverwriteAll : $script:OverwriteAll"
        LogDebug -Message "BackupAll : $script:BackupAll"
        LogDebug -Message "SkipAll : $script:SkipAll"

        if (($script:OverwriteAll -eq $false) -and ($script:BackupAll -eq $false) -and ($script:SkipAll -eq $false)) {
            $CurrentSrc = Resolve-Path -Path $Destination

            LogDebug -Message "Destination : $Destination"
            LogDebug -Message "CurrentSrc : $CurrentSrc"
            LogDebug -Message "Source : $Source"

            if ($CurrentSrc.FullName -eq $Source) {
                $Skip = $true
                LogDebug -Message "Skip : $true"
            } else {
                $Action = LogUser -Message "File already exists: $Destination ($Source), what do you want to do?`n          [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"

                Switch -CaseSensitive ($Action) {
                    "o" {
                        LogDebug -Message "Setting Overwrite to true"
                        $Overwrite = $true
                    }
                    "O" {
                        LogDebug -Message "Setting OverwriteAll to true"
                        $script:OverwriteAll = $true
                    }
                    "b" {
                        LogDebug -Message "Setting Backup to true"
                        $Backup = $true
                    }
                    "B" {
                        LogDebug -Message "Setting BackupAll to true"
                        $script:BackupAll = $true
                    }
                    "s" {
                        LogDebug -Message "Setting Skip to true"
                        $Skip = $true
                    }
                    "S" {
                        LogDebug -Message "Setting SkipAll to true"
                        $script:SkipAll = $true
                    }
                }
            }
        }

        LogDebug -Message ""
        LogDebug -Message "Action : $Action"
        LogDebug -Message ""
        LogDebug -Message "OverwriteAll : $script:OverwriteAll"
        LogDebug -Message "BackupAll : $script:BackupAll"
        LogDebug -Message "SkipAll : $script:SkipAll"
        LogDebug -Message ""
        LogDebug -Message "Overwrite : $Overwrite"
        LogDebug -Message "Backup : $Backup"
        LogDebug -Message "Skip : $Skip"
        LogDebug -Message ""

        $Overwrite = $Overwrite -or $script:OverwriteAll
        $Backup = $Backup -or $script:BackupAll
        $Skip = $Skip -or $script:SkipAll

        LogDebug -Message "Overwrite : $Overwrite"
        LogDebug -Message "Backup : $Backup"
        LogDebug -Message "Skip : $Skip"
        LogDebug -Message ""

        if ($Overwrite -eq $true) {
            Remove-Item -Recurse -Force $Destination
            LogSuccess "Removed $Destination"
        }

        if ($Backup -eq $true) {
            Move-Item -Path $Destination -Destination "$Destination.backup"
            LogSuccess "Moved $Destination to $Destination.backup"
        }

        if ($Skip -eq $true) {
            LogSuccess "Skipped $Destination"
        }
    }

    if ($Skip -ne $true) {
        New-Item -ItemType SymbolicLink -Path $Destination -Target $Source | Out-Null
        LogSuccess "Linked $Destination -> $Source"
    }
}

function InstallDotFiles() {
    LogInfo -Message "Installing dotfiles"

    $SymLinkFiles = Get-ChildItem -Path ./ -Filter *.symlink -Recurse

    ForEach ($SymLinkFile in $SymLinkFiles) {
        if ($SymLinkFile.FullName -match "git") {
            continue
        }

        if ($SymLinkFile.FullName -match "powershell") {
            continue
        }

        $FileName = [System.IO.Path]::GetFileNameWithoutExtension($SymLinkFile)
        $Destination = Join-Path $Home $FileName
        LinkFile -Source $SymLinkFile.FullName -Destination $Destination
    }
}

try {
    Push-Location   # we will pop the location in the finally block.

    Init

    # if (-not(Check-IsElevated)) {
    #     throw [System.InvalidOperationException]::new("Please run this script as an administrator")
    # }

    LogStart -Message "Starting bootstrap.ps1"

    SetupGitConfig
    SetupGitSymLinks
    SetupPowerShellSymLinks
    InstallDotFiles

    # Write-Host "PSScriptRoot: $PSScriptRoot"
    # Write-Host "DOTFILES_ROOT: $DOTFILES_ROOT"

    LogEnd -Message "Finished bootstrap.ps1"

    Write-Host "`nBadass AzShell terminal installed!"
# } catch [System.InvalidOperationException] {
#     throw
} catch [System.Exception] {
    LogFail -Message "bootstrap.ps1 terminated with error" -Exception $_
} finally {
    Pop-Location
}
