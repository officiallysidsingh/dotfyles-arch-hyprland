#!/bin/bash

#        _____                                __          __ 
#       / ___/_____________  ___  ____  _____/ /_  ____  / /_
#       \__ \/ ___/ ___/ _ \/ _ \/ __ \/ ___/ __ \/ __ \/ __/
#      ___/ / /__/ /  /  __/  __/ / / (__  ) / / / /_/ / /_  
#     /____/\___/_/___\___/\___/_/ /_/____/_/ /_/\____/\__/  
#
#                 _____           _       __ 
#                / ___/__________(_)___  / /_
#                \__ \/ ___/ ___/ / __ \/ __/
#               ___/ / /__/ /  / / /_/ / /_  
#              /____/\___/_/  /_/ .___/\__/  
#                              /_/
#
#
#                       By Siddharth Singh
# -----------------------------------------------------------------------------------


# -----------------------------------------------------------------------------------------
# Check If Grim is Installed Or Not
# -----------------------------------------------------------------------------------------

if ! command -v grim &> /dev/null; then
    echo -e "grim is Not Installed.\nPlease Install It To Use This Script."
    exit 1
fi

# -----------------------------------------------------------------------------------------
# Check the number of arguments provided
# -----------------------------------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <command>"
    echo "Commands: whole_screen, selected_area"
    exit 1
fi

# -----------------------------------------------------------------------------------------
# Assign the value of the argument
# -----------------------------------------------------------------------------------------

command="$1"

# -----------------------------------------------------------------------------------------
# Functions to Screenshot whole screen or specific area of screen
# -----------------------------------------------------------------------------------------

whole_screen () {
  location="$HOME/Screenshots"
  filename="$(date '+%d-%m-%y_%H-%M-%S').jpg"
  grim "$location/$filename"
  notify-send -t 4000 "Screenshot stored" "At $location with name $filename"
}

# -----------------------------------------------------------------------------------------
# First Check If Slurp is Installed Or Not
# Then Run Grim Command
# -----------------------------------------------------------------------------------------

selected_area () {
  if ! command -v slurp &> /dev/null; then
    echo -e "slurp is Not Installed.\nPlease Install It To Use This Script."
    exit 1
  fi

  location="$HOME/Screenshots"
  filename="$(date '+%d-%m-%y_%H-%M-%S').jpg"
  grim -g "$(slurp)" "$location/$filename"
  notify-send -t 4000 "Screenshot stored" "At $location with name $filename"
}

# -----------------------------------------------------------------------------------------
# Switch case to execute appropriate commands based on args
# -----------------------------------------------------------------------------------------

case "$command" in
  "whole_screen")
    whole_screen
    ;;
  "selected_area")
    selected_area
    ;;
  *)
    echo "Invalid command. Usage: $0 <command>"
    echo "Commands: whole_screen, selected_area"
    exit 1
    ;;
esac

exit 0














