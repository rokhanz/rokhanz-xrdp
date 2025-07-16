#!/bin/bash
# Uninstall XRDP & Semua Komponen (validasi PID/zombie, marker, logging)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -e

# Source language strings (fallback silently if missing)
. ./set/set-language.sh 2>/dev/null || true

# ANSI COLORS
CYAN='\033[0;36m'; RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

# Prepare error logging
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs
error_log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"
}

clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_UNINSTALL_ALL_TITLE:-❌ Uninstall XRDP & Semua Komponen}"
echo -e "========================================================${NC}"
echo

# Step 1: Stop services & kill zombies
echo -e "${CYAN} Stopping services & killing zombie processes...${NC}"
bash utils/stop-services.sh || error_log "stop-services.sh failed"
echo

# Step 2: Run every uninstall-*.sh under ./uninstall/
echo -e "${CYAN} Running modular uninstall scripts...${NC}"
for f in ./uninstall/uninstall-*.sh; do
  [ -f "$f" ] || continue
  bash "$f" || error_log "Failed: $f"
done
echo

# Step 3: Remove marker flags
rm -f .installed_* 2>/dev/null

echo -e "${GREEN}${LANG_UNINSTALL_DONE:-Uninstall selesai!}${NC}"
echo -e "${CYAN}↩️ ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh
