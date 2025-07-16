#!/bin/bash
# menu-batch.sh - Batch Install/Uninstall Menu Modular
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh
CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'

MODE="$1"

if [ "$MODE" == "install" ]; then
  while true; do
    clear
    echo -e "${CYAN}========================================================"
    echo -e "🚀 ${LANG_BATCH_INSTALL_TITLE:-Install Batch XRDP + Desktop + Tools}"
    echo -e "========================================================${NC}"
    echo -e "[1] 🚀 ${LANG_BATCH_MINIMAL_INSTALL:-Install XRDP Minimal (inti saja)}"
    echo -e "[2] 🚀 ${LANG_BATCH_FULL_INSTALL:-Install XRDP + Full Tools (rekomendasi)}"
    echo -e "[3] 🔄 ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama}"
    echo    "-----------------------------------------"
    read -p "${LANG_MENU_PROMPT:-Pilih menu}: " bchoice
    case "$bchoice" in
      1) bash ./install/install-xrdp.sh; break ;;
      2) bash ./install/install-batch.sh; break ;;
      3) exec bash ./main.sh ;;
      *) echo -e "${YELLOW}${LANG_INVALID_OPTION:-Pilihan tidak valid}${NC}"; sleep 2 ;;
    esac
  done
elif [ "$MODE" == "uninstall" ]; then
  while true; do
    clear
    echo -e "${CYAN}========================================================"
    echo -e "❌ ${LANG_BATCH_UNINSTALL_TITLE:-Batch Uninstall XRDP + Desktop + Tools}"
    echo -e "========================================================${NC}"
    echo -e "[1] 🗑️  ${LANG_BATCH_FULL_UNINSTALL:-Uninstall XRDP Full (inti + tools)}"
    echo -e "[2] 🔄 ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama}"
    echo    "-----------------------------------------"
    read -p "${LANG_MENU_PROMPT:-Pilih menu}: " bchoice
    case "$bchoice" in
      1) bash ./uninstall/uninstall-batch.sh; break ;;
      2) exec bash ./main.sh ;;
      *) echo -e "${YELLOW}${LANG_INVALID_OPTION:-Pilihan tidak valid}${NC}"; sleep 2 ;;
    esac
  done
else
  exec bash ./main.sh
fi
