alias t='clear; exa --tree --level=1 --group-directories-first'
alias r='clear; exa --tree --group-directories-first'

alias c='clear'
set -o vi

function fnd() {
	pattern="$*"
    rg -i --files --glob "*${pattern}*"
}

function dn() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}"; t
}
alias up="cd ..; t"

eval "$(zoxide init zsh)"

# alias to='z'
function to() {
  z "${@}"
  t
}
