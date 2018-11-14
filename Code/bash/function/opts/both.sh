#!/bin/bash

function echoUsage () {
	echo "Usage: cmd [-h] [-t]"
}

# allows for the options -h, -t, -a
opts=':hc:-'
while getopts ${opts} opt; do
	case ${opt} in
		- )
			echo ${OPTARG}
			;;
		h )
			;;
		t )
			;;
		\? )
			echo "Usage: cmd [-h] [-t]"
			;;
	esac
done

# https://stackoverflow.com/questions/402377/using-getopts-in-bash-shell-script-to-get-long-and-short-command-line-options
        -)
            case "${OPTARG}" in
                loglevel)
                    val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
                    ;;
                loglevel=*)
                    val=${OPTARG#*=}
                    opt=${OPTARG%=$val}
                    echo "Parsing option: '--${opt}', value: '${val}'" >&2
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unknown option --${OPTARG}" >&2
                    fi
                    ;;
            esac;;
