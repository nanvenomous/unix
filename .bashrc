PROMPT_COMMAND="history -a; history -c" # add to ~/.bash_history after each command
export EDITOR='vim'

source ${HOME}/.settings/colorSettings.sh

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
#__________Aliases
function dn() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}"; t
}
alias up="cd ..; t"
alias c='clear'
alias linuxDrive='sudo mkfs.ext4'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state:|percentage:|time to empty:"'
alias upgrade='sudo apt-get update; sudo apt-get upgrade; sudo apt update; sudo apt upgrade'
alias u-grub='sudo update-grub'
alias weather='sudo curl wttr.in'
alias fetch='neofetch'
alias chrome='/usr/bin/chromium-browser &>/dev/null'
alias ve='/usr/local/bin/virtualenv'

alias src="${HOME}/scripts/scripts.py; source ${HOME}/.bashrc"
alias settings='bash ~/.settings/settings.sh'

#________________________________________________________________________________
#__________bin
export PATH="${HOME}/scripts/bin:${PATH}"

#________________________________________________________________________________
#__________Open
alias image='/usr/bin/xdg-open'

#________________________________________________________________________________
#__________Python Environment
alias p='python3.7'
alias pin='sudo python3.7 -m pip install'
alias create='python3.7 -m virtualenv env'
alias activate='source env/bin/activate'

#________________________________________________________________________________
#__________Local (not trackable)
source ${HOME}/.locrc

echo 'Sourced ~/.bashrc'
