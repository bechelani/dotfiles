#!/bin/bash

# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ] ; then
    echo ''
    echo "oh-my-zsh is already installed..."
    read -p "Would you like to update oh-my-zsh now?" -n 1 -r
    echo ''

    if [[ $REPLY =~ ^[Yy]$ ]] ; then
        cd ~/.oh-my-zsh && git pull

        if [[ $? -eq 0 ]] ; then
            echo "Update complete..." && cd
        else
            echo "Update not complete..." >&2 cd
        fi
    fi
else
    echo "oh-my-zsh not found, now installing oh-my-zsh..."
    echo ''

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''

# zsh z
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-z

# zsh completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

# auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/powerlevel9k

# powerlevel 10k install
echo ''
echo "Now installing powerlevel10k..."
echo ''
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/powerlevel10k

# Pull down personal dotfiles
echo ''
read -p "Do you want to use bechelani's dotfiles? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ''
    echo "Now pulling down bechelani dotfiles..."
    git clone https://github.com/bechelani/dotfiles.git ~/.dotfiles
    echo ''
    cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
    echo ''
    echo "Checking out azshell branch..." && git checkout azshell
    echo ''
    echo "Setting script to exectubale" && chmod +x $HOME/.dotfiles/script/bootstrap
    echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured your environment with bechelani's dotfiles..."
    else
        echo "bechelani's dotfiles were not applied successfully..." >&2
fi
else
    echo ''
    echo "You chose not to apply bechelani's dotfiles. You will need to configure your environment manually..."
    echo ''
    echo "Setting defaults for .zshrc and .bashrc..."
    echo ''
    echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-syntax-highlighting to .zshrc..."
    echo ''
    echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-autosuggestions to .zshrc..."
    echo ''
    echo "source $HOME/.git-completion.bash" >> ${ZDOTDIR:-$HOME}/.bashrc && echo "added git-completion to .bashrc..."
fi

echo ''
echo '	Badass WSL terminal installed!'
