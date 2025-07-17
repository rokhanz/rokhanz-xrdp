#!/usr/bin/env bash
# install/install-xrdp-core.sh — Install XRDP Core
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Direktori skrip ini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Load bahasa & helper umum (run_step, log_ok, log_warn, log_error, check_marker, write_marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Tampilkan langkah instalasi
echo -e "${CYAN}${LANG_INSTALL_STEP_XRDP}${NC}"

# ────────────────────────────────────────────────────────────
# Tandai dengan marker "xrdp" agar tidak diulang
MARKER="xrdp"

if check_marker "$MARKER"; then
  log_warn "${LANG_ALREADY_INSTALLED:-✔️  XRDP sudah terpasang}"
  exit 0
fi

# ────────────────────────────────────────────────────────────
# Jalankan instalasi XRDP & XorgXrdp
run_step "${LANG_STEP_XRDP:-Install XRDP Core}" \
         "sudo apt-get install -y xrdp xorgxrdp" \
         "dpkg -l | grep -qw xrdp"

# ────────────────────────────────────────────────────────────
# Tulis marker dan konfirmasi sukses
write_marker "$MARKER"
log_ok "${LANG_STEP_DONE:-✅  XRDP Core selesai dipasang}"
