eval "$(dircolors)"

case "$(uname -s)" in
  Linux*)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
    ;;
  Darwin*)
    source ~/.scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

oBrack='%F{magenta}{%f'
cBrack='%F{magenta}}%f'
oParen='%F{cyan}(%f'
cParen='%F{cyan})%f'
at='%F{yellow}@%f'
arrow='%F{blue}|>%f'

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats "${oParen}%b${cParen}"
zstyle ':vcs_info:*' enable git

function set_terminal_title() {
  echo -n -e "\033]0;$(hostnamectl hostname) | $(dirs -c; dirs)\007"
}

precmd() {
	vcs_info
  set_terminal_title
	print -rP "%B%F{blue}%~%f%b ${vcs_info_msg_0_}"
}
RPROMPT="${oBrack}%n${at}%m${cBrack}"
PROMPT='%(?.%F{green}0.%F{red}%?)%f${arrow} '

# cyan
programming_languages='*.py=00;36:*.go=00;36:*.c=00;36:*.js=00;36:*.jsx=00;36:*.ts=00;36:*.tsx=00;36:'
# yellow
storage_files='*.json=00;33:*.yml=00;33:*.yaml=00;33:'
# magenta
text_notes_logs='*.md=00;35:*.txt=00;35:*.log=00;35:'
# red
template_files='*.html=00;31:*.css=00;31:'
# blue
directories='di=1;34:'

LS_COLORS="${LS_COLORS}${directories}${programming_languages}${storage_files}${text_notes_logs}${template_files}"
export LS_COLORS

# export TERM='xterm-256color'
