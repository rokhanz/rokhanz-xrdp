#!/bin/bash
# XRDP + Desktop Environment Installer (Core)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

# Muat terjemahan & warna
./set/set-language.sh
[ -z "$LANG_INSTALL_START" ] && choose_language
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

error_count=0

log_error() {
  echo -e "${RED}${LANG_FAIL_EMOJI:-❌} $1${NC}"
  ((error_count++))
}
log_warn() {
  echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️} $1${NC}"
}
log_ok() {
  echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅} $1${NC}"
}

run_step() {
  local desc="$1"
  local script="$2"
  local check_installed="$3"

  echo -e "${CYAN}$desc${NC}"

  # --- Skip jika sudah terinstall (hanya jika param ketiga diberikan)
  if [ -n "$check_installed" ]; then
    if eval "$check_installed" >/dev/null 2>&1; then
      log_warn "$LANG_INSTALL_SKIP"
      return
    fi
  fi

  # --- Jalankan script step
  if [ -f "$script" ]; then
    if bash "$script"; then
      log_ok "$LANG_STEP_DONE"
    else
      log_error "$LANG_INSTALL_ERROR"
      sudo apt-get -f install -y || true
      sudo dpkg --configure -a || true
      sleep 1
      log_warn "$LANG_INSTALL_TROUBLE"
    fi
  else
    log_warn "$LANG_SCRIPT_NOT_FOUND: $script"
  fi

  sleep 1
}

clear
echo -e "${CYAN}$LANG_INSTALL_TITLE${NC}"
echo -e "${CYAN}$LANG_INSTALL_START${NC}"

# Jalankan langkah instalasi
echo
run_step "$LANG_INSTALL_STEP_DEPS" ./install/install-deps.sh
run_step "$LANG_INSTALL_STEP_DESKTOP" ./install/install-desktop.sh "dpkg -l | grep -E -q 'xfce4|plasma-desktop|ubuntu-desktop|gnome-session'"
# Berikut ini sudah tanpa validasi pengecekan, sehingga wajib jalan
run_step "$LANG_INSTALL_STEP_XRDP" ./install/install-xrdp-core.sh
run_step "$LANG_INSTALL_STEP_TIMEZONE" ./set/set-timezone.sh
run_step "$LANG_INSTALL_STEP_PORT" ./set/set-port.sh
run_step "$LANG_INSTALL_STEP_CONFIG" ./set/set-config.sh

echo
# Ringkasan hasil
if [ "$error_count" -eq 0 ]; then
  log_ok "$LANG_INSTALL_SUCCESS"
  echo -e "${CYAN}$LANG_INSTALL_NEXT_STEP${NC}"
else
  log_warn "$LANG_INSTALL_ERROR ($error_count error)"
fi

echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -t 3 -p "${LANG_BACK_TO_MAIN_MENU}"
