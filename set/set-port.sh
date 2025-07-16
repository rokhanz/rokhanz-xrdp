#!/bin/bash
# Set XRDP Port Script
# Author : rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

echo -e "${CYAN}$LANG_INSTALL_STEP_PORT${NC}"

PORT_CONF="/etc/xrdp/xrdp.ini"

# Validasi xrdp.ini
if [ ! -f "$PORT_CONF" ]; then
  log_error "$LANG_SCRIPT_NOT_FOUND: $PORT_CONF"
  exit 1
fi

current_port=$(grep -m1 "^port=" "$PORT_CONF" | cut -d= -f2)
echo -e "${CYAN}$LANG_SET_PORT${NC} (default: $current_port)"
read -p "Port [3389]: " new_port
new_port="${new_port:-3389}"

# Validasi port
if ! [[ "$new_port" =~ ^[0-9]+$ ]] || [ "$new_port" -le 1024 ] || [ "$new_port" -ge 65535 ]; then
  log_warn "Invalid port, using 3389"
  new_port=3389
fi

if sudo sed -i "s/^port=.*/port=${new_port}/" "$PORT_CONF"; then
  log_ok "$LANG_STEP_DONE (port: $new_port)"
  # Optional: Update firewall
  if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow "$new_port"/tcp
    sudo ufw reload
  fi
else
  log_error "$LANG_ERROR_FAILED (port: $new_port)"
  exit 1
fi

echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"    
read -r -t 3 -p "${LANG_BACK_TO_MAIN_MENU}"
