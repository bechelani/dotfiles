#!/usr/bin/env bash
#
# iterm2 config

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt

set -e

echo ""

info "configuring iTerm2"

user "Do you currently use iTerm2 and would you like to set your custom colors? y/n "
read -n 1 -e action

if [[ $action =~ ^[Yy]$ ]] ; then
  # Specify the preferences directory
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.itermcfg/"

  # Tell iTerm2 to use the custom preferences in the directory
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

  if [[ $? -eq 0 ]] ; then
    success "successfully configured iTerm2 to use your custom colors..."
  else
    fail "failed to apply your custom colors..." >&2
  fi
else
  info "You chose not to use iTerm2 or your custom colors."
fi
