#!/bin/bash

# Aggregates all files and directories listed in CONFIG_FILE to UPLOAD_DIR/system-info
# Writes installed packages to ~/Documents/SystemInfo/pacman-installs.txt
# Formats the consolidated file as Markdown with an index

# Script metadata
SCRIPT_NAME="System Info Collector ArchLaptop"
SCRIPT_VERSION="2.4"

# Print script name and version
echo -e "\e[34m$SCRIPT_NAME - Version $SCRIPT_VERSION\e[0m"
echo

# Define directories
UPLOAD_DIR="$HOME/Uploads/Archlinux/ArchLaptop/LatestSync/"
SYSTEM_INFO_DIR="$UPLOAD_DIR/system-info"
CONFIG_FILE="$HOME/Uploads/Archlinux/ArchLaptop/upload-files.txt"
CONCAT_FILE="$UPLOAD_DIR/sys.txt"
SYSFILES_MD="$UPLOAD_DIR/sys.md"
LOG_FILE="$UPLOAD_DIR/copy_failures.log"

# Create directories if they don't exist
mkdir -p "$SYSTEM_INFO_DIR"

# Colors for output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Clean the upload directory
echo -e "${YELLOW}Cleaning upload directory: $UPLOAD_DIR...${RESET}"
rm -rf "$UPLOAD_DIR"/*
mkdir -p "$UPLOAD_DIR"
echo -e "${GREEN}Upload directory cleaned.${RESET}"

# Clean the system-info directory
echo -e "${YELLOW}Cleaning system-info directory: $SYSTEM_INFO_DIR...${RESET}"
rm -rf "$SYSTEM_INFO_DIR"/*
mkdir -p "$SYSTEM_INFO_DIR"
echo -e "${GREEN}System-info directory cleaned.${RESET}"

# Initialize log file
>"$LOG_FILE"

# Save installed packages
SYSTEM_INFO_FILE="$HOME/Documents/SystemInfo/pacman-installs.txt"
echo -e "${YELLOW}Saving installed packages to $SYSTEM_INFO_FILE...${RESET}"
if pacman -Qqe >"$SYSTEM_INFO_FILE" 2>/dev/null; then
  echo -e "${GREEN}Installed packages saved to $SYSTEM_INFO_FILE${RESET}"
else
  echo -e "${RED}Failed to save installed packages.${RESET}"
fi

# Save system information to the same file
echo -e "\n=== System Information (inxi -Fxz) ===\n" >>"$SYSTEM_INFO_FILE"
inxi -Fxz >>"$SYSTEM_INFO_FILE" 2>/dev/null

echo -e "\n=== Memory Information (free -h) ===\n" >>"$SYSTEM_INFO_FILE"
free -h >>"$SYSTEM_INFO_FILE"

echo -e "\n=== Disk Usage (df -h) ===\n" >>"$SYSTEM_INFO_FILE"
df -h >>"$SYSTEM_INFO_FILE"

echo -e "\n=== Wayland Session Variables ===\n" >>"$SYSTEM_INFO_FILE"
env | grep WAYLAND >>"$SYSTEM_INFO_FILE"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo -e "${RED}Error: Config file '$CONFIG_FILE' not found.${RESET}"
  exit 1
fi

# Counters for success and failure
success_count=0
failure_count=0

# Start with empty files
>"$CONCAT_FILE"
>"$SYSFILES_MD"

# Create Markdown header
echo -e "# System Files\n\n## Index\n" >>"$SYSFILES_MD"

# Process each file or directory from the config file
section_counter=1
while IFS= read -r ENTRY; do
  # Skip empty lines and comments
  [[ -z "$ENTRY" || "$ENTRY" == \#* ]] && continue

  # Expand tilde and variables
  ENTRY=$(eval echo "$ENTRY")

  # Validate the file or directory
  if [ -f "$ENTRY" ]; then
    DEST="$SYSTEM_INFO_DIR/${ENTRY#$HOME/}"
    mkdir -p "$(dirname "$DEST")"
    if cp "$ENTRY" "$DEST" 2>/dev/null; then
      echo -e "${GREEN}Copied $ENTRY to $DEST${RESET}"
      ((success_count++))

      # Add to the concatenated file
      echo "=== $(basename "$ENTRY") ===" >>"$CONCAT_FILE"
      cat "$ENTRY" >>"$CONCAT_FILE"
      echo -e "\n\n" >>"$CONCAT_FILE"

      # Add to Markdown file
      section_title="$(basename "$ENTRY")"
      anchor="section-$section_counter"
      echo "- [$section_title](#$anchor)" >>"$SYSFILES_MD"
      echo -e "\n## $section_title\n<a id=\"$anchor\"></a>\n" >>"$SYSFILES_MD"
      cat "$ENTRY" >>"$SYSFILES_MD"
      echo -e "\n\n" >>"$SYSFILES_MD"
      ((section_counter++))
    else
      echo -e "${RED}Failed to copy $ENTRY to $DEST${RESET}" | tee -a "$LOG_FILE"
      ((failure_count++))
    fi
  elif [ -d "$ENTRY" ]; then
    while IFS= read -r -d '' FILE; do
      DEST="$SYSTEM_INFO_DIR/${FILE#$HOME/}"
      mkdir -p "$(dirname "$DEST")"
      if cp "$FILE" "$DEST"; then
        echo -e "${GREEN}Copied $FILE to $DEST${RESET}"
        ((success_count++))
      else
        echo -e "${RED}Failed to copy $FILE to $DEST${RESET}" | tee -a "$LOG_FILE"
        ((failure_count++))
      fi
    done < <(find -L "$ENTRY" -type f -print0)

  else
    echo -e "${YELLOW}File or directory does not exist: $ENTRY${RESET}" | tee -a "$LOG_FILE"
  fi
done <"$CONFIG_FILE"

# Notify user of completion
echo -e "${GREEN}Files gathered in $SYSTEM_INFO_DIR${RESET}"
echo -e "${GREEN}$success_count${RESET}/$((success_count + failure_count)) files copied successfully, ${RED}$failure_count${RESET} failed."
echo -e "${GREEN}Concatenated file created at: $CONCAT_FILE${RESET}"
echo -e "${GREEN}Markdown file created at: $SYSFILES_MD${RESET}"
echo -e "${YELLOW}Log of failures saved at: $LOG_FILE${RESET}"

# Commented out this part for now
# Open Dolphin to the upload directory
# if command -v dolphin &>/dev/null; then
#     dolphin "$UPLOAD_DIR" &
# else
#     echo -e "${YELLOW}Dolphin is not installed. Files are in $UPLOAD_DIR.${RESET}"
# fi
#
# Open project folder in browser
# if command -v xdg-open &>/dev/null; then
#     echo -e "${YELLOW}Opening project page in browser...${RESET}"
#     xdg-open "https://chatgpt.com/g/g-p-675e3fc315d481918227664d2b6bf82f-archlinux-install/project" &
# else
#     echo -e "${RED}Failed to open browser. Please visit https://chat.openai.com/${RESET}"
# fi
