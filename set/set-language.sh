#!/bin/bash
# set/set-language.sh — Dynamic language chooser
# Author : rokhanz
# Version : 1.0.0
# License : MIT

# 1) Direktori file bahasa
LANG_DIR="$(dirname "${BASH_SOURCE[0]}")/lang"
if [ ! -d "$LANG_DIR" ]; then
  echo -e "🚨 ERROR: Folder bahasa ($LANG_DIR) tidak ditemukan!" >&2
  exit 1
fi

# 2) Daftar kode bahasa (tanpa ekstensi .sh)
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//')
if [ ${#LANG_LIST[@]} -eq 0 ]; then
  echo -e "🚨 ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# 3) Jika LANG_SET belum valid,
if [[ -z "$LANG_SET" || ! " ${LANG_LIST[*]} " =~ " $LANG_SET " ]]; then
  echo
  echo -e "🌐  Pilih bahasa / Choose language:"
  for i in "${!LANG_LIST[@]}"; do
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    # Baca nama & emoji dari file bahasa
    name=$(grep -m1 '^LANG_NAME=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
    [[ -z "$name"  ]] && name="$code"
    [[ -z "$emoji" ]] && emoji="🌐"
    printf "  [%d] %s  %s\n" $((i+1)) "$emoji" "$name"
  done
  echo
  max_choice=${#LANG_LIST[@]}
  read -p "⏩  Pilihan / Choice [1-${max_choice}] (default 1): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 1 ] && [ "$sel" -le "$max_choice" ]; then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    echo -e "⚠️  Pilihan tidak valid, gunakan default: ${LANG_LIST[0]}"
    LANG_SET="${LANG_LIST[0]}"
  fi
  export LANG_SET
  # Tampilkan emoji dan nama yang terpilih
  file="$LANG_DIR/$LANG_SET.sh"
  name=$(grep -m1 '^LANG_NAME=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
  emoji=$(grep -m1 '^LANG_EMOJI=' "$file" 2>/dev/null | cut -d= -f2- | tr -d '"')
  [[ -z "$name"  ]] && name="$LANG_SET"
  [[ -z "$emoji" ]] && emoji="🌐"
  echo -e "✅  Bahasa dipilih: ${emoji} ${name}"
  echo
fi

# 4) Source file bahasa yang sesuai
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [ -f "$LANG_FILE" ]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo -e "🚨  File bahasa tidak ditemukan: $LANG_FILE" >&2
  exit 1
fi
