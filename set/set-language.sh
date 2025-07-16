#!/bin/bash
# set-language.sh — Dynamic multi–language loader

# 1) Tentukan folder bahasa
LANG_DIR="$(dirname "${BASH_SOURCE[0]}")/lang"
if [ ! -d "$LANG_DIR" ]; then
  echo "ERROR: Folder bahasa ($LANG_DIR) tidak ditemukan!" >&2
  exit 1
fi

# 2) Kumpulkan semua kode bahasa yang tersedia
mapfile -t LANG_LIST < <(cd "$LANG_DIR" && ls *.sh | sed 's/\.sh$//')
if [ ${#LANG_LIST[@]} -eq 0 ]; then
  echo "ERROR: Tidak ada file bahasa di $LANG_DIR" >&2
  exit 1
fi

# 3) Pilih bahasa (via ENV atau prompt)
if [[ -n "$LANG_SET" && " ${LANG_LIST[*]} " == *" $LANG_SET "* ]]; then
  :  # LANG_SET sudah valid
else
  echo "Available languages:"
  select choice in "${LANG_LIST[@]}"; do
    if [[ -n "$choice" ]]; then
      LANG_SET="$choice"
      break
    fi
    echo "Pilihan tidak valid, coba lagi."
  done
fi
export LANG_SET

# 4) Source file bahasa yang sesuai
source "$LANG_DIR/$LANG_SET.sh"
