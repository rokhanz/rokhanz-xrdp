#!/bin/bash
# uninstall-batch.sh - Full Uninstall XRDP + Desktop + Tools with Validation
# Author: rokhanz
# Version: 1.0.2
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ANSI colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# Load bahasa dan funngsi umum
source ./set/set-language.sh
source ./lib/common.sh

# Prepare error logging
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir -p logs
error_log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"
}

clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_BATCH_UNINSTALL_TITLE:-Batch Uninstall XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"
echo

# 1) Stop & kill all relevant services
echo -e "${CYAN} Stopping services & killing zombie processes...${NC}"
bash ../utils/stop-services.sh || error_log "stop-services.sh failed"
echo

# 2) Core XRDP uninstall
echo -e "${YELLOW}→ Uninstall XRDP Core...${NC}"
bash ../uninstall-xrdp.sh || error_log "uninstall-xrdp.sh failed"
echo

# 3) Remove Desktop Environment (XFCE4)
echo -e "${YELLOW}→ Removing XFCE4 and related packages...${NC}"
sudo apt purge -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
  || error_log "XFCE4 purge failed"
echo

# 4) Remove additional tools
echo -e "${YELLOW}→ Removing additional tools...${NC}"
sudo apt purge -y conky-all xscreensaver flameshot ristretto gnome-software \
  || error_log "Tools purge failed"
echo

# 5) Autoremove & autoclean
echo -e "${YELLOW}→ Autoremove & cleanup...${NC}"
sudo apt autoremove -y \
  && sudo apt autoclean -y \
  || error_log "Autoremove/autoclean failed"
echo

# 6) Remove markers
echo -e "${YELLOW}→ Cleaning up markers...${NC}"
rm -f ./.installed_batch ../.marker_bot_uptime 2>/dev/null
echo

# 7) Summary
if [ ! -s "$LOG_ERROR" ]; then
  echo -e "${GREEN}${LANG_BATCH_UNINSTALL_SUCCESS:-Semua komponen batch berhasil di-uninstall!}${NC}"
else
  echo -e "${RED}${LANG_BATCH_UNINSTALL_FAIL:-Beberapa error terjadi saat uninstall batch.}${NC}"
  echo -e "${YELLOW}Periksa $LOG_ERROR untuk detail.${NC}"
fi
echo

# 8) Back to main menu
echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU:-Tekan Enter atau tunggu 10 detik untuk kembali ke menu utama}${NC}"
read -t 10 -p ""
