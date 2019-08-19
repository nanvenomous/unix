#!/bin/sh

tree='tree'
ignore='__pycache__|*.pyc'

clear
${tree} -I ${ignore} -L 1 --dirsfirst "${@}"
