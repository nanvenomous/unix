alias lg='lazygit'
alias cg="lazygit --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias g="git --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias weather='curl wttr.in/?m2'
alias battery='cat /sys/class/power_supply/BAT0/capacity'
alias clk="date +%I:%M"
alias dsk="lsblk | grep -v -e 'SWAP' -e 'loop'"
alias ss='scrot' # scrot -d 20
alias keychain='sudo pacman -S archlinux-keyring; sudo pacman-key --populate archlinux; sudo pacman-key --refresh'

alias chrome='chromium --args --use-gl=swiftshader --disable-gpu --disable-software-rasterizer --no-xshm --no-gpu --disable-accelerated-compositing --disable-gpu-compositing &'

function _color() {
  xrdb merge "${1}"
  kill -USR1 $(pidof st)
}
alias color=_color

function _hr() {
  echo "${PWD}"
}
alias hr=_hr

PATH="$PATH:${HOME}/.local/bin"

case "$(uname -s)" in
  Linux*)
    ################### NVM
    if [ -f /usr/share/nvm/init-nvm.sh ]; then 
      . /usr/share/nvm/init-nvm.sh
    fi

    ################### JAVA
    export JAVA_HOME='/usr/lib/jvm/default'

    ################### ANDROID
    export ANDROID_SDK_ROOT='/opt/android-sdk'
    export ANDROID_HOME='/opt/android-sdk'
    export ANDROID_AVD_HOME="${HOME}/.android/avd"

    ################### GO
    export GOROOT=/usr/lib/go
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    ;;
  Darwin*)
    ################### NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    ################### JAVA
    # export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
    export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home'

    ################### ANDROID
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    export ANDROID_SDK="${ANDROID_HOME}"
    export ANDROID_SDK_ROOT="${ANDROID_HOME}"
    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/tools"
    export PATH="$PATH:$ANDROID_HOME/tools/bin"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"

    ################### GO
    export GOPATH=$HOME/go
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin
    ;;
esac
