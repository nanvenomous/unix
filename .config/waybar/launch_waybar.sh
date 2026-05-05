#!/usr/bin/env bash
# Terminate already running bar instances
killall -q waybar
# Get DPI from xrdb, default to 96 if not set
DPI=$(xrdb -query | grep "Xft.dpi:" | awk '{print $2}')
DPI=${DPI:-96}

# # Calculate font size based on DPI (18px at 96 DPI)
# FONT_SIZE=$(echo "scale=0; 18 * $DPI / 96" | bc)
# # Update style.css with correct font size from fluoromachine theme
# sed "s/font-size: [0-9]*px/font-size: ${FONT_SIZE}px/" \
#     ~/.config/waybar/style_fluoromachine.css > ~/.config/waybar/style.css

# Launch waybar
waybar &
