autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git
precmd() {
	vcs_info
	print -rP "%B%F{cyan}%~%f%b %F{blue}${vcs_info_msg_0_}%f"
}
PROMPT='%(?.%F{green}0.%F{red}%?)%f %# '
