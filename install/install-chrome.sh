#!/usr/bin/env bash
# install/install-chrome.sh — Install Google Chrome (modular, logging, marker)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ——————————————————————————————————————————————
# Load bahasa & common helpers
source "$(dirname "$0")/../set/set-language.sh"
source "$(dirname "$0")/../lib/common.sh"

# ——————————————————————————————————————————————
# Define marker name (used by check_marker/write_marker)
MARKER="chrome"

clear
echo -e "${CYAN}🌐  ${LANG_STEP_CHROME}${NC}"

# ——————————————————————————————————————————————
# Skip if we’ve already marked this as installed
if check_marker "$MARKER"; then
  log_ok "${LANG_ALREADY_INSTALLED}"
  exit 0
fi

# ——————————————————————————————————————————————
# If Chrome is already on the system, write marker and skip
if dpkg -l | grep -qw google-chrome-stable; then
  write_marker "$MARKER"
  log_ok "${LANG_ALREADY_INSTALLED_SYSTEM}"
  exit 0
fi

# ——————————————————————————————————————————————
# 1) Update package lists
run_step "${LANG_STEP_UPDATE}" "sudo apt-get update"

# 2) Download the .deb
run_step "${LANG_STEP_DOWNLOAD}" \
  "wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# 3) Install the .deb
run_step "${LANG_STEP_INSTALL}" "sudo dpkg -i /tmp/chrome.deb"

# 4) Fix any missing deps
run_step "${LANG_STEP_FIX_DEPS}" "sudo apt-get install -f -y"

# ——————————————————————————————————————————————
# Mark success & cleanup
write_marker "$MARKER"
log_ok "${LANG_STEP_DONE}"
sudo rm -f /tmp/chrome.deb
