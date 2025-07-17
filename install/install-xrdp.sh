#!/usr/bin/env bash
# install/install-all-core.sh — XRDP + Desktop Environment Installer (Core)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Tentukan direktori skrip ini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Muat bahasa & fungsi umum (run_step, log_ok, log_warn, log_error)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Tampilkan judul dan langkah awal
clear
echo -e "${CYAN}${LANG_INSTALL_TITLE}${NC}"
echo -e "${CYAN}${LANG_INSTALL_START}${NC}"
echo

# ────────────────────────────────────────────────────────────
# 1) Install dependencies
run_step "${LANG_INSTALL_STEP_DEPS}" "$SCRIPT_DIR/install-deps.sh"

# ────────────────────────────────────────────────────────────
# 2) Install desktop environment (skip jika sudah terpasang)
run_step "${LANG_INSTALL_STEP_DESKTOP}" \
         "$SCRIPT_DIR/install-desktop.sh" \
         "dpkg -l | grep -E -q 'xfce4|gnome-session|plasma-desktop|ubuntu-desktop'"

# ────────────────────────────────────────────────────────────
# 3) Install XRDP core
run_step "${LANG_INSTALL_STEP_XRDP}" \
         "$SCRIPT_DIR/install-xrdp-core.sh"

# ────────────────────────────────────────────────────────────
# 4) Set timezone
run_step "${LANG_INSTALL_STEP_TIMEZONE}" \
         "$SCRIPT_DIR/../set/set-timezone.sh"

# ────────────────────────────────────────────────────────────
# 5) Set port
run_step "${LANG_INSTALL_STEP_PORT}" \
         "$SCRIPT_DIR/../set/set-port.sh"

# ────────────────────────────────────────────────────────────
# 6) Konfigurasi tambahan
run_step "${LANG_INSTALL_STEP_CONFIG}" \
         "$SCRIPT_DIR/../set/set-config.sh"

# ────────────────────────────────────────────────────────────
# Ringkasan hasil
echo
if [ "$error_count" -eq 0 ]; then
  log_ok "${LANG_INSTALL_SUCCESS}"
  echo -e "${CYAN}${LANG_INSTALL_NEXT_STEP}${NC}"
else
  log_warn "${LANG_INSTALL_ERROR} ($error_count errors)"
fi

# ────────────────────────────────────────────────────────────
# Kembali ke menu utama
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -t 3 -p "${LANG_BACK_TO_MAIN_MENU}"
