#!/usr/bin/env bash
# Set XRDP Port Script
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

PORT_CONF="/etc/xrdp/xrdp.ini"

# Validasi file xrdp.ini
if [ ! -f "$PORT_CONF" ]; then
  log_error "${LANG_SCRIPT_NOT_FOUND:-Config file tidak ditemukan}: $PORT_CONF"
  return 1 2>/dev/null || exit 1
fi

current_port=$(grep -m1 "^port=" "$PORT_CONF" | cut -d= -f2)
[ -z "$current_port" ] && current_port=3389

echo -e "${CYAN}${LANG_SET_PORT:-Set XRDP Port}${NC} (${LANG_CURRENT_PORT:-Current}: $current_port)"
read -r -p "Port [3389]: " new_port
new_port="${new_port:-$current_port}"

# Validasi port (hanya digit & range 1025-65534)
if ! [[ "$new_port" =~ ^[0-9]+$ ]] || [ "$new_port" -le 1024 ] || [ "$new_port" -ge 65535 ]; then
  log_warn "${LANG_WARN_INVALID_PORT:-Port tidak valid, kembali ke default 3389}"
  new_port=3389
fi

if sudo sed -i "s/^port=.*/port=${new_port}/" "$PORT_CONF"; then
  log_ok "${LANG_STEP_DONE:-Selesai} (port: $new_port)"
  # Opsional: Update firewall otomatis (jika ufw aktif)
  if command -v ufw >/dev/null 2>&1 && sudo ufw status | grep -qw active; then
    sudo ufw allow "$new_port"/tcp
    sudo ufw reload
    log_ok "${LANG_STEP_DONE:-Firewall dibuka di port} $new_port"
  fi
else
  log_error "${LANG_ERROR_FAILED:-Gagal mengubah port} ($new_port)"
fi

# Pause
echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Tekan Enter untuk kembali}${NC}"
read -r -p ""
