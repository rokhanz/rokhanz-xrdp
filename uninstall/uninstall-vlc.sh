#!/usr/bin/env bash
# uninstall/uninstall-vlc.sh — Uninstall VLC media player (modular, logging, marker)
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/error.log"
MARKER="vlc"

mkdir -p "$LOG_DIR"

# ────────────────────────────────────────────────────────────
# Load bahasa & common helpers
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Title
echo -e "${CYAN}${LANG_STEP_UN_VLC:-Uninstall VLC}${NC}"

# ────────────────────────────────────────────────────────────
# Skip jika VLC tidak terpasang
if ! dpkg -l | grep -qw vlc; then
  log_warn "${LANG_ALREADY_UNINSTALLED:-VLC sudah dihapus}"
  write_marker "$MARKER" false 2>/dev/null || true
  exit 0
fi

# ────────────────────────────────────────────────────────────
# Uninstall VLC
run_step "${LANG_STEP_UN_VLC:-Uninstall VLC}" \
         "sudo apt-get remove --purge -y vlc" \
         "dpkg -l | grep -qw vlc"

# ────────────────────────────────────────────────────────────
# Autoremove leftover packages
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove unused packages}" \
         "sudo apt-get autoremove -y"

# ────────────────────────────────────────────────────────────
# Hapus marker
write_marker "$MARKER" false

# ────────────────────────────────────────────────────────────
# Selesai
log_ok "${LANG_STEP_DONE:-✅  VLC berhasil di-uninstall}"
