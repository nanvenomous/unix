# Created by newuser for 5.8
## If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -U compinit; compinit # zsh completions

COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
	source "${filePath}"
}

neofetch
verbose_source "${HOME}/.settings/navigation.sh"
verbose_source "${HOME}/.settings/programs.zsh"
verbose_source "${HOME}/.settings/prompt.zsh"
verbose_source "${HOME}/.settings/system-clipboard/zsh-system-clipboard.zsh"
verbose_source "${HOME}/.locrc.sh"


