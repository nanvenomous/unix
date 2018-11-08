#!/bin/bash

cc='/usr/bin/g++'
subDir='./.execute/'
src="${@}"

# make the directory for executables if there is none
command mkdir -p ${subDir}

# get executable file name
ind=`expr index ${src} .`
exe=${src:0:`expr ${ind} - 1`}

# create the executable for the given source file
command ${cc} ${src} -o ${subDir}${exe}

# run the executable
command ${subDir}${exe}
