#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser
# Version: 1.0.2
# License: MIT
# Copyright (c) 2025 rokhanz

set -euo pipefail
IFS=$'\n\t'

# lokasi file bahasa
LANG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/lang" && pwd)"
if [ ! -d "$LANG_DIR" ]; then
  echo "🚨 ERROR: Folder bahasa tidak ditemukan: $LANG_DIR" >&2
  exit 1
fi

# ambil daftar bahasa (tanpa .sh)
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')
if [ ${#LANG_LIST[@]} -eq 0 ]; then
  echo "🚨 ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# kalau sudah pernah dipilih, baca dari file .LANG_SET
if [ -f ".LANG_SET" ]; then
  LANG_SET="$(<.LANG_SET)"
  # validasi isinya
  if [[ ! " ${LANG_LIST[*]} " =~ " ${LANG_SET} " ]]; then
    echo "⚠️  Pilihan lama tidak valid, reset pilihan." >&2
    rm -f .LANG_SET
    LANG_SET=""
  fi
fi

# jika LANG_SET belum diisi, tampilkan prompt
if [ -z "${LANG_SET:-}" ]; then
  echo
  echo "🌐  Pilih bahasa / Choose language:"
  for i in "${!LANG_LIST[@]}"; do
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    # ambil nama & emoji dari file bahasa
    name=$(grep -m1 '^LANG_NAME=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
    printf "  [%2d] %s  %s\n" $((i+1)) "$emoji" "$name"
  done
  echo
  read -rp "⏩   Pilihan / Choice [1-${#LANG_LIST[@]}] (default 1): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel>=1 && sel<=${#LANG_LIST[@]} )); then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    LANG_SET="${LANG_LIST[0]}"
    echo "⚠️  Pilihan tidak valid, menggunakan default: ${LANG_SET}"
  fi
  printf '%s' "$LANG_SET" > .LANG_SET
  echo
  # tampilkan konfirmasi
  emoji=$(grep -m1 '^LANG_EMOJI=' "$LANG_DIR/$LANG_SET.sh" | cut -d= -f2- | tr -d '"')
  name=$(grep -m1 '^LANG_NAME='  "$LANG_DIR/$LANG_SET.sh" | cut -d= -f2- | tr -d '"')
  echo "✅   Bahasa dipilih: $emoji  $name"
  echo
fi

export LANG_SET

# source file bahasa
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [ -f "$LANG_FILE" ]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo "🚨 ERROR: File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi
