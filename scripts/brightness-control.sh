#!/bin/bash


#         ____       _       __    __                      
#        / __ )_____(_)___ _/ /_  / /_____  ___  __________
#       / __  / ___/ / __ `/ __ \/ __/ __ \/ _ \/ ___/ ___/
#      / /_/ / /  / / /_/ / / / / /_/ / / /  __(__  |__  ) 
#     /_____/_/  /_/\__, /_/ /_/\__/_/ /_/\___/____/____/  
#                  /____/                                  
#
#                   ___            _       __              
#                 / ___/__________(_)___  / /_             
#                 \__ \/ ___/ ___/ / __ \/ __/             
#                ___/ / /__/ /  / / /_/ / /_               
#               /____/\___/_/  /_/ .___/\__/               
#                               /_/                        
#
#               
#               By Siddharth Singh
# -----------------------------------------------------------------------------------


# -----------------------------------------------------------------------------------
# Check If Brightness-CTL is Installed Or Not
# -----------------------------------------------------------------------------------

if ! command -v brightnessctl &> /dev/null; then
    echo -e "brightnessctl is Not Installed.\nPlease Install It To Use This Script."
    exit 1
fi

# -----------------------------------------------------------------------------------
# Check the number of arguments provided
# -----------------------------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <command>"
    echo "Commands: increase, decrease"
    exit 1
fi

# -----------------------------------------------------------------------------------
# Assign the value of the argument
# -----------------------------------------------------------------------------------

command="$1"

# -----------------------------------------------------------------------------------
# Functions to increase, decrease and toggle
# -----------------------------------------------------------------------------------

increase_function() {
  brightnessctl set +10%
  notify-send "Brightness Increased  "
}

decrease_function() {
  brightnessctl set 10%-
  notify-send "Brightness Decreased  "
}


# -----------------------------------------------------------------------------------
# Switch case to execute appropriate commands based on args
# -----------------------------------------------------------------------------------

case "$command" in
  "increase")
    increase_function
    ;;
  "decrease")
    decrease_function
    ;;
  *)
    echo "Invalid command. Usage: $0 <command>"
    echo "Commands: increase, decrease"
    exit 1
    ;;
esac

exit 0
