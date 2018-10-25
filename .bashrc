source ${HOME}/Scripts/colorSettings.sh

#________________________________________________________________________________
#__________File
alias s='sudo'
alias c='clear'
alias ls='ls --color=auto'
alias t='tree -L 1 --dirsfirst'
alias T='bash ~/Scripts/T.sh'
alias size='sudo du -hs'
alias here='echo $PWD'
alias cur='cd ~/Code/'
alias copy='bash ~/Scripts/edit/copy.sh'
alias view='bash ~/Scripts/edit/view.sh'
alias hs='history | vim -'

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
alias chrome='/usr/bin/chromium-browser &>/dev/null'
alias render='bash ~/Scripts/render.sh &>/dev/null'
alias p='python'
alias g='bash ~/Scripts/cliGit/g.sh'
alias cg='bash ~/Scripts/cliGit/cg.sh'
alias ve='/usr/local/bin/virtualenv'
alias cr='bash ~/Scripts/cr.sh'
alias fetch='bash ~/Scripts/fetch.sh'
