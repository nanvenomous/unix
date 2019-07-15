#!/bin/bash

# this is the example caller
hr="${HOME}/scripts/test"
helper="${hr}/helper.sh"
source "${helper}" "${hr}/caller.sh"

function doStuff() {
	echo 'worked'
}

apiExample 'doStuff'

