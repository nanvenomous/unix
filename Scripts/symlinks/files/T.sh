#!/bin/sh

tree='/usr/bin/tree'
ignore='__pycache__|*.pyc|__init__.py|node_modules|ios|android'

${tree} --dirsfirst -I ${ignore} "${@}"
