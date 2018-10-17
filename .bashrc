# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#________________________________________________________________________________
#__________File
alias s='sudo'
alias c='clear'
alias ls='ls --color=auto'
alias t='tree -L 1 --dirsfirst'
alias T='bash ~/Scripts/T.sh'
alias size='sudo du -hs'
alias here='echo $PWD'
alias cur='cd ~/Projects/serveMe/src/'
alias copy='bash ~/Scripts/edit/copy.sh'
alias view='bash ~/Scripts/edit/view.sh'

#________________________________________________________________________________
#__________System
alias b='bash ~/Scripts/b.sh'
alias fixBash='source ~/.bashrc'
alias disk='lsblk'
alias writeSystem='sudo dd if=/dev/nvme0n1' # of=/path/to/usb
alias poweroff='/sbin/shutdown -r now'
alias saveRoot='sudo rsync -aAXv --delete / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","~/Downloads"}'
alias linuxDrive='sudo mkfs.ext4'
alias mouse='bash ~/Scripts/mouse.sh'
alias apt-size='bash ~/Scripts/apt-size.sh'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|percentage|time to empty"'

#________________________________________________________________________________
#__________Programs
alias weather='sudo curl wttr.in'
alias chrome='/usr/bin/google-chrome-stable &>/dev/null'
alias render='bash ~/Scripts/render.sh &>/dev/null'
alias p='python'
alias g='bash ~/Scripts/g.sh'
alias cg='bash ~/Scripts/cg.sh'
alias ve='/usr/local/bin/virtualenv'
