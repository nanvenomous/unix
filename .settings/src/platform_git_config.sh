cd "${HOME}"

backup_dir="${HOME}/BackedUpFiles"

unameOut="$( uname -s )"
function clone_based_on_paltform() {
	case "${unameOut}" in
		Linux*)
			git clone --bare 'https://github.com/mrgarelli/linux.git' "$HOME/.pltfrm"
			;;
		Darwin*) # mac
			git clone --bare 'https://github.com/mrgarelli/osx.git' "$HOME/.pltfrm"
			;;
		*)
			machine="UNKNOWN:${unameOut}"
			;;
	esac
}

function cfg() {
	"/usr/bin/git" --git-dir="${HOME}/.pltfrm/" --work-tree="${HOME}" "${@}"
}
clone_based_on_paltform

error="$(cfg checkout 2>&1 >/dev/null | tail -2 | head -1)"

if [[ "${error}" == 'Please move or remove them before you switch branches.' ]]; then
	mkdir -p "${backup_dir}"
	echo "Backing up pre-existing dot files.";
	files="$(cfg checkout 2>&1 | egrep "\s+\." | awk {'print $1'})"
	echo "${files}"
else
	echo "Checked out config.";
fi
# cfg checkout 

# may need to fix conflicts by moving files
# cfg config --local status.showUntrackedFiles no
