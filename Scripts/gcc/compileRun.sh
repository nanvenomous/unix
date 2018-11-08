#!/bin/bash

compRun () {
	# _________________________________ Gather Inputs
	local -n compRef="${1}"; shift # remove compRun from list
	local -n srcRef="${1}"

	# _________________________________ Run Checks
	if [ ! -f ${srcRef} ]; then # what you passed in wasn't a file
		echo 'Not a file or directory: ' "${srcRef}"
		exit 1
	elif [[ -z "${srcRef// }" ]]; then
		echo "Must pass in a source C or C++ file"
		exit 1
	fi

	# _________________________________ Compile and run c/c++ code
	subDir='./.execute/'

	# make the directory for executables if there is none
	command mkdir -p ${subDir}

	# get executable file name
	ind=`expr index ${srcRef} .`
	exe=${srcRef:0:`expr ${ind} - 1`}

	# create the executable for the given source file
	command ${compRef} ${srcRef} -o ${subDir}${exe}

	# run the executable
	command ${subDir}${exe}
}
