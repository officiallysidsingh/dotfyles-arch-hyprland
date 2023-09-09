#!/bin/bash


#      _    __      __                   
#     | |  / /___  / /_  ______ ___  ___ 
#     | | / / __ \/ / / / / __ `__ \/ _ \
#     | |/ / /_/ / / /_/ / / / / / /  __/
#     |___/\____/_/\__,_/_/ /_/ /_/\___/ 
#         ___            _       __
#       / ___/__________(_)___  / /_     
#       \__ \/ ___/ ___/ / __ \/ __/     
#      ___/ / /__/ /  / / /_/ / /_       
#     /____/\___/_/  /_/ .___/\__/       
#                     /_/                
#
#
#         By Siddharth Singh
# -----------------------------------------------------------------------------------------


# -----------------------------------------------------------------------------------------
# Check If Pamixer is Installed Or Not
# -----------------------------------------------------------------------------------------

if ! command -v pamixer &> /dev/null; then
    echo -e "pamixer is Not Installed.\nPlease Install It To Use This Script."
    exit 1
fi


# -----------------------------------------------------------------------------------------
# Check the number of arguments provided
# -----------------------------------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <command>"
    echo "Commands: increase, decrease, toggle"
    exit 1
fi

# -----------------------------------------------------------------------------------------
# Assign the value of the argument
# -----------------------------------------------------------------------------------------

command="$1"

# -----------------------------------------------------------------------------------------
# Functions to increase, decrease and toggle
# -----------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------
# Increase Function Internals :-
#   1. If Speakers Are Mute, Check if Volume == 0.
#       I) If Volume == 0.
#           i) Increase Volume By 5
#          ii) Unmute Speakers
#         iii) Show Notification
#      II) Else (If Volume != 0)
#           i) Unmute Speakers
#   2. Else (If Speakers Are Not Mute)
#       I) Increase Volume By 5
#      II) Show Notification
# -----------------------------------------------------------------------------------------

increase_function() {
  if [ "$(pamixer --get-mute)" == "true" ]
  then
    if [ "$(pamixer --get-volume)" == "0" ]
    then
      pamixer -i 5
      pamixer -u
      notify-send "Volume Increased  " -h int:value:"`pamixer --get-volume`"
    else
      notify-send "Unmuted 󰕾 "
      pamixer -u
    fi
  else
    pamixer -i 5
    notify-send "Volume Increased  " -h int:value:"`pamixer --get-volume`"
  fi
}

# -----------------------------------------------------------------------------------------
# Increase Function Internals :-
#   1. If Volume == 5 (Last Step Before Reaching 0)
#       I) Decrease Volume By 5
#      II) Mute Speakers
#   2. Else (If Volume != 5)
#       I) If Speakers Are Mute
#           i) Show Notification
#      II) Else (If Speakers Are Not Mute)
#           i) Decrease Volume By 5
#           i) Show Notification
# -----------------------------------------------------------------------------------------

decrease_function() {
  if [ "$(pamixer --get-volume)" == "5" ]
  then
    pamixer -d 5
    pamixer -m
    notify-send --urgency critical "Muted 󰖁 "
  else
    if [ "$(pamixer --get-mute)" == "true" ]
    then
    notify-send --urgency critical "Muted 󰖁 "
    else
      pamixer -d 5
      notify-send "Volume Decreased  " -h int:value:"`pamixer --get-volume`"
    fi
  fi
}

# -----------------------------------------------------------------------------------------
# Toggle Function Internals :-
#   1. If Speakers Are Muted
#       I) Unmute Speakers
#      II) Send Notification
#   2. Else (If Speakers Are Not Muted)
#       I) Mute Speakers
#      II) Send Notification
# -----------------------------------------------------------------------------------------

toggle_function() {
  if [ "$(pamixer --get-mute)" == "true" ]
  then
    pamixer -u
    notify-send "Unmuted 󰕾 "
  else
    pamixer -m
    notify-send --urgency critical "Muted 󰖁 "
  fi
}

# -----------------------------------------------------------------------------------------
# Switch case to execute appropriate commands based on args
# -----------------------------------------------------------------------------------------

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
