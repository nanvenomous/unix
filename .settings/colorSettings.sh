alias theme="lxappearance"

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_SEA_GREEN="\033[0;36m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function git_color {
	local git_status="$(git status 2> /dev/null)"
	if [[ ! $git_status =~ "nothing to commit, working tree clean" ]]; then
		echo -e $COLOR_RED
	elif [[ $git_status =~ "Your branch is ahead of" ]]; then
		echo -e $COLOR_YELLOW
	elif [[ $git_status =~ "nothing to commit" ]]; then
		echo -e $COLOR_GREEN
	else
		echo -e $COLOR_OCHRE
	fi
}

function git_branch {
	local git_status="$(git status 2> /dev/null)"
	local on_branch="On branch ([^${IFS}]*)"
	local on_commit="HEAD detached at ([^${IFS}]*)"

	if [[ $git_status =~ $on_branch ]]; then
		local branch=${BASH_REMATCH[1]}
		echo "($branch)"
	elif [[ $git_status =~ $on_commit ]]; then
		local commit=${BASH_REMATCH[1]}
		echo "($commit)"
	fi
}

PS1="{\[$COLOR_GREEN\]\u\[$COLOR_RESET\]"
PS1+="@\[$COLOR_SEA_GREEN\]\h\[$COLOR_RESET\]}"
PS1+=" \[$COLOR_BLUE\]\$?\[$COLOR_RESET\] \w "
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\n\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1

