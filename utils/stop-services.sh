#!/bin/bash
# utils/stop-services.sh — Stop XRDP services & kill zombie processes
# Author: rokhanz
# Version: 1.0.0
# License: MIT

# Stop & disable systemd services
SVCS=(xrdp xrdp-sesman)
echo "🔒 Stopping XRDP services..."
for svc in "${SVCS[@]}"; do
  sudo systemctl stop "$svc"   >/dev/null 2>&1 || true
  sudo systemctl disable "$svc" >/dev/null 2>&1 || true
  echo "  • $svc stopped"
done
echo

# Kill leftover XRDP-related processes
echo "🪓 Killing leftover XRDP processes..."
PIDS=$(pgrep -f "xrdp-sesman|xrdp-chansrv|xrdp")
if [ -n "$PIDS" ]; then
  echo "  • Found PIDs: $PIDS"
  echo "$PIDS" | xargs sudo kill -9 >/dev/null 2>&1 || true
  echo "  • Processes killed"
else
  echo "  • No leftover XRDP processes"
fi
