#!/bin/bash
# Install Google Chrome (modular, logging, marker)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs
MARKER="./.installed_chrome"

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}🌐 ${LANG_STEP_CHROME:-Install Google Chrome}${NC}"

if [ -f "$MARKER" ]; then
  log_ok "Google Chrome ${LANG_ALREADY_INSTALLED:-sudah terpasang}"
  exit 0
fi

if dpkg -l | grep -qw google-chrome-stable; then
  log_ok "Google Chrome ${LANG_ALREADY_INSTALLED:-sudah terpasang (dari sistem)}"
  touch "$MARKER"
  exit 0
fi

# Proses installasi
sudo apt-get update
wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
if sudo dpkg -i /tmp/chrome.deb; then
  sudo apt-get install -f -y
  touch "$MARKER"
  log_ok "Google Chrome ${LANG_STEP_DONE:-Selesai}"
  sudo rm -f /tmp/chrome.deb
else
  log_error "Google Chrome ${LANG_FAIL_EMOJI:-Gagal install!}"
  sudo rm -f /tmp/chrome.deb
fi

echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
read -t 5 -p ""