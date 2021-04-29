oBrack='%F{magenta}{%f'
cBrack='%F{magenta}}%f'
oParen='%F{blue}(%f'
cParen='%F{blue})%f'
at='%F{yellow}@%f'

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats "${oParen}%b${cParen}"
zstyle ':vcs_info:*' enable git

precmd() {
	vcs_info
	print -rP "%B%F{cyan}%~%f%b ${vcs_info_msg_0_}"
}
RPROMPT="${oBrack}%n${at}%m${cBrack}"
PROMPT='%(?.%F{green}0.%F{red}%?)%f %# '
