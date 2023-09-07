#!/bin/bash


#      _    __      __                   
#     | |  / /___  / /_  ______ ___  ___ 
#     | | / / __ \/ / / / / __ `__ \/ _ \
#     | |/ / /_/ / / /_/ / / / / / /  __/
#     |___/\____/_/\__,_/_/ /_/ /_/\___/ 
#       / ___/__________(_)___  / /_     
#       \__ \/ ___/ ___/ / __ \/ __/     
#      ___/ / /__/ /  / / /_/ / /_       
#     /____/\___/_/  /_/ .___/\__/       
#                     /_/                
#
#
#         By Siddharth Singh
# ----------------------------------------------------------------


# ----------------------------------------------------------------
# Check the number of arguments provided
# ----------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <command>"
    echo "Commands: increase, decrease, toggle"
    exit 1
fi

# ----------------------------------------------------------------
# Assign the value of the argument
# ----------------------------------------------------------------

command="$1"

# ----------------------------------------------------------------
# Functions to increase, decrease and toggle
# ----------------------------------------------------------------

increase_function() {
  # If Speaker is Muted and We Increase Volume
  # It Automatically Unmutes
  if [ "$(pamixer --get-mute)" == "true" ]
  then
    if [ "$(pamixer --get-volume)" == "0" ]
    then
      pamixer -i 5
      pamixer -u
      dunstify "Volume: " -h int:value:"`pamixer --get-volume`"
    else
      pamixer -u
    fi
  else
    pamixer -i 5
    dunstify "Volume: " -h int:value:"`pamixer --get-volume`"
  fi
}

decrease_function() {
  if [ "$(pamixer --get-volume)" == "5" ]
  then
    pamixer -d 5
    pamixer -m
    dunstify "Speaker Muted"
  else
    if [ "$(pamixer --get-mute)" == "true" ]
    then
      dunstify "Speaker Muted"
    else
      pamixer -d 5
      dunstify "Volume: " -h int:value:"`pamixer --get-volume`"
    fi
  fi
}

toggle_function() {
  pamixer -t

  if [ "$(pamixer --get-mute)" == "true" ]
  then
    dunstify "Speaker Muted"
  else
    dunstify "Speaker Unmuted" -h int:value:"`pamixer --get-volume`"
  fi
}

# ----------------------------------------------------------------
# Switch case to execute appropriate commands based on args
# ----------------------------------------------------------------

case "$command" in
  "increase")
    increase_function
    ;;
  "decrease")
    decrease_function
    ;;
  "toggle")
    toggle_function
    ;;
  *)
    echo "Invalid command. Usage: $0 <command>"
    echo "Commands: increase, decrease, toggle"
    exit 1
    ;;
esac

exit 0
