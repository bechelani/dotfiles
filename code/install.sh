#!/usr/bin/env bash
#
# symlink VSCode User Settings

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt
source $DOTFILES_ROOT/script/linkfile

set -e

echo ""
info "Configuring VS Code"

if [ -d "$HOME/Library/Application\ Support/Code/User" ] ; then
  info "  making backup of current settings.json and creating symlink..."
  link_file "$DOTFILES_ROOT/code/settings.json" "$HOME/Library/Application\ Support/Code/User/settings.json" && success "settings.json for vs code symlink created"
  #mv $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.old.json && success "settings.old.json created"
  #ln -s $HOME/.dotfiles/code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json && success "settings.json for vs code symlink created"
else
  info "  VS Code does not appear to be installed or has not been launched yet."
  info "  trying to launch VS Code"

  code ~/Documents

  user "Please wait for VS Code to launch then press enter."
  read -e vscode

  if [ -d "$HOME/Library/Application\ Support/Code/User" ] ; then
    link_file "$DOTFILES_ROOT/code/settings.json" "$HOME/Library/Application\ Support/Code/User/settings.json" && success "settings.json for vs code symlink created"
  else
    info "  symlink for vs code settings not created"
    info "  VS Code does not appear to be installed or has not been launched yet. Cannot create symlink for VS Code User settings..."
  fi
fi
