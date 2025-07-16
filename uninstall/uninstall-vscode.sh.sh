#!/bin/bash
# Uninstall VSCode (app & all extension) - rokhanz v1.0.0 - MIT

. ./set/set-language.sh

SAVEFILE="save-ext.txt"
MARKER=".installed_vscode_ext"
LOGFILE="./logs/error.log"
[ -d ./logs ] || mkdir ./logs

log_error() { echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOGFILE"; }

clear
echo "========================================================"
echo "❌ Uninstall VSCode & Semua Extension"
echo "========================================================"

if ! command -v code >/dev/null 2>&1; then
    echo "❌ VSCode tidak ditemukan di sistem."
    log_error "VSCode app not found for uninstall."
    echo -e "${LANG_BACK_MAIN}"
    read -t 10 -p ""
    exec bash ./main.sh
fi

echo "⚠️  Ini akan menghapus SEMUA extension dan aplikasi VSCode dari server Anda!"
read -p "Lanjutkan uninstall total? (y/n): " confirm
[[ ! "$confirm" =~ ^[Yy]$ ]] && echo "Batal uninstall."; sleep 2; exec bash ./main.sh

# Step 1: Uninstall extension (save-ext.txt jika ada, jika tidak hapus semua)
echo "🧹 Menghapus semua extension VSCode..."
if [ -f "$SAVEFILE" ]; then
    while IFS= read -r ext; do
        code --uninstall-extension "$ext" && echo "✅ Uninstall $ext" || { echo "⚠️ $ext gagal dihapus"; log_error "Failed uninstall $ext"; }
    done < "$SAVEFILE"
    rm -f "$SAVEFILE"
elif code --list-extensions | grep . &>/dev/null; then
    # Hapus semua extension yang terinstall (jika save-ext.txt tidak ada)
    for ext in $(code --list-extensions); do
        code --uninstall-extension "$ext" && echo "✅ Uninstall $ext" || { echo "⚠️ $ext gagal dihapus"; log_error "Failed uninstall $ext"; }
    done
else
    echo "🔹 Tidak ada extension VSCode yang terinstall."
fi
rm -f "$MARKER"

# Step 2: Uninstall VSCode package
echo "❌ Uninstall aplikasi VSCode (package, repo, config)..."
sudo apt-get remove --purge -y code
sudo rm -rf ~/.config/Code
sudo rm -f /etc/apt/sources.list.d/vscode.list
sudo rm -f /usr/share/keyrings/packages.microsoft.gpg

echo "✅ VSCode dan semua extension berhasil dihapus."

echo -e "${YELLOW}↩️  ${LANG_BACK_MAIN} (3 detik)${NC}"
sleep 3
exec bash ./main.sh