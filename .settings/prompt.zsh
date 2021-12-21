oBrack='%F{magenta}{%f'
cBrack='%F{magenta}}%f'
oParen='%F{cyan}(%f'
cParen='%F{cyan})%f'
at='%F{yellow}@%f'

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats "${oParen}%b${cParen}"
zstyle ':vcs_info:*' enable git

precmd() {
	vcs_info
	print -rP "%B%F{blue}%~%f%b ${vcs_info_msg_0_}"
}
RPROMPT="${oBrack}%n${at}%m${cBrack}"
PROMPT='%(?.%F{green}0.%F{red}%?)%f %# '

# cyan
programming_languages='*.py=00;36:*.go=00;36:*.c=00;36:*.js=00;36:*.jsx=00;36:*.ts=00;36:*.tsx=00;36:'
# yellow
storage_files='*.json=00;33:*.yml=00;33:*.yaml=00;33:'
# magenta
text_notes_logs='*.md=00;35:*.txt=00;35:*.log=00;35:'
# red
template_files='*.html=00;31:*.css=00;31:'

eval "$(dircolors)"
LS_COLORS="${LS_COLORS}${programming_languages}${storage_files}${text_notes_logs}${template_files}"
# LS_COLORS="${LS_COLORS}*.py=00;33:*.go=00;36:*.c=00;35:*.js=00;31:*.jsx=00;31:*.ts=00;31:*.tsx=00;31:"
export LS_COLORS

# export TERM='xterm-256color'
