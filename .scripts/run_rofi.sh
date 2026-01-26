#!/bin/bash

# Define your TUI apps
tui_apps=(
  "nvim"
  "vim"
  "nano"
  "htop"
  "lazygit"
  "pulsemixer"
  "bluetuith"
  "bluetui"
  "cava"
  "vis"
  "pulsetui"
  "termpicker"
  "alarm"
  "battery"
)

# If called with an argument, we're handling the launch
if [[ -n "$1" ]]; then
    # Extract command name
    cmd=$(echo "$1" | awk '{print $1}')
    cmd=$(basename "$cmd")
    
    # Check if it's a TUI app
    for app in "${tui_apps[@]}"; do
        if [[ "$cmd" == "$app" ]]; then
            exec kitty -e $1
        fi
    done
    
    # Not a TUI app, launch normally
    exec $1
fi

# Show rofi with this script as the run command
rofi -show run -run-command "$0 '{cmd}'" -dpi $(xrdb -query | grep Xft.dpi | cut -f2)
