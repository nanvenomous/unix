# Pulling OSX files (for mac only), onto your machine

> cd "${HOME}"

> alias cfg='/usr/bin/git --git-dir=${HOME}/.pltfrm/ --work-tree=${HOME}'

> git clone --bare 'https://github.com/mrgarelli/osx.git' "${HOME}/.pltfrm"

> cfg checkout

* may need to fix conflicts by moving files, then re-run previous command

> cfg config --local status.showUntrackedFiles no

