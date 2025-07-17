#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser
# Author : rokhanz
# Version : 1.1.0
# License : MIT

# 1. Lokasi file bahasa
LANG_DIR="$(dirname "${BASH_SOURCE[0]}")/lang"
LANG_SET_FILE=".LANG_SET"

if [ ! -d "$LANG_DIR" ]; then
  echo -e "🚨 ERROR: Folder bahasa ($LANG_DIR) tidak ditemukan!" >&2
  exit 1
fi

# 2. Cek var LANG_SET dari file jika ada
if [[ -z "${LANG_SET:-}" ]] && [[ -f "$LANG_SET_FILE" ]]; then
  LANG_SET=$(<"$LANG_SET_FILE")
  export LANG_SET
fi

# 3. List kode bahasa
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')
if [ ${#LANG_LIST[@]} -eq 0 ]; then
  echo -e "🚨 ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# 4. Prompt hanya jika LANG_SET belum valid
if [[ -z "${LANG_SET:-}" || ! " ${LANG_LIST[*]} " =~ " $LANG_SET " ]]; then
  echo
  echo -e "🌐  Pilih bahasa / Choose language:"
  for i in "${!LANG_LIST[@]}"; do
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    name=$(grep -m1 '^LANG_NAME=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
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
  export LANG_SET
  echo "$LANG_SET" > "$LANG_SET_FILE"
  # Show confirmation
  file="$LANG_DIR/$LANG_SET.sh"
  name=$(grep -m1 '^LANG_NAME=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
  emoji=$(grep -m1 '^LANG_EMOJI=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
  echo -e "✅   Bahasa dipilih: ${emoji:-🌐} ${name:-$LANG_SET}"
  echo
fi

# 5. Source file bahasa yang sesuai
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [ -f "$LANG_FILE" ]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo -e "🚨  File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi
