#!/bin/bash

set -e

# ══════════════════════════════════════════════════════════════
#  CONFIGURATION
# ══════════════════════════════════════════════════════════════

CORE_URL="https://buildbot.libretro.com/nightly/linux/x86_64/latest/fbneo_libretro.so.zip"
CORE_DIR="/home/gegecom83/.config/retroarch/cores"

REPOS=(
    "FBNeo|/home/gegecom83/Projects/rom-tools/support/fbneo/FBNeo|https://github.com/libretro/FBNeo.git"
    "FBNeo-extras|/home/gegecom83/Projects/rom-tools/support/fbneo/FBNeo-extras|https://github.com/finalburnneo/FBNeo-extras.git"
    "gtk|/home/gegecom83/.themes/Dracula|https://github.com/dracula/gtk.git"
)

# ══════════════════════════════════════════════════════════════
#  FUNCTIONS
# ══════════════════════════════════════════════════════════════

update_core() {
    echo "══════════════════════════════════════════════════════"
    echo "  Buildbot: FBNeo Libretro Core"
    echo "══════════════════════════════════════════════════════"

    local zip_file="/tmp/fbneo_libretro.so.zip"
    local tmp_dir
    tmp_dir=$(mktemp -d)
    local local_core="$CORE_DIR/fbneo_libretro.so"

    echo "Checking latest FBNeo core version..."

    local remote_date
    remote_date=$(curl -sI "$CORE_URL" | grep -i '^last-modified:' | sed 's/Last-Modified: //I' | tr -d '\r')

    if [ -z "$remote_date" ]; then
        echo "ERROR: Failed to get remote Last-Modified header"
        rm -rf "$tmp_dir"
        return 1
    fi

    echo "Remote build date: $remote_date"

    local remote_ts
    remote_ts=$(date -d "$remote_date" +%s 2>/dev/null || true)

    if [ -z "$remote_ts" ]; then
        echo "ERROR: Failed to parse remote date: $remote_date"
        rm -rf "$tmp_dir"
        return 1
    fi

    if [ -f "$local_core" ]; then
        local local_ts
        local_ts=$(stat -c %Y "$local_core")

        if [ "$remote_ts" -le "$local_ts" ]; then
            echo "FBNeo core is already up to date."
            rm -rf "$tmp_dir"
            return 0
        fi
    fi

    echo "New version found. Downloading..."
    curl -L --progress-bar -o "$zip_file" "$CORE_URL"

    echo "Extracting..."
    unzip -oq "$zip_file" -d "$tmp_dir"

    echo "Backing up old core..."
    mkdir -p "$CORE_DIR/backup"
    if [ -f "$local_core" ]; then
        cp "$local_core" "$CORE_DIR/backup/fbneo_libretro.so.$(date +%Y%m%d_%H%M%S)"
    fi

    echo "Installing..."
    install -m 755 "$tmp_dir/fbneo_libretro.so" "$local_core"
    touch -d "$remote_date" "$local_core"

    rm -f "$zip_file"
    rm -rf "$tmp_dir"

    echo "Done ✔ FBNeo core updated"
}

sync_repo() {
    local name=$1
    local path=$2
    local git_url=$3

    echo "══════════════════════════════════════════════════════"
    echo "  Repository: $name"
    echo "══════════════════════════════════════════════════════"

    if [ -d "$path/.git" ]; then
        echo "[+] Repository already exists. Updating..."
        cd "$path" || return 1
        git pull --no-rebase --progress origin
    else
        echo "[+] Repository not found. Cloning..."
        mkdir -p "$(dirname "$path")"
        git clone "$git_url" "$path"
    fi

    echo -e "Done ✔ $name\n"
}

# ══════════════════════════════════════════════════════════════
#  MAIN
# ══════════════════════════════════════════════════════════════

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║             Update Buildbot & Repositories             ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# 1. Update RetroArch core
update_core

echo ""

# 2. Sync repositories
for entry in "${REPOS[@]}"; do
    IFS='|' read -r name path git_url <<< "$entry"
    sync_repo "$name" "$path" "$git_url"
done

echo "╔════════════════════════════════════════════════════════╗"
echo "║             Everything is up to date! ✔                ║"
echo "╚════════════════════════════════════════════════════════╝"
