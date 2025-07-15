#!/bin/bash
# XRDP + Desktop Environment Manager by rokhanz
# Version: 1.0.0
# License: MIT

# === Header ANSI Banner ===
CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'; GREEN='\033[0;32m'

echo -e "${CYAN}"
echo "    $$$\   $$$$$$\  $$\   $$\ $$\   $$\  $$$$$$\  $$\   $$\ $$$$$$$$\ "
echo " $$  __$$\ $$  __$$\ $$ | $$  |$$ |  $$ |$$  __$$\ $$$\  $$ |\____$$  |"
echo " $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |  $$ |$$ /  $$ |$$$$\ $$ |    $$  /"
echo " $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$$$$ |$$$$$$$$ |$$ $$\$$ |   $$  /"
echo " $$  __$$< $$ |  $$ |$$  $$<   $$  __$$ |$$  __$$ |$$ \$$$$ |  $$  /"
echo " $$ |  $$ |$$ |  $$ |$$ |\$$\  $$ |  $$ |$$ |  $$ |$$ |\$$$ | $$  /"
echo " $$ |  $$ | $$$$$$  |$$ | \$$\ $$ |  $$ |$$ |  $$ |$$ | \$$ |$$$$$$$$\ "
echo " \__|  \__| \______/ \__|  \__|\__|  \__|\__|  \__|\__|  \__|\________|"

echo    "========================================================"
echo    "✨ XRDP + Desktop Environment Manager by rokhanz ✨"
echo    "========================================================"
echo -e "\033[0m"

# === Set Permission & Include Language ===
find ./install ./uninstall ./set ./menu ./utils -type f -name "*.sh" -exec chmod +x {} +
chmod +x ./install/install-batch.sh ./uninstall/uninstall-batch.sh
. ./set/set-language.sh

[ -f .marker_bot_uptime ] || date +%s > .marker_bot_uptime

CYAN='\033[0;36m'; NC='\033[0m'; YELLOW='\033[0;33m'; GREEN='\033[0;32m'

while true; do
  clear
  # --- Info singkat di atas menu
  if [ -f ./.installed_batch ]; then
    echo -e "${GREEN}🟢  ${LANG_BATCH_ALREADY_INSTALLED:-Batch sudah pernah diinstall!}${NC}"
  else
    echo -e "${YELLOW}🟡  ${LANG_BATCH_NOT_INSTALLED:-Batch belum diinstall.}${NC}"
  fi
  echo -e "${CYAN}========================================================"
  echo -e "✨ XRDP + Desktop Environment Manager by rokhanz ✨"
  echo -e "========================================================${NC}"
  echo -e "[1] 🚀 ${LANG_MENU_INSTALL:-Install XRDP + Desktop Environment}"
  echo -e "[2] ❌ ${LANG_MENU_UNINSTALL:-Uninstall XRDP & Desktop Environment}"
  echo -e "[3] 🛠️  ${LANG_MENU_TOOLS:-Install aplikasi/tools XRDP}"
  echo -e "[4] ℹ️  ${LANG_MENU_INFO:-Info & Status}"
  echo -e "[5] 🔧 ${LANG_MENU_SET:-Pengaturan/SET}"
  echo -e "[6] 🚪 ${LANG_MENU_EXIT:-Exit}"
  echo    "-----------------------------------------"
  read -p "${LANG_MENU_PROMPT} " choice

  case "$choice" in
    1)
      clear
      bash ./install/install-batch.sh
      ;;
    2)
      clear
      bash ./uninstall/uninstall-batch.sh
      ;;
    3)
      clear
      bash ./menu/menu-tools.sh
      ;;
    4)
      clear
      bash ./utils/info_vps.sh
      ;;
    5)
      clear
      bash ./menu/menu-set.sh
      ;;
    6|q|Q)
      clear
      echo -e "${CYAN}👋 ${LANG_GOODBYE:-Sampai jumpa!}${NC}"
      exit 0
      ;;
    *)
      echo -e "${YELLOW}${LANG_INVALID_OPTION:-Pilihan tidak valid}${NC}"
      sleep 2
      ;;
  esac
done
