alias r='clear; exa --tree --group-directories-first'
alias c='clear'
set -o vi

function fnd() {
	pattern="$*"
    rg -i --files --glob "*${pattern}*"
}

eval "$(where-to init)"

alias fd='cd $(find * -maxdepth 0 -type d | fzf); t'
