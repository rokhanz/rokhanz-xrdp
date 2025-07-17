#!/usr/bin/env bash
# uninstall/uninstall-deps.sh — Uninstall Base Dependencies for XRDP
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Load bahasa & common helpers (run_step, log_ok, log_error)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Title
echo -e "${CYAN}${LANG_STEP_UNINSTALL_DEPS:-Uninstall Base Dependencies}${NC}"

# ────────────────────────────────────────────────────────────
# Packages to remove
DEPS=(wget curl gpg dbus-x11 xauth)

# ────────────────────────────────────────────────────────────
# Uninstall dependencies
run_step "${LANG_STEP_UNINSTALL_DEPS:-Uninstall base dependencies}" \
         "sudo apt-get remove --purge -y ${DEPS[*]}" \
         "dpkg -l | grep -qw wget"

# ────────────────────────────────────────────────────────────
# Autoremove leftover packages
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove unused packages}" \
         "sudo apt-get autoremove -y"

# ────────────────────────────────────────────────────────────
# Summary
log_ok "${LANG_STEP_DONE:-✅ Base dependencies uninstalled}"
