# Load the Functions file
#if [ -e ~/.zsh_files/theme_icons.zsh ]; then
#  source ~/.zsh_files/theme_icons.zsh
#fi

# Load the Git Prompt file
if [ -e ~/.zsh_files/git-prompt.zsh ]; then
  source ~/.zsh_files/git-prompt.zsh
fi

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

PROMPT='${ret_status}%{$reset_color%}%n@$(box_name)%{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c%{$reset_color%}$(__posh_git_echo) %{$reset_color%}$(prompt_char) '

#PROMPT='%n@$(box_name) %{$fg[yellow]%}$(current_pwd)%{$reset_color%}$(__posh_git_echo) $(prompt_char) '
