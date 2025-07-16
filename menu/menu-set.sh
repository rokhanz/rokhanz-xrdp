#!/bin/bash
# Menu Pengaturan/SET XRDP & Tools
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'

while true; do
  clear
  echo -e "${CYAN}========================================================"
  echo -e " ${LANG_SET_MENU_TITLE}"
  echo -e "========================================================${NC}"
  echo -e "[1] ${LANG_SET_DESKTOP_LANG}"
  echo -e "[2] ${LANG_SET_TERMINAL_LANG}"
  echo -e "[3] ${LANG_SET_PORT}"
  echo -e "[4] ${LANG_SET_TIMEZONE}"
  echo -e "[5] ${LANG_SET_VPS_INFO}"
  echo -e "[6] ↩️  ${LANG_BACK_TO_MAIN_MENU}"
  echo    "--------------------------------------------------------"
  read -p "${LANG_MENU_PROMPT} " set_choice

  case "$set_choice" in
    1) clear; bash ./set/set-desktop-language.sh ;;
    2) clear; bash ./set/set-language.sh ;;
    3) clear; bash ./set/set-port.sh ;;
    4) clear; bash ./set/set-timezone.sh ;;
    5) clear; bash ./set/set-conky.sh ;;
    6) clear; break ;;
    *) echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}"; sleep 2 ;;
  esac
done