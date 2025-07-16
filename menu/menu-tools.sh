#!/bin/bash
# menu/menu-tools.sh
# Menu Install/Uninstall Aplikasi XRDP
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'

while true; do
  clear
  echo -e "${CYAN}========================================================"
  echo -e "   ${LANG_TOOLS_MENU_TITLE:-📦 Install Aplikasi/Tools XRDP}"
  echo -e "========================================================${NC}"
  echo -e "[1] 🌐  Install Google Chrome"
  echo -e "[2] 🎬  Install VLC"
  echo -e "[3] 🖥️   Install VSCode"
  echo -e "[4] 🗑️  Uninstall Google Chrome"
  echo -e "[5] 🗑️  Uninstall VLC"
  echo -e "[6] 🗑️  Uninstall VSCode"
  echo -e "[7] 🟢  Install Semua Tools"
  echo -e "[8] 🔴  Uninstall Semua Tools"
  echo -e "[9] ↩️  ${LANG_BACK_TO_MAIN_MENU}"
  echo    "--------------------------------------------------------"
  read -p "Pilih (1-9): " tchoice

  case "$tchoice" in
    1) clear; bash ./install/install-chrome.sh ;;
    2) clear; bash ./install/install-vlc.sh ;;
    3) clear; bash ./install/install-vscode.sh ;;
    4) clear; bash ./uninstall/uninstall-chrome.sh ;;
    5) clear; bash ./uninstall/uninstall-vlc.sh ;;
    6) clear; bash ./uninstall/uninstall-vscode.sh ;;
    7)
      clear
      bash ./install/install-chrome.sh
      bash ./install/install-vlc.sh
      bash ./install/install-vscode.sh
      ;;
    8)
      clear
      bash ./uninstall/uninstall-chrome.sh
      bash ./uninstall/uninstall-vlc.sh
      bash ./uninstall/uninstall-vscode.sh
      ;;
    9)
      clear
      break
      ;;
    *)
      echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}"
      sleep 2
      ;;
  esac
done
