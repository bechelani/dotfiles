#!/usr/bin/env bash
#
# setup configures ssh things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt
source $DOTFILES_ROOT/script/linkfile

set -e

restoreSshConfiguration () {

  if [[ -L "$HOME/.ssh/config" ]] ; then
    echo ""
    info "removing ssh config link"
    rm $HOME/.ssh/config  && success "ssh config link removed"

    if [ -f $HOME/.ssh/config.backup ] ; then
      echo ""
      info "restoring ssh config"
      mv $HOME/.ssh/config.backup $HOME/.ssh/config && success "ssh configuration restored"
    fi
  fi

}

removePublicSshKey () {

  if [ -f $HOME/.ssh/id_rsa_yubikey.pub ] ; then
    echo ""
    info "Deleting current id_rsa_yubikey.pub..."
    rm $HOME/.ssh/id_rsa_yubikey.pub && success "id_rsa_yubikey.pub deleted"
  fi

  if [ -f $HOME/.ssh/id_rsa_yubikey.old.pub ] ; then
    echo ""
    info "Restoring old id_rsa_yubikey.pub..."
    mv $HOME/.ssh/id_rsa_yubikey.old.pub $HOME/.ssh/id_rsa_yubikey.pub && success "id_rsa_yubikey.old.pub restored"
  fi

}

removeSshDirectory () {

  if [ -d "$HOME/.ssh/sockets" ]; then
    echo ""
    info "deleting .ssh/sockets directory"
    rm -rf $HOME/.ssh/sockets && success "sockets directory deleted"
  fi

  if [ ! "$(ls -A $HOME/.ssh)" ]; then
    echo ""
    info "deleting ssh directory"
    rm -rf $HOME/.ssh && success "ssh directory deleted"
	fi

}

restoreSshConfiguration
removePublicSshKey
removeSshDirectory
