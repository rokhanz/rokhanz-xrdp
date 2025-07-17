#!/usr/bin/env bash
# uninstall/uninstall-all.sh — Uninstall XRDP & Semua Komponen
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Paths & helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/error.log"
mkdir -p "$LOG_DIR"

# Load bahasa & helper
source "$SCRIPT_DIR/../set/set-language.sh" 2>/dev/null || true
source "$SCRIPT_DIR/../lib/common.sh" 2>/dev/null || true

# ANSI COLORS
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

# Banner
clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_UNINSTALL_ALL_TITLE:-❌ Uninstall XRDP & Semua Komponen}"
echo -e "========================================================${NC}"
echo

# Step 1: Stop services & kill zombies
echo -e "${CYAN}${LANG_UNINSTALL_STOP_SERVICES:-Stopping services & killing zombie processes...}${NC}"
bash "$SCRIPT_DIR/../utils/stop-services.sh" || log_error "stop-services.sh failed"
echo

# Step 2: Run every uninstall-*.sh under ./uninstall/
echo -e "${CYAN}${LANG_UNINSTALL_MODULAR:-Menjalankan semua modular uninstall...}${NC}"
for f in "$SCRIPT_DIR"/uninstall-*.sh; do
  [ -f "$f" ] || continue
  bash "$f" || log_error "Failed: $f"
done
echo

# Step 3: Remove marker flags
rm -f "$SCRIPT_DIR"/../.installed_* 2>/dev/null || true

# Selesai
echo -e "${GREEN}${LANG_UNINSTALL_DONE:-Uninstall selesai!}${NC}"
echo -e "${CYAN}↩️ ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (10 detik)${NC}"
read -t 10 -p ""
