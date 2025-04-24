#!/bin/bash

# Get battery info
BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo "0")
STATUS=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Discharging")

# Select icon based on status and capacity
if [ "$STATUS" = "Charging" ]; then
    echo "y"  # Lightning bolt for charging
else
    if [ "$CAPACITY" -gt 95 ]; then
        echo "O"  # Full battery
    elif [ "$CAPACITY" -gt 80 ]; then
        echo "C"  # 3/4 battery
    elif [ "$CAPACITY" -gt 45 ]; then
        echo "D"  # Half battery
    elif [ "$CAPACITY" -gt 25 ]; then
        echo "P"  # Low battery
    elif [ "$CAPACITY" -gt 10 ]; then
        echo "Q"  # Ultra Low battery
    else
        echo "N"  # Warning for critical
    fi
fi
    
