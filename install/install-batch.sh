#!/usr/bin/env bash
# install/install-batch.sh — Batch Install XRDP + Desktop + Tools
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Tentukan direktori skrip
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Muat bahasa & fungsi umum (run_step, log_*, check_marker, write_marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

clear
echo -e "${CYAN}========================================================"
echo -e "  ${LANG_BATCH_INSTALL_TITLE}"
echo -e "========================================================${NC}"

# Langkah 1: Install dependensi dasar
run_step "${LANG_STEP_DEPS}" "$SCRIPT_DIR/install-deps.sh"

# Langkah 2: Install desktop environment
run_step "${LANG_STEP_DESKTOP}" \
         "$SCRIPT_DIR/install-desktop.sh" \
         "xfce4|gnome-session|plasma-desktop"

# Langkah 3: Install XRDP core
run_step "${LANG_STEP_XRDP}" \
         "$SCRIPT_DIR/install-xrdp-core.sh" \
         "xrdp|xorgxrdp"

# Langkah 4: Install Google Chrome
run_step "${LANG_STEP_CHROME}" \
         "$SCRIPT_DIR/install-chrome.sh" \
         "google-chrome-stable"

# Langkah 5: Install VLC
run_step "${LANG_STEP_VLC}" \
         "$SCRIPT_DIR/install-vlc.sh" \
         "vlc"

# Langkah 6: Install VSCode
run_step "${LANG_STEP_VSCODE}" \
         "$SCRIPT_DIR/install-vscode.sh" \
         "code"

# Langkah 7: Konfigurasi tambahan (Conky, etc.)
run_step "${LANG_STEP_CONFIG}" \
         "$SCRIPT_DIR/../set/set-config.sh"

# Ringkasan & penanda sukses
if [ "$error_count" -eq 0 ]; then
  write_marker batch success all
  log_ok "${LANG_BATCH_SUCCESS}"
else
  log_error "${LANG_BATCH_FAIL} ($error_count errors)"
  echo -e "${YELLOW}${LANG_CHECK_LOG}:${NC} $LOG_FILE"
fi
