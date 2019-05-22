h="${HOME}"

"${h}/Scripts/symlinks/sl.sh" link

mkdir "${h}/Images"
mv "${h}/Pictures/Wallpapers" "${h}/Images"

toRemove=( 'Desktop' 'Documents' 'Music' 'Pictures' 'Public' 'Templates' 'Videos' )

for dir in "${toRemove[@]}"; do
	rmdir "${h}/${dir}"
done

mkdir "${h}/Projects"
