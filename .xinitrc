#!/bin/bash

unclutter -idle 1 -root &
bluetoothctl power on

picom &
exec i3
