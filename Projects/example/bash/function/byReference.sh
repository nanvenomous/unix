var='initial'

fun () {
	# essentially var passed by reference (cannot be named var)
	local -n varRef=$1
	local restOfInputs=${@:2}
	echo "$restOfInputs"
	# re-setting the value of global var
	varRef='final'
}

fun var other inputs

echo $var
