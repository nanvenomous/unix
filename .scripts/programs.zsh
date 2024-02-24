alias lg='lazygit'
alias cg="lazygit --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias x='nvim ~/.Xresources; xrdb merge ~/.Xresources && kill -USR1 $(pidof st)'
alias g="git --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias weather='curl "wttr.in/Austin?m"'
alias clk="date '+%I:%M %p'"
alias review='git diff --name-only HEAD HEAD~1 | uniq | xargs nvim -p'
alias resolve='git diff --name-only | uniq | xargs nvim -p'

alias dsk="lsblk | grep -v -e 'SWAP' -e 'loop'"
alias ss='scrot' # scrot -d 20
alias keychain='sudo pacman -S archlinux-keyring; sudo pacman-key --populate archlinux; sudo pacman-key --refresh'

function agenda() {
  gcalcli --nocolor agenda --no-military "$(date '+%a %b %d')" "$(date '+%a %b %d' -d "8 days")"
}

function battery() {
  battery_status=$(cat /sys/class/power_supply/BAT0/status)
  battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  echo "${battery_capacity}% ${battery_status}"
}

function random_ssh_port() {
  python -c 'import random; print(random.randrange(1024, 32767))'
}

alias brightness='xrandr --output eDP-1 --brightness'

alias lock='i3lock -i ~/Images/background_lock.png'
alias bye='lock && systemctl suspend'
function background() {
  feh --bg-scale ~/Images/background.jpg
}

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
    source /usr/share/nvm/init-nvm.sh

    ################### JAVA
    export JAVA_HOME='/usr/lib/jvm/default'

    ################### ANDROID
    export ANDROID_HOME="${HOME}/.android"
    export ANDROID_SDK_ROOT="${ANDROID_HOME}"

    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/tools"
    export PATH="$PATH:$ANDROID_HOME/tools/bin"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
    export ANDROID_BUILD_TOOLS=33.0.2

    ################### GO
    export GOROOT='/usr/lib/go'
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    
    ################### RUST
    export PATH=$PATH:$HOME/.cargo/bin

    ################### MASON
    export PATH="${PATH}:${HOME}/.local/share/nvim/mason/bin"
    
    ;;
  Darwin*)
    ################### NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    ################### JAVA
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"

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
    export GOPATH=${GOPATH}:`pwd`
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin
    ;;
esac
