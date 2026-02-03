#!/usr/bin/env bash

ANGLE_FILE="/sys/bus/iio/devices/iio:device*/in_angl_raw"

ACTIVE_FILE="/tmp/tablet_script_active"

# Thresholds for state swapping
TABLETIN=400
TABLETOPIN=200
TABLETOPOUT=180

REQUIRED_HITS=9

swaymsg output eDP-1 transform 0

# Don't let >1 process in the loop
[ -f "$ACTIVE_FILE" ] && rm "$ACTIVE_FILE"; sleep 0.21
touch "$ACTIVE_FILE"

current_state="laptop"
candidate="laptop"
count=9

while [ -f "$ACTIVE_FILE" ]; do
  
  sleep 0.2

  angle=$(cat $ANGLE_FILE)
  if [ "$angle" -gt "$TABLETIN" ]; then
    desired_state="tablet"
  elif [ "$angle" -gt "$TABLETOPIN" ]; then
    desired_state="tabletop"
  elif [ "$angle" -le "$TABLETOPOUT" ]; then
    desired_state="laptop"
  else
    continue
  fi

  if [ "$desired_state" = "$current_state" ]; then
    count=0
    continue
  fi

  # Debounce logic
  if [ "$desired_state" = "$candidate" ]; then
    count=$((count + 1))
  else
    candidate="$desired_state"
    count=0
  fi

  # Commit only after enough confirmations
  if [ "$count" = "$REQUIRED_HITS" ]; then
    if [ "$desired_state" = "tabletop" ]; then
      swaymsg output eDP-1 transform 180
    else
      swaymsg output eDP-1 transform 0
    fi
    current_state="$candidate"
  fi

done
