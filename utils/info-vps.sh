#!/usr/bin/env bash
# utils/info-vps.sh — VPS & XRDP Status Info
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Load bahasa
source ./set/set-language.sh 2>/dev/null || true

# ANSI COLORS
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

clear
echo -e "${CYAN}======================================"
echo -e "   ${LANG_INFO_TITLE:-ℹ️  Info & Status VPS XRDP}"
echo -e "======================================${NC}"

echo -e "Hostname       : $(hostname)"
echo -e "Public IP      : $(hostname -I | awk '{print $1}')"
echo -e "OS             : $(lsb_release -ds 2>/dev/null || grep -m1 PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo -e "Kernel         : $(uname -r)"
echo -e "Uptime         : $(uptime -p)"
echo -e "CPU            : $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //')"
echo -e "RAM Used/Total : $(free -h | awk '/^Mem:/ {print $3 \" / \" $2}')"
echo -e "Disk Used/Total: $(df -h / | awk '/\/$/ {print $3 \" / \" $2}')"
echo -e "Total Users    : $(awk -F: '$3>=1000&&$1!="nobody"{c++}END{print c+0}' /etc/passwd)"
echo -e "XRDP Status    : $(systemctl is-active xrdp 2>/dev/null || echo 'inactive')"
echo -e "XRDP Port      : $(grep -m1 '^port=' /etc/xrdp/xrdp.ini 2>/dev/null | cut -d= -f2 || echo '3389')"
echo -e "Desktop Env    : $(cat /etc/xrdp/startwm.sh 2>/dev/null | grep '^exec' | awk '{print $2}' || echo '-')"

echo
echo -e "${GREEN}${LANG_TIPS_STATUS:-Tips: Gunakan menu SET untuk pengaturan lanjutan.}${NC}"
echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU:-Tekan Enter untuk kembali}${NC}"
read -r -p ""
