#!/usr/bin/env bash
# uninstall/uninstall-batch.sh — Full Uninstall XRDP + Desktop + Tools
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
# Setup logging
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_ERROR="$LOG_DIR/error.log"
mkdir -p "$LOG_DIR"

# ────────────────────────────────────────────────────────────
# Banner
clear
echo -e "${CYAN}========================================================${NC}"
echo -e "  ${LANG_BATCH_UNINSTALL_TITLE}${NC}"
echo -e "${CYAN}========================================================${NC}"
echo

# ────────────────────────────────────────────────────────────
# 1) Stop & kill services
run_step "${LANG_STEP_STOP_SERVICES:-Stopping services}" \
         "bash \"$SCRIPT_DIR/../utils/stop-services.sh\"" || log_error "stop-services.sh failed"
echo

# ────────────────────────────────────────────────────────────
# 2) Uninstall XRDP core
run_step "${LANG_STEP_UNINSTALL_XRDP:-Uninstall XRDP Core}" \
         "bash \"$SCRIPT_DIR/../uninstall-xrdp.sh\"" || log_error "uninstall-xrdp.sh failed"
echo

# ────────────────────────────────────────────────────────────
# 3) Purge Desktop Environment
run_step "${LANG_STEP_UNINSTALL_DESKTOP:-Removing Desktop Environment}" "\
sudo apt-get purge -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils" || log_error "Desktop purge failed"
echo

# ────────────────────────────────────────────────────────────
# 4) Purge additional tools
run_step "${LANG_STEP_UNINSTALL_TOOLS:-Removing additional tools}" "\
sudo apt-get purge -y conky-all xscreensaver flameshot ristretto gnome-software" || log_error "Tools purge failed"
echo

# ────────────────────────────────────────────────────────────
# 5) Autoremove & cleanup
run_step "${LANG_STEP_CLEANUP:-Autoremove & cleanup}" "\
sudo apt-get autoremove -y && sudo apt-get autoclean -y" || log_error "Cleanup failed"
echo

# ────────────────────────────────────────────────────────────
# 6) Remove markers
echo -e "${YELLOW}${LANG_CLEAN_MARKERS:-Cleaning up markers...}${NC}"
rm -f "$SCRIPT_DIR/../.installed_chrome" \
      "$SCRIPT_DIR/../.installed_vlc" \
      "$SCRIPT_DIR/../.installed_vscode_ext" \
      "$SCRIPT_DIR/../marker/batch.json" \
      2>/dev/null || true
echo

# ────────────────────────────────────────────────────────────
# Summary
if [ ! -s "$LOG_ERROR" ]; then
  log_ok "${LANG_BATCH_UNINSTALL_SUCCESS:-✅ Semua komponen berhasil di-uninstall}"
else
  log_error "${LANG_BATCH_UNINSTALL_FAIL:-❌ Beberapa error terjadi saat uninstall}"
  echo -e "${YELLOW}${LANG_CHECK_LOG_FILE:-Periksa log untuk detail:}$LOG_ERROR${NC}"
fi

# ────────────────────────────────────────────────────────────
# Kembali ke main menu
echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU:-Tekan Enter untuk kembali ke menu utama}${NC}"
read -r -t 10 -p ""
```0
