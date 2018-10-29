#!/bin/bash

file='textfile.xml.gzip'

command echo ${file/%gzip/zip}
