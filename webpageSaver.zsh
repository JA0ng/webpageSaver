#!/bin/zsh

# Config File
CONFIG_FILE="config.txt"

# Check if the config file exists
if [ -f "$CONFIG_FILE" ]; then
  # Load config from file
  source "$CONFIG_FILE"
else
  # Prompt the user for SAVE_DIRECTORY if the config file doesn't exist
  echo -n "What directory would you like to save your files to? "
  read -r SAVE_DIRECTORY < /dev/tty

  # Check if the directory exists
  if [ ! -d "$SAVE_DIRECTORY" ]; then
    echo -n "Directory does not exist. Would you like to create it (y/n): "
    read -r create_dir < /dev/tty
    if [ "$create_dir" = "y" ]; then
      mkdir -p "$SAVE_DIRECTORY"
      echo "Directory created: $SAVE_DIRECTORY"
    else
      echo "Exiting. Directory not created."
      exit 1
    fi
  fi

  # Create the config file with specified SAVE_DIRECTORY
  echo "SAVE_DIRECTORY=\"$SAVE_DIRECTORY\"" > "$CONFIG_FILE"
  echo "Config file created: $CONFIG_FILE"
fi

while true; do
  # Prompt user for a URL
  echo -n "Enter the URL of the webpage you want to save: "
  read -r url < /dev/tty

  # Check if URL is provided
  if [ -z "$url" ]; then
    echo "URL is required. Exiting."
    exit 1
  fi

  # Extract title from the webpage
  title=$(curl -s "$url" | grep -o '<title>[^<]*' | sed -E 's/<title>([^<]*)<\/title>/\1/' | sed -E 's/^[[:space:]]+//;s/[[:space:]]+$//;s/<[^>]+>//g')

  # Replace spaces and special characters in the title with underscores
  sanitized_title="${title//[^a-zA-Z0-9]/}"

  # Create timestamp for the filename
  timestamp=$(date +"%Y%m%d%H%M%S")

  # Use curl to download the webpage
  curl -o "${SAVE_DIRECTORY}/${sanitized_title}_${timestamp}.html" "$url"

  echo "Webpage saved as ${SAVE_DIRECTORY}/${sanitized_title}_${timestamp}.html"

  # Ask the user if they want to download another website
  echo -n "Do you want to download another website? (y/n): "
  read -r download_another < /dev/tty

  if [ "$download_another" != "y" ]; then
    echo "Exiting."
    exit 0
  fi
done
