#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
wifi=$(echo /sys/class/net/*/wireless | awk -F'/' '{ print $5 }')
eth=$(ls /sys/class/net | grep ^e)
WIRELESS_INTERFACE=$wifi ETHERNET_INTERFACE=$eth polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
