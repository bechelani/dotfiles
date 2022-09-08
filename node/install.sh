#!/usr/bin/env bash
#
# iterm2 config

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt

set -e

echo ""

info "Installing NodeJS"

nvm install --lts

success "NodeJS installed"
