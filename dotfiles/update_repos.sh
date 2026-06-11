#!/bin/bash

# Repository Configuration
DEPOT1_NAME="FBNeo"
DEPOT1_PATH="/home/gegecom83/Projects/rom-tools/support/fbneo/FBNeo"
DEPOT1_GIT="https://github.com/libretro/FBNeo.git"

DEPOT2_NAME="FBNeo-extras"
DEPOT2_PATH="/home/gegecom83/Projects/rom-tools/support/fbneo/FBNeo-extras"
DEPOT2_GIT="https://github.com/finalburnneo/FBNeo-extras.git"

DEPOT3_NAME="gtk"
DEPOT3_PATH="/home/gegecom83/.themes/Dracula"
DEPOT3_GIT="https://github.com/dracula/gtk.git"

# Function to sync (clone or update) a repository
sync_repo() {
    local name=$1
    local path=$2
    local git_url=$3

    echo "=================================================="
    echo " Processing: $name"
    echo "=================================================="

    # Check if the repository already exists
    if [ -d "$path/.git" ]; then
        echo "[+] Repository already exists. Updating..."
        cd "$path" || exit
        git pull --no-rebase --progress "origin"
    else
        echo "[+] Repository not found. Cloning..."
        # Create parent directories if they don't exist
        mkdir -p "$(dirname "$path")"
        git clone "$git_url" "$path"
    fi
    echo -e "Done for $name\n"
}

# Run sync for repository 1
sync_repo "$DEPOT1_NAME" "$DEPOT1_PATH" "$DEPOT1_GIT"

# Run sync for repository 2
sync_repo "$DEPOT2_NAME" "$DEPOT2_PATH" "$DEPOT2_GIT"

# Run sync for repository 3
sync_repo "$DEPOT3_NAME" "$DEPOT3_PATH" "$DEPOT3_GIT"

echo "Everything is up to date!"