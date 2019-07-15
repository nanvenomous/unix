from subprocess import Popen, PIPE, call

from select import select
from os import path, environ, read
import sys
import getopt
import importlib

def fail(): sys.exit(1)

def succeed(): sys.exit(0)

def getInputs(): return sys.argv[1:]

def _addToPath(location):
	# add the location to the path of this script's python instance
	sys.path.insert(0, location)

def functionFromScript(location, file, method):
	_addToPath(location)
	moduleName = file.split('.')[0]
	try:
		module = importlib.import_module(moduleName)
	except ImportError as err:
		print('Error:', err)
		print('You are dynamically importing a module that does not exist')

	try:
		func = getattr(module, method)
	except:
		print('Error: you are dynamically referencing a function that does not exist')
	# return func
	func()


def parseOptions(args, shortOpts, longOpts):
	# checks that the option exists
	try:
		# returns options and remainder (if success)
		return getopt.getopt(
			args,
			shortOpts,
			longOpts
			)
	except getopt.GetoptError as err:
		print('[BASH OPTS ERROR]')
		print(err)
		fail()

def editor(name):
	# create editor
	vim = environ.get('EDITOR','vim')
	# open file to read
	with open(name, 'r+') as tf:
		call([vim, tf.name])

class Directory():
	def __init__(self):
		mainFile = path.abspath(sys.modules['__main__'].__file__)
		self.mainDir = path.dirname(mainFile)
		# print('MainDir: ', self.mainDir)

	def relPath(self, partPath):
		fullPath = ''.join([self.mainDir, '/', partPath])
		return fullPath

class BashAPI():
	# input is file (path to shell script)
	def __init__(self, file):
		# get the full executable path of our bash api script
		dir = Directory()
		self.api = dir.relPath(file)

	# runs a function within a bash script
	def cmd(self, function, args=[''], realTime=False):
		# syntax to run a function within a bash script
		command = ' '.join(['.', self.api, '&&', function] + args)
		# print(command)
		# Popen explanation: https://pypi.org/project/bash/

		# https://stackoverflow.com/questions/31926470/run-command-and-get-its-stdout-stderr-separately-in-near-real-time-like-in-a-te/31953436#31953436
		with Popen(['bash', '-c', command], stdout=PIPE, stderr=PIPE) as p:
			if (realTime):
				readable = {
					p.stdout.fileno(): sys.stdout.buffer, # log separately
					p.stderr.fileno(): sys.stderr.buffer,
				}
				# print(readable) # 3 is a stdout and 5 is a stderr
				while readable:
					for fd in select(readable, [], [])[0]:
							data = read(fd, 1024) # read available
							# print('data: ', data)
							if not data: # handle end of file
								del readable[fd]
							elif (fd == 5): # handle the case of an error
								print('[BASH ERROR]')
								readable[fd].write(data)
								readable[fd].flush()
								fail()
							else: 
								readable[fd].write(data)
								readable[fd].flush()
			else: # not real time output, simple pipe
				# create a pipeline to a subprocess
				# pipe = Popen(['bash', '-c', command], stdout=PIPE, stderr=PIPE)
				# run command and gather output
				byteOutput, byteError = p.communicate()
				output = byteOutput.decode('utf-8')
				error = byteError.decode('utf-8')
				# print output (if there are errors)
				if error == '': return(output)
				else:
					print('[BASH ERROR]')
					print(error)
					fail()

class Message():
	def __init__(self, content, display=False):
		self.display = display
		self.content = content
	def smartPrint(self):
		if self.display == True: print(self.content)
