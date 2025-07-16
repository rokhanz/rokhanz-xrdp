#!/bin/bash
# uninstall-deps.sh - Uninstall dependensi dasar XRDP
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅} $1${NC}"; }
log_fail()  { echo -e "${RED}${LANG_FAIL_EMOJI:-❌} $1${NC}"; }
error_log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}== Uninstall Base Dependencies ==${NC}"

DEPS=(wget curl gpg dbus-x11 xauth)

if sudo apt-get remove --purge -y "${DEPS[@]}"; then
  log_ok "${LANG_STEP_DONE:-Selesai} (Base dependencies uninstalled)"
else
  log_fail "Uninstall dependencies gagal!"
  error_log "Uninstall dependencies gagal!"
fi

echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
read -t 5 -p ""
exec bash ./main.sh
