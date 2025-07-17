#!/usr/bin/env bash
# uninstall/uninstall-chrome.sh — Uninstall Google Chrome (modular, logging, marker)
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOGFILE="$LOG_DIR/error.log"
MARKER_FILE="$SCRIPT_DIR/../.installed_chrome"

mkdir -p "$LOG_DIR"

# ────────────────────────────────────────────────────────────
# Load bahasa & helpers
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Title
echo -e "${CYAN}${LANG_STEP_UN_CHROME:-Uninstall Google Chrome}${NC}"

# ────────────────────────────────────────────────────────────
# Skip jika belum terpasang
if ! dpkg -l | grep -qw google-chrome-stable; then
  log_warn "${LANG_ALREADY_UNINSTALLED:-Google Chrome sudah dihapus}"
  rm -f "$MARKER_FILE"
  exit 0
fi

# ────────────────────────────────────────────────────────────
# Uninstall Chrome
run_step "${LANG_STEP_UN_CHROME}" \
         "sudo apt-get remove --purge -y google-chrome-stable" \
         "dpkg -l | grep -qw google-chrome-stable"

# Autoremove sisa paket
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove sisa paket}" \
         "sudo apt-get autoremove -y" \
         ""

# ────────────────────────────────────────────────────────────
# Cleanup sources & temp files
sudo rm -f /etc/apt/sources.list.d/google-chrome.list /tmp/chrome.deb || true

# ────────────────────────────────────────────────────────────
# Hapus marker
rm -f "$MARKER_FILE"

# ────────────────────────────────────────────────────────────
# Selesai
log_ok "${LANG_STEP_DONE:-Selesai uninstall Google Chrome}"
