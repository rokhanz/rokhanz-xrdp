#!/usr/bin/env bash
# Set/Reset VPS Info (Conky)
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

. ./set/set-language.sh 2>/dev/null || true

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

clear
echo -e "${CYAN}${LANG_SET_VPS_INFO:-Set VPS Info (Conky)}${NC}"
echo "1. ${LANG_SET_CONKY_ENABLE:-Enable/Reset Info VPS (Conky)}"
echo "2. ${LANG_SET_CONKY_DISABLE:-Disable Info VPS (Conky)}"
echo "3. ${LANG_BACK_TO_MAIN_MENU:-Kembali/Back}"
read -r -p "${LANG_MENU_PROMPT:-Pilihan/Choice (1/2/3): }" c_choice

case "$c_choice" in
  1)
    # Enable/Reset conky config (untuk user baru)
    if sudo apt-get install -y conky; then
      mkdir -p /etc/skel/.config/conky
      cat > /etc/skel/.config/conky/conky.conf <<'EOL'
conky.config = {
  alignment = 'top_right',
  gap_x = 20,
  gap_y = 40,
  minimum_width = 300,
  maximum_width = 300,
  minimum_height = 200,
  own_window = true,
  own_window_type = 'desktop',
  own_window_transparent = true,
  own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
  double_buffer = true,
  draw_shades = false,
  draw_outline = false,
  draw_borders = false,
  use_xft = true,
  xftalpha = 0.8,
  update_interval = 5
}
conky.text = [[
${color white}${font Ubuntu:style=Bold:size=12}VPS SPECIFICATIONS${font}${color}
${color grey}=================================${color}
${color white}Hostname: ${color grey}$nodename
${color white}IP: ${color grey}$addr
${color white}CPU: ${color grey}$cpu ${color white}@ ${color grey}$freq_g GHz
${color white}RAM: ${color grey}$mem/$memmax ($memperc%)
${color white}Storage: ${color grey}$fs_used/$fs_size ($fs_used_perc)
${color white}Uptime: ${color grey}$uptime
${color grey}=================================${color}
${color white}XRDP Status: ${color grey}${exec systemctl is-active xrdp}
${color white}Desktop: ${color grey}${exec cat /etc/xrdp/startwm.sh | grep '^exec' | cut -d' ' -f2}
]]
EOL
      mkdir -p /etc/skel/.config/autostart
      cat > /etc/skel/.config/autostart/conky.desktop <<EOL
[Desktop Entry]
Type=Application
Name=Conky
Exec=conky -c ~/.config/conky/conky.conf
StartupNotify=false
Terminal=false
EOL
      log_ok "${LANG_SET_SUCCESS:-Konfigurasi berhasil} (VPS Info enabled/reset)"
    else
      log_error "${LANG_SET_FAIL:-Gagal mengaktifkan Conky}"
    fi
    ;;
  2)
    # Disable conky autostart pada user baru
    rm -f /etc/skel/.config/autostart/conky.desktop
    log_ok "${LANG_SET_SUCCESS:-Konfigurasi berhasil} (VPS Info disabled)"
    ;;
  3)
    # Kembali, tidak perlu pesan
    ;;
  *)
    ;;
esac
