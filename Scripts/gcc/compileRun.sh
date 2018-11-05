#!/bin/bash


compRun () {
	# gather inputs
	local -n compRef="${1}"
	local -n srcRef="${2}"

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
