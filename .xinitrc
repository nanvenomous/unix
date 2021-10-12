#!/bin/bash

unclutter --timeout 1 &
# bluetoothctl power on
# xfce4-power-manager &

picom &
exec i3
