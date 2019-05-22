#!/bin/bash
source ${HOME}/Scripts/git/general.sh

g='/usr/bin/git'
config="--git-dir=${HOME}/.cfg --work-tree=${HOME}"
cmd="${g} ${config}"


case "$1" in
	"aa")
		# stage manually deleted or moved files
		stageManualChanges cmd
		# add/stage changes in all configuration files
		${cmd} add ${HOME}'/.README.md'
		${cmd} add ${HOME}'/.bashrc'
		${cmd} add ${HOME}'/.vimrc'
		${cmd} add ${HOME}'/.profile'
		${cmd} add ${HOME}'/.xinitrc'
		${cmd} add ${HOME}'/Scripts/*'

		${cmd} add ${HOME}'/.local/share/konsole/*'
		${cmd} add ${HOME}'/.config/konsolerc'
		${cmd} add ${HOME}'/.config/Code/User/keybindings.json'
		${cmd} add ${HOME}'/.config/Code/User/settings.json'
		${cmd} add ${HOME}'/.config/pcmanfm/LXDE/desktop-items-0.conf'
		${cmd} add ${HOME}'/.config/openbox/lxde-rc.xml'
		;;
	*)
		generalGitWrapper cmd "${@}"
		command $cmd
		;;
esac
