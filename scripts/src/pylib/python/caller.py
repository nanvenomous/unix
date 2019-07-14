from syspy import getInputs
from sys import path

location, file, method = getInputs()

# add the location to the path of this script's python instance
path.insert(0, location)

moduleName = file.split('.')[0]
import importlib
try:
	module = importlib.import_module(moduleName)
except ImportError as err:
	print('Error:', err)
	print('This is probably because you are dynamically importing a module that does not exist')

try:
	func = getattr(module, method)
except:
	print('This is probably because you are dynamically importing a module that does not exist')

func()