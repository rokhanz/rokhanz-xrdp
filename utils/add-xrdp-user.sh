#!/usr/bin/env bash
# utils/add-xrdp-user.sh — Tambah user XRDP (multi–bahasa + emoji)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ANSI colors
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

# Load bahasa & common helpers
source ./set/set-language.sh
source ./lib/common.sh

MARKER="user"   # kita pakai type "user" untuk marker/user.json

# Jika marker sudah ada, skip
if check_marker "$MARKER"; then
  log_warn "${LANG_ADD_XRDP_USER_EXISTS}"
  echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
  read -r -p "${LANG_BACK_TO_MAIN_MENU}"
  exit 0
fi

echo -e "${CYAN}${LANG_ADD_XRDP_USER_TITLE}${NC}"
read -r -p "${LANG_ADD_XRDP_USER_PROMPT}" xuser

if id "$xuser" &>/dev/null; then
  echo -e "${YELLOW}${LANG_ADD_XRDP_USER_EXISTS}${NC}"
else
  if sudo adduser --gecos "" "$xuser"; then
    log_ok "${LANG_ADD_XRDP_USER_SUCCESS}"
  else
    log_error "${LANG_ADD_XRDP_USER_FAIL}"
    exit 1
  fi
fi

# Set password
read -s -r -p "${LANG_ADD_XRDP_USER_PASS_PROMPT}" xpasswd
echo
if echo "$xuser:$xpasswd" | sudo chpasswd; then
  log_ok "${LANG_ADD_XRDP_USER_PASS_SET}"
else
  log_error "${LANG_ADD_XRDP_USER_PASS_FAIL}"
fi

# Opsi sudo
read -r -p "${LANG_ADD_XRDP_USER_SUDO_PROMPT}" gs
if [[ "$gs" =~ ^[Yy]$ ]]; then
  if sudo usermod -aG sudo "$xuser"; then
    log_ok "${LANG_ADD_XRDP_USER_SUDO_OK}"
  else
    log_error "${LANG_ADD_XRDP_USER_FAIL}"
  fi
fi

# Tulis marker supaya tidak ulangi
write_marker "$MARKER" "$xuser"

# Kembali ke menu
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -p "${LANG_BACK_TO_MAIN_MENU}"
