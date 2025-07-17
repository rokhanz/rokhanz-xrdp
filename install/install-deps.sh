#!/usr/bin/env bash
# install/install-deps.sh — Install Dependencies (dasar)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Load bahasa & common helpers
source "$(dirname "$0")/../set/set-language.sh"
source "$(dirname "$0")/../lib/common.sh"

# Mulai langkah instalasi
echo -e "${CYAN}${LANG_INSTALL_STEP_DEPS}${NC}"

# Daftar paket
PKGS=(software-properties-common apt-transport-https wget curl lsb-release ca-certificates gnupg)

# Cek berapa paket yang sudah terpasang
installed=0
for pkg in "${PKGS[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    ((installed++))
  fi
done

# Jika sudah terpasang cukup banyak, skip
if [ "$installed" -ge 4 ]; then
  log_warn "${LANG_INSTALL_SKIP}"
  exit 0
fi

# Update & install
if sudo apt-get update -y \
   && sudo apt-get install -y "${PKGS[@]}"; then

  log_ok "${LANG_STEP_DONE}"

else
  # Gagal instalasi pertama, coba perbaiki dependency lalu ulang
  log_error "${LANG_INSTALL_ERROR}"
  sudo apt-get -f install -y || true
  sudo dpkg --configure -a     || true

  if sudo apt-get install -y "${PKGS[@]}"; then
    log_ok "${LANG_STEP_DONE}"
  else
    log_error "${LANG_INSTALL_ERROR}"
    exit 1
  fi
fi
