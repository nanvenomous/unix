#!/bin/bash

xrandr | grep " connected " | awk '{print $1}'
