##########################################
# zsh/oh-my-zsh aliasies
##########################################
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias reload!="source ~/.zshrc"

##########################################
# dotfiles aliasies
##########################################
alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"
alias dotconfig="cd ~/.dotfiles && vim"

##########################################
# Easier Navigation aliases
##########################################
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though

##########################################
# Utility aliases
##########################################
alias svim="sudo vim"
alias vi="vim"
alias c='pygmentize -O style=monokai -f console256 -g'
alias history-stat="history | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# List all files colorized in long format
alias ls="ls -lhA --color"
alias ll="ls -lF --color"

# List all files colorized in long format, including dot files
alias la="ls -laF --color"

# List only directories
alias lsd='ls -lF --color | grep "^d"'
