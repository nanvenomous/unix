#!/usr/bin/env python3

from syspy import Shell, parseOptions, extend, fail, succeed, getInputs, error
sh = Shell()

version = 'Version: 1.0'

help_msg = '''options
	-h, --help :\thelp menu
	-v, --verbose :\tlist the actual command being run
	--version :\tversion
'''

def help():
	print(help_msg)

unix = False
platform = False
verbose = False

shortOpts = 'hv'
longOpts = [
	'help',
	'verbose',
	'version',
	]

source_files = sh.find('*.c')
header_files = sh.find('*.h')
header_dirs = list(set([sh.dirname(p) for p in header_files]))

header_dirs_with_options = \
	[y for x in zip(['-I'] * len(header_dirs), header_dirs) for y in x]

def compile():
	cmd = ['cc'] + \
			source_files + \
			['-o ./execute'] + \
			header_dirs_with_options
	sh.command(cmd)

# parsed options and gathers remainder (command)
options, command, remainder = parseOptions(getInputs(), shortOpts, longOpts)

# deals with options accordingly
for opt, arg in options:
	if opt in ('-h', '--help'):
		help()
		succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
		sh.verbose = True
	elif opt == '--version':
		print(version)
		succeed()

if sh.verbose:
	print('Source files:')
	print(source_files)
	print()
	print('Header file include directories:')
	print(header_dirs)
	print()

compile()