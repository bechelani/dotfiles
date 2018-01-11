
# alias tat='tmux new-session -As $(basename "$PWD" | tr . -)' # will attach if session exists, or create a new session
# alias tmuxsrc="tmux source-file ~/.tmux.conf"
# alias tmuxkillall="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions
# alias ct="ctags -R --exclude=.git --exclude=node_modules"

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
#alias go_write="cd ~/Projects/Writing"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# List all files colorized in long format
alias ls="ls -lhA ${colorflag}"
alias ll="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd='ls -lF ${colorflag} | grep "^d"'
