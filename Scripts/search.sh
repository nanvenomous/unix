#!/bin/bash

find='/usr/bin/find'

# finds files with a particular string

${find} . -type f -print | xargs grep "${@}"
