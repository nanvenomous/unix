#!/bin/bash
hr="${HOME}/Scripts/mem"

function clone() {
	# ${1} is the partition
	# ${2} is the file
	sudo partclone.ext4 -c -d -s "${1}" | gzip -c5 > "${2}".img.gz
}

function restore() {
	# ${1} is the file
	# ${2} is the partition
	zcat "${1}" | sudo partclone.ext4 -r -o "${2}"
}