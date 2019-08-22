#!/bin/sh

tree='tree'
ignore='__pycache__|*.pyc|node_modules'

clear
${tree} --dirsfirst -I ${ignore} "${@}"
