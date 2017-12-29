# Load the Functions file
if [ -e ~/.zsh_files/theme_icons.zsh ]; then
  source ~/.zsh_files/theme_icons.zsh
fi

# Load the Git Prompt file
if [ -e ~/.zsh_files/git-prompt.zsh ]; then
  source ~/.zsh_files/git-prompt.zsh
fi

PROMPT='%n@$(box_name) %{$fg[yellow]%}$(current_pwd)%{$reset_color%}$(__posh_git_echo) $(prompt_char) '
