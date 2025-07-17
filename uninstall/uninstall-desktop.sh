#!/usr/bin/env bash
# uninstall/uninstall-desktop.sh — Uninstall Desktop Environment (XFCE, GNOME, KDE, dll)
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Load bahasa & helper umum (run_step, log_ok, log_warn, log_error, check_marker, write_marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Title
echo -e "${CYAN}${LANG_STEP_UN_DESKTOP:-Uninstall Desktop Environment}${NC}"

# ────────────────────────────────────────────────────────────
# Marker key
MARKER="desktop"

# ────────────────────────────────────────────────────────────
# Check if any DE package is installed
DE_PACKAGES=(xfce4 xfce4-goodies gnome-session gdm3 ubuntu-desktop plasma-desktop kde-standard)
any_installed=false
for pkg in "${DE_PACKAGES[@]}"; do
  if dpkg -l | grep -qw "$pkg"; then
    any_installed=true
    break
  fi
done

if ! $any_installed; then
  log_warn "${LANG_ALREADY_UNINSTALLED:-Desktop Environment sudah dihapus}"
  # Remove marker if exists
  write_marker "$MARKER" false 2>/dev/null || true
  exit 0
fi

# ────────────────────────────────────────────────────────────
# Purge DE packages
run_step "${LANG_STEP_UN_DESKTOP:-Remove Desktop Environment}" "\
sudo apt-get purge -y ${DE_PACKAGES[*]}" \
"dpkg -l | grep -qw xfce4 || dpkg -l | grep -qw gnome-session || dpkg -l | grep -qw plasma-desktop"

# ────────────────────────────────────────────────────────────
# Autoremove unused dependencies
run_step "${LANG_STEP_AUTO_REMOVE:-Autoremove unused packages}" "sudo apt-get autoremove -y"

# ────────────────────────────────────────────────────────────
# Cleanup marker
write_marker "$MARKER" false

# ────────────────────────────────────────────────────────────
# Done
log_ok "${LANG_STEP_DONE:-✅  Desktop Environment berhasil di-uninstall}"
