#!/bin/bash
# menu-tools.sh
. ./set/set-language.sh

CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'

while true; do
  clear
  echo -e "${CYAN}========================================================"
  echo -e "${LANG_TOOLS_MENU_TITLE}"
  echo -e "========================================================${NC}"
  echo -e "[1] ${LANG_TOOLS_CHROME}"
  echo -e "[2] ${LANG_TOOLS_VLC}"
  echo -e "[3] ${LANG_TOOLS_VSCODE}"
  echo -e "[4] ${LANG_TOOLS_UNINSTALL_CHROME}"
  echo -e "[5] ${LANG_TOOLS_UNINSTALL_VLC}"
  echo -e "[6] ${LANG_TOOLS_UNINSTALL_VSCODE}"
  echo -e "[7] ${LANG_TOOLS_ALL}"
  echo -e "[8] ${LANG_TOOLS_UNINSTALL_ALL}"
  echo -e "[9] ${LANG_TOOLS_BACK}"
  echo    "-----------------------------------------"
  read -p "${LANG_TOOLS_MENU_PROMPT} " tchoice

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
      echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}"; sleep 2 ;;
  esac
done