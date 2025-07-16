#!/bin/bash
# utils/status.sh - Cek Status Install/Uninstall & Proses
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -e
. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; NC='\033[0m'

# Daftar paket yang dicek
PKGS=( \
  xrdp xorgxrdp \
  xfce4 gnome-session plasma-desktop \
  google-chrome-stable vlc code conky \
)

clear
echo -e "${CYAN}======================================"
echo -e "   ${LANG_MENU_STATUS:-📝 Status Install/Uninstall}"
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
    echo -e "[ ] $pkg belum terpasang"
  else
    echo -e "[✔] $pkg sudah terhapus"
  fi
done

echo ""

# --- Running Processes ---
echo -e "${CYAN}--- Running Processes ---${NC}"
# Daemon / service
SERVICES=(xrdp xrdp-sesman conky)
for svc in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$svc"; then
    echo -e "[✔] $svc berjalan"
  else
    echo -e "[ ] $svc tidak berjalan"
  fi
done
# Aplikasi GUI
APPS=(google-chrome-stable vlc code)
for app in "${APPS[@]}"; do
  # cek nama proses tanpa path
  name=$(basename "$app")
  if pgrep -x "$name" >/dev/null 2>&1; then
    echo -e "[✔] $app berjalan"
  else
    echo -e "[ ] $app tidak berjalan"
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
