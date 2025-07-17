#!/bin/bash
# install-batch.sh - Batch Install XRDP + Desktop + Tools
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail  
IFS=$'\n\t'  
  
# ANSI colors  
CYAN='\033[0;36m'  
GREEN='\033[0;32m'  
YELLOW='\033[0;33m'  
RED='\033[0;31m'  
NC='\033[0m'  
  
# Load bahasa dan funngsi umum  
source ./set/set-language.sh  
source ./lib/common.sh

clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_BATCH_INSTALL_TITLE:-Install Batch XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"

# Urutan langkah install
run_step "${LANG_STEP_DEPS:-Install dependensi dasar}" \
         "$SCRIPT_DIR/install-deps.sh" \
         ""

run_step "${LANG_STEP_DESKTOP:-Install Desktop Environment}" \
         "$SCRIPT_DIR/install-desktop.sh" \
         "xfce4|gnome-session|plasma-desktop"

run_step "${LANG_STEP_XRDP:-Install XRDP Core}" \
         "$SCRIPT_DIR/install-xrdp-core.sh" \
         "xrdp|xorgxrdp"

run_step "${LANG_STEP_CHROME:-Install Google Chrome}" \
         "$SCRIPT_DIR/install-chrome.sh" \
         "google-chrome-stable"

run_step "${LANG_STEP_VLC:-Install VLC}" \
         "$SCRIPT_DIR/install-vlc.sh" \
         "vlc"

run_step "${LANG_STEP_VSCODE:-Install VSCode}" \
         "$SCRIPT_DIR/install-vscode.sh" \
         "code"

run_step "${LANG_STEP_CONFIG:-Konfigurasi tambahan}" \
         "$SCRIPT_DIR/../set/set-config.sh" \
         "conky"

# Ringkasan & pembuatan marker
if [ "$error_count" -eq 0 ]; then
  touch "$BATCH_MARKER"
  echo -e "${GREEN}✅ ${LANG_BATCH_SUCCESS:-Semua proses install batch sukses!}${NC}"
else
  echo -e "${RED}❌ ${LANG_BATCH_FAIL:-Ada error pada instalasi batch!} ($error_count errors)${NC}"
  echo -e "${YELLOW}❗ Cek detail di $LOG_ERROR${NC}"
fi

echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
read -t 5 -p ""
