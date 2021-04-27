alias lg='lazygit'
alias cg="lazygit --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias weather='curl wttr.in/?m2'
alias battery='cat /sys/class/power_supply/BAT0/capacity'
alias ss='scrot' # scrot -d 20
alias keychain='sudo pacman -S archlinux-keyring; sudo pacman-key --populate archlinux; sudo pacman-key --refresh'

source /usr/share/nvm/init-nvm.sh

export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export ANDROID_SDK_ROOT='/opt/android-sdk'
export ANDROID_HOME='/opt/android-sdk'
export ANDROID_AVD_HOME="${HOME}/.android/avd"

export JAVA_HOME='/usr/lib/jvm/default'
