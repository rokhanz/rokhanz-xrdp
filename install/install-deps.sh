#!/bin/bash
# Install Dependencies (dasar)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }

echo -e "${CYAN}$LANG_INSTALL_STEP_DEPS${NC}"

# --- List dependencies yang umum untuk semua DE & XRDP
PKGS="software-properties-common apt-transport-https wget curl lsb-release ca-certificates gnupg"

# --- Validasi sudah terinstall (anggap minimal 1 sudah ada = skip)
DEPS_INSTALLED=0
for dep in $PKGS; do
  if dpkg -l | grep -qw "$dep"; then
    DEPS_INSTALLED=$((DEPS_INSTALLED+1))
  fi
done

if [ "$DEPS_INSTALLED" -ge 4 ]; then
  log_warn "$LANG_INSTALL_SKIP"
  exit 0
fi

# --- Proses installasi
if sudo apt-get update -y && sudo apt-get install -y $PKGS; then
  log_ok "$LANG_STEP_DONE"
else
  log_error "$LANG_INSTALL_ERROR"
  sudo apt-get -f install -y || true
  sudo dpkg --configure -a || true
  sleep 1
  # Coba ulang install 1x
  if sudo apt-get install -y $PKGS; then
    log_ok "$LANG_STEP_DONE"
    exit 0
  else
    log_error "$LANG_INSTALL_ERROR"
    exit 1
  fi
fi
