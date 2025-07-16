#!/bin/bash
# Batch Installer XRDP + Desktop + Tools
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; YELLOW='\033[0;33m'; GREEN='\033[0;32m'; RED='\033[0;31m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
BATCH_MARKER="./.installed_batch"
[ -d logs ] || mkdir logs

clear
echo -e "${CYAN}========================================================"
echo -e " 🚀 ${LANG_BATCH_INSTALL_TITLE:-Install Batch XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"

if [ -f "$BATCH_MARKER" ]; then
  echo -e "${YELLOW}⚠️  ${LANG_BATCH_ALREADY_INSTALLED:-Batch sudah pernah diinstall!}${NC}"
  echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
  read -t 5 -p ""
  exit 0
fi

error_count=0
step_count=1

run_step() {
  local name="$1"
  local file="$2"
  echo -e "${CYAN}[$step_count] ▶️  $name...${NC}"
  if [ -f "$file" ]; then
    bash "$file"
    if [ $? -ne 0 ]; then
      echo "[ERROR] $name ($file) gagal!" | tee -a "$LOG_ERROR"
      error_count=$((error_count+1))
    fi
  else
    echo "[WARNING] Script $file tidak ditemukan!" | tee -a "$LOG_ERROR"
    error_count=$((error_count+1))
  fi
  step_count=$((step_count+1))
}

## =========================
# Langkah install batch
# =========================

run_step "${LANG_STEP_DEPS:-Install dependensi dasar}"        ./install/install-deps.sh
run_step "${LANG_STEP_DESKTOP:-Install Desktop Environment}"  ./install/install-desktop.sh
run_step "${LANG_STEP_XRDP:-Install XRDP Core}"               ./install/install-xrdp-core.sh
run_step "${LANG_STEP_CHROME:-Install Google Chrome}"         ./install/install-chrome.sh
run_step "${LANG_STEP_VLC:-Install VLC}"                      ./install/install-vlc.sh
run_step "${LANG_STEP_VSCODE:-Install VSCode}"                ./install/install-vscode.sh
run_step "${LANG_STEP_CONFIG:-Konfigurasi tambahan}"          ./set/set-config.sh

# =========================
# Penutup
# =========================

if [ $error_count -eq 0 ]; then
  touch "$BATCH_MARKER"
  echo -e "${GREEN}✅  ${LANG_BATCH_SUCCESS:-Semua proses install batch sukses!}${NC}"
else
  echo -e "${RED}❌  ${LANG_BATCH_FAIL:-Ada error pada instalasi batch!} ($error_count error, cek $LOG_ERROR)${NC}"
fi

echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
read -t 5 -p ""