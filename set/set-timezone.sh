#!/bin/bash
# Set Timezone Script
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

clear
echo -e "${CYAN}${LANG_SET_TIMEZONE}${NC}"

while true; do
  echo "1. Asia/Jakarta"
  echo "2. UTC"
  echo "3. Manual input"
  read -p "Pilihan/Choice (1/2/3): " tz_choice

  case "$tz_choice" in
    1) timezone="Asia/Jakarta" ;;
    2) timezone="UTC" ;;
    3)
      while true; do
        read -p "Timezone manual (ex: Asia/Makassar): " timezone
        # Cek valid timezone
        if [ -n "$timezone" ] && timedatectl list-timezones | grep -Fxq "$timezone"; then
          break
        else
          log_warn "Timezone tidak valid! Silakan cek di 'timedatectl list-timezones' dan ulangi input."
        fi
      done
      ;;
    *)
      timezone="UTC"
      ;;
  esac

  if [ -n "$timezone" ]; then
    if sudo timedatectl set-timezone "$timezone"; then
      log_ok "$LANG_SET_SUCCESS ($timezone)"
      break
    else
      log_error "$LANG_SET_FAIL (timezone: $timezone)"
      sleep 1
    fi
  else
    log_warn "$LANG_WARNING_ALREADY_INSTALLED"
    break
  fi
done

echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU} (3 detik)${NC}"
sleep 3