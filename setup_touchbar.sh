#!/bin/bash

# Get current brightness percentage
CURRENT_BRIGHTNESS=$(brightnessctl | grep -o "(..%)" | grep -o "[0-9]*")

# Show a slider dialog and get the new brightness value
NEW_BRIGHTNESS=$(zenity --scale --text="Set screen brightness" --min-value=0 --max-value=100 --value=$CURRENT_BRIGHTNESS)

# If the user clicked OK, set the new brightness
if [ $? -eq 0 ]; then
    brightnessctl set $NEW_BRIGHTNESS%
fi