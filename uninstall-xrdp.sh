#!/bin/bash
# Uninstall XRDP & Semua Komponen (validasi PID/zombie, marker, logging)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs

error_log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_UNINSTALL_ALL_TITLE:-❌ Uninstall XRDP & Semua Komponen}"
echo -e "========================================================${NC}"

# Step 1: Cek & hentikan proses zombie / PID tools/desktop/xrdp
echo -e "${CYAN}🛑 Stopping services & killing zombie processes...${NC}"
for svc in xrdp xrdp-sesman conky code code-oss vlc chrome google-chrome; do
  if pgrep "$svc" >/dev/null 2>&1; then
    sudo killall -9 "$svc" 2>/dev/null && echo -e "${GREEN}Killed process: $svc${NC}" || true
  fi
  sudo systemctl stop "$svc" 2>/dev/null || true
done

# Step 2: Modular Uninstall (semua uninstall-*.sh)
for f in ./uninstall/uninstall-*.sh; do
  if [ -f "$f" ]; then
    bash "$f" || error_log "Failed $f"
  fi
done

# Step 3: Hapus marker/flag
rm -f .installed_* 2>/dev/null

echo -e "${GREEN}${LANG_UNINSTALL_DONE:-Uninstall selesai!}${NC}"
echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU} (10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh