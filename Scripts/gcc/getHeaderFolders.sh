#!/bin/bash

headerFiles=("$(find . -name '*.h')")
iter=0

for hdr in "${headerFiles[@]}"; do   # The quotes are necessary here

	# set the file path in array to the directory
	newHdr="$(dirname ${hdr} &>/dev/null)"
	headerFiles[iter]="${newHdr}"

	# increment the iterator for next loop
	iter=$(expr ${iter} + 1)

done

uniqueHeaders=$(sort -u <(echo "${headerFiles[@]}"))

echo "${uniqueHeaders}"
