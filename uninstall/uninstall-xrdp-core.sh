#!/bin/bash
# Uninstall XRDP Core
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs
MARKER="./.installed_xrdp_core"

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}🧹 ${LANG_STEP_UN_XRDP:-Uninstall XRDP Core}${NC}"

if ! dpkg -l | grep -qw xrdp; then
  log_warn "XRDP Core ${LANG_ALREADY_UNINSTALLED:-sudah dihapus!}"
  [ -f "$MARKER" ] && rm -f "$MARKER"
  echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
  read -t 5 -p ""
  exit 0
fi

sudo systemctl stop xrdp xrdp-sesman 2>/dev/null
sudo apt-get remove --purge -y xrdp xorgxrdp
sudo apt-get autoremove -y
sudo rm -rf /etc/xrdp
[ -f "$MARKER" ] && rm -f "$MARKER"

log_ok "XRDP Core ${LANG_STEP_DONE:-Selesai uninstall}"

echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
read -t 5 -p ""