#!/bin/bash

ln='/bin/ln'

# must be global
filePath="${PWD}/files/"

# user executable directory
exeDir='/usr/local/bin/'

array=(${filePath}*)

for file in "${array[@]}"; do   # The quotes are necessary here
	link="${file/${filePath}/${exeDir}}"
	link="${link/%.*/}"
	echo -e "\t" "${file}" '-->' "${link}"
	command sudo ln -sf "${file}" ${link}
	command chmod +x "${file}"
done
