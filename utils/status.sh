#!/usr/bin/env bash
# utils/status.sh - Cek Status Install/Uninstall & Proses
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Load bahasa
source ./set/set-language.sh 2>/dev/null || true

# ANSI COLORS
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Daftar paket yang dicek
PKGS=(xrdp xorgxrdp xfce4 gnome-session plasma-desktop google-chrome-stable vlc code conky)

clear
echo -e "${CYAN}======================================"
echo -e "   ${LANG_MENU_STATUS:-📝 Status Install/Uninstall}"
echo -e "======================================${NC}\n"

# --- Install Status ---
echo -e "${GREEN}${LANG_STATUS_INSTALL:---- Install Status ---}${NC}"
for pkg in "${PKGS[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    echo -e "[✔] $pkg"
  else
    echo -e "[ ] $pkg"
  fi
done

echo ""

# --- Uninstall Status ---
echo -e "${RED}${LANG_STATUS_UNINSTALL:---- Uninstall Status ---}${NC}"
for pkg in "${PKGS[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    echo -e "[ ] $pkg ${LANG_STATUS_NOT_REMOVED:-belum terhapus}"
  else
    echo -e "[✔] $pkg ${LANG_STATUS_REMOVED:-sudah terhapus}"
  fi
done

echo ""

# --- Running Processes ---
echo -e "${CYAN}${LANG_STATUS_PROC:---- Running Processes ---}${NC}"
SERVICES=(xrdp xrdp-sesman conky)
for svc in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$svc" 2>/dev/null; then
    echo -e "[✔] $svc ${LANG_STATUS_RUNNING:-berjalan}"
  else
    echo -e "[ ] $svc ${LANG_STATUS_NOT_RUNNING:-tidak berjalan}"
  fi
done
APPS=(google-chrome-stable vlc code)
for app in "${APPS[@]}"; do
  name=$(basename "$app")
  if pgrep -x "$name" >/dev/null 2>&1; then
    echo -e "[✔] $app ${LANG_STATUS_RUNNING:-berjalan}"
  else
    echo -e "[ ] $app ${LANG_STATUS_NOT_RUNNING:-tidak berjalan}"
  fi
done

echo ""

# --- Zombie Processes ---
zombie_count=$(ps aux | awk '$8=="Z"{count++} END{print count+0}')
if [ "$zombie_count" -gt 0 ]; then
  echo -e "${YELLOW}⚠️  Zombie Process Detected: $zombie_count${NC}"
  echo -e "    👉 Gunakan: ps aux | grep Z  &  sudo kill -9 <PID>"
else
  echo -e "${GREEN}🟢 Tidak ada zombie process${NC}"
fi

echo
echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU:-Tekan Enter untuk kembali}${NC}"
read -r -p ""
