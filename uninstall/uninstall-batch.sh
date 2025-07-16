#!/bin/bash
# uninstall-batch.sh - Full Uninstall XRDP + Desktop + Tools + VSCode Ext
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -e

. ./set/set-language.sh
CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; NC='\033[0m'

LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir -p logs
error_log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}========================================================"
echo -e "   ${LANG_BATCH_UNINSTALL_TITLE}"
echo -e "========================================================${NC}"

# 1) Stop services & kill zombies
echo -e "${CYAN}🛑 Stopping services & killing zombie processes...${NC}"
for svc in xrdp xrdp-sesman conky code vlc chrome; do
  pgrep -x "$svc" >/dev/null && sudo killall -9 "$svc" && echo -e "${GREEN}Killed: $svc${NC}"
  sudo systemctl stop "$svc" &>/dev/null || true
done

# 2) Uninstall XRDP Core
echo -e "${YELLOW}🔄 Uninstall XRDP Core...${NC}"
bash ./uninstall-xrdp.sh || error_log "uninstall-xrdp.sh failed"

# 3) Modular Uninstall dari folder uninstall/
echo -e "${YELLOW}🔄 Modular Uninstall...${NC}"
error_count=0
for script in ./uninstall/uninstall-*.sh; do
  [[ "$(basename "$script")" == "uninstall-batch.sh" ]] && continue
  echo -e "${YELLOW}→ $script${NC}"
  if bash "$script"; then
    echo -e "${GREEN}✔ $script${NC}"
  else
    echo -e "${RED}✖ $script${NC}"
    error_log "Failed: $script"
    ((error_count++))
  fi
done

# 4) Remove all VSCode extensions
echo -e "${YELLOW}🗑️ Removing all VSCode extensions...${NC}"
if command -v code >/dev/null 2>&1; then
  for ext in $(code --list-extensions); do
    code --uninstall-extension "$ext" \
      && echo -e "${GREEN}✔ $ext${NC}" \
      || { echo -e "${RED}✖ $ext${NC}"; error_log "Failed ext: $ext"; }
  done
else
  echo -e "${YELLOW}⚠️  VSCode CLI not found, skipping extension cleanup${NC}"
fi

# 5) Remove user extensions folder (optional)
rm -rf "$HOME/.vscode/extensions" &>/dev/null

# 6) Cleanup markers
rm -f ./.installed_batch ./.installed_* 2>/dev/null

# 7) Summary
echo
if [ "$error_count" -eq 0 ]; then
  echo -e "${GREEN}${LANG_BATCH_UNINSTALL_SUCCESS}${NC}"
else
  echo -e "${RED}${LANG_BATCH_UNINSTALL_FAIL} ($error_count errors)${NC}"
  echo -e "${YELLOW}❗ Check $LOG_ERROR${NC}"
fi

# Back to main
echo -e "${CYAN}${LANG_BACK_TO_MAIN_MENU} (Enter or 10s)${NC}"
read -t 10 -p ""
exec bash ./main.sh
