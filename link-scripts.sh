#!/bin/bash

SOURCE_DIR="$HOME/Archivo/postinstall/scripts/"
TARGET_DIR="$HOME/.local/bin"

# Check if ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "❌ ERROR: $HOME/.local/bin is not in your PATH."
    echo "➜ Add the following line to your ~/.zshrc (or ~/.bashrc):"
    echo '    export PATH="$HOME/.local/bin:$PATH"'
    echo "Then run: source ~/.zshrc"
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Link scripts
for script in "$SOURCE_DIR"/*.sh; do
    script_name=$(basename "$script")
    ln -sf "$script" "$TARGET_DIR/$script_name"
    echo "✅ Linked: $script_name"
done
