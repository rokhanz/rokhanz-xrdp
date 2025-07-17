#!/usr/bin/env bash
# set/set-config.sh — Configurasi Conky, wallpaper & Autologin XRDP
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Load bahasa & fungsi umum
source "$(dirname "${BASH_SOURCE[0]}")/set-language.sh"
source "../lib/common.sh"

# ANSI colors
: "${CYAN:='\033[0;36m'}" : "${GREEN:='\033[0;32m'}"
: "${YELLOW:='\033[0;33m'}": "${RED:='\033[0;31m'}" : "${NC:='\033[0m'}"

# ────────────────────────────────────────────────────────────
# 1) Install Conky & config di /etc/skel
echo -e "${CYAN}${LANG_STEP_CONFIG}${NC}"
if ! dpkg -l | grep -qw conky; then
  sudo apt-get install -y conky
fi

# buat folder skeleton
sudo mkdir -p /etc/skel/.config/conky /etc/skel/.config/autostart

# tulis conky.conf
sudo tee /etc/skel/.config/conky/conky.conf >/dev/null <<'EOL'
conky.config = {
  alignment = 'top_right', gap_x = 20, gap_y = 40,
  minimum_width = 300, own_window = true,
  own_window_type = 'desktop',
  own_window_transparent = true,
  update_interval = 5
}
conky.text = [[
${color white}${font Ubuntu:size=12}VPS INFO${font}${color}
Hostname: $nodename
IP:       $addr
CPU:      $cpu @ $freq_g GHz
RAM:      $mem/$memmax ($memperc%)
Disk:     $fs_used/$fs_size ($fs_used_perc)
Uptime:   $uptime
XRDP:     ${exec systemctl is-active xrdp}
Desktop:  ${exec grep '^exec ' /etc/xrdp/startwm.sh | cut -d' ' -f2}
]]
EOL

# tulis autostart
sudo tee /etc/skel/.config/autostart/conky.desktop >/dev/null <<'EOL'
[Desktop Entry]
Type=Application
Name=Conky
Exec=conky -c ~/.config/conky/conky.conf
Terminal=false
EOL

log_ok "$LANG_STEP_DONE"

# ────────────────────────────────────────────────────────────
# 2) Download wallpaper branding
wallpaper_url="https://raw.githubusercontent.com/rokhanz/myimg/main/assets/image/chips_rokhanz.png"
wallpaper_dest="/usr/share/backgrounds/chips_rokhanz.png"
if [ ! -f "$wallpaper_dest" ]; then
  sudo wget -qO "$wallpaper_dest" "$wallpaper_url" \
    && log_ok "Wallpaper branding $LANG_STEP_DONE" \
    || log_warn "Wallpaper $LANG_ERROR_FAILED"
fi

# ────────────────────────────────────────────────────────────
# 3) Autologin XRDP
# pastikan variabel XRDP_NEW_USER & XRDP_NEW_PASS sudah diekspor sebelumnya
if [[ -n "${XRDP_NEW_USER:-}" && -n "${XRDP_NEW_PASS:-}" ]]; then
  echo -e "${CYAN}🔐 Mengonfigurasi autologin XRDP untuk user ${XRDP_NEW_USER}${NC}"

  # sesman.ini
  sudo sed -i \
    -e "s|^;*AutoLoginUser=.*|AutoLoginUser=${XRDP_NEW_USER}|" \
    -e "s|^;*AutoLoginPass=.*|AutoLoginPass=${XRDP_NEW_PASS}|" \
    /etc/xrdp/sesman.ini

  # pilih session sesuai DE yang terpasang
  if command -v xfce4-session &>/dev/null; then
    SESSION="xfce4-session"
  elif command -v gnome-session &>/dev/null; then
    SESSION="gnome-session"
  elif command -v startplasma-x11 &>/dev/null; then
    SESSION="startplasma-x11"
  else
    SESSION="xfce4-session"
  fi

  # startwm.sh
  sudo sed -i -E \
    "s|^exec .*|exec dbus-launch --exit-with-session ${SESSION}|" \
    /etc/xrdp/startwm.sh

  log_ok "Autologin XRDP: user=${XRDP_NEW_USER}, session=${SESSION}"
else
  log_warn "Variabel XRDP_NEW_USER/XRDP_NEW_PASS belum diset, lewati autologin"
fi

# ────────────────────────────────────────────────────────────
# Selesai
echo -e "${GREEN}✅  ${LANG_STEP_DONE}${NC}"
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -p ""
