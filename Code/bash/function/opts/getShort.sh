# allows for the options -h, -t, -a
opts='hta'

while getopts ${opts} opt; do
	case ${opt} in
		h ) # process option a
		;;
    t ) # process option t
      ;;
    \? ) echo "Usage: cmd [-h] [-t]"
      ;;
  esac
done
