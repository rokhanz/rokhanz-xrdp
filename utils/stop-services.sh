#!/usr/bin/env bash
# utils/stop-services.sh — Stop XRDP services & kill zombie processes
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Stop & disable XRDP services (ignore error jika tidak ada)
SVCS=(xrdp xrdp-sesman)
echo -e "${CYAN}🔒 Stopping XRDP services...${NC}"
for svc in "${SVCS[@]}"; do
  if systemctl list-unit-files | grep -qw "$svc.service"; then
    sudo systemctl stop "$svc" >/dev/null 2>&1 || true
    sudo systemctl disable "$svc" >/dev/null 2>&1 || true
    echo -e "  • $svc ${GREEN}stopped${NC}"
  else
    echo -e "  • $svc ${YELLOW}service not found${NC}"
  fi
done
echo

# Kill leftover XRDP-related processes
echo -e "${CYAN}🪓 Killing leftover XRDP processes...${NC}"
PIDS=$(pgrep -f "xrdp-sesman|xrdp-chansrv|xrdp" || true)
if [ -n "$PIDS" ]; then
  echo -e "  • Found PIDs: $PIDS"
  echo "$PIDS" | xargs -r sudo kill -9 >/dev/null 2>&1 || true
  echo -e "  • ${GREEN}Processes killed${NC}"
else
  echo -e "  • ${GREEN}No leftover XRDP processes${NC}"
fi
