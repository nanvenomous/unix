#!/bin/bash

function whereAmI () {
	local -n DIR=$1
	SOURCE="${BASH_SOURCE[0]}"
	while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
	  SOURCE="$(readlink "$SOURCE")"
	  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
	# if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
}

dir=''
whereAmI dir
echo ${dir}

## or another solution is:
workingDir=`dirname $(readlink -f $0)`
filepath="${workingDir}/files/"
echo ${filepath}
