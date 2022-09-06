#!/usr/bin/env bash
#
# setup configures ssh things.

echo "starting ssh/uninstall.sh"

echo $pwd

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt
source $DOTFILES_ROOT/script/linkfile

echo $pwd

set -e

restoreSshConfiguration () {

  if [[ -L "$HOME/.ssh/config" ]] ; then
    info "removing ssh config link"
    echo ""
    rm $HOME/.ssh/config  && success "ssh config link removed"

    if [ -f $HOME/.ssh/config.backup ] ; then
      info "restoring ssh config"
      echo ""
      mv $HOME/.ssh/config.backup $HOME/.ssh/config && success "ssh configuration restored"
    fi
  fi

}

removePublicSshKey () {

  if [ -f $HOME/.ssh/id_rsa_yubikey.pub ] ; then
    echo "Deleting current id_rsa_yubikey.pub..."
    echo ""
    mv $HOME/.ssh/id_rsa_yubikey.pub $HOME/.ssh/id_rsa_yubikey.old.pub && success "id_rsa_yubikey.old.pub deleted"
  fi

  if [ -f $HOME/.ssh/id_rsa_yubikey.old.pub ] ; then
    echo "Restoring old id_rsa_yubikey.pub..."
    echo ""
    mv $HOME/.ssh/id_rsa_yubikey.old.pub $HOME/.ssh/id_rsa_yubikey.pub && success "id_rsa_yubikey.old.pub restored"
  fi

}

removeSshDirectory () {

  if [ ! "$(ls -A $HOME/.ssh)" ]; then
    info "deleting ssh directory"
    rm -rf $HOME/.ssh && success "ssh directory deleted"
	fi

}

restoreSshConfiguration
removePublicSshKey
removeSshDirectory
