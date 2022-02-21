$DOTFILES_ROOT = (Get-Item $PSScriptRoot).Parent.FullName

$SecretsFile = (Join-Path $DOTFILES_ROOT aya/secrets.pwsh)
#$SshFile = (Join-Path $HOME /.ssh/id_rsa)

function Init() {
    if (Get-Module -ListAvailable -Name DotFiles) {
    } else {
        Import-Module $(Join-Path $DOTFILES_ROOT script/DotFilesModule.psm1)
    }
}

function SetupAya() {
    LogStart -Message "Install Aya"

    # # setup SSH key for GitHub

    # ## check for $Home/.ssh
    # if ((Test-Path $Home/.ssh) -eq $false) {
    #     LogInfo -Message "Creating $Home/.ssh directory"
    #     New-Item -Path $Home/.ssh -ItemType Directory
    #     LogSuccess -Message "Created $Home/.ssh directory"
    # }

    # ## ask for SSH key
    # $SshKey = LogUser -Message " - What is your GitHub SSH Key?"

    # ## create id_rsa file
    # LogInfo -Message "Creating id_rsa file"
    # New-Item -Path $SshFile -ItemType File -Force
    # Set-Content -Path $SshFile -Value $SshKey
    # LogSuccess -Message "Created id_rsa file"

    # install script modules

    ## check for $Home/dev/utils/
    if ((Test-Path $Home/dev/utils/scripts) -eq $false) {
        LogInfo -Message "Creating $Home/dev/utils/script directory"
        New-Item -Path $Home/dev/utils/scripts -ItemType Directory
        LogSuccess -Message "Created $Home/dev/utils/script directory"
    }

    ## clone bechelani/PowerShellModules to $Home/dev/utils/scripts
    LogInfo -Message "Cloning bechelani/PowerShellModules repo"
    &git clone git@github.com:bechelani/PowerShellModules.git $Home/dev/utils/scripts --quiet
    LogSuccess -Message "Cloned bechelani/PowerShellModules repo"

    # download aya repositories

    ## check for $Home/dev/ayahealthcare
    if ((Test-Path $Home/dev/ayahealthcare) -eq $false) {
        LogInfo -Message "Creating $Home/dev/ayahealthcare directory"
        New-Item -Path $Home/dev/ayahealthcare -ItemType Directory
        LogSuccess -Message "Created $Home/dev/ayahealthcare directory"
    }

    # create secrets.pwsh

    ## ask for AYA_GITHUB_TOKEN
    $AyaGitHubToken = LogUser -Message " - What is your Aya GitHub Token?"

    ## create file
    LogInfo -Message "Creating secrets.pwsh file"
    New-Item -Path $SecretsFile -ItemType File -Force
    Set-Content -Path $SecretsFile -Value "# Aya Secrets"
    Add-Content -Path $SecretsFile -Value "`$Env:AYA_GITHUB_TOKEN = `"$AyaGitHubToken`""
    LogSuccess -Message "Created secrets.pwsh file"

    LogEnd -Message "Installed Aya"
}

Init
SetupAya
