#!/bin/bash

find='/usr/bin/find'

${find} . -type f -print | xargs grep "${@}"
