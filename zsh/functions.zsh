# Ruby {{{
function get_ruby_version() {
  ruby -v | awk '{print $1 " " $2}'
}
# }}}

# DotNet {{{
function get_dotnet_version() {
  dotnet --version | awk '{print $1 " " $2}'
}
# }}}

# Tmux {{{
# Makes creating a new tmux session (with a specific name) easier
function tmuxopen() {
  tmux attach -t $1
}

# Makes creating a new tmux session (with a specific name) easier
function tmuxnew() {
  tmux new -s $1
}

# Makes deleting a tmux session easier
function tmuxkill() {
  tmux kill-session -t $1
}
# }}}
