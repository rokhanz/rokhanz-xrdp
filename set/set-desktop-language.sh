#!/usr/bin/env bash
# Set Desktop (XRDP GUI session) Language
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

. ./set/set-language.sh 2>/dev/null || true

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

clear
echo -e "${CYAN}${LANG_SET_DESKTOP_LANG:-Set Desktop Language}${NC}"
echo "1. English (en_US.UTF-8)"
echo "2. Indonesia (id_ID.UTF-8)"
read -r -p "${LANG_MENU_PROMPT:-Pilih/Choose (1/2): }" lang_choice

case "$lang_choice" in
  2) DESKTOP_LANG="id_ID.UTF-8" ;;
  *) DESKTOP_LANG="en_US.UTF-8" ;;
esac

# Untuk user baru (skel)
SKEL_PAM="/etc/skel/.pam_environment"
sudo bash -c "echo 'LANG=$DESKTOP_LANG' > $SKEL_PAM && echo 'LANGUAGE=${DESKTOP_LANG%%.*}' >> $SKEL_PAM"

# Untuk user yang sedang aktif (bukan root, jika pakai sudo)
if [ "${SUDO_USER:-}" ] && [ "${SUDO_USER:-}" != "root" ]; then
  USER_HOME=$(eval echo "~$SUDO_USER")
  # Patch file tanpa hapus data lain (safe)
  {
    grep -v '^LANG=' "$USER_HOME/.pam_environment" 2>/dev/null || true
    echo "LANG=$DESKTOP_LANG"
    grep -v '^LANGUAGE=' "$USER_HOME/.pam_environment" 2>/dev/null || true
    echo "LANGUAGE=${DESKTOP_LANG%%.*}"
  } > "$USER_HOME/.pam_environment.tmp"
  mv "$USER_HOME/.pam_environment.tmp" "$USER_HOME/.pam_environment"
  chown "$SUDO_USER":"$SUDO_USER" "$USER_HOME/.pam_environment"
  log_ok "$LANG_SET_SUCCESS (user: $SUDO_USER, $DESKTOP_LANG)"
else
  log_ok "$LANG_SET_SUCCESS (default: $DESKTOP_LANG)"
  echo -e "${YELLOW}Catatan: Silakan logout dan login ulang agar bahasa desktop berubah.${NC}"
fi
