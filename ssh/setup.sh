#!/usr/bin/env bash
#
# setup configures ssh things.
source ./script/prompt
source ./script/linkfile

echo "starting ssh/setup.sh"

echo $pwd

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

echo $pwd

setupSsh () {
  if [ ! -d "$HOME/.ssh" ]; then
    info "creating ssh directory"
    mkdir -p ~/.ssh/sockets && success "ssh directory created"
  fi
}

downloadPublicSshKey () {
  info "downloading ssh public key"

  if [ -f $HOME/.ssh/id_rsa_yubikey.pub ] ; then
    echo "Making backup of current id_rsa_yubikey.pub..."
    echo ""
    mv $HOME/.ssh/id_rsa_yubikey.pub $HOME/.ssh/id_rsa_yubikey.old.pub && success "id_rsa_yubikey.old.pub created"
  fi

  curl -LSso ~/.ssh/id_rsa_yubikey.pub https://raw.githubusercontent.com/bechelani/public_keys/main/id_rsa_yubikey.pub && success 'ssh key downloaded'
}

configureSsh() {
  info "configuring ssh"

  local overwrite_all=false backup_all=false skip_all=false

  link_file "$HOME/.dotfiles/ssh/config" "$HOME/.ssh/config"
  #ln -s "$HOME/.dotfiles/ssh/config" "$HOME/.ssh/config"
  success "ssh configured"
}

setupSsh
downloadPublicSshKey
configureSsh
