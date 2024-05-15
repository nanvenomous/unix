# Created by newuser for 5.8
## If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -U compinit; compinit # zsh completions

COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	# echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
	source "${filePath}"
}

# neofetch
SCRIPTS_DIR="${HOME}/.scripts"
verbose_source "${SCRIPTS_DIR}/navigation.zsh"
verbose_source "${SCRIPTS_DIR}/programs.zsh"
verbose_source "${SCRIPTS_DIR}/prompt.zsh"
verbose_source "${SCRIPTS_DIR}/system-clipboard/zsh-system-clipboard.zsh"
verbose_source "${HOME}/.locrc.zsh"
verbose_source "${SCRIPTS_DIR}/window_manager.zsh"

# bun completions
[ -s "/home/gin/.bun/_bun" ] && source "/home/gin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
