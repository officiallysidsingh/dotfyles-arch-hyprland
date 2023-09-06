# -----------------------------------------------------
# Specify the path to your wallpaper folder
# ----------------------------------------------------- 

wallpaper_folder="$HOME/wallpaper"

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

swww img $selected_wallpaper --transition-step 20 --transition-fps=20

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

notify-send "Wallpaper updated" "With image $selected_wallpaper"

echo "DONE!"
