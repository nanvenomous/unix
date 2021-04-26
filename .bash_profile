# If not running interactively, don't do anything
[[ $- != *i* ]] && return

COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
	source "${filePath}"
}

# settingsFiles="${HOME}/.settings/*"
# for f in $settingsFiles; do
# 	verbose_source "${f}"
# done
verbose_source "${HOME}/.settings/programs.sh"
verbose_source "${HOME}/.settings/colorSettings.sh"
verbose_source "${HOME}/.settings/navigation.sh"
verbose_source "${HOME}/.locrc.sh"
echo
neofetch
