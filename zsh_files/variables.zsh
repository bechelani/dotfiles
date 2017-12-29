##########################################
# Core Variables
##########################################
export PULSE_LATENCY_MSEC=30
export EDITOR='vim'
export HOMEBREW_NO_ANALYTICS=1
#export JEKYLL_ENV=development
export GITHUB_USER="bechelani"
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH # Reorder PATH so local bin is first
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
export EDITOR="vim"
export TERM="screen-256color"
export CLICOLOR=1
#export LSCOLORS=Gxfxcxdxbxegedabagacad
#export LS_COLORS=Gxfxcxdxbxegedabagacad
export LSCOLORS=dxfxcxdxbxegedabagacad
export LS_COLORS=dxfxcxdxbxegedabagacad

##########################################
# NPM Varialbes
##########################################
NPM_PACKAGES="$HOME/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

##########################################
# Setting up the Paths
##########################################
#COMPOSERPATH="$HOME/.composer"
#GOPATH="$HOME/go"
#TMUXIFIERPATH="$HOME/.tmuxifier"
#POWERLINE_PATH="$HOME/Projects/Utilities/powerline"
#BASE16_SHELL="$HOME/.config/base16-shell/"

##########################################
# Setting up the Bin Paths
##########################################
#GOBINPATH="$GOPATH/bin"
#COMPOSERBINPATH="$COMPOSERPATH/vendor/bin"
#TMUXIFIERBINPATH="$TMUXIFIERPATH/bin"
NPMBINPATH="$NPM_PACKAGES/bin"
HOMEBIN="$HOME/bin"
SBINPATH="/usr/local/sbin"

#export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier_layouts"

##########################################
# Build and Export the PATH
##########################################
#export PATH="$GOBINPATH:$COMPOSERBINPATH:$TMUXIFIERBINPATH:$NPMBINPATH:$HOMEBIN:$SBINPATH:$PATH"


##########################################
# Experimental
##########################################
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# PHP-version switcher
# source $(brew --prefix php-version)/php-version.sh && php-version 5
# The variables are wrapped in \%\{\%\}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

eval RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE
export PR_BOLD_WHITE PR_BOLD_BLACK
