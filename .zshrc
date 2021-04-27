# Created by newuser for 5.8
## If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
	source "${filePath}"
}

verbose_source '/usr/share/zsh/scripts/git-prompt.zsh'
# settingsFiles="${HOME}/.settings/*"
# for f in $settingsFiles; do
# 	verbose_source "${f}"
# done
verbose_source "${HOME}/.settings/programs.sh"
verbose_source "${HOME}/.settings/navigation.sh"
verbose_source "${HOME}/.settings/prompt.zsh"
verbose_source "${HOME}/.locrc.sh"

echo
neofetch

