alias lg='lazygit'
alias cg="lazygit --work-tree=${HOME} --git-dir=${HOME}/.unx"
# alias x='nvim ~/.Xresources; xrdb merge ~/.Xresources && kill -USR1 $(pidof st)'
alias x='nvim ~/.config/kitty/kitty.conf && nvim ~/.config/chrome-flags.conf'
alias g="git --work-tree=${HOME} --git-dir=${HOME}/.unx"
alias weather='curl "wttr.in/Chicago?m"'
alias clk="date '+%I:%M %p'"
alias review='git diff --name-only HEAD HEAD~1 | uniq | xargs nvim -p'
alias resolve='git diff --name-only | uniq | xargs nvim -p'
alias packages='comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base-devel | sort | uniq)'

alias -g C="| sed -z 's/^[[:space:]]*//; s/[[:space:]]*$//' | wl-copy"

fzf-kill() {
    ps aux | fzf -m | awk '{print $2}' | xargs kill -9
}

fzf-rg() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

alias -s go="${EDITOR}"
alias -s lua="${EDITOR}"
alias -s c="${EDITOR}"
alias -s h="${EDITOR}"
alias -s rs="${EDITOR}"
alias -s ts="${EDITOR}"
alias -s js="${EDITOR}"

alias db='nvim -c ":DBUI" -'
alias dps="docker ps --format 'table {{.Names}}\\t{{.Status}}\\t{{.Image}}\\t{{.ID}}'"
alias gdiff='nvim -c ":DiffviewOpen" -'

alias space='duf --only local'
alias screenshot='grim -g "$(slurp)"'

alias gpp='gopass show --password  $(gopass list -f | fzf) | wl-copy'
alias gp='gopass edit  $(gopass list -f | fzf)'

function release() {
  lastTag=$(git describe --tags --abbrev=0 @^)
  git log ${lastTag}..@ | e -
}

function help() {
  cat ~/.config/i3/config | rg '^bindsym' 
}

alias dsk="lsblk | grep -v -e 'SWAP' -e 'loop'"
alias ss='scrot' # scrot -d 20
alias keychain='sudo pacman -S archlinux-keyring; sudo pacman-key --populate archlinux; sudo pacman-key --refresh'

function agenda() {
  gcalcli --nocolor agenda --no-military "$(date '+%a %b %d')" "$(date '+%a %b %d' -d "8 days")"
}

# function battery() {
#   battery_status=$(cat /sys/class/power_supply/BAT1/status)
#   battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)
#   echo "${battery_capacity}% ${battery_status}"
# }

function random_ssh_port() {
  python -c 'import random; print(random.randrange(1024, 32767))'
}

function lock() {
  clear
  fastfetch
  swaylock -i ~/Images/fluoromachine_background.png
}
alias bye='systemctl suspend && lock'

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

export CRUSH_DISABLE_PROVIDER_AUTO_UPDATE=1

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

    ################### CSHARP
    export PATH="$PATH:$HOME/.dotnet/tools"
    export PATH="$PATH:$HOME/csharp/netcoredbg"
    
    ################### CISCO
    export PATH=$PATH:/opt/cisco/secureclient/bin
    export PATH=$PATH:/opt/microsoft/microsoft-azurevpnclient

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
