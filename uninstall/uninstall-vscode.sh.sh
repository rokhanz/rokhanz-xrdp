#!/usr/bin/env bash
# uninstall/uninstall-vscode.sh — Uninstall VSCode (app & all extensions)
# Author : rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Paths & file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAVEFILE="$SCRIPT_DIR/../save-ext.txt"
MARKER="$SCRIPT_DIR/../.installed_vscode_ext"
LOGDIR="$SCRIPT_DIR/../logs"
LOGFILE="$LOGDIR/error.log"
mkdir -p "$LOGDIR"

# Load bahasa & helper
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# Title
echo -e "${CYAN}========================================================${NC}"
echo -e "❌ ${LANG_STEP_UN_VSCODE:-Uninstall VSCode & Extensions}"
echo -e "========================================================${NC}"

# Cek ada VSCode
if ! command -v code >/dev/null 2>&1; then
    log_warn "${LANG_VSCODE_NOT_FOUND:-VSCode tidak ditemukan di sistem.}"
    write_marker "vscode_ext" false 2>/dev/null || true
    exit 0
fi

# Konfirmasi lanjut uninstall
echo -e "${YELLOW}⚠️  ${LANG_UNVSCODE_CONFIRM:-Ini akan menghapus SEMUA extension dan aplikasi VSCode dari server Anda!}${NC}"
read -r -p "${LANG_UNVSCODE_PROMPT:-Lanjutkan uninstall total? (y/n): }" confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "❌ ${LANG_UNVSCODE_CANCELLED:-Batal uninstall.}"
    sleep 2
    exit 0
fi

# Step 1: Uninstall extensions (pakai save-ext.txt jika ada)
echo -e "${CYAN}${LANG_UNVSCODE_EXT_RM:-Menghapus semua extension VSCode...}${NC}"
if [ -f "$SAVEFILE" ]; then
    while IFS= read -r ext; do
        code --uninstall-extension "$ext" && log_ok "Uninstall $ext" || log_warn "$ext gagal dihapus"
    done < "$SAVEFILE"
    rm -f "$SAVEFILE"
elif code --list-extensions | grep . &>/dev/null; then
    for ext in $(code --list-extensions); do
        code --uninstall-extension "$ext" && log_ok "Uninstall $ext" || log_warn "$ext gagal dihapus"
    done
else
    log_warn "${LANG_UNVSCODE_NO_EXT:-Tidak ada extension VSCode yang terinstall.}"
fi
[ -f "$MARKER" ] && rm -f "$MARKER"

# Step 2: Uninstall VSCode package
echo -e "${CYAN}${LANG_UNVSCODE_APP_RM:-Uninstall aplikasi VSCode (package, repo, config)...}${NC}"
sudo apt-get remove --purge -y code
sudo rm -rf ~/.config/Code
sudo rm -f /etc/apt/sources.list.d/vscode.list
sudo rm -f /usr/share/keyrings/packages.microsoft.gpg

log_ok "${LANG_UNVSCODE_DONE:-VSCode dan semua extension berhasil dihapus.}"

# Selesai, kembali ke menu utama (pause sebentar)
echo -e "${YELLOW}↩️  ${LANG_BACK_MAIN:-Tekan Enter atau tunggu 5 detik untuk kembali}${NC}"
read -t 5 -p ""
