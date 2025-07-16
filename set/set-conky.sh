#!/bin/bash
# Set/Reset VPS Info (Conky)
# Author: rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

clear
echo -e "${CYAN}${LANG_SET_VPS_INFO}${NC}"
echo "1. Enable/Reset Info VPS (Conky)"
echo "2. Disable Info VPS (Conky)"
echo "3. Kembali/Back"
read -p "Pilihan/Choice (1/2/3): " c_choice

case "$c_choice" in
  1)
    # Re-setup conky config (seperti di set-config.sh)
    sudo apt-get install -y conky
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
    log_ok "$LANG_SET_SUCCESS (VPS Info enabled/reset)"
    ;;
  2)
    # Disable conky dari autostart semua user baru
    rm -f /etc/skel/.config/autostart/conky.desktop
    log_ok "$LANG_SET_SUCCESS (VPS Info disabled)"
    ;;
  *)
    ;;
esac

echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU} (tekan Enter atau tunggu 10 detik)${NC}"
read -t 10 -p ""
exec bash ./main.sh