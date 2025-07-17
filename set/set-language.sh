#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# Direktori root (tempat main.sh)
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Folder bahasa
LANG_DIR="$ROOT_DIR/set/lang"

# 1) Dapatkan daftar kode bahasa (tanpa .sh)
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')

# 2) Coba load pilihan yang disimpan
if [[ -f "$ROOT_DIR/.LANG_SET" ]]; then
  SAVED="$(<"$ROOT_DIR/.LANG_SET")"
  if [[ " ${LANG_LIST[*]} " == *" $SAVED "* ]]; then
    LANG_SET="$SAVED"
  else
    rm -f "$ROOT_DIR/.LANG_SET"
  fi
fi

# 3) Jika belum ada, tampilkan menu
if [[ -z "${LANG_SET:-}" ]]; then
  echo
  echo "🌐  Pilih bahasa / Choose language:"
  for i in "${!LANG_LIST[@]}"; do
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    name=$(grep -m1 '^LANG_NAME=' "$file" | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" | cut -d= -f2- | tr -d '"')
    printf "  [%2d] %s  %s\n" $((i+1)) "$emoji" "$name"
  done
  echo
  read -r -p "⏩   Pilihan / Choice [1-${#LANG_LIST[@]}] (default 1): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel>=1 && sel<=${#LANG_LIST[@]} )); then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    echo "⚠️  Pilihan tidak valid, gunakan default."
    LANG_SET="${LANG_LIST[0]}"
  fi
  echo "$LANG_SET" > "$ROOT_DIR/.LANG_SET"
  # Tampilkan konfirmasi
  file="$LANG_DIR/$LANG_SET.sh"
  emoji=$(grep -m1 '^LANG_EMOJI=' "$file" | cut -d= -f2- | tr -d '"')
  name=$(grep -m1 '^LANG_NAME='  "$file" | cut -d= -f2- | tr -d '"')
  echo "✅   Bahasa dipilih: $emoji $name"
  echo
fi

# 4) Source file bahasa
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [[ -f "$LANG_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo "🚨  File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi
