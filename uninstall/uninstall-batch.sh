#!/bin/bash
# uninstall-batch.sh - Uninstall Semua Komponen XRDP (Batch)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs

error_log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }
log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅} $1${NC}"; }
log_fail()  { echo -e "${RED}${LANG_FAIL_EMOJI:-❌} $1${NC}"; }

clear
echo -e "${CYAN}========================================================"
echo -e " ${LANG_BATCH_UNINSTALL_TITLE:-Uninstall Batch XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"

# Step 1: Kill zombie process & stop all services
echo -e "${CYAN}🛑 Stopping services & killing zombie processes...${NC}"
for svc in xrdp xrdp-sesman conky code code-oss vlc chrome google-chrome; do
  if pgrep "$svc" >/dev/null 2>&1; then
    sudo killall -9 "$svc" 2>/dev/null && log_ok "Killed process: $svc" || true
  fi
  sudo systemctl stop "$svc" 2>/dev/null || true
done

# Step 2: Modular uninstall all main uninstallers
declare -A UNINSTALL_SCRIPTS=(
  [xrdp_core]="./uninstall/uninstall-xrdp-core.sh"
  [desktop]="./uninstall/uninstall-desktop.sh"
  [chrome]="./uninstall/uninstall-chrome.sh"
  [vlc]="./uninstall/uninstall-vlc.sh"
  [vscode]="./uninstall/uninstall-vscode.sh"
  [conky]="./uninstall/uninstall-conky.sh"
)

error_count=0
for key in "${!UNINSTALL_SCRIPTS[@]}"; do
  script="${UNINSTALL_SCRIPTS[$key]}"
  if [ -f "$script" ]; then
    echo -e "${YELLOW}🔄 Uninstall: $key${NC}"
    bash "$script" || { error_log "Uninstall failed: $key ($script)"; ((error_count++)); }
  fi
done

# Step 3: Hapus marker/flag
rm -f .installed_* 2>/dev/null

if [ "$error_count" -eq 0 ]; then
  log_ok "${LANG_BATCH_UNINSTALL_SUCCESS:-Semua uninstall batch sukses!}"
else
  log_fail "${LANG_BATCH_UNINSTALL_FAIL:-Ada error pada uninstall batch!} ($error_count)"
  echo -e "${YELLOW}Log error: $LOG_ERROR${NC}"
fi

echo -e "${CYAN}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama} (10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh