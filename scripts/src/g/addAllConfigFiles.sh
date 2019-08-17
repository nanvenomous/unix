#!/bin/bash

cmd="${@}"

# add/stage changes in all configuration files
${cmd} add ${HOME}'/.bashrc'
${cmd} add ${HOME}'/.vimrc'
${cmd} add ${HOME}'/.profile'
${cmd} add ${HOME}'/.xinitrc'
${cmd} add ${HOME}'/.inputrc'
${cmd} add ${HOME}'/.gitignore'
${cmd} add ${HOME}'/readme.md'
${cmd} add ${HOME}'/.settings/*'
${cmd} add ${HOME}'/scripts/src/*'
${cmd} add ${HOME}'/scripts/scripts.py'

${cmd} add ${HOME}'/.local/share/konsole/*'
${cmd} add ${HOME}'/.config/konsolerc'
${cmd} add ${HOME}'/.config/Code/User/keybindings.json'
${cmd} add ${HOME}'/.config/Code/User/settings.json'
${cmd} add ${HOME}'/.config/openbox/lxde-rc.xml'
