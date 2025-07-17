#!/usr/bin/env bash
# uninstall/uninstall-xrdp.sh — Uninstall XRDP Core
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOGFILE="$LOG_DIR/error.log"
MARKER="xrdp_core"

mkdir -p "$LOG_DIR"

# Load bahasa & helpers
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# Title
echo -e "${CYAN}${LANG_STEP_UN_XRDP:-Uninstall XRDP Core}${NC}"

# Cek sudah terpasang
if ! dpkg -l | grep -qw xrdp; then
  log_warn "${LANG_ALREADY_UNINSTALLED:-XRDP Core sudah dihapus}"
  write_marker "$MARKER" false 2>/dev/null || true
  exit 0
fi

# Stop services
sudo systemctl stop xrdp xrdp-sesman 2>/dev/null || true

# Uninstall paket XRDP
run_step "${LANG_STEP_UN_XRDP:-Uninstall XRDP Core}" \
         "sudo apt-get remove --purge -y xrdp xorgxrdp" \
         "dpkg -l | grep -qw xrdp"

# Autoremove dependensi
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove unused packages}" "sudo apt-get autoremove -y"

# Hapus direktori & marker
sudo rm -rf /etc/xrdp || true
write_marker "$MARKER" false

log_ok "${LANG_STEP_DONE:-✅ XRDP Core berhasil di-uninstall}"

# Selesai
echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
read -t 5 -p ""
