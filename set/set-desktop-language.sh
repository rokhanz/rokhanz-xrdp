#!/bin/bash
# Set Desktop (XRDP GUI session) Language
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

clear
echo -e "${CYAN}${LANG_SET_DESKTOP_LANG}${NC}"
echo "1. English (en_US.UTF-8)"
echo "2. Indonesia (id_ID.UTF-8)"
read -p "Pilih/Choose (1/2): " lang_choice

case "$lang_choice" in
  2) DESKTOP_LANG="id_ID.UTF-8" ;;
  *) DESKTOP_LANG="en_US.UTF-8" ;;
esac

# Set ke semua user baru (di /etc/skel)
echo "LANG=$DESKTOP_LANG"  | sudo tee /etc/skel/.pam_environment >/dev/null
echo "LANGUAGE=${DESKTOP_LANG%%.*}" | sudo tee -a /etc/skel/.pam_environment >/dev/null

# Set ke user saat ini (jika bukan root)
if [ "$SUDO_USER" ] && [ "$SUDO_USER" != "root" ]; then
  USER_HOME=$(eval echo "~$SUDO_USER")
  echo "LANG=$DESKTOP_LANG" > "$USER_HOME/.pam_environment"
  echo "LANGUAGE=${DESKTOP_LANG%%.*}" >> "$USER_HOME/.pam_environment"
  chown "$SUDO_USER":"$SUDO_USER" "$USER_HOME/.pam_environment"
  log_ok "$LANG_SET_SUCCESS (user: $SUDO_USER, $DESKTOP_LANG)"
else
  log_ok "$LANG_SET_SUCCESS (default: $DESKTOP_LANG)"
  echo "Catatan: Silakan logout dan login ulang agar bahasa berubah."
fi

echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU} (tekan Enter atau tunggu 10 detik)${NC}"
read -t -t 5 -p ""
