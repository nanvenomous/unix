#!/bin/bash

compRun () {
	# _________________________________ Gather Inputs
	# the compiler to be used
	local -n compRef="${1}"; shift # remove compRun from list
	# the source code to be used
	local -n srcRef="${1}"; shift
	local -n headerRef="${1}"

	# ext="${srcRef: -2}"

	# _________________________________ Run Checks
	# if [ ! -f ${srcRef} ]; then # what you passed in wasn't a file
		# echo 'Not a file or directory: ' "${srcRef}"
		# exit 1
	# elif [[ -z "${srcRef// }" ]]; then
		# echo "Package C requires an argument"
		# echo 'For help:'
		# echo -e '\tC -h'
		# exit 1
	# elif [ ! "${ext}" == ".c" ] && [ ! "${ext}" == ".h" ]; then
		# echo "Must pass in a source C or C++ file"
		# exit 1
	# fi

	# _________________________________ Compile c/c++ code
	output='./execute'

	echo 'Header folder paths:'
	sed -e 's/^/\t/' <(echo "${headerRef}")
	echo 'Source files to be compiled:'
	sed -e 's/^/\t/' <(echo "${srcRef}")
	echo
	
	# create the executable for the given source file
	if [ -z ${headerRef} ]; then # if headerRef is null or empty
		${compRef} ${srcRef} -o ${output} # compile without header paths included
		echo ${compRef} ${srcRef} -o ${output}
	else # otherwise we have headers
		# add -I to the array of headers
		withInclude="$(sed -e 's/^/-I/' <(echo "${headerRef}"))"
		# compile with the headers
		${compRef} ${srcRef} -o ${output} ${withInclude}
		echo ${compRef} ${srcRef} -o ${output} ${withInclude}
	fi


}
