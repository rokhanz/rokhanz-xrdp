#!/bin/bash
# Uninstall VLC (modular, logging, marker)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs
MARKER="./.installed_vlc"

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}🧹 ${LANG_STEP_UN_VLC:-Uninstall VLC}${NC}"

if ! dpkg -l | grep -qw vlc; then
  log_warn "VLC ${LANG_ALREADY_UNINSTALLED:-sudah dihapus!}"
  [ -f "$MARKER" ] && rm -f "$MARKER"
  echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
  read -t 5 -p ""
  exit 0
fi

sudo apt-get remove --purge -y vlc
sudo apt-get autoremove -y
[ -f "$MARKER" ] && rm -f "$MARKER"

if ! dpkg -l | grep -qw vlc; then
  log_ok "VLC ${LANG_STEP_DONE:-Selesai uninstall}"
else
  log_error "VLC gagal dihapus!"
fi

echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
read -t 5 -p ""