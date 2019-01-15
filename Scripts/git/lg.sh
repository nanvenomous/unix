#!/bin/bash
source ${HOME}/Scripts/git/general.sh

lin='/mnt/hgfs/epc/sw/S56_HWIO/Supplier/HWIO_Projects/HWIO_LIN_S56'
spp='/mnt/hgfs/epc/sw/S56_HWIO/Supplier'
gitDir="${HOME}/Projects/linTracking"

g='/usr/bin/git'
config="--git-dir=${gitDir} --work-tree=${spp}"
cmd="${g} ${config}"


case "$1" in
	"aa")
		# stage manually deleted or moved files
		stageManualChanges cmd
		# add/stage changes in all configuration files
		command $cmd add "${lin}/*"
		command $cmd add "${spp}/hwioappl.mak"
		;;
	*)
		generalGitWrapper cmd "${@}"
		command $cmd
		;;
esac
