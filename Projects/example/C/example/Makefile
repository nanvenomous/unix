#!/bin/bash

# We will use the C compiler
cComp=/usr/bin/cc

pointer: pointer.c
	cc pointer.c -o ./.execute/pointer -I .
dataTypes: dataTypes.c
	cc dataTypes.c -o ./.execute/dataTypes -I .
macro: macro.c
	cc macro.c -o ./.execute/macro -I .
all: pointer dataTypes macro
