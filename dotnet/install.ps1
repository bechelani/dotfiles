$DOTFILES_ROOT = (Get-Item $PSScriptRoot).Parent.FullName

function Init() {
    if (Get-Module -ListAvailable -Name DotFiles) {
    } else {
        Import-Module $(Join-Path $DOTFILES_ROOT script/DotFilesModule.psm1)
    }
}

$SecretsFile = (Join-Path $DOTFILES_ROOT dotnet/secrets.pwsh)

function SetupDotNet() {
    LogStart -Message "Install .NET"

    # create secrets.pwsh
    ## ask for NUGET_API_KEY
    $NugetApiKey = LogUser -Message " - What is your Aya NuGet Api Key?"

    ## create file
    LogInfo -Message "Creating secrets.pwsh file"
    New-Item -Path $SecretsFile -ItemType File -Force
    Set-Content -Path $SecretsFile -Value "# Aya Secrets"
    Add-Content -Path $SecretsFile -Value "`$Env:NUGET_API_KEY = `"$NugetApiKey`""
    LogSuccess -Message "Created secrets.pwsh file"
    

    LogEnd -Message "Installed .NET"
}

Init
SetupDotNet
