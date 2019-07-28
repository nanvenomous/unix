# VARIABLES
h="${HOME}"

# SYMLINKS
"${h}/Scripts/symlinks/sl.sh" link

# CREATE DESIRED DIRECTORIES
mkdir "${h}/Projects"
mkdir "${h}/Images"

# REMOVE UNWANTED DIRECTORIES
toRemove=( 'Desktop' 'Documents' 'Music' 'Pictures' 'Public' 'Templates' 'Videos' )
for dir in "${toRemove[@]}"; do
	rmdir "${h}/${dir}"
done
