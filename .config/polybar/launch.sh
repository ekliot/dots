#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for bar in main; do
  echo "---" | tee -a ~/.log/polybar/polybar-$bar.log
  polybar -r $bar >>~/.log/polybar/polybar-$bar.log 2>&1 & disown
done

echo "Bars launched..."
