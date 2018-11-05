#!/bin/bash

# grab general script
hr="${HOME}/Scripts/gcc/compileRun.sh"
source ${hr}

comp='/usr/bin/g++'
src="${1}"

compRun comp src
