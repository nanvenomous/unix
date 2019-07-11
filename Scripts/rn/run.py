# To Do
#	implement verbose

import sys
from syspy import Message, BashAPI, parseOptions, fail, succeed, getInputs

version = Message('Version: 1.0')

help = Message(
'''options
	-h, --help: help menu
	--version: version

commands
	docs: move all the documentation
	lint: setup eslint in a project directory
	r: react-native run-android
	setup: install everything related to react-native'''
)

verbose = False

shortOpts = 'hv'
longOpts = [
	'help',
	'verbose',
	'version',
	]

# parsed options and gathers remainder (command)
options, remainder = parseOptions(getInputs(), shortOpts, longOpts)

# deals with options accordingly
for opt, arg in options:
	if opt in ('-h', '--help'):
		help.display = True
		help.smartPrint()
		succeed()
	elif opt in ('-v', '--verbose'):
		verbose = True
	elif opt == '--version':
		version.display = True
		version.smartPrint()
		succeed()

output = ''
api = BashAPI('api.sh')
if remainder == ['docs']:
	output = api.cmd('documentationMigration')
elif remainder == ['lint']:
	api.cmd('linterInstallation', realTime=True)
elif remainder == ['r']:
	api.cmd('runProject', realTime=True)
elif remainder == ['setup']:
	api.cmd('setup', realTime=True)
else:
	print('Wrapper for react-native')
	print()
	print(version.content)
	print()
	print(help.content)
	fail()

if output not in ['']: print(output)
