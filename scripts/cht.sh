#!/bin/bash


#        ________               __       __              __ 
#       / ____/ /_  ___  ____ _/ /______/ /_  ___  ___  / /_
#      / /   / __ \/ _ \/ __ `/ __/ ___/ __ \/ _ \/ _ \/ __/
#     / /___/ / / /  __/ /_/ / /_(__  ) / / /  __/  __/ /_  
#     \____/_/ /_/\___/\__,_/\__/____/_/ /_/\___/\___/\__/  
#       
#
#                        By Siddharth Singh
# --------------------------------------------------------------------------------


# Check If fzf is Installed Or Not
# --------------------------------------------------------------------------------

if ! command -v fzf &> /dev/null; then
    echo -e "fzf is Not Installed.\nPlease Install It To Use This Script."
    exit 1
fi

# --------------------------------------------------------------------------------
# List of Programming Languages and Core Utils
# --------------------------------------------------------------------------------

languages="go java js git lua bash"
core_utils="xargs fd mv sed awk"

# --------------------------------------------------------------------------------
# Convert Space-Separated Lists Into Separate Lines
# --------------------------------------------------------------------------------

languages_list=$(echo "$languages" | tr ' ' '\n')
core_utils_list=$(echo "$core_utils" | tr ' ' '\n')

# --------------------------------------------------------------------------------
# Use 'fzf' To Allow User To Select an Item
# --------------------------------------------------------------------------------

selected=$(printf "$languages_list\n$core_utils_list" | fzf)

# --------------------------------------------------------------------------------
# Prompt User To Enter A Query String
# --------------------------------------------------------------------------------

read -p "Query: " query

# --------------------------------------------------------------------------------
# Remove Spaces From The Query and Replace With '+'
# --------------------------------------------------------------------------------

query=${query// /+}

# --------------------------------------------------------------------------------
# 1) If Selected Item is Language
#     I) Open New 'TMUX' Window
#    II) Run Command To Query 'cht.sh' With Selected Language and Query String
# 2) Else (If Selected Item is Core Util)
#     I) Directly Query 'cht.sh' With Selected Utility and Query String
# --------------------------------------------------------------------------------
if printf "$languages_list" | grep -qs "$selected"; then
  bash -c "curl cht.sh/$selected/$query & while true; do sleep 1; done"
else
  curl "cht.sh/$selected~$query"
fi
