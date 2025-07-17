#!/usr/bin/env bash
# install/install-vlc.sh — Install VLC media player
# Author : rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Tentukan direktori skrip
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Muat bahasa & fungsi umum (logging, run_step, marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# Tampilkan langkah
echo -e "${CYAN}${LANG_STEP_VLC}${NC}"

# Marker untuk VLC
MARKER="vlc"

# Jika sudah terpasang, skip
if check_marker "$MARKER"; then
  log_ok "${LANG_ALREADY_INSTALLED}"
  exit 0
fi

# Lakukan instalasi VLC
run_step "${LANG_STEP_VLC}" \
         "sudo apt-get update && sudo apt-get install -y vlc" \
         "dpkg -l | grep -qw vlc"

# Tandai sukses
write_marker "$MARKER"
