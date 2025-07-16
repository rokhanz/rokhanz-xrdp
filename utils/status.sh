#!/bin/bash
# utils/status.sh - Cek Status Install/Uninstall
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -e
. ./set/set-language.sh

# ANSI COLORS
CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; NC='\033[0m'

# Daftar paket yang dicek
PKGS=( \
  xrdp xorgxrdp \
  xfce4 gnome-session plasma-desktop \
  google-chrome-stable vlc code conky \
)

clear
echo -e "${CYAN}======================================"
echo -e "   ${LANG_MENU_STATUS:-Status Install/Uninstall}"
echo -e "======================================${NC}\n"

# --- Install Status ---
echo -e "${GREEN}--- Install Status ---${NC}"
for pkg in "${PKGS[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    echo -e "[✔] $pkg"
  else
    echo -e "[ ] $pkg"
  fi
done

echo ""

# --- Uninstall Status ---
echo -e "${RED}--- Uninstall Status ---${NC}"
for pkg in "${PKGS[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    echo -e "[ ] $pkg masih terpasang"
  else
    echo -e "[✔] $pkg sudah terhapus"
  fi
done

echo ""
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU} (tekan Enter atau tunggu 10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh
