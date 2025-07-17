#!/usr/bin/env bash
# utils/add-xrdp-user.sh — Tambah user XRDP (multi–bahasa + emoji)
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

source ./set/set-language.sh
source ./lib/common.sh

echo -e "${CYAN}${LANG_ADD_XRDP_USER_TITLE}${NC}"
read -r -p "${LANG_ADD_XRDP_USER_PROMPT}" xuser

if id "$xuser" &>/dev/null; then
  echo -e "${YELLOW}${LANG_ADD_XRDP_USER_EXISTS}${NC}"
else
  if sudo adduser --gecos "" "$xuser"; then
    log_ok "${LANG_ADD_XRDP_USER_SUCCESS}"
  else
    log_error "${LANG_ADD_XRDP_USER_FAIL}"
    echo -e "${RED}${LANG_ADD_XRDP_USER_FAIL}${NC}"
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
  echo -e "${RED}${LANG_ADD_XRDP_USER_PASS_FAIL}${NC}"
  exit 1
fi

# Opsi sudo
read -r -p "${LANG_ADD_XRDP_USER_SUDO_PROMPT}" gs
if [[ "$gs" =~ ^[Yy]$ ]]; then
  if sudo usermod -aG sudo "$xuser"; then
    log_ok "${LANG_ADD_XRDP_USER_SUDO_OK}"
  fi
fi

# Ekspor variabel untuk autologin ke session selanjutnya
export XRDP_NEW_USER="$xuser"
export XRDP_NEW_PASS="$xpasswd"

echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -p "${LANG_BACK_TO_MAIN_MENU}"
