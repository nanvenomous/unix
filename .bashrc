source ${HOME}/Scripts/colorSettings.sh

#________________________________________________________________________________
#__________Temporary
alias cur='cd ~/Projects/music/Scipy'
alias epc='cd /mnt/hgfs/epc'

#________________________________________________________________________________
#__________File
alias c='clear'
alias apps='cd /usr/share/applications'
alias copy='bash ~/Scripts/edit/copy.sh'
alias view='bash ~/Scripts/edit/view.sh'

#________________________________________________________________________________
#__________System
alias fixBluetooth='pactl load-module module-bluetooth-discover'
alias fixBash='source ~/.bashrc'
alias disk='lsblk'
alias writeSystem='sudo dd if=/dev/nvme0n1' # of=/path/to/usb
alias poweroff='/sbin/shutdown -r now'
alias saveRoot='sudo rsync -aAXv --delete / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","~/Downloads"}'
alias linuxDrive='sudo mkfs.ext4'
alias mouse='bash ~/Scripts/mouse.sh'
alias apt-size='bash ~/Scripts/apt-size.sh'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state:|percentage:|time to empty:"'

#________________________________________________________________________________
#__________Programs
alias weather='sudo curl wttr.in'
alias chrome='/usr/bin/chromium-browser &>/dev/null'
alias render='bash ~/Scripts/render.sh &>/dev/null'
alias g='bash ~/Scripts/cliGit/g.sh'
alias cg='bash ~/Scripts/cliGit/cg.sh'
alias ve='/usr/local/bin/virtualenv'
alias fetch='bash ~/Scripts/fetch.sh'
alias sl='sudo bash ~/Scripts/symlinks/sl.sh'
alias C='bash ~/Scripts/gcc/C.sh'
alias todo='bash ~/Scripts/todo/run.sh'
alias search='bash ~/Scripts/search.sh'

#________________________________________________________________________________
#__________Open
alias pdf="bash ~/Scripts/pdf.sh"
alias image='/usr/bin/xdg-open'

# p equates to whichever python is active
alias p='python'
alias activate='source env/bin/activate'
