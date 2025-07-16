#!/bin/bash
# Uninstall Conky (VPS Info) + Config & Autostart
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
LOG_ERROR="./logs/error.log"
[ -d logs ] || mkdir logs
MARKER="./.installed_conky"

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOG_ERROR"; }

clear
echo -e "${CYAN}🧹 ${LANG_STEP_UN_CONKY:-Uninstall Conky/Config}${NC}"

if ! dpkg -l | grep -qw conky; then
  log_warn "Conky ${LANG_ALREADY_UNINSTALLED:-sudah dihapus!}"
else
  sudo apt-get remove --purge -y conky conky-std
  sudo apt-get autoremove -y
fi

sudo rm -rf /etc/skel/.config/conky /etc/skel/.config/autostart/conky.desktop

# Hapus dari seluruh user home (idempotent)
for user_home in /home/*; do
  sudo rm -f "$user_home/.config/autostart/conky.desktop"
  sudo rm -rf "$user_home/.config/conky"
done

[ -f "$MARKER" ] && rm -f "$MARKER"

log_ok "Conky/Config ${LANG_STEP_DONE:-Selesai uninstall}"

echo -e "${CYAN}↩️  ${LANG_BACK_TO_TOOLS:-Kembali ke menu tools} (5 detik)${NC}"
read -t 5 -p ""