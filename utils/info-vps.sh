#!/usr/bin/env bash
# utils/info-vps.sh — Cek Info & Status VPS XRDP
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Load bahasa
source "$(dirname "$0")/../set/set-language.sh"

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; NC='\033[0m'

clear
echo -e "${CYAN}======================================"
echo -e "   ${LANG_INFO_TITLE}"
echo -e "======================================${NC}"

echo -e "Hostname       : $(hostname)"
echo -e "Public IP      : $(hostname -I | awk '{print $1}')"
echo -e "OS             : $(lsb_release -ds 2>/dev/null || \
                         awk -F= '/^PRETTY_NAME/{gsub(/\"/,""); print $2}' /etc/os-release)"
echo -e "Kernel         : $(uname -r)"
echo -e "Uptime         : $(uptime -p)"
echo -e "CPU            : $(awk -F: '/model name/{print $2; exit}' /proc/cpuinfo | sed 's/^ //')"

# RAM Used/Total
ram="$(free -h | awk '/^Mem:/ {printf "%s / %s\n", $3, $2}')"
echo -e "RAM Used/Total : $ram"

# Disk Used/Total (root)
disk="$(df -h / | awk 'NR==2 {printf "%s / %s\n", $3, $2}')"
echo -e "Disk Used/Total: $disk"

# Total user (UID >=1000)
total_users="$(awk -F: '$3>=1000 && $1!="nobody"{count++} END{print count+0}' /etc/passwd)"
echo -e "Total Users    : $total_users"

# XRDP status, port, session
echo -e "XRDP Status    : $(systemctl is-active xrdp 2>/dev/null)"
echo -e "XRDP Port      : $(grep -m1 '^port=' /etc/xrdp/xrdp.ini 2>/dev/null | cut -d= -f2 || echo '3389')"
sess="$(grep -E '^exec ' /etc/xrdp/startwm.sh 2>/dev/null | awk '{print $2}')"
echo -e "Desktop Env    : ${sess:--}"

echo -e "${GREEN}${LANG_TIPS_STATUS}${NC}"
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -p ""
