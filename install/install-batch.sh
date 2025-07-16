#!/bin/bash
# install-batch.sh - Batch Install XRDP + Desktop + Tools with Validation
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -e

# — Muat terjemahan & warna —
. ./set/set-language.sh
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

LOG_ERROR="./logs/error.log"
BATCH_MARKER="./.installed_batch"
[ -d logs ] || mkdir -p logs

# — Early-exit jika sudah batch-install pernah dijalankan —
if [ -f "$BATCH_MARKER" ]; then
  echo -e "${YELLOW}⚠️  ${LANG_BATCH_ALREADY_INSTALLED:-Batch sudah pernah diinstall!}${NC}"
  echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
  read -t 5 -p ""
  exit 0
fi

error_count=0
step_count=1

# — run_step helper dengan validasi dpkg —
run_step() {
  local title="$1"
  local cmd="$2"
  local pkg_regex="$3"

  echo -e "${CYAN}[${step_count}] ▶️  ${title}...${NC}"
  # Jika ada regex dan paket sudah ada → skip
  if [ -n "$pkg_regex" ] && dpkg -l | grep -E "$pkg_regex" >/dev/null 2>&1; then
    echo -e "${GREEN}✔  Skip ${title}, sudah terpasang${NC}"
  else
    if eval "$cmd"; then
      echo -e "${GREEN}✅  ${title} selesai${NC}"
    else
      echo -e "${RED}❌  ${title} gagal${NC}"
      echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] Step \"$title\" gagal" >> "$LOG_ERROR"
      ((error_count++))
    fi
  fi

  ((step_count++))
}

clear
echo -e "${CYAN}========================================================"
echo -e "   ${LANG_BATCH_INSTALL_TITLE:-Install Batch XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"

# =========================
# Urutan langkah install
# =========================

run_step "${LANG_STEP_DEPS:-Install dependensi dasar}"        "./install/install-deps.sh"             ""
run_step "${LANG_STEP_DESKTOP:-Install Desktop Environment}" "./install/install-desktop.sh"         "xfce4|gnome-session|plasma-desktop"
run_step "${LANG_STEP_XRDP:-Install XRDP Core}"              "./install/install-xrdp-core.sh"       "xrdp|xorgxrdp"
run_step "${LANG_STEP_CHROME:-Install Google Chrome}"        "./install/install-chrome.sh"          "google-chrome-stable"
run_step "${LANG_STEP_VLC:-Install VLC}"                     "./install/install-vlc.sh"             "vlc"
run_step "${LANG_STEP_VSCODE:-Install VSCode}"               "./install/install-vscode.sh"          "code"
run_step "${LANG_STEP_CONFIG:-Konfigurasi tambahan}"         "./set/set-config.sh"                  "conky"

# =========================
# Ringkasan & marker selesai
# =========================
if [ "$error_count" -eq 0 ]; then
  touch "$BATCH_MARKER"
  echo -e "${GREEN}✅ ${LANG_BATCH_SUCCESS:-Semua proses install batch sukses!}${NC}"
else
  echo -e "${RED}❌ ${LANG_BATCH_FAIL:-Ada error pada instalasi batch!} ($error_count errors)${NC}"
  echo -e "${YELLOW}❗  Cek detail di $LOG_ERROR${NC}"
fi

echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (5 detik)${NC}"
read -t 5 -p ""
exec bash ./main.sh
