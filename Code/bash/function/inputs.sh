#!/bin/bash

concat () {
	prt1='setInStone'
	# gathers all inputs and puts in a string (respecting )
	args="$*"
	str="${prt1} ${args}"
	echo ${str}
}

var='variableInput'

concat userInput
concat $var

concat 'string input'
