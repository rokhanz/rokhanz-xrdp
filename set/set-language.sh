#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser & loader (cached, multi-script)
# Author: rokhanz
# Version: 1.0.1
# License: MIT

set -euo pipefail

# Dir bahasa
LANG_DIR="$(dirname "${BASH_SOURCE[0]}")/lang"
LANG_FILE_CACHE=".LANG_SET"

# Deteksi & muat dari cache jika ada
if [[ -f "$LANG_FILE_CACHE" ]]; then
  LANG_SET="$(cat "$LANG_FILE_CACHE" | head -n1 | tr -d '[:space:]')"
fi

# Cari semua file .sh di lang/
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')
if [[ ${#LANG_LIST[@]} -eq 0 ]]; then
  echo "🚨 ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# Prompt bahasa hanya jika LANG_SET kosong/invalid
if [[ -z "${LANG_SET:-}" || ! " ${LANG_LIST[*]} " =~ " ${LANG_SET} " ]]; then
  echo
  echo -e "🌐  Pilih bahasa / Choose language:"
  for i in "${!LANG_LIST[@]}"; do
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    name=$(grep -m1 '^LANG_NAME=' "$file" | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" | cut -d= -f2- | tr -d '"')
    [[ -z "$name"  ]] && name="$code"
    [[ -z "$emoji" ]] && emoji="🌐"
    printf "  [%d] %s  %s\n" $((i+1)) "$emoji" "$name"
  done
  echo
  read -r -p "⏩   Pilihan / Choice [1-${#LANG_LIST[@]}] (default 1): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel>=1 && sel<=${#LANG_LIST[@]} )); then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    LANG_SET="${LANG_LIST[0]}"
  fi
  echo "$LANG_SET" > "$LANG_FILE_CACHE"
  echo "✅   Bahasa dipilih: $(grep -m1 '^LANG_EMOJI=' "$LANG_DIR/$LANG_SET.sh" | cut -d= -f2- | tr -d '"') $(grep -m1 '^LANG_NAME=' "$LANG_DIR/$LANG_SET.sh" | cut -d= -f2- | tr -d '"')"
fi

# Muat file bahasa
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [[ -f "$LANG_FILE" ]]; then
  # shellcheck source=/dev/null
  source "$LANG_FILE"
else
  echo "🚨  File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi

export LANG_SET
