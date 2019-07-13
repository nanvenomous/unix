PROMPT_COMMAND="history -a; history -c" # add to ~/.bash_history after each command
export EDITOR='vim'

source ${HOME}/Scripts/colorSettings.sh

#________________________________________________________________________________
#__________Android SDK Setup
androidsdk="${HOME}/Projects/android/sdk"
PATH=${PATH}:"${androidsdk}/platform-tools"
PATH=${PATH}:"${androidsdk}/emulator"
PATH=${PATH}:"${androidsdk}/tools"
PATH=${PATH}:"${androidsdk}/tools/bin"

export ANDROID_SDK_ROOT="${HOME}/Projects/android/sdk"
export ANDROID_HOME="${HOME}/Projects/android/sdk"
export ANDROID_AVD_HOME="${HOME}/.android/avd"

#________________________________________________________________________________
#__________Local (not trackable)
source ${HOME}/.locrc

#________________________________________________________________________________
#__________File
alias apps='cd /usr/share/applications'

#________________________________________________________________________________
#__________Aliases
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && t
}
alias up="cd ..; t"
alias c='clear'
alias linuxDrive='sudo mkfs.ext4'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state:|percentage:|time to empty:"'
alias get='sudo apt-get install'
alias purge='sudo apt-get purge'
alias upgrade='sudo apt-get update; sudo apt-get upgrade; sudo apt update; sudo apt upgrade'
alias u-grub='sudo update-grub'

alias fixBackground='dbus-send --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval "string:global.reexec_self()"'
alias src="source ${HOME}/.bashrc; source ${HOME}/.profile"


#________________________________________________________________________________
#__________Scripts
# BASH
alias mouse='bash ~/Scripts/mouse.sh'
alias apt-size='bash ~/Scripts/apt-size.sh'
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
alias copy='bash ~/Scripts/edit/copy.sh'
alias view='bash ~/Scripts/edit/view.sh'
alias fnd='bash ~/Scripts/fnd/run.sh'
alias search='bash ~/Scripts/search.sh'
alias rn='bash ~/Scripts/rn/run.sh'
alias dsk='bash ~/Scripts/dsk/run.sh'
alias mem='bash ~/Scripts/mem/run.sh'
alias studio='bash ~/Scripts/studio/run.sh'

# Pyhton

#________________________________________________________________________________
#__________Open
alias pdf="bash ~/Scripts/pdf.sh"
alias image='/usr/bin/xdg-open'

#________________________________________________________________________________
#__________Python Environment
alias p='python3.7'
alias pin='sudo python3.7 -m pip install'
alias create='python3.7 -m virtualenv env'
alias activate='source env/bin/activate'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/pablo/.sdkman"
[[ -s "/home/pablo/.sdkman/bin/sdkman-init.sh" ]] && source "/home/pablo/.sdkman/bin/sdkman-init.sh"

echo 'Sourced ~/.bashrc'
