#!/bin/bash

command apt-cache --no-all-versions show $1 | grep '^Size: '
