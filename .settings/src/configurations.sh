# VARIABLES
h="${HOME}"

# CREATE DESIRED DIRECTORIES
mkdir -p "${h}/Projects"
mkdir -p "${h}/Images"

# REMOVE UNWANTED DIRECTORIES
toRemove=( 'Desktop' 'Documents' 'Music' 'Pictures' 'Public' 'Templates' 'Videos' )
for dir in "${toRemove[@]}"; do
	rmdir "${h}/${dir}"
done

echo "press enter to edit sudoers file"
read -n 1 -p "Input Selection:" mainmenuinput
sudo visudo
