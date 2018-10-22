g='/usr/bin/git'

g () {
	$g --git-dir=$HOME/.cfg/ --work-tree=$HOME "${@}"
}

case "$1" in
	"b")
		g branch "${@:2}"
		;;
	"c")
		g commit "${@:2}"
		;;
	"ch")
		g checkout "${@:2}"
		;;
	"i")
		g init "${@:2}"
		;;
	"l")
		g log "${@:2}"
		;;
	"m")
		g merge "${@:2}"
		;;
	"p")
		g push "${@:2}"
		;;
	"r")
		g remote "${@:2}"
		;;
	"s")
		g status "${@:2}"
		;;
	"t")
		g ls-tree -r --name-only "${@:2}"
		;;
	"aa")
		g add . "${@:2}"
		;;
	"chb")
		g checkout -b "${@:2}"
		;;
	"pr")
		g pull --rebase "${@:2}"
		;;
	"rs")
		g remote show "${@:2}"
		;;
	*)
		g "${@}"
		;;
esac
