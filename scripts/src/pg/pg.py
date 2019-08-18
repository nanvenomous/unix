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
	b: branch
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
	elif command == 'c':
		git(['commit'] + remainder)
	elif command == 'ca':
		git(['commit', '--amend'] + remainder)
	elif command == 'ch':
		git(['checkout'] + remainder)
	elif command == 'i':
		git(['init'] + remainder)
	elif command == 'l':
		git(['log'] + remainder)
	elif command == 'm':
		git(['merge'] + remainder)
	elif command == 'ph':
		git(['push'] + remainder)
	elif command == 'pho':
		git(['push', 'origin'] + remainder)
	elif command == 'pl':
		git(['pull'] + remainder)
	elif command == 'plr':
		git(['pull', '--rebase'] + remainder)
	elif command == 'plo':
		git(['pull', 'origin'] + remainder)
	elif command == 'rma':
		git(['rm', '-r', '--cached', '.'] + remainder)
	elif command == 'rst':
		git(['reset'] + remainder)
	elif command == 'rsth':
		git(['reset', '--hard', 'HEAD'] + remainder)
	elif command == 's':
		git(['status'] + remainder)
	elif command == 'sh':
		git(['stash'] + remainder)
	elif command == 'shc':
		git(['stash', 'clear'] + remainder)
	elif command == 't':
		git(['ls-tree', '-r', '--name-only'] + remainder)
	else:
		git([command] + remainder)
else:
	# default behavior of the package, possibly the help
	git([''])