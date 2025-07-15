#!/bin/bash
# Batch SET/Config XRDP, Desktop, Tools
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; YELLOW='\033[0;33m'; GREEN='\033[0;32m'; RED='\033[0;31m'; NC='\033[0m'
BATCH_MARKER="./.configured_batch"

clear
echo -e "${CYAN}========================================================"
echo -e " 🔧 ${LANG_BATCH_SET_TITLE:-Batch Pengaturan XRDP & Tools}"
echo -e "========================================================${NC}"

if [ -f "$BATCH_MARKER" ]; then
  echo -e "${YELLOW}⚠️  ${LANG_BATCH_ALREADY_CONFIGURED:-Batch SET sudah pernah dijalankan!}${NC}"
  echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
  read -t 5 -p ""
  exit 0
fi

step_count=1
run_step() {
  local name="$1"
  local file="$2"
  echo -e "${CYAN}[$step_count] ▶️  $name...${NC}"
  if [ -f "$file" ]; then
    bash "$file"
  else
    echo "[WARNING] Script $file tidak ditemukan!"
  fi
  step_count=$((step_count+1))
}

run_step "${LANG_STEP_SET_LANG_TERM:-Set Bahasa Terminal}" ./set/set-language.sh
run_step "${LANG_STEP_SET_LANG_GUI:-Set Bahasa Desktop (GUI)}" ./set/set-desktop-language.sh
run_step "${LANG_STEP_SET_PORT:-Set Port XRDP}" ./set/set-port.sh
run_step "${LANG_STEP_SET_TZ:-Set Timezone}" ./set/set-timezone.sh
run_step "${LANG_STEP_SET_CONKY:-Set VPS Info/Conky}" ./set/set-conky.sh

touch "$BATCH_MARKER"
echo -e "${GREEN}✅  ${LANG_BATCH_SET_SUCCESS:-Semua batch konfigurasi selesai!}${NC}"
echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
read -t 5 -p ""
