#!/bin/bash


#      _       __      ____                           
#     | |     / /___ _/ / /___  ____ _____  ___  _____
#     | | /| / / __ `/ / / __ \/ __ `/ __ \/ _ \/ ___/
#     | |/ |/ / /_/ / / / /_/ / /_/ / /_/ /  __/ /    
#     |__/|__/\__,_/_/_/ .___/\__,_/ .___/\___/_/     
#              _____  /_/      _  /_/  __             
#             / ___/__________(_)___  / /_            
#             \__ \/ ___/ ___/ / __ \/ __/            
#            ___/ / /__/ /  / / /_/ / /_              
#           /____/\___/_/  /_/ .___/\__/              
#                           /_/                       
#
#
#          By Siddharth Singh
# -----------------------------------------------------


# -----------------------------------------------------
# Specify the path to your wallpaper folder
# ----------------------------------------------------- 

wallpaper_folder="/hdd/entertainment/wallpapers"

# -----------------------------------------------------
# Check if the folder exists
# ----------------------------------------------------- 

if [ ! -d "$wallpaper_folder" ]; then
  echo "Wallpaper folder '$wallpaper_folder' not found."
  exit 1
fi

# -----------------------------------------------------
# Get a list of all image files in the folder
# -----------------------------------------------------

wallpaper_files=("$wallpaper_folder"/*)

# -----------------------------------------------------
# Check if there are any wallpaper files
# -----------------------------------------------------

if [ ${#wallpaper_files[@]} -eq 0 ]; then
  echo "No wallpaper images found in '$wallpaper_folder'."
  exit 1
fi

# -----------------------------------------------------
# Select a random wallpaper from the list
# -----------------------------------------------------

random_index=$((RANDOM % ${#wallpaper_files[@]}))
selected_wallpaper="${wallpaper_files[random_index]}"

# -----------------------------------------------------
# Set the new current_wallpaper
# -----------------------------------------------------

swww init
swww img $selected_wallpaper --transition-step 20 --transition-fps=20

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

notify-send "Wallpaper updated" "With $(basename "$selected_wallpaper")"

exit 0
