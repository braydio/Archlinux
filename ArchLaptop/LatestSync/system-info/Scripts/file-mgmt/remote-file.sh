#!/bin/bash

# Usage: ./remote-file.sh get|send [-s server] [-src source_path] [-dst destination_path]

# Default paths
DEFAULT_SRC_PATH="/home/braydenchaffee/Uploads/Source/"
DEFAULT_DST_PATH="/home/braydenchaffee/Downloads/Fetch/"

# Initialize variables
ACTION=""
SRC_PATH="$DEFAULT_SRC_PATH"
DST_PATH="$DEFAULT_DST_PATH"
SELECTED_SERVER=""
PASSWORD=""

# Remote server credentials
SERVERS=(
  "192.168.1.85:Raspberry Pi 4:03231997:braydenchaffee"
  "192.168.1.78:Pi Zero W:03231997:braydenchaffee"
  "192.168.1.225:MacBook Pro:braydenchaffee"
  "192.168.1.227:Archlinux Laptop:0323:braydenchaffee"
)

# Function to display usage
usage() {
  echo "Usage: $0 get|send [-s server] [-src source_path] [-dst destination_path]"
  exit 1
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
  get | send)
    ACTION="$1"
    ;;
  -s | --server)
    SELECTED_SERVER="$2"
    shift
    ;;
  -src | --source)
    SRC_PATH="$2"
    shift
    ;;
  -dst | --destination)
    DST_PATH="$2"
    shift
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
  shift
done

# Validate action
if [[ -z "$ACTION" ]]; then
  echo "Error: You must specify an action (get or send)."
  usage
fi

# Prompt user to select a server if none provided
if [[ -z "$SELECTED_SERVER" ]]; then
  echo "Select the server:"
  select SERVER_INFO in "${SERVERS[@]}"; do
    if [[ -n "$SERVER_INFO" ]]; then
      SELECTED_SERVER="$SERVER_INFO"
      break
    else
      echo "Invalid selection."
    fi
  done
fi

# Extract server details
SERVER=$(echo "$SELECTED_SERVER" | cut -d':' -f1)
DEVICE=$(echo "$SELECTED_SERVER" | cut -d':' -f2)
PASSWORD=$(echo "$SELECTED_SERVER" | cut -d':' -f3)
USER=$(echo "$SELECTED_SERVER" | cut -d':' -f4)

echo "Selected server: $DEVICE ($SERVER)"

# Perform the action
if [[ "$ACTION" == "get" ]]; then
  echo "Fetching file from $DEVICE..."
  sshpass -p "$PASSWORD" scp "$USER@$SERVER:$SRC_PATH" "$DST_PATH"
elif [[ "$ACTION" == "send" ]]; then
  echo "Sending file to $DEVICE..."
  sshpass -p "$PASSWORD" scp "$SRC_PATH" "$USER@$SERVER:$DST_PATH"
else
  echo "Invalid action. Use 'get' or 'send'."
  exit 1
fi
