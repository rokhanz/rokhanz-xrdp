#!/bin/bash
# Install Desktop Environment
# Author : rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }

echo -e "${CYAN}$LANG_INSTALL_STEP_DESKTOP${NC}"

# --- Pilihan Desktop Environment (via ENV atau default xfce4)
DE_CHOICE="${DE_CHOICE:-xfce4}"

case "$DE_CHOICE" in
  xfce4)
    PKGS="xfce4 xfce4-goodies xorg dbus-x11 xauth"
    CHECK="dpkg -l | grep -qw xfce4"
    DE_LABEL="XFCE4"
    ;;
  plasma)
    PKGS="plasma-desktop kde-standard"
    CHECK="dpkg -l | grep -qw plasma-desktop"
    DE_LABEL="KDE Plasma"
    ;;
  gnome)
    PKGS="gnome-session gdm3 ubuntu-desktop"
    CHECK="dpkg -l | grep -qw gnome-session"
    DE_LABEL="GNOME"
    ;;
  *)
    log_error "$LANG_ERROR_FAILED Desktop Environment: $DE_CHOICE"
    exit 1
    ;;
esac

# --- Validasi sudah install
if eval "$CHECK"; then
  log_warn "$DE_LABEL $LANG_INSTALL_SKIP"
  exit 0
fi

if sudo apt-get install -y $PKGS; then
  log_ok "$DE_LABEL $LANG_STEP_DONE"
else
  log_error "$DE_LABEL $LANG_INSTALL_ERROR"
  sudo apt-get -f install -y || true
  sudo dpkg --configure -a || true
  sleep 1
  # Coba ulang install 1x
  if sudo apt-get install -y $PKGS; then
    log_ok "$DE_LABEL $LANG_STEP_DONE"
    exit 0
  else
    log_error "$DE_LABEL $LANG_INSTALL_ERROR"
    exit 1
  fi
fi

exit 0