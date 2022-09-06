#!/usr/bin/env bash
#
# setup configures git things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

source $DOTFILES_ROOT/script/prompt

set -e

brewBundle () {
  # Run Homebrew through the Brewfile
  echo "› brew bundle"

  cd $DOTFILES_ROOT/git

  brew bundle

  cd $DOTFILES_ROOT
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info "setup gitconfi"

    git_credential="cache"
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential="osxkeychain"
    fi

    user " - What is your github author name?"
    read -e git_authorname
    user " - What is your github author email?"
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" \
        -e "s/AUTHOREMAIL/$git_authoremail/g" \
        -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
        git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success "gitconfig"
  fi
}

configureGitCompletion () {
    GIT_VERSION=`git --version | awk '{print $3}'`
    URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
    success "git-completion for $GIT_VERSION downloaded"
    if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
        echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
        fail 'git completion download failed'
    fi
}

setup_gitconfig_with_gpg () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'setup gitconfig with GPG'

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    gpg_program = "$(brew --prefix gpg)/bin/gpg"

    sed -e "s/AUTHORNAME/$git_authorname/g" \
        -e "s/AUTHOREMAIL/$git_authoremail/g" \
        -e "s/SIGNINGKEY/$KEYID/g" \
        -e "s/GPGPROGRAM/$gpg_program/g" \
        git/gitconfig.local.symlink.gpg.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}

install () {
  # git install

  brewBundle

  configureGitCompletion

  # setup ssh
  bash $DOTFILES_ROOT/ssh/setup.sh

  # ask if need gpg
  echo ""
  read -p "Do you want to use GPG to sign your commits? y/n " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # setup gpg
    bash $DOTFILES_ROOT/gpg/setup.sh

    setup_gitconfig_with_gpg

    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured GPG to sign your commits"
    else
        echo "GPG was not setup correct..." >&2
  fi
  else
      echo ""
      echo "You chose not to use GPG."
      echo ""
      setup_gitconfig
  fi
}

install
