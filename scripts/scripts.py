#!/usr/bin/env python3

from os import listdir
from syspy import Directory, Shell, error

here = Directory()
binDir = Directory(here.to('bin'))
srcDir = Directory(here.to('src'))
sh = Shell()

sources = set(listdir(srcDir.path))
executables = set(listdir(binDir.path))
unlinked_sources = list(sources - executables)
executables_to_clean = list(executables - sources)

# remove unecessary executables
for exe in executables_to_clean:
	sh.rm(binDir.to(exe))

def get_correct_source(pkg):
	pkgDir = Directory(srcDir.to(pkg))
	srcFile = pkg + '.sh'
	if (srcFile in listdir(pkgDir.path)):
		return pkgDir.to(srcFile)
	srcFile = pkg + '.py'
	if (srcFile in listdir(pkgDir.path)):
		return pkgDir.to(srcFile)
	error('could not find correct file type in: \n\t' + pkgDir.path)

# make every source file executable
for pkg in sources:
	source = get_correct_source(pkg)
	sh.make_executable(source)

# link all sources to executables
for pkg in unlinked_sources:
	source = get_correct_source(pkg)
	destination = binDir.to(pkg)
	sh.link(source, destination)
	print(source, ' <--> ', destination)