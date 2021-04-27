# Created by newuser for 5.8
## If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -U compinit; compinit
alias ls='ls --color=auto'
COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
	source "${filePath}"
}

verbose_source "${HOME}/.settings/navigation.sh"
verbose_source "${HOME}/.settings/programs.sh"
verbose_source "${HOME}/.settings/system-clipboard/zsh-system-clipboard.zsh"
verbose_source "${HOME}/.locrc.sh"

precmd() { print -rP "%(?.%F{green}V.%F{red}?%?)%f %B%F{cyan}%~%f%b" }
PROMPT='%# '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

echo
neofetch

