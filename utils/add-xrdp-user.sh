#!/bin/bash
# utils/add-xrdp-user.sh - Tambah user XRDP (multi-language + emoji)
# Author: rokhanz
# versi : 1.0.0
# License : MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

echo -e "${CYAN}${LANG_ADD_XRDP_USER_TITLE:-=== 👤 Tambah User XRDP ===}${NC}"
read -p "${LANG_ADD_XRDP_USER_PROMPT:-Masukkan username baru: }" xuser

if id "$xuser" &>/dev/null; then
  echo -e "${YELLOW}${LANG_ADD_XRDP_USER_EXISTS:-⚠️  User $xuser sudah ada.}${NC}"
else
  sudo adduser --gecos "" "$xuser"
  [ $? -eq 0 ] && echo -e "${GREEN}${LANG_ADD_XRDP_USER_SUCCESS:-✅ User $xuser berhasil dibuat.}${NC}" || { echo -e "${RED}${LANG_ADD_XRDP_USER_FAIL:-❌ Gagal membuat user.}${NC}"; exit 1; }
fi

read -s -p "${LANG_ADD_XRDP_USER_PASS_PROMPT:-Masukkan password: }" xpasswd
echo
echo "$xuser:$xpasswd" | sudo chpasswd
[ $? -eq 0 ] && echo -e "${GREEN}${LANG_ADD_XRDP_USER_PASS_SET:-✅ Password diset.}${NC}" || echo -e "${RED}${LANG_ADD_XRDP_USER_PASS_FAIL:-❌ Gagal set password.}${NC}"

read -p "${LANG_ADD_XRDP_USER_SUDO_PROMPT:-Tambah user ke sudo group? (y/n): }" gs
if [[ "$gs" =~ ^[Yy]$ ]]; then
  sudo usermod -aG sudo "$xuser"
  echo -e "${GREEN}${LANG_ADD_XRDP_USER_SUDO_OK:-✅ User $xuser ditambahkan ke group sudo.}${NC}"
fi

export XRDP_NEW_USER="$xuser"
