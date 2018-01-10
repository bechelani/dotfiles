# Load the Functions file
#if [ -e ~/.zsh_files/theme_icons.zsh ]; then
#  source ~/.zsh_files/theme_icons.zsh
#fi

# Load the Git Prompt file
# if [ -e ~/.zsh_files/git-prompt.zsh ]; then
#   source ~/.zsh_files/git-prompt.zsh
# fi

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

PROMPT='${ret_status}%{$reset_color%}%n@$(box_name)%{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c%{$reset_color%}$(__posh_git_echo) %{$reset_color%}$(prompt_char) '

#PROMPT='%n@$(box_name) %{$fg[yellow]%}$(current_pwd)%{$reset_color%}$(__posh_git_echo) $(prompt_char) '

#PROMPT='%n@%m %{$fg[yellow]%}%1~%{$reset_color%}$(__posh_git_echo) $ '
#PROMPT='%n:%m %~$(__posh_git_echo)> '

#PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$reset_color%}'

#PROMPT='
#$(current_pwd) $(__posh_git_echo) $ '

#export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "

# RPROMPT='${PR_GREEN}$(virtualenv_info)%{$reset_color%} ${PR_WHITE}$(get_dotnet_version)%{$reset_color%}'
