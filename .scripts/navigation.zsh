alias r='clear; exa --tree --group-directories-first'
alias c='clear'

bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line  

function fnd() {
	pattern="$*"
    rg -i --files --glob "*${pattern}*"
}

# eval "$(where-to)"
eval "$(where-to)"

# to

# alias fd='cd $(find * -maxdepth 0 -type d | fzf); t'
