#!/bin/bash
# Install Tools Bundle (Chrome, VLC, VSCode, dst)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; YELLOW='\033[0;33m'; NC='\033[0m'

while true; do
  clear
  echo -e "${CYAN}========================================================"
  echo -e " ${LANG_TOOLS_MENU_TITLE:-📦 Install Aplikasi/Tools XRDP}"
  echo -e "========================================================${NC}"
  echo -e "[1] Google Chrome"
  echo -e "[2] VLC Media Player"
  echo -e "[3] VSCode"
  echo -e "[4] ${LANG_TOOLS_INSTALL_ALL:-Install Semua Tools}"
  echo -e "[5] 🔙 ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama}"
  echo    "--------------------------------------------------------"
  read -p "${LANG_MENU_PROMPT} " tools_choice

  case "$tools_choice" in
    1) clear; bash ./install/install-chrome.sh ;;
    2) clear; bash ./install/install-vlc.sh ;;
    3) clear; bash ./install/install-vscode.sh ;;
    4)
      clear
      bash ./install/install-chrome.sh
      bash ./install/install-vlc.sh
      bash ./install/install-vscode.sh
      ;;
    5) break ;;
    *) echo -e "${YELLOW}${LANG_INVALID_OPTION:-Pilihan tidak valid}${NC}"; sleep 2 ;;
  esac

  echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU} (5 detik)${NC}"
  read -t 5 -p ""
done