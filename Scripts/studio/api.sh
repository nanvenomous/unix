droid="${HOME}/Projects/android"
run="${droid}/android-studio/bin/studio.sh"
emulator="${droid}/sdk/emulator/emulator"

run () {
	"${run}" &
}

emulator () {
	"${emulator}" @pixel &
}

build () {
	./gradlew installDebug
}
