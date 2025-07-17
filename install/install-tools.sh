#!/usr/bin/env bash
# install/install-tools.sh — Install Tools Bundle (Chrome, VLC, VSCode)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Direktori skrip ini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Muat bahasa & fungsi umum
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# Marker untuk bundle tools
MARKER="tools"

clear
echo -e "${CYAN}${LANG_TOOLS_MENU_TITLE}${NC}"

# Lewati jika sudah dipasang
if check_marker "$MARKER"; then
  log_ok "${LANG_ALREADY_INSTALLED}"
  exit 0
fi

# Install Google Chrome
run_step "${LANG_STEP_CHROME}" \
         "$SCRIPT_DIR/install-chrome.sh" \
         "dpkg -l | grep -qw google-chrome-stable"

# Install VLC
run_step "${LANG_STEP_VLC}" \
         "$SCRIPT_DIR/install-vlc.sh" \
         "dpkg -l | grep -qw vlc"

# Install VSCode
run_step "${LANG_STEP_VSCODE}" \
         "$SCRIPT_DIR/install-vscode.sh" \
         "dpkg -l | grep -qw code"

# Tandai sukses dan ringkasan
write_marker "$MARKER"
log_ok "${LANG_STEP_DONE}"
