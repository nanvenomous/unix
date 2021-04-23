# If not running interactively, don't do anything
[[ $- != *i* ]] && return

COLOR_SEA_GREEN="\033[0;36m"
COLOR_RESET="\033[0m"

function verbose_source {
	filePath="${1}"
	source "${filePath}"
	echo -e "${COLOR_SEA_GREEN}[SOURCING]${COLOR_RESET} ${filePath}"
}

settingsFiles="${HOME}/.settings/*"
for f in $settingsFiles; do
	verbose_source "${f}"
done
echo
neofetch
