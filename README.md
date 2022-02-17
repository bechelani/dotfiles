# dot-files for AzShell

Dotfiles repository

## prerequisites

Install-Module nvm -Force
Install-Module oh-my-posh -Force
Install-Module PSReadLine -AllowPrerelease -Force

## symlinks

New-Item -ItemType SymbolicLink -Path $Profile -Target $Home\.dotfiles\powershell\Microsoft.PowerShell_profile.ps1.symlink
