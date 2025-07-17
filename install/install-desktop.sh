#!/usr/bin/env bash
# install/install-desktop.sh — Install Desktop Environment
# Author    : rokhanz
# Version   : 1.0.0
# License   : MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Tentukan direktori skrip ini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ────────────────────────────────────────────────────────────
# Muat bahasa & fungsi umum (run_step, log_*, check_marker, write_marker)
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Pilihan Desktop Environment (via ENV atau default xfce4)
DE_CHOICE="${DE_CHOICE:-xfce4}"

case "$DE_CHOICE" in
  xfce4)
    PKGS="xfce4 xfce4-goodies xorg dbus-x11 xauth"
    CHECK="dpkg -l | grep -qw xfce4"
    DE_LABEL="XFCE4"
    ;;
  plasma)
    PKGS="plasma-desktop kde-standard"
    CHECK="dpkg -l | grep -qw plasma-desktop"
    DE_LABEL="KDE Plasma"
    ;;
  gnome)
    PKGS="gnome-session gdm3 ubuntu-desktop"
    CHECK="dpkg -l | grep -qw gnome-session"
    DE_LABEL="GNOME"
    ;;
  *)
    log_error "${LANG_ERROR_FAILED//\{item\}/Desktop Environment: $DE_CHOICE}"
    exit 1
    ;;
esac

# ────────────────────────────────────────────────────────────
# Tampilkan langkah
echo -e "${CYAN}${LANG_INSTALL_STEP_DESKTOP//\{item\}/$DE_LABEL}${NC}"

# ────────────────────────────────────────────────────────────
# Marker untuk desktop
MARKER="desktop"

# Jika sudah di‐marker, skip
if check_marker "$MARKER"; then
  log_warn "${DE_LABEL} ${LANG_INSTALL_SKIP}"
  exit 0
fi

# Jalankan instalasi dengan helper run_step
run_step "${DE_LABEL} ${LANG_INSTALL_STEP_DESKTOP//\{item\}/$DE_LABEL}" \
         "sudo apt-get install -y $PKGS" \
         "$CHECK"

# Tandai sukses
write_marker "$MARKER"
