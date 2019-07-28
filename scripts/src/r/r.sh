#!/bin/sh

tree='/usr/bin/tree'
ignore='__pycache__|*.pyc|node_modules'

clear
${tree} --dirsfirst -I ${ignore} "${@}"
