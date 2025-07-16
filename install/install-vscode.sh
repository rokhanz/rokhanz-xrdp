#!/bin/bash
# Install VSCode & extensions (multi-bahasa, marker, autologging, kembali ke main)
# Author: rokhanz

. ./set/set-language.sh

SAVEFILE="save-ext.txt"
MARKER=".installed_vscode_ext"
LOGFILE="./logs/error.log"
[ -d ./logs ] || mkdir ./logs

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOGFILE"
}

clear
echo "========================================================"
echo "🚀 VSCode & Extensions Installer"
echo "========================================================"

if ! ping -c 1 google.com >/dev/null 2>&1; then
  echo "❌ Tidak ada koneksi internet. Pastikan koneksi stabil dulu."
  log_error "No internet for install-vscode."
  sleep 3
  exec bash ./main.sh
fi

sudo apt update
sudo apt install -y wget gpg curl

# Install VSCode jika belum ada
if ! command -v code >/dev/null 2>&1; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
fi

if [ ! -f "$SAVEFILE" ]; then
  echo "${LANG_ERR_NO_SAVEFILE}"
  ./menu/menu-extension.sh
fi

echo "🔧 Menginstall extension VSCode..."
err=0
while IFS= read -r ext; do
  code --install-extension "$ext" && echo "✅ $ext" || { echo "❌ $ext (gagal)"; err=1; log_error "Failed install $ext"; }
done < "$SAVEFILE"

if [ "$err" -eq 0 ]; then
  echo "${LANG_VSCODE_SUCCESS}"
  touch "$MARKER" && echo "${LANG_MARKER_INSTALL}"
else
  echo "${LANG_VSCODE_ERROR}"
  log_error "Ada extension gagal install."
fi

echo -e "${LANG_BACK_MAIN}"
read -t 10 -p ""
exec bash ./main.sh
