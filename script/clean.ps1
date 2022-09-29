# cleanup removes symlinked files and .dotfiles

$DOTFILES_ROOT = (Get-Item $PSScriptRoot).Parent.FullName

$global:DEBUG = $false

function Init() {
    if (Get-Module -ListAvailable -Name DotFiles) {
    } else {
        Import-Module $(Join-Path $DOTFILES_ROOT script\DotFilesModule.psm1)
    }
}

function CleanGitConfig() {
    if ((Test-Path -Path git\gitconfig.local.symlink -PathType Leaf) -eq $false) {
        LogInfo -Message "Setup gitconfig"

        $GitCredential='cache'

        $GitAuthorName = LogUser -Message " - What is your GitHub author name?"
        $GitAuthorEmail = LogUser -Message " - What is your GitHub author email?"

        ((((Get-Content -Path $DOTFILES_ROOT\git\gitconfig.local.symlink.example -Raw) -Replace 'AUTHORNAME', $GitAuthorName) -Replace 'AUTHOREMAIL', $GitAuthorEmail) -Replace 'GIT_CREDENTIAL_HELPER', $GitCredential) | Set-Content -Path $DOTFILES_ROOT\git\gitconfig.local.symlink

        LogSuccess -Message "gitconfig"
    }
}

function CleanGitSymLinks() {
    LogInfo -Message "Clean git files"

    UnLinkFile -Source (Join-Path $DOTFILES_ROOT "git\gitconfig.symlink") -Destination $HOME\.gitconfig
    UnLinkFile -Source (Join-Path $DOTFILES_ROOT "git\gitconfig.local.symlink") -Destination $HOME\.gitconfig.local
    UnLinkFile -Source (Join-Path $DOTFILES_ROOT "git\gitignore.symlink") -Destination $HOME\.gitignore

    LogSuccess -Message "Cleaned git files"
}

function CleanPowerShellSymLinks() {
    LogInfo -Message "Clean PowerShell files"

    if ((Test-Path $HOME\.config\PowerShell) -eq $false) {
        LogInfo -Message "Creating $HOME\.config\PowerShell directory"
        New-Item -Path $HOME\.config\PowerShell -ItemType Directory
        LogSuccess -Message "Created $HOME\.config\PowerShell directory"
    }

    UnLinkFile -Source (Join-Path $DOTFILES_ROOT "powershell\Microsoft.PowerShell_profile.ps1.symlink") -Destination $Profile # $HOME\.config\PowerShell\Microsoft.PowerShell_profile.ps1

    LogSuccess -Message "Cleaned PowerShell files"
}

function CleanDotFiles() {
    LogInfo -Message "Cleaning dotfiles"

    $SymLinkFiles = Get-ChildItem -Path $DOTFILES_ROOT -Filter *.symlink -Recurse

    ForEach ($SymLinkFile in $SymLinkFiles) {
        if ($SymLinkFile.FullName -match "git") {
            continue
        }

        if ($SymLinkFile.FullName -match "powershell") {
            continue
        }

        $FileName = [System.IO.Path]::GetFileNameWithoutExtension($SymLinkFile)
        $Destination = Join-Path $Home $FileName
        UnLinkFile -Source $SymLinkFile.FullName -Destination $Destination
    }

    LogSuccess -Message "Cleaned dotfiles"
}

function UnLinkFile([string]$Source, [string]$Destination) {
    LogInfo -Message "Unlinking $Source -> $Destination"

    $symLink = Get-Item $Destination -ErrorAction SilentlyContinue |
    Where-Object { $_.LinkType -eq 'SymbolicLink' -and $_.Target -like $Source }

    if ($symLink) {
        LogDebug -Message "Deleting symlink $Destination"
        $symLink.Delete()
        LogInfo "Deleted $Destination"
    }

    LogSuccess "Unlinked $Source -> $Destination"
}

try {
    Push-Location   # we will pop the location in the finally block.

    Init

    # if (-not(Check-IsElevated)) {
    #     throw [System.InvalidOperationException]::new("Please run this script as an administrator")
    # }

    LogStart -Message "Starting clean.ps1"

    CleanGitSymLinks
    CleanPowerShellSymLinks
    CleanDotFiles

    LogEnd -Message "Finished clean.ps1"

    Write-Host "`nBad ass windows terminal cleaned!"
# } catch [System.InvalidOperationException] {
#     throw
} catch [System.Exception] {
    LogFail -Message "clean.ps1 terminated with error" -Exception $_
} finally {
    Pop-Location
}
