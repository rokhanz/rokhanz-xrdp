#!/usr/bin/env bash
# main.sh — XRDP + Desktop Environment Manager (All-in-One Menu)
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Pastikan dijalankan dari root repo
cd "$(dirname "$0")"

# ────────────────────────────────────────────────────────────
# Beri permission untuk semua skrip
for d in utils set "set/lang" uninstall install lib; do
  [ -d "$d" ] && find "$d" -type f -name '*.sh' -exec chmod +x {} +
done

# ────────────────────────────────────────────────────────────
# ANSI colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# ────────────────────────────────────────────────────────────
# Muat bahasa & fungsi umum
source ./set/set-language.sh
source ./lib/common.sh

# ────────────────────────────────────────────────────────────
# Banner / Big ASCII art (hanya di menu utama)
show_banner() {
  clear
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
EOF
  echo -e "${NC}"
}

# ────────────────────────────────────────────────────────────
# Submenu: Batch Install / Uninstall XRDP & Desktop
menu_batch() {
  local opt
  while true; do
    show_banner
    echo "── ${LANG_TITLE_MENU_BATCH} ──"
    echo "1. ${LANG_BATCH_MINIMAL_INSTALL}"
    echo "2. ${LANG_BATCH_FULL_INSTALL}"
    echo "3. ${LANG_BATCH_MINIMAL_UNINSTALL}"
    echo "4. ${LANG_BATCH_FULL_UNINSTALL}"
    echo "9. ${LANG_BACK_TO_MAIN_MENU}"
    read -r -p "${LANG_MENU_PROMPT}" opt
    case "$opt" in
      1) run_step "${LANG_BATCH_MINIMAL_INSTALL}" "./install/install-xrdp.sh" "dpkg -l | grep -qw xrdp" ;;
      2)
        if check_marker batch; then
          log_warn "${LANG_BATCH_ALREADY_INSTALLED}"
        else
          run_step "${LANG_STEP_DEPS}"    "./install/install-deps.sh"
          run_step "${LANG_STEP_DESKTOP}" "./install/install-desktop.sh" "dpkg -l | grep -E -q 'xfce4|gnome-session|plasma-desktop'"
          run_step "${LANG_STEP_XRDP}"    "./install/install-xrdp-core.sh" "dpkg -l | grep -qw xrdp"
          write_marker batch success xfce4
          log_ok "${LANG_BATCH_DONE}"
        fi
        ;;
      3) bash ./uninstall/uninstall-xrdp.sh ;;
      4) bash ./uninstall/uninstall-batch.sh ;;
      9) break ;;
      *) echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}" && sleep 1 ;;
    esac
    echo
    read -r -p "${LANG_BACK_TO_MAIN_MENU}"
  done
}

# ────────────────────────────────────────────────────────────
# Submenu: Install / Uninstall Tools
menu_tools() {
  local opt
  while true; do
    show_banner
    echo "── ${LANG_TOOLS_MENU_TITLE} ──"
    echo "1. ${LANG_STEP_CHROME}"
    echo "2. ${LANG_STEP_VLC}"
    echo "3. ${LANG_STEP_VSCODE}"
    echo "4. ${LANG_STEP_UN_CHROME}"
    echo "5. ${LANG_STEP_UN_VLC}"
    echo "6. ${LANG_STEP_UN_VSCODE}"
    echo "7. ${LANG_TOOLS_INSTALL_ALL}"
    echo "8. ${LANG_TOOLS_UNINSTALL_ALL}"
    echo "9. ${LANG_ADD_MENU_XRDP}"
    echo "0. ${LANG_BACK_TO_MAIN_MENU}"
    read -r -p "${LANG_MENU_PROMPT}" opt
    case "$opt" in
      1) run_step "${LANG_STEP_CHROME}"   "./install/install-chrome.sh"   "dpkg -l | grep -qw google-chrome-stable" ;;
      2) run_step "${LANG_STEP_VLC}"      "./install/install-vlc.sh"      "dpkg -l | grep -qw vlc"                ;;
      3) run_step "${LANG_STEP_VSCODE}"   "./install/install-vscode.sh"   "dpkg -l | grep -qw code"               ;;
      4) bash "./uninstall/uninstall-chrome.sh" ;;
      5) bash "./uninstall/uninstall-vlc.sh"    ;;
      6) bash "./uninstall/uninstall-vscode.sh" ;;
      7) bash "./install/install-chrome.sh"; bash "./install/install-vlc.sh"; bash "./install/install-vscode.sh" ;;
      8) bash "./uninstall/uninstall-chrome.sh"; bash "./uninstall/uninstall-vlc.sh"; bash "./uninstall/uninstall-vscode.sh" ;;
      9) bash ./utils/add-xrdp-user.sh     ;;
      0) break ;;
      *) echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}" && sleep 1 ;;
    esac
    echo
    read -r -p "${LANG_BACK_TO_MAIN_MENU}"
  done
}

# ────────────────────────────────────────────────────────────
# Submenu: Extensions (VSCode wizard) – inline
menu_extension() {
  local EXTFILE="vscode-ext.txt" SAVEFILE="save-ext.txt" MARKER=".installed_vscode_ext"
  local LOGFILE="$LOG_DIR/error.log"
  mkdir -p "$(dirname "$LOGFILE")"

  declare -A EXT_CAT EXT_MAP
  local CAT_LIST=()

  # parse categories & items
  while IFS= read -r line; do
    if [[ "$line" =~ ^#CATEGORY:(.*) ]]; then
      CAT_LIST+=("${BASH_REMATCH[1]}")
    elif [[ "$line" =~ ^([[:alnum:]\._-]+)[[:space:]]+\(publisher:[[:space:]]*([^)]+)\)$ ]]; then
      ext="${BASH_REMATCH[1]}" pub="${BASH_REMATCH[2]}"
      EXT_CAT["${CAT_LIST[-1]}"]+="$ext|$pub,"
      EXT_MAP["$ext"]="$pub"
    fi
  done < "$EXTFILE"

  local PICKED=()
  log_error(){ echo "$(date '+%F %T') ${LANG_LOG_ERROR_PREFIX} $1" >> "$LOGFILE"; }

  while :; do
    show_banner
    echo "── ${LANG_EXT_MENU_TITLE} ──"
    for i in "${!CAT_LIST[@]}"; do
      printf "%2d. %s\n" $((i+1)) "${CAT_LIST[$i]}"
    done
    echo "99. ${LANG_EXT_SAVE}"
    echo "0. ${LANG_EXT_BACK}"
    read -r -p "${LANG_MENU_PROMPT}" choice
    [[ "$choice" == "0" ]] && return
    [[ "$choice" == "99" ]] && break

    local cat="${CAT_LIST[$((choice-1))]}"
    IFS=',' read -ra items <<< "${EXT_CAT[$cat]}"
    echo "${LANG_LINE_THIN}"
    for j in "${!items[@]}"; do
      [[ -z "${items[$j]}" ]] && continue
      IFS='|' read -r nm pb <<< "${items[$j]}"
      printf "%2d. %-30s (by %s)\n" $((j+1)) "$nm" "$pb"
    done
    echo "0. ${LANG_EXT_BACK}"
    read -r -p "${LANG_EXT_CHOOSE_EXT_PROMPT}" picks
    for p in $picks; do
      [[ "$p" == "0" ]] && break
      ext="${items[$((p-1))]%%|*}"
      [[ -n "$ext" && ! " ${PICKED[*]} " =~ " $ext " ]] && PICKED+=("$ext")
    done
  done

  show_banner
  echo "${LANG_EXT_CHOSEN}"
  for ext in "${PICKED[@]}"; do
    echo "- $ext"
  done
  read -r -p "${LANG_EXT_SAVE}? (y/n): " ok
  if [[ "$ok" =~ ^[Yy]$ ]]; then
    printf "%s\n" "${PICKED[@]}" > "$SAVEFILE"
    touch "$MARKER"
    log_ok "${LANG_EXT_DONE}"
  else
    echo "${LANG_EXT_ERR_EMPTY}"
  fi
  read -r -p "${LANG_BACK_TO_MAIN_MENU}"
}

# ────────────────────────────────────────────────────────────
# Submenu: Settings
menu_set() {
  local opt
  while true; do
    show_banner
    echo "── ${LANG_SET_MENU_TITLE} ──"
    echo "1. ${LANG_SET_DESKTOP_LANG}"
    echo "2. ${LANG_SET_TERMINAL_LANG}"
    echo "3. ${LANG_SET_PORT}"
    echo "4. ${LANG_SET_TIMEZONE}"
    echo "5. ${LANG_SET_VPS_INFO}"
    echo "9. ${LANG_BACK_TO_MAIN_MENU}"
    read -r -p "${LANG_MENU_PROMPT}" opt
    case "$opt" in
      1) bash ./set/set-desktop-language.sh ;;
      2) bash ./set/set-language.sh         ;;
      3) bash ./set/set-port.sh             ;;
      4) bash ./set/set-timezone.sh         ;;
      5) bash ./set/set-conky.sh            ;;
      9) break                              ;;
      *) echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}" && sleep 1 ;;
    esac
    echo
    read -r -p "${LANG_BACK_TO_MAIN_MENU}"
  done
}

# ────────────────────────────────────────────────────────────
# MAIN MENU LOOP
while true; do
  show_banner
  echo "${LANG_MENU_HEADER}"
  echo
  echo "1. ${LANG_MENU_INSTALL}"
  echo "2. ${LANG_MENU_TOOLS}"
  echo "3. ${LANG_MENU_INFO}"
  echo "4. ${LANG_MENU_STATUS}"
  echo "5. ${LANG_MENU_SET}"
  echo "0. ${LANG_MENU_EXIT}"
  echo
  read -r -p "${LANG_MENU_PROMPT}" choice
  case "$choice" in
    1) menu_batch    ;;
    2) menu_tools    ;;
    3) bash ./utils/info-vps.sh ;;
    4) bash ./utils/status.sh   ;;
    5) menu_set      ;;
    0) echo -e "${GREEN}${LANG_GOODBYE}${NC}" && exit 0 ;;
    *) echo -e "${YELLOW}${LANG_INVALID_OPTION}${NC}" && sleep 1 ;;
  esac
done
