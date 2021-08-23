alias t='clear; tree -C -L 1 --dirsfirst'
alias r='clear; tree -C --dirsfirst'
alias c='clear'
set -o vi

function dn() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}"; c; t
}
alias up="cd ..; c; t"

