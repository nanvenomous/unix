#!/usr/bin/env python3

from os import system
from syspy import getInputs, parseOptions, succeed, error

import sys
from syspy import Message, BashAPI, parseOptions, fail, succeed, getInputs, Shell
sh = Shell()

version = Message('Version: 1.0')

help = Message(
'''options
	-h, --help: help menu
	--version: version
commands
	a: add
	aa: add .
	s: status'''
)

configuration = False
verbose = False

git_command = '/usr/bin/git'
configuration_git_command = ''.join([
	git_command,
	' --git-dir=',
	sh.home,
	'/.cfg',
	' --work-tree=',
	sh.home
	])

shortOpts = 'chv'
longOpts = [
	'help',
	'verbose',
	'version',
	]

# parsed options and gathers remainder (command)
options, command, remainder = parseOptions(getInputs(), shortOpts, longOpts)

print('options: ', options)
print('command : ', command)
print('remainder: ', remainder)

# deals with options accordingly
for opt, arg in options:
	if opt in ('-c'):
		configuration = True
		cmd="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
		git_command = configuration_git_command
	elif opt in ('-h', '--help'):
		help.display = True
		help.smartPrint()
		succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
	elif opt == '--version':
		version.display = True
		version.smartPrint()
		succeed()

def git(command):
	command = ' '.join([git_command] + command)
	print(command)
	system(command)

def add_all_configuration_files():
	files = [
		'/.bashrc',
		'/.vimrc',
		'/.profile',
		'/.xinitrc',
		'/.inputrc',
		'/.gitignore',
		'/readme.md',
		'/.settings/*',
		'/scripts/src/*',
		'/scripts/scripts.py',
		'/.local/share/konsole/*',
		'/.config/konsolerc',
		'/.config/Code/User/keybindings.json',
		'/.config/Code/User/settings.json',
		'/.config/openbox/lxde-rc.xml'
		]
	files = [sh.home + f for f in files]
	for file in files:
		git(['add', file])

if (command):
	if command == 'a':
		git(['add'] + remainder)
	elif command == 'aa':
		if configuration: add_all_configuration_files()
		else: git(['add .'])
	elif command == 'b':
		git(['branch'] + remainder)
	elif command == 's':
		if remainder: error('git status does not take arguments')
		git(['status'])
	else:
		error('not a recognized command')
else:
	pass # default behavior of package


# "b")
# 	cmd="$cmd branch ${inputs}"
# 	;;
# "c")
# 	cmd="$cmd commit ${inputs}"
# 	;;
# "ca")
# 	cmd="$cmd commit --amend ${inputs}"
# 	;;
# "ch")
# 	cmd="$cmd checkout ${inputs}"
# 	;;
# "cha")
# 	cmd="$cmd reset --hard ${inputs}"
# 	;;
# "chb")
# 	cmd="$cmd checkout -b ${inputs}"
# 	;;
# "chl")
# 	cmd="$cmd checkout - ${inputs}"
# 	;;
# "i")
# 	cmd="$cmd init ${inputs}"
# 	;;
# "l")
# 	cmd="$cmd log ${inputs}"
# 	;;
# "m")
# 	cmd="$cmd merge ${inputs}"
# 	;;
# "ph")
# 	cmd="$cmd push ${inputs}"
# 	;;
# "pl")
# 	cmd="$cmd pull ${inputs}"
# 	;;
# "plr")
# 	cmd="$cmd pull --rebase ${inputs}"
# 	;;
# "r")
# 	cmd="$cmd remote ${inputs}"
# 	;;
# "ra")
# 	cmd="$cmd remote add ${inputs}"
# 	;;
# "rma")
# 	cmd="$cmd rm -r --cached . ${inputs}"
# 	;;
# "rs")
# 	cmd="$cmd remote show ${inputs}"
# 	;;
# "s")
# 	cmd="$cmd status ${inputs}"
# 	;;
# "sh")
# 	cmd="$cmd stash ${inputs}"
# 	;;
# "shc")
# 	cmd="$cmd stash clear ${inputs}"
# 	;;
# "t")
# 	cmd="$cmd ls-tree -r --name-only ${inputs}"
# 	;;
# *)
# 	# to run anything not just the shortcuts
# 	# cmd="$cmd ${allInputs}"
# 	echo "Not a recognized command: ${shortcut}"
# 	exit 1
# 	;;
