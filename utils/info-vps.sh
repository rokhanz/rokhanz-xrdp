#!/usr/bin/env bash
# set/set-language.sh — Dynamic language chooser with cache
# Author : rokhanz
# Version: 1.1.0
# License: MIT

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# ANSI colors (digunakan dalam prompt)
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# ────────────────────────────────────────────────────────────
# Direktori dan cache
LANG_DIR="$(dirname "${BASH_SOURCE[0]}")/lang"
CACHE_FILE="$(dirname "${BASH_SOURCE[0]}")/../.LANG_SET"

# Validasi folder bahasa
if [ ! -d "$LANG_DIR" ]; then
  echo -e "${YELLOW}🚨 ERROR: Folder bahasa ($LANG_DIR) tidak ditemukan!${NC}" >&2
  exit 1
fi

# Kumpulkan daftar kode bahasa
mapfile -t LANG_LIST < <(
  cd "$LANG_DIR" && ls *.sh 2>/dev/null | sed 's/\.sh$//'
)
if [ ${#LANG_LIST[@]} -eq 0 ]; then
  echo -e "${YELLOW}🚨 ERROR: Tidak ada file bahasa di $LANG_DIR${NC}" >&2
  exit 1
fi

# ────────────────────────────────────────────────────────────
# Coba ambil dari cache
if [ -f "$CACHE_FILE" ]; then
  cached="$(<"$CACHE_FILE")"
  if [[ " ${LANG_LIST[*]} " =~ " $cached " ]]; then
    LANG_SET="$cached"
  else
    echo -e "${YELLOW}⚠️  Pilihan lama tidak valid, reset pilihan.${NC}"
    rm -f "$CACHE_FILE"
  fi
fi

# ────────────────────────────────────────────────────────────
# Jika belum ada LANG_SET valid, tampilkan prompt
if [[ -z "${LANG_SET:-}" ]]; then
  echo
  echo -e "${CYAN}🌐  Pilih bahasa / Choose language:${NC}"
  for i in "${!LANG_LIST[@]}"; do
    idx=$((i+1))
    code="${LANG_LIST[$i]}"
    file="$LANG_DIR/$code.sh"
    name=$(grep -m1 '^LANG_NAME=' "$file" | cut -d= -f2- | tr -d '"')
    emoji=$(grep -m1 '^LANG_EMOJI=' "$file" | cut -d= -f2- | tr -d '"')
    printf "  [%2d] %s  %s\n" "$idx" "$emoji" "$name"
  done
  echo
  read -r -p "⏩  Pilihan / Choice [1-${#LANG_LIST[@]}] (default 1): " sel
  sel="${sel:-1}"
  if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel>=1 && sel<=${#LANG_LIST[@]} )); then
    LANG_SET="${LANG_LIST[$((sel-1))]}"
  else
    echo -e "${YELLOW}⚠️  Pilihan tidak valid, gunakan default.${NC}"
    LANG_SET="${LANG_LIST[0]}"
  fi
  # Simpan cache
  echo "$LANG_SET" > "$CACHE_FILE"
  # Tampilkan konfirmasi
  sel_file="$LANG_DIR/$LANG_SET.sh"
  sel_emoji=$(grep -m1 '^LANG_EMOJI=' "$sel_file" | cut -d= -f2- | tr -d '"')
  sel_name=$(grep -m1 '^LANG_NAME=' "$sel_file" | cut -d= -f2- | tr -d '"')
  echo -e "${GREEN}✅   Bahasa dipilih: ${sel_emoji}  ${sel_name}${NC}"
  echo
fi

# ────────────────────────────────────────────────────────────
# Source file bahasa yang sesuai
LANG_FILE="$LANG_DIR/$LANG_SET.sh"
if [ -f "$LANG_FILE" ]; then
  # shellcheck disable=SC1090
  source "$LANG_FILE"
else
  echo -e "${YELLOW}🚨  File bahasa tidak ditemukan: $LANG_FILE${NC}" >&2
  exit 1
fi
