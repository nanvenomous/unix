#!/usr/bin/env python3

from syspy import Shell, getInputs, parseOptions, succeed, error
sh = Shell()

version = 'Version: 0.0.1'

synopsis_msg = '''~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fnd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A python package to explore your filesystem
'''
def synopsis():
	print(synopsis_msg)

help_msg = '''Usage: fnd (-/--)option command <pattern>

options
	-h, --help :\thelp menu
	--synopsis :\tpackage description
	-v, --verbose :\ttalk to me
	--version :\tversion
commands
	d: recursively search for directories containing a file with included pattern
	h: search current directory one level deep for files with the included pattern
	i: find files with pattern inside (case sensetive)
	r: recursively search for files with the included pattern'''
def help():
	print(help_msg)

verbose = False

shortOpts = 'hv'
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
	elif opt in ('--synopsis'): synopsis(); succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
		sh.verbose = True
	elif opt == '--version': print(version); succeed()

def compile():
	source_files = sh.find.recurse('*.c')
	header_dirs = sh.find.directories_with('*.h')
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

# TODO: add command to search for environment variables
if (command):
	if len(remainder) > 1: error('too many input arguments')
	def list_print(li):
		for item in li: print('./' + item)
	try: pattern = remainder[0]
	except: error('not enough input args, expecting a pattern to search for')

	if command == 'd': list_print(sh.find.directories_with(pattern))
	elif command == 'h': list_print(sh.find.here(pattern))
	elif command == 'i': sh.command(['find . -type f -print | xargs grep'] + remainder)
	elif command == 'r': list_print(sh.find.recurse(pattern))
	else: error('not a recognized command: ' + command)
else:
	# default behavior of the package
	synopsis()
	help()