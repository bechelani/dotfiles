#!/bin/bash
set -eou pipefail

source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/bechelani/dotfiles/mac/script/prompt)"

xcodeInstall () {
    # install xcode dependency for homebrew

    check=$((xcode-select -p) 1>/dev/null;echo $?;)

    if [[ "$check" == "0" ]] ; then
      echo ""
      info "Command Line Tools (CLT) for Xcode already installed"
    else
      echo ""
      info "installing Command Line Tools (CLT) for Xcode"
      read -p "please wait for the tools to finish installing then press enter." -n 1 -r
      xcode-select --install
      success "Command Line Tools (CLT) for Xcode installed"
    fi
}

brewInstall () {
  # install brew

  if test ! $(which brew); then
    # Install the correct homebrew for each OS type
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    success "brew installed"
  else
    info "brew is already installed"
  fi
}

brewUpdate () {
  brew update
  success "brew updated"
}

zshInstall () {
  # zsh install
  # todo add in check for macOS 10.15 since zsh is default
  if test $(which zsh); then
      info "zsh already installed..."
  else
      brew install zsh
      success 'zsh installed'
  fi

  brew install zsh-completions
  success 'zsh-completions installed'
}

zshPluginInstall () {
  # zsh plugin install

  if [ -d "$HOME/.zsh/zsh-completions" ]; then
    info 'zsh-completions already installed'
  else
    git clone https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions && success 'zsh-completions installed'
  fi

  if [ -d "$HOME/.zsh/zsh-autosuggestions" ]; then
    info 'zsh-autosuggestions already installed'
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions && success 'zsh-autosuggestions installed'
  fi

  if [ -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
    info 'zsh-syntax-highlighting already installed'
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting && success 'zsh-syntax-highlighting installed'
  fi

  if [ -d "$HOME/.zsh/zsh-z" ]; then
    info "zsh-z already exists..."
  else
    git clone https://github.com/agkozak/zsh-z ~/.zsh/zsh-z && success "zsh-z installed"
  fi
}

ohmyposhInstall () {
  # oh-my-posh install

  if test $(which oh-my-posh); then
    info "oh-my-posh is already installed..."
    read -p "Would you like to update oh-my-posh now? y/n " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
      brew update && brew upgrade oh-my-posh
      if [[ $? -eq 0 ]] ; then
        success "Update complete..."
      else
        fail "Update not complete..."
      fi
    fi
  else
    echo ""
    echo "oh-my-posh not found, now installing oh-my-posh..."
    echo ""
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
    success "oh-my-posh installed"
  fi
}

dotfilesInstall () {
  # dotfiles install

  # Pull down personal dotfiles
  echo ""
  read -p "Do you want to use your dotfiles? y/n " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo ""
      echo "Now pulling down your dotfiles..."
      git clone https://github.com/bechelani/dotfiles.git ~/.dotfiles
      echo ""
      cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
      echo ""
      echo "Checking out macOS branch..." && git checkout mac
      echo ""
      echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
      echo ""

      if [[ $? -eq 0 ]]
      then
          echo "Successfully configured your environment with your macOS dotfiles..."
      else
          echo "Your macOS dotfiles were not applied successfully..." >&2
  fi
  else
      echo ""
      echo "You chose not to apply your macOS dotfiles. You will need to configure your environment manually..."
      echo ""
  fi
}

# xcode setup
xcodeInstall

# brew setup
brewInstall
brewUpdate

# zsh setup
zshInstall
zshPluginInstall

# oh my posh setup
ohmyposhInstall

# dotfiles install
dotfilesInstall
