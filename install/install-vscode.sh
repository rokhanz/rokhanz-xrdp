#!/usr/bin/env bash
# install/install-vscode.sh — Install VSCode & Extensions (multi-bahasa, logging, marker)
# Author : rokhanz
# Version: 1.0.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Directories & files
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAVEFILE="$SCRIPT_DIR/../save-ext.txt"
LOGDIR="$SCRIPT_DIR/../logs"
LOGFILE="$LOGDIR/error.log"
MARKER="vscode_ext"

mkdir -p "$LOGDIR"

# ────────────────────────────────────────────────────────────
# Load bahasa & fungsi umum
source "$SCRIPT_DIR/../set/set-language.sh"
source "$SCRIPT_DIR/../lib/common.sh"

# ────────────────────────────────────────────────────────────
# Banner
echo -e "${CYAN}========================================================${NC}"
echo -e "🚀 ${LANG_STEP_VSCODE_INSTALL:-Install VSCode & Extensions}"
echo -e "========================================================${NC}"

# ────────────────────────────────────────────────────────────
# 1) Cek koneksi internet
if ! ping -c1 google.com &>/dev/null; then
  log_error "${LANG_ERR_NO_INTERNET:-❌  Tidak ada koneksi internet}"
  exit 1
fi

# ────────────────────────────────────────────────────────────
# 2) Update & pasang CLI prerequisites
run_step "${LANG_STEP_UPDATE:-Update package lists}"       "sudo apt-get update"
run_step "${LANG_STEP_INSTALL_CLI:-Install prerequisites}" "sudo apt-get install -y wget gpg curl"

# ────────────────────────────────────────────────────────────
# 3) Pasang VSCode kalau belum ada
if ! command -v code &>/dev/null; then
  run_step "${LANG_STEP_VSCODE:-Install VSCode}" "\
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
sudo install -o root -g root -m644 packages.microsoft.gpg /usr/share/keyrings/ && \
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/vscode stable main' | \
sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null && \
rm -f packages.microsoft.gpg && \
sudo apt-get update && \
sudo apt-get install -y code"
else
  log_ok "${LANG_ALREADY_INSTALLED:-✅  VSCode sudah terpasang}"
fi

# ────────────────────────────────────────────────────────────
# 4) Pastikan file daftar extension ada (otomatis buat jika belum)
if [ ! -f "$SAVEFILE" ]; then
  log_warn "${LANG_WARN_NO_SAVEFILE:-⚠️  Daftar extension tidak ditemukan, membuat $SAVEFILE}"
  touch "$SAVEFILE"
  log_ok   "${LANG_INFO_SAVEFILE_CREATED:-✅  File save-ext.txt berhasil dibuat. Silakan isi dengan extension.}"
fi

# ────────────────────────────────────────────────────────────
# 5) Pasang extensions jika belum pernah
if check_marker "$MARKER"; then
  log_ok "${LANG_EXT_ALREADY_INSTALLED:-✅  Semua extension sudah terpasang}"
  exit 0
fi

echo -e "${CYAN}${LANG_EXT_INSTALLING:-Menginstall extension VSCode...}${NC}"
err=0
while IFS= read -r ext; do
  [[ -z "$ext" ]] && continue
  if code --install-extension "$ext"; then
    log_ok "✅  $ext"
  else
    log_error "❌  Gagal install extension: $ext"
    err=1
  fi
done < "$SAVEFILE"

if [ "$err" -eq 0 ]; then
  write_marker "$MARKER"
  log_ok "${LANG_EXT_DONE:-✅  Semua extension berhasil dipasang}"
else
  log_error "${LANG_EXT_ERROR:-❌  Beberapa extension gagal dipasang}"
  exit 1
fi
```0
