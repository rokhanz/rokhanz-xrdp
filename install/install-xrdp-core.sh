#!/bin/bash
# Install XRDP Core
# Author : rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }

echo -e "${CYAN}$LANG_INSTALL_STEP_XRDP${NC}"

# --- Validasi sudah terinstall
if dpkg -l | grep -qw xrdp; then
  log_warn "XRDP $LANG_INSTALL_SKIP"
  exit 0
fi

if sudo apt-get install -y xrdp xorgxrdp; then
  log_ok "XRDP $LANG_STEP_DONE"
else
  log_error "XRDP $LANG_INSTALL_ERROR"
  sudo apt-get -f install -y || true
  sudo dpkg --configure -a || true
  sleep 1
  if sudo apt-get install -y xrdp xorgxrdp; then
    log_ok "XRDP $LANG_STEP_DONE"
    exit 0
  else
    log_error "XRDP $LANG_INSTALL_ERROR"
    exit 1
  fi
fi
