#!/bin/sh

tree='/usr/bin/tree'
ignore='__pycache__|*.pyc'

command ${tree} -I ${ignore} -L 1 --dirsfirst "${@}"
