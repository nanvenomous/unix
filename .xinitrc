#!/bin/bash

unclutter -idle 1 -root &
bluetoothctl power on
xfce4-power-manager &

picom &
exec i3
