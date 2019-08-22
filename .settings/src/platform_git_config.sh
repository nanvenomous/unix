cd "${HOME}"
alias cfg='/usr/bin/git --git-dir=$HOME/.pltfrm/ --work-tree=$HOME'
unameOut="$( uname -s )"
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
cfg checkout
# may need to fix conflicts by moving files
cfg config --local status.showUntrackedFiles no
