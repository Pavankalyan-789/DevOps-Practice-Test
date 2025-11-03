#!/bin/bash

# ---------------------------------------
# Backup Script with SHA256 Verification
# ---------------------------------------

set -e

# --- LOG FUNCTIONS ---
log_info()  { echo "[INFO] $1"; }
log_success(){ echo "[SUCCESS] $1"; }
log_error() { echo "[ERROR] $1"; }

# --- CHECK ARGUMENT ---
if [ -z "$1" ]; then
    log_error "Usage: ./backup.sh <folder_to_backup>"
    exit 1
fi

SOURCE_FOLDER="$1"
BACKUP_DIR="./backups"

# --- Create backup folder if missing ---
mkdir -p "$BACKUP_DIR"

# --- Timestamp & filenames ---
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"
CHECKSUM_FILE="$BACKUP_FILE.sha256"

# --- Step 1: Create backup ---
log_info "Starting backup of $SOURCE_FOLDER..."
tar -czf "$BACKUP_FILE" "$SOURCE_FOLDER"
log_success "Backup created: $(basename "$BACKUP_FILE")"

# --- Step 2: Generate checksum ---
sha256sum "$BACKUP_FILE" > "$CHECKSUM_FILE"
log_success "Checksum saved: $(basename "$CHECKSUM_FILE")"

# --- Step 3: Verify checksum ---
log_info "Verifying checksum..."
if sha256sum -c "$CHECKSUM_FILE"; then
    log_success "Backup verification successful ✅"
else
    log_error "Backup verification FAILED ❌"
    exit 1
fi
