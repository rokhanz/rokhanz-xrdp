#!/usr/bin/env bash
# set/set-config.sh — Konfigurasi Conky, Wallpaper, Autologin XRDP
# Author : rokhanz
# Version: 1.0.2
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Load bahasa & fungsi umum
source "$(dirname "${BASH_SOURCE[0]}")/set-language.sh"
source "../lib/common.sh"

: "${CYAN:='\033[0;36m'}"
: "${GREEN:='\033[0;32m'}"
: "${YELLOW:='\033[0;33m'}"
: "${RED:='\033[0;31m'}"
: "${NC:='\033[0m'}"

echo -e "${CYAN}${LANG_STEP_CONFIG}${NC}"

# 1. Install Conky & config di /etc/skel
if ! dpkg -l | grep -qw conky; then
  sudo apt-get install -y conky
fi
sudo mkdir -p /etc/skel/.config/conky /etc/skel/.config/autostart

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

sudo tee /etc/skel/.config/autostart/conky.desktop >/dev/null <<'EOL'
[Desktop Entry]
Type=Application
Name=Conky
Exec=conky -c ~/.config/conky/conky.conf
Terminal=false
EOL

log_ok "$LANG_STEP_DONE"

# 2. Download wallpaper branding
wallpaper_url="https://raw.githubusercontent.com/rokhanz/myimg/main/assets/image/chips_rokhanz.png"
wallpaper_dest="/usr/share/backgrounds/chips_rokhanz.png"
if [ ! -f "$wallpaper_dest" ]; then
  if sudo wget -qO "$wallpaper_dest" "$wallpaper_url"; then
    log_ok "Wallpaper branding $LANG_STEP_DONE"
  else
    log_warn "Wallpaper $LANG_ERROR_FAILED"
  fi
fi

# 3. Autologin XRDP (pakai variable XRDP_NEW_USER & XRDP_NEW_PASS dari proses add user)
AUTOLOGIN_OK=0
if [[ -n "${XRDP_NEW_USER:-}" && -n "${XRDP_NEW_PASS:-}" ]]; then
  echo -e "${CYAN}🔐 Mengonfigurasi autologin XRDP untuk user ${XRDP_NEW_USER}${NC}"

  # sesman.ini patch
  if [ -f /etc/xrdp/sesman.ini ]; then
    sudo sed -i \
      -e "s|^;*AutoLoginUser=.*|AutoLoginUser=${XRDP_NEW_USER}|" \
      -e "s|^;*AutoLoginPass=.*|AutoLoginPass=${XRDP_NEW_PASS}|" \
      /etc/xrdp/sesman.ini
    AUTOLOGIN_OK=1
  else
    log_warn "/etc/xrdp/sesman.ini tidak ditemukan, skip autologin!"
  fi

  # Pilih session DE
  if command -v xfce4-session &>/dev/null; then
    SESSION="xfce4-session"
  elif command -v gnome-session &>/dev/null; then
    SESSION="gnome-session"
  elif command -v startplasma-x11 &>/dev/null; then
    SESSION="startplasma-x11"
  else
    SESSION="xfce4-session"
  fi

  # Patch startwm.sh
  if [ -f /etc/xrdp/startwm.sh ]; then
    sudo sed -i -E "s|^exec .*|exec dbus-launch --exit-with-session ${SESSION}|" /etc/xrdp/startwm.sh
    log_ok "Autologin XRDP: user=${XRDP_NEW_USER}, session=${SESSION}"
  else
    log_warn "/etc/xrdp/startwm.sh tidak ditemukan. Session tidak diubah."
  fi
else
  log_warn "Variabel XRDP_NEW_USER/XRDP_NEW_PASS belum diset, lewati autologin."
fi

if [[ "$AUTOLOGIN_OK" -eq 1 ]]; then
  sudo systemctl restart xrdp || log_warn "Gagal restart xrdp service."
fi

echo -e "${GREEN}✅  ${LANG_STEP_DONE}${NC}"
echo -e "${YELLOW}${LANG_BACK_TO_MAIN_MENU}${NC}"
read -r -p "${LANG_BACK_TO_MAIN_MENU}"
