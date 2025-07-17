#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser
# author : rokhanz
# version : 1.0.0
# License : MIT

# 1) Direktori file bahasa
LANG_SCRIPT="${BASH_SOURCE[0]:-${(%):-%N}}"
LANG_DIR="$(cd "$(dirname "$LANG_SCRIPT")" && pwd)/lang"
if [ ! -d "$LANG_DIR" ]; then
  echo -e "🚨 ERROR: Folder bahasa ($LANG_DIR) tidak ditemukan!" >&2
  exit 1
fi

# 2) Daftar kode bahasa (tanpa ekstensi .sh)
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')
if [ "${#LANG_LIST[@]}" -eq 0 ]; then
  echo -e "🚨 ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# 3) Jika LANG_SET belum valid,
if [[ -z "${LANG_SET:-}" || ! " ${LANG_LIST[*]} " =~ " ${LANG_SET} " ]]; then
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
  read -rp "⏩  Pilihan / Choice [1-${#LANG_LIST[@]}] (default 1): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel>=1 && sel<=${#LANG_LIST[@]} )); then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    LANG_SET="${LANG_LIST[0]}"
    name=$(grep -m1 '^LANG_NAME=' "$LANG_DIR/$LANG_SET.sh" 2>/dev/null | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$LANG_DIR/$LANG_SET.sh" 2>/dev/null | cut -d= -f2- | tr -d '"')
    [[ -z "$name"  ]] && name="$LANG_SET"
    [[ -z "$emoji" ]] && emoji="🌐"
    echo -e "ℹ️  Default: ${emoji} ${name}"
  fi
fi

export LANG_SET

# 4) Source file bahasa yang sesuai
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [ -f "$LANG_FILE" ]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo -e "🚨  File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi
