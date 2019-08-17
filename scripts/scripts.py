#!/usr/bin/env python3

from os import listdir, path
from syspy import Directory, Shell

here = Directory()
binDir = Directory(here.to('bin'))
srcDir = Directory(here.to('src'))
sh = Shell()

sources = set(listdir(srcDir.path))
executables = set(listdir(binDir.path))
unlinked_sources = list(sources - executables)
executables_to_clean = list(executables - sources)


print(sources)
print(executables)
print(unlinked_sources)
print(executables_to_clean)

# remove unecessary executables
for exe in executables_to_clean:
	sh.rm(binDir.to(exe))

# make every source file executable
for pkg in sources:
	pkgDir = Directory(srcDir.to(pkg))
	source = pkgDir.to(pkg + '.sh')
	sh.make_executable(source)

# link all sources to executables
for pkg in unlinked_sources:
	pkgDir = Directory(srcDir.to(pkg))
	source = pkgDir.to(pkg + '.sh')
	destination = binDir.to(pkg)
	sh.link(source, destination)
	print(source, ' <--> ', destination)