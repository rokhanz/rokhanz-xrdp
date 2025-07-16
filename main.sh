#!/bin/bash
# XRDP + Desktop Environment Manager by rokhanz
# Version: 1.0.1
# License: MIT
# Copyright (c) 2025 rokhanz

# ===== Ensure we're in the script's directory =====
cd "$(dirname "$0")"

# ===== ANSI COLORS =====
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# ---- Marker Bot Uptime ----
[ -f .marker_bot_uptime ] || date +%s > .marker_bot_uptime

# ---- Make all scripts executable (skip missing dirs) ----
for d in install uninstall set menu utils; do
  [ -d "./$d" ] && find "./$d" -type f -name "*.sh" -exec chmod +x {} +
done
chmod +x ./install/install-batch.sh ./uninstall/uninstall-batch.sh 2>/dev/null || true

# ---- Load multi-language & emoji, with fallback ----
if ! . ./set/set-language.sh; then
  echo -e "${YELLOW}⚠️  Warning: language settings not found, using defaults.${NC}"
fi

# ===== MAIN MENU LOOP =====
while true; do
  clear

  # show batch-status
  if [ -f ./.installed_batch ]; then
    echo -e "${GREEN}${LANG_BATCH_ALREADY_INSTALLED}${NC}"
  else
    echo -e "${YELLOW}${LANG_BATCH_NOT_INSTALLED}${NC}"
  fi

  # display banner + menu
  echo -e "${CYAN}"
  cat << 'EOF'
  $$$\   $$$$$$\  $$\   $$\ $$\   $$\  $$$$$$\  $$\   $$\ $$$$$$$$\ 
 $$  __$$\ $$  __$$\ $$ | $$  |$$ |  $$ |$$  __$$\ $$$\  $$ |\____$$  |
 $$ |  $$ |$$ /  $$ |$$ |$$  / $$ |  $$ |$$ /  $$ |$$$$\ $$ |    $$  /
 $$$$$$$  |$$ |  $$ |$$$$$  /  $$$$$$$$ |$$$$$$$$ |$$ $$\$$ |   $$  /
 $$  __$$< $$ |  $$ |$$  $$<   $$  __$$ |$$  __$$ |$$ \$$$$ |  $$  /
 $$ |  $$ |$$ |  $$ |$$ |\$$\  $$ |  $$ |$$ |  $$ |$$ |\$$$ | $$  /
 $$ |  $$ | $$$$$$  |$$ | \$$\ $$ |  $$ |$$ |  $$ |$$ | \$$ |$$$$$$$$\ 
 \__|  \__| \______/ \__|  \__|\__|  \__|\__|  \__|\__|  \__|\________|
========================================================
✨ XRDP + Desktop Environment Manager by rokhanz ✨
========================================================
EOF
  echo -e "${NC}"
  echo -e "[1] ${LANG_MENU_INSTALL}"
  echo -e "[2] ${LANG_MENU_UNINSTALL}"
  echo -e "[3] ${LANG_MENU_TOOLS}"
  echo -e "[4] Status Install/Uninstall"
  echo -e "[5] ${LANG_MENU_INFO}"
  echo -e "[6] ${LANG_MENU_SET}"
  echo -e "[7] ${LANG_MENU_EXIT}"
  echo    "-----------------------------------------"
  read -p "${LANG_MENU_PROMPT} " choice

  case "$choice" in
    1)
      bash ./menu/menu-batch.sh install
      ;;
    2)
      bash ./menu/menu-batch.sh uninstall
      ;;
    3)
      bash ./menu/menu-tools.sh
      ;;
    4)
      bash ./utils/status.sh
      ;;
    5)
      bash ./utils/info-vps.sh
      ;;
    6)
      bash ./menu/menu-set.sh
      ;;
    7|q|Q)
      echo -e "${CYAN}${LANG_GOODBYE}${NC}"
      exit 0
      ;;
    *)
      echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}"
      sleep 2
      ;;
  esac
done
