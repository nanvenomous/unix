#!/bin/bash

xrandr | grep -E " connected | disconnected " | awk '{print $1,$2}'
