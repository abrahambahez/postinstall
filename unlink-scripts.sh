#!/bin/bash

SOURCE_DIR="$HOME/Archivo/postinstall/scripts/"
TARGET_DIR="$HOME/.local/bin"

for script in "$SOURCE_DIR"/*.sh; do
    script_name=$(basename "$script")
    link_path="$TARGET_DIR/$script_name"
    if [ -L "$link_path" ] && [ "$(readlink -- "$link_path")" = "$script" ]; then
        rm "$link_path"
        echo "Unlinked: $script_name"
    fi
done
