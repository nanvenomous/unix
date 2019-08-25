#!/usr/bin/env python3

from syspy import Shell, parseOptions, extend, fail, succeed, getInputs, error
sh = Shell()

version = 'Version: 0.0.2'

synopsis_msg = '''~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A python package for quickly compiling C/C++ code without a makefile
Run from top level of project directory
Useful for rapid prototyping of C/C++ packages
'''
def synopsis():
	print(synopsis_msg)

help_msg = '''options
	-h, --help :\thelp menu
	-s, --synopsis :\tpackage description
	-v, --verbose :\tlist the actual command being run
	--version :\tversion
commands
	c: gather relevant files, compile source, create ./execute
'''
def help():
	print(help_msg)

unix = False
platform = False
verbose = False

shortOpts = 'hsv'
longOpts = [
	'help',
	'synopsis',
	'verbose',
	'version',
	]

# parsed options and gathers remainder (command)
options, command, remainder = parseOptions(getInputs(), shortOpts, longOpts)

# deals with options accordingly
for opt, arg in options:
	if opt in ('-h', '--help'): help(); succeed()
	elif opt in ('-s', '--synopsis'): synopsis(); succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
		sh.verbose = True
	elif opt == '--version': print(version); succeed()

def compile():
	source_files = sh.find('*.c')
	header_files = sh.find('*.h')
	header_dirs = list(set([sh.dirname(p) for p in header_files]))
	header_dirs_with_options = \
		[y for x in zip(['-I'] * len(header_dirs), header_dirs) for y in x]

	cmd = ['cc'] + \
			source_files + \
			['-o ./execute'] + \
			header_dirs_with_options

	if sh.verbose:
		print()
		print('Source files:')
		print(source_files)
		print()
		print('Header file include directories:')
		print(header_dirs)
		print()

	sh.command(cmd)

if (command):
	if command == 'c': compile()
	else: error('not a recognized command: ' + command)
else:
	# default behavior of the package
	synopsis()
	help()