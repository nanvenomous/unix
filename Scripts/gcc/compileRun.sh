#!/bin/bash

compRun () {
	# _________________________________ Handel inputs and run checks
	local -n compRef="${1}"; shift # remove compRun from list

	# if anything passed in
	if [ $# -eq 0 ]; then
		echo "Must pass in a source C or C++ file"
		exit 1
	fi

	local -n srcRef="${1}"

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