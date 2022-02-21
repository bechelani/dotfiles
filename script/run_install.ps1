# Run all dotfiles installers

Set-Location $PSScriptRoot/..

Get-ChildItem -Path ./ -Filter install.ps1 -Recurse | ForEach-Object -Process { 
    # Write-Host "  " + $_.FullName
    Invoke-Expression (Get-Content $_.FullName -Raw)
}
