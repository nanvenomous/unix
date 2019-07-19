droid="${HOME}/Projects/android"
run="${droid}/android-studio/bin/studio.sh"
emulator="${droid}/sdk/emulator/emulator"

hr="${HOME}/scripts/src/studio"
help="${hr}/help"

buildProject () {
	./gradlew installDebug
}

emulatorLaunch () {
	"${emulator}" @pixel &
}

runAndroidStudio () {
	"${run}" &
}

while getopts ":h" opt; do
	case "${opt}" in
		h ) 
			cat "${help}"
			exit 0
			;;
		\? )
			echo "Invalid Option: -${OPTARG}"
			exit 1
			;;
	esac
done
shift $((OPTIND -1)) # remove the package flag

# Handle case no arguments
if [[ $# -eq 0 ]] ; then
	cat "${help}"
	exit 0
fi

cmd="${1}"; shift # remove rn from the arguments
case "${cmd}" in
	build )
		buildProject
		;;
	emulator )
		emulatorLaunch
		;;
	run )
		runAndroidStudio
		;;
	* )
		echo "Not a recognized command: ${cmd}"
		;;
esac
