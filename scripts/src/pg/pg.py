#!/usr/bin/env python3

from os import system
from syspy import parseOptions, fail, succeed, getInputs, Shell, error
sh = Shell()

version = 'Version: 1.0'

shortcuts = {
	'a': ['add'],
	'aa': ['add', '.'],
	'b': ['branch'],
	'c': ['commit'],
	'ca': ['commit', '--amend'],
	'ch': ['checkout'],
	'i': ['init'],
	'l': ['log'],
	'm': ['merge'],
	'ph': ['push'], 
	'pho': ['push', 'origin'],
	'pl': ['pull'],
	'plr': ['pull', '--rebase'],
	'plo': ['pull', 'origin'],
	'rma': ['rm', '-r', '--cached', '.'],
	'rst': ['reset'],
	'rsth': ['reset', '--hard', 'HEAD'],
	's': ['status'],
	'sh': ['stash'],
	'shc': ['stash', 'clear'],
	't': ['ls-tree', '-r', '--name-only'],
	}

help_msg = '''options
	-c :\t\tsystem configuration tracker
	-h, --help :\thelp menu
	-v, --verbose :\tlist the actual command being run
	--version :\tversion

command shortcuts'''

def help():
	print(help_msg)
	for sh in shortcuts:
		print('\t', sh, ':\t', ' '.join(shortcuts[sh]))

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

# deals with options accordingly
for opt, arg in options:
	if opt in ('-c'):
		configuration = True
		cmd="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
		git_command = configuration_git_command
	elif opt in ('-h', '--help'):
		help()
		succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
	elif opt == '--version':
		print(version)
		succeed()

def git(command):
	command = ' '.join([git_command] + command)
	if verbose: print(command)
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
	if command == 'aa':
		if configuration: add_all_configuration_files()
		else: git(['add .'])
	else:
		git(shortcuts.get(command, [command]) + remainder)
else:
	# default behavior of the package
	help()
	# git(['']) # calls the default git help