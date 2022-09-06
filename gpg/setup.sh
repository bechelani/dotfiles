#!/usr/bin/env bash
#
# setup configures gpg things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt
source $DOTFILES_ROOT/script/linkfile

set -e

brewBundle () {
  # Run Homebrew through the Brewfile
  echo "› brew bundle"

  cd $DOTFILES_ROOT/gpg

  brew bundle

  cd $DOTFILES_ROOT
}

downloadPublicGpgKey () {
  echo ""
  info "downloading public gpg key"

  curl -LSso ./public_gpg.asc https://raw.githubusercontent.com/bechelani/public_keys/main/public_gpg.asc && success 'gpg key downloaded'
}

importAndTrustGpgKey () {
  KEYID=$(gpg --with-fingerprint public_gpg.asc)

  info "importing public gpg key ($KEYID)"
  gpg --import ./public_gpg.asc

  info "raising level trust of public gpg key ($KEYID)"
  echo "$KEYID:6:" | gpg --import-ownertrust

  success "gpg key configured"
}

configureGpgAgent () {
  echo ""
  info "configuring gpg"

  local overwrite_all=false backup_all=false skip_all=false

  link_file "$HOME/.dotfiles/gpg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
  link_file "$HOME/.dotfiles/gpg/gpg.conf" "$HOME/.gnupg/gpg.conf"

  success "gpg configured"
}

cleanup () {
  info "cleaning after ourselves"
  rm -f ./public_gpg.asc
}

brewBundle
downloadPublicGpgKey
importAndTrustGpgKey
configureGpgAgent
cleanup
