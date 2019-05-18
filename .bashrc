source ${HOME}/Scripts/colorSettings.sh

#________________________________________________________________________________
#__________Local (not trackable)
source ${HOME}/.locrc

#________________________________________________________________________________
#__________File
alias c='clear'
alias copy='bash ~/Scripts/edit/copy.sh'
alias view='bash ~/Scripts/edit/view.sh'
alias apps='cd /usr/share/applications'
alias fnd='bash ~/Scripts/fnd/run.sh'
alias search='bash ~/Scripts/search.sh'

#________________________________________________________________________________
#__________System
alias fixBluetooth='pactl load-module module-bluetooth-discover'
alias disk='lsblk'
alias writeSystem='sudo dd if=/dev/nvme0n1' # of=/path/to/usb
alias linuxDrive='sudo mkfs.ext4'
alias mouse='bash ~/Scripts/mouse.sh'
alias apt-size='bash ~/Scripts/apt-size.sh'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state:|percentage:|time to empty:"'
alias get='sudo apt-get'
alias upgrade='sudo apt-get update; sudo apt-get upgrade; sudo apt update; sudo apt upgrade; sudo update-grub'
alias mem='python3.7 ~/Scripts/mem/run.py'
alias dsk='python3.7 ~/Scripts/dsk/run.py'

alias fixSound='killall pulseaudio; rm -r ~/.config/pulse/*; rm -r ~/.pulse*; sudo reboot'
alias reinstallSound='sudo apt-get remove --purge alsa-base pulseaudio; sudo apt-get install alsa-base pulseaudio'


#________________________________________________________________________________
#__________Programs
alias weather='sudo curl wttr.in'
alias chrome='/usr/bin/chromium-browser &>/dev/null'
alias render='bash ~/Scripts/render.sh &>/dev/null'
alias g='bash ~/Scripts/git/g.sh'
alias cg='bash ~/Scripts/git/cg.sh'
alias ve='/usr/local/bin/virtualenv'
alias fetch='bash ~/Scripts/fetch.sh'
alias sl='sudo bash ~/Scripts/symlinks/sl.sh'
alias C='bash ~/Scripts/gcc/C.sh'
alias todo='bash ~/Scripts/todo/run.sh'
alias settings='bash ~/Scripts/settings/run.sh'
alias clk='bash ~/Scripts/clk/run.sh'
alias dsp='bash ~/Scripts/dsp/run.sh'
alias pypi='bash ~/Scripts/pypi/run.sh'
alias rct='/usr/local/bin/react-native'

#________________________________________________________________________________
#__________Open
alias pdf="bash ~/Scripts/pdf.sh"
alias image='/usr/bin/xdg-open'

# p equates to whichever python is active
alias p='python'
alias pin='sudo python3.7 -m pip install'
alias create='python3.7 -m virtualenv env'
alias activate='source env/bin/activate'
