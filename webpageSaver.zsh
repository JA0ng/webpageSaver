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
  read SAVE_DIRECTORY < /dev/tty

  # Check if the directory exists
  if [ ! -d "$SAVE_DIRECTORY" ]; then
    echo -n "Directory does not exist. Would you like to create it (y/n): "
    read create_dir < /dev/tty
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

# Prompt user for a URL
echo -n "Enter the URL of the webpage you want to save: "
read url < /dev/tty

# Check if URL is provided
if [ -z "$url" ]; then
  echo "URL is required. Exiting."
  exit 1
fi

# Create timestamp for the filename
timestamp=$(date +"%Y%m%d%H%M%S")

# Use curl to download the webpage
curl -o "${SAVE_DIRECTORY}/page_${timestamp}.html" "$url"

echo "Webpage saved as ${SAVE_DIRECTORY}/page_${timestamp}.html"
