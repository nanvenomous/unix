#!/bin/bash

ANGLE_SENSOR="/sys/bus/iio/devices/iio:device0/in_angl_raw"
THRESHOLD=175
DISPLAY="eDP-1"  # Change if needed - check with: swaymsg -t get_outputs
TABLET_MODE=false

while true; do
    ANGLE=$(cat "$ANGLE_SENSOR" 2>/dev/null || echo "0")
    
    if [ "$ANGLE" -gt "$THRESHOLD" ] && [ "$TABLET_MODE" = false ]; then
        # Entering tablet mode
        echo "Tablet mode activated (angle: $ANGLE)"
        TABLET_MODE=true
        pkill rot8
        rot8 --invert-x &
        
    elif [ "$ANGLE" -le "$THRESHOLD" ] && [ "$TABLET_MODE" = true ]; then
        # Entering laptop mode
        echo "Laptop mode activated (angle: $ANGLE)"
        TABLET_MODE=false
        pkill rot8
        swaymsg output "$DISPLAY" transform 0
    fi
    
    sleep 1  # Check every second (adjust if needed)
done
