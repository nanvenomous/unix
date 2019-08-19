#!/usr/bin/env python3

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
	-u :\t\tunix configuration tracker
	-h, --help :\thelp menu
	-s :\t\tsystem/platform specific tracker
	-v, --verbose :\tlist the actual command being run
	--version :\tversion

command shortcuts'''

def help():
	print(help_msg)
	for sh in shortcuts:
		print('\t', sh, ':\t', ' '.join(shortcuts[sh]))

unix = False
system = False
verbose = False

git_command = '/usr/bin/git'
command_with_tree = [
	git_command,
	' --work-tree=',
	sh.home
	]
unix_git_command = ''.join(
	command_with_tree + [' --git-dir=', sh.home, '/.cfg']
	)
system_git_command = ''.join(
	command_with_tree + [' --git-dir=', sh.home, '/.sys']
	)

shortOpts = 'hsuv'
longOpts = [
	'help',
	'verbose',
	'version',
	]

# parsed options and gathers remainder (command)
options, command, remainder = parseOptions(getInputs(), shortOpts, longOpts)

# deals with options accordingly
for opt, arg in options:
	if opt in ('-h', '--help'):
		help()
		succeed()
	elif opt in ('-s'):
		system = True
		git_command = system_git_command
	elif opt in ('-u'):
		unix = True
		git_command = unix_git_command
	elif opt in ('-v', '--verbose'):
		verbose = True
		sh.verbose = True
	elif opt == '--version':
		print(version)
		succeed()

def git(command):
	sh.command([git_command] + command)

def add_all(files):
	files = [sh.home + f for f in files]
	for file in files:
		git(['add', file])

def add_all_unix_files():
	files = [
		'/.bashrc',
		'/.gitignore',
		'/readme.md',
		'/.settings/*',
		'/scripts/src/*',
		'/scripts/scripts.py',
		]
	add_all(files)

def add_all_system_files():
	files = [
		'/.vimrc',
		'/.profile',
		'/.xinitrc',
		'/.inputrc',
		'/.local/share/konsole/*',
		'/.config/konsolerc',
		'/.config/Code/User/keybindings.json',
		'/.config/Code/User/settings.json',
		'/.config/openbox/lxde-rc.xml',
		]
	add_all(files)

if (command):
	if command == 'aa':
		if unix: add_all_unix_files()
		elif system: add_all_system_files()
		else: git(['add .'])
	else:
		git(shortcuts.get(command, [command]) + remainder)
else:
	# default behavior of the package
	help()
	# git(['']) # calls the default git help