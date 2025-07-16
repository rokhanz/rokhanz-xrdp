#!/bin/bash
# Set/Config: conky, autostart, custom config, wallpaper branding
# Author : rokhanz
# Version: 1.0.0
# License: MIT

. ./set/set-language.sh

CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'

log_ok()    { echo -e "${GREEN}${LANG_SUCCESS_EMOJI:-✅}  $1${NC}"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI:-⚠️}  $1${NC}"; }
log_error() { echo -e "${RED}${LANG_FAIL_EMOJI:-❌}  $1${NC}"; }

echo -e "${CYAN}$LANG_INSTALL_STEP_CONFIG${NC}"

# --- Install Conky jika belum ada
if ! dpkg -l | grep -qw conky; then
  sudo apt-get install -y conky || log_warn "Conky $LANG_ERROR_FAILED"
fi

# --- Buat config conky & autostart di /etc/skel (untuk user baru)
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

# --- Download wallpaper (branding)
wallpaper_url="https://raw.githubusercontent.com/rokhanz/myimg/main/assets/image/chips_rokhanz.png"
wallpaper_dest="/usr/share/backgrounds/chips_rokhanz.png"
if [ ! -f "$wallpaper_dest" ]; then
  wget -qO "$wallpaper_dest" "$wallpaper_url" && log_ok "Wallpaper branding $LANG_STEP_DONE" || log_warn "Wallpaper $LANG_ERROR_FAILED"
fi

# --- Sukses
log_ok "$LANG_STEP_DONE"

echo -e "${YELLOW}↩️  ${LANG_BACK_TO_MAIN_MENU:-Kembali ke menu utama}${NC}"
read -t 5 -p ""
