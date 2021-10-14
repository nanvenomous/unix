#!/bin/bash

unclutter --timeout 1 &
xfce4-power-manager &
# bluetoothctl power on
# picom &

exec i3
