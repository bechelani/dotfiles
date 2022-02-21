# dotfiles for AzShell

## AzShell Configuration

Run the following to configure AzShell from scratch...

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression -Command ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/bechelani/dotfiles/azshell/configure.ps1'))"
```

It should go without saying, you should never run a script on your system without reading it to understand what changes it will make to your system. My scripts and code samples are no exception to the rule.

If you choose to use my dotfiles, my configure script will backup your current dotfiles, but will also make changes to your crontab - it's in your best interest to understand these changes prior to opting in.

## prerequisites

Install-Module nvm -Force
Install-Module oh-my-posh -Force
Install-Module Terminal-Icons -Force
Install-Module PSReadLine -AllowPrerelease -Force

## symlinks

New-Item -ItemType Directory -Path $Home/.config/PowerShell
New-Item -ItemType SymbolicLink -Path $Profile -Target $Home/.dotfiles/powershell/Microsoft.PowerShell_profile.ps1.symlink
