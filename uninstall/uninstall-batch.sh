#!/bin/bash
# uninstall-batch.sh - Full Uninstall XRDP + Desktop + Tools with Validation
# Author: rokhanz
# Version: 1.0.2
# License: MIT

set -e

# --- Load language & colors ---
. ./set/set-language.sh
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# --- Logging setup ---
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir -p logs
error_log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

# --- Header ---
clear
echo -e "${CYAN}========================================================"
echo -e "   ${LANG_BATCH_UNINSTALL_TITLE:-Uninstall Batch XRDP + Desktop + Tools}"
echo -e "========================================================${NC}"

# --- 1) Stop services & kill zombies ---
echo -e "${CYAN}🛑 Stopping services & killing zombie processes...${NC}"
for svc in xrdp xrdp-sesman conky code vlc chrome; do
  if pgrep -x "$svc" >/dev/null 2>&1; then
    sudo killall -9 "$svc" 2>/dev/null && echo -e "${GREEN}Killed: $svc${NC}"
  fi
  sudo systemctl stop "$svc" &>/dev/null || true
done

# --- Map skrip ke pola nama paket untuk validasi ---
declare -A PKG_MAP=(
  [uninstall-xrdp.sh]="xrdp|xorgxrdp"
  [uninstall-desktop.sh]="xfce4|gnome-session|plasma-desktop"
  [uninstall-chrome.sh]="google-chrome-stable"
  [uninstall-vlc.sh]="vlc"
  [uninstall-vscode.sh]="code"
  [uninstall-conky.sh]="conky"
)

# --- 2) Uninstall XRDP Core ---
echo -e "${YELLOW}🔄 Uninstall XRDP Core...${NC}"
bash ./uninstall-xrdp.sh || error_log "uninstall-xrdp.sh failed"

# --- 3) Modular Uninstall dari folder uninstall/ ---
echo -e "${YELLOW}🔄 Modular Uninstall...${NC}"
error_count=0
for script in ./uninstall/uninstall-*.sh; do
  name=$(basename "$script")
  [[ "$name" == "uninstall-batch.sh" ]] && continue

  # validasi apakah komponen masih terpasang
  regex=${PKG_MAP[$name]}
  if [[ -n "$regex" && -z $(dpkg -l | grep -E "$regex") ]]; then
    echo -e "${GREEN}$name: komponen tidak ditemukan, skip${NC}"
    continue
  fi

  echo -e "${YELLOW}→ Running $name...${NC}"
  if bash "$script"; then
    echo -e "${GREEN}✔ $name${NC}"
  else
    echo -e "${RED}✖ $name${NC}"
    error_log "Failed $script"
    ((error_count++))
  fi
done

# --- 4) Remove all VSCode extensions ---
echo -e "${YELLOW}🗑️  Removing all VSCode extensions...${NC}"
if command -v code >/dev/null 2>&1; then
  for ext in $(code --list-extensions); do
    if code --uninstall-extension "$ext"; then
      echo -e "${GREEN}✔ $ext${NC}"
    else
      echo -e "${RED}✖ $ext${NC}"
      error_log "Failed ext: $ext"
    fi
  done
else
  echo -e "${YELLOW}⚠️  VSCode CLI not found, skipping extension cleanup${NC}"
fi

# --- 5) Cleanup markers ---
rm -f ./.installed_batch ./.installed_* 2>/dev/null

# --- 6) Summary ---
echo
if [ "$error_count" -eq 0 ]; then
  echo -e "${GREEN}${LANG_BATCH_UNINSTALL_SUCCESS:-Semua uninstall batch sukses!}${NC}"
else
  echo -e "${RED}${LANG_BATCH_UNINSTALL_FAIL:-Ada error pada uninstall batch!} ($error_count errors)${NC}"
  echo -e "${YELLOW}❗ Check $LOG_ERROR${NC}"
fi

# --- Back to main ---
echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU} (tekan Enter atau tunggu 10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh

