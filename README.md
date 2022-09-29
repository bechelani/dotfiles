# dotfiles for Windows

Dotfiles repository

## prerequisites

Install-Module nvm -Force
Install-Module oh-my-posh -Force
Install-Module PSReadLine -AllowPrerelease -Force

## symlinks

New-Item -ItemType SymbolicLink -Path $Profile -Target $Home\.dotfiles\powershell\Microsoft.PowerShell_profile.ps1.symlink

New-Item -ItemType SymbolicLink -Path C:\Users\MichelBechelani\AppData\Roaming\Code\User\settings.json -Target C:\Users\MichelBechelani\.dotfiles\code\settings.js
-Target C:\Users\MichelBechelani\.dotfiles\code\settings.json -Force
