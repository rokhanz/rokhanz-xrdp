#!/usr/bin/env bash
# uninstall/uninstall-conky.sh — Uninstall Conky (VPS Info) + Config & Autostart
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Direktori skrip ini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Muat bahasa & helper umum (run_step, log_ok, log_warn, log_error, check_marker, write_marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Tampilkan judul
echo -e "${CYAN}${LANG_STEP_UN_CONKY:-Uninstall Conky & Config}${NC}"

# ────────────────────────────────────────────────────────────
# Marker untuk Conky
MARKER="conky"

# 1) Uninstall paket Conky jika terpasang
run_step "${LANG_STEP_UN_CONKY:-Remove Conky packages}" \
         "sudo apt-get remove --purge -y conky conky-all conky-std" \
         "dpkg -l | grep -qw conky" || log_warn "${LANG_ALREADY_UNINSTALLED}"

# 2) Autoremove dependensi yang tidak terpakai
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove unused packages}" \
         "sudo apt-get autoremove -y"

# ────────────────────────────────────────────────────────────
# 3) Hapus konfigurasi dan autostart di skeleton dan home users
echo -e "${CYAN}${LANG_STEP_CLEAN_CONFIG:-Cleaning config & autostart files}${NC}"
sudo rm -rf /etc/skel/.config/conky \
            /etc/skel/.config/autostart/conky.desktop || true

for home in /home/*; do
  sudo rm -rf "$home/.config/conky" \
               "$home/.config/autostart/conky.desktop" || true
done

# ────────────────────────────────────────────────────────────
# 4) Hapus marker
write_marker "$MARKER" false 2>/dev/null || true

# ────────────────────────────────────────────────────────────
# Selesai
log_ok "${LANG_STEP_DONE:-✅  Uninstall Conky & Config selesai}"
