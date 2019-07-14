from os import listdir, path

dir_path = path.dirname(path.realpath(__file__))

src_path = path.join(dir_path, 'src')
bin_path = path.join(dir_path, 'bin')

sources = set(listdir(src_path))
executables = set(listdir(bin_path))

def get_unlinked_sources():
	unlinked_sources = list(sources - executables)
	print(' '.join(unlinked_sources))

def get_executables_to_clean():
	executables_to_clean = list(executables - sources)
	print(' '.join(executables_to_clean))
