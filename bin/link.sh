#!/usr/bin/env bash

# ~/.dotfiles/bin/link-dotfiles.sh
#
# Symlinks dotfiles from the ~/.dotfiles directory to their respective
# locations in the home directory. It will back up existing files.

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

# --- Configuration ---
# List of files/directories to symlink.
# Format: "source_in_dotfiles_repo destination_in_home"
#
# - For files directly in home (e.g., .zshrc): "shell/zshrc .zshrc"
# - For files in .config (e.g., nvim config): "nvim .config/nvim"
#   This will link the entire ~/.dotfiles/nvim directory to ~/.config/nvim
#
# Add your files and directories here:
declare -A LINKS=(
    ["shell/.zshrc"]="$HOME/.zshrc"
    ["shell/.p10k.zsh"]="$HOME/.p10k.zsh"
    # SSH config
    ["ssh/config"]="$HOME/.ssh/config"
    # Git configs
    ["git/gitconfig"]="$HOME/.gitconfig"
    ["git/gitconfig-personal"]="$HOME/.gitconfig-personal"
    ["git/gitconfig-bigleaf"]="$HOME/.gitconfig-bigleaf"
    ["git/gitignore"]="$HOME/.gitignore_global"
    # Zed editor
    ["zed/settings.json"]="$HOME/.config/zed/settings.json"
    # Ghostty terminal
    ["ghostty/config"]="$HOME/.config/ghostty/config"
)

# --- Helper Functions ---
info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# --- Main Logic ---
info "Starting dotfiles symlinking process."
info "Dotfiles directory: $DOTFILES_DIR"
info "Backups will be stored in: $BACKUP_DIR"

mkdir -p "$BACKUP_DIR" # Create backup directory

for src_in_dotfiles in "${!LINKS[@]}"; do
    dest_in_home="${LINKS[$src_in_dotfiles]}"
    full_src_path="$DOTFILES_DIR/$src_in_dotfiles"
    full_dest_path="$dest_in_home" # Destination path is already absolute or relative to $HOME

    info "Processing: $full_src_path -> $full_dest_path"

    # Ensure source file/directory exists in dotfiles repo
    if [ ! -e "$full_src_path" ] && [ ! -L "$full_src_path" ]; then
        warn "Source '$full_src_path' does not exist. Skipping."
        continue
    fi

    # Create parent directory for destination if it doesn't exist
    mkdir -p "$(dirname "$full_dest_path")"

    # Check if destination already exists
    if [ -e "$full_dest_path" ] || [ -L "$full_dest_path" ]; then
        # If it's already a symlink to the correct source, do nothing
        if [ -L "$full_dest_path" ] && [ "$(readlink "$full_dest_path")" = "$full_src_path" ]; then
            info "Already correctly symlinked: $full_dest_path"
            continue
        fi
        # Otherwise, back it up
        info "Backing up existing '$full_dest_path' to '$BACKUP_DIR/'"
        mv "$full_dest_path" "$BACKUP_DIR/" || error "Failed to back up '$full_dest_path'."
    fi

    # Create the symlink
    info "Creating symlink: $full_dest_path -> $full_src_path"
    ln -s "$full_src_path" "$full_dest_path" || error "Failed to create symlink for '$full_dest_path'."
done

info "Symlinking process completed."
info "Old files (if any) are backed up in $BACKUP_DIR"
info "Remember to source your shell config (e.g., 'source ~/.zshrc') if it was updated."
