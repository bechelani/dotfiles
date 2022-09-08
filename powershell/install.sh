#!/usr/bin/env bash
#
# powershell config

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt
source $DOTFILES_ROOT/script/linkfile

set -e

echo ""
info "configuring powershell"

if ! [ -d "$HOME/.config/powershell" ] ; then
  mkdir -p "$HOME/.config/powershell"
fi

link_file "$DOTFILES_ROOT/powershell/Microsoft.PowerShell_profile.ps1" "$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"

success "powershell configured"
