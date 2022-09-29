$Env:DOTFILES=Join-Path $HOME ".dotfiles"

$config_files=Get-ChildItem $Env:DOTFILES -Recurse -Include *.pwsh

# Write-Host "config files"

#  $config_files
#      | ForEach-Object -Process { Write-Host "  " + $_.FullName }

# load the variable files
# Write-Host "load the variable files"

# $config_files | Where-Object { $_.Name -Match 'variables.pwsh' }
#     | ForEach-Object -Process { 
#         Write-Host "  " + $_.FullName
#         Invoke-Expression (Get-Content $_.FullName -Raw)
#     }

# load the secrets files
# Write-Host "load the secrets files"

$config_files | Where-Object { $_.Name -Match 'secrets.pwsh' }
    | ForEach-Object -Process { 
        # Write-Host "  " + $_.FullName
        Invoke-Expression (Get-Content $_.FullName -Raw)
    }

# load the path files
# Write-Host "load the path files"

$config_files | Where-Object { $_.Name -Match 'path.pwsh' }
    | ForEach-Object -Process { 
        # Write-Host "  " + $_.FullName
        Invoke-Expression (Get-Content $_.FullName -Raw)
    }

# load the module files
# Write-Host "load the modules files"

$config_files | Where-Object { $_.Name -Match 'modules.pwsh' }
    | ForEach-Object -Process { 
        # Write-Host "  " + $_.FullName
        Invoke-Expression (Get-Content $_.FullName -Raw)
    }

# load everything but the module, path and completion files
# Write-Host "load everything but the module, path, completion, varibles and secrets files"

$config_files | Where-Object { $_.Name -NotMatch 'modules.pwsh' -And $_.Name -NotMatch 'path.pwsh' -And $_.Name -NotMatch 'completion.pwsh' -And $_.Name -NotMatch 'variables.pwsh' -And $_.Name -NotMatch 'secrets.pwsh' }
    | ForEach-Object -Process { 
        # Write-Host "  " + $_.FullName
        Invoke-Expression (Get-Content $_.FullName -Raw)
    }
