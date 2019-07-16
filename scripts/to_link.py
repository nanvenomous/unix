from os import listdir, path

def _print_bash_array(lst): print(' '.join(lst))

dir_path = path.dirname(path.realpath(__file__))

src_path = path.join(dir_path, 'src')
bin_path = path.join(dir_path, 'bin')

sources = set(listdir(src_path))
executables = set(listdir(bin_path))

def get_all_sources():
	_print_bash_array(sources)

def get_unlinked_sources():
	unlinked_sources = list(sources - executables)
	_print_bash_array(unlinked_sources)

def get_executables_to_clean():
	executables_to_clean = list(executables - sources)
	_print_bash_array(executables_to_clean)
