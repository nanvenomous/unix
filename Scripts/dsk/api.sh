#!/bin/bash
hr="${HOME}/Scripts/mem"

function list() {
	# list all drives discluding swap
	lsblk | grep -v -e 'SWAP' -e 'loop'
}
