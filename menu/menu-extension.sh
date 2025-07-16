#!/bin/bash
# Wizard pilih extension VSCode (multi-bahasa, marker, logging)
# Author: rokhanz

. ./set/set-language.sh

EXTFILE="vscode-ext.txt"
SAVEFILE="save-ext.txt"
MARKER=".installed_vscode_ext"
LOGFILE="./logs/error.log"
[ -d ./logs ] || mkdir ./logs

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$LOGFILE"
}

declare -A EXT_CAT
declare -A EXT_MAP
CAT_LIST=()

# Parse kategori dan extension+publisher
while IFS= read -r line; do
  if [[ "$line" =~ ^#CATEGORY:(.*) ]]; then
    current_cat="${BASH_REMATCH[1]}"
    CAT_LIST+=("$current_cat")
    continue
  fi
  if [[ "$line" =~ ^([a-zA-Z0-9.-]+)\ \(\s*publisher:\ ([^)]+)\) ]]; then
    ext_name="${BASH_REMATCH[1]}"
    publisher="${BASH_REMATCH[2]}"
    EXT_CAT["$current_cat"]+="$ext_name|$publisher,"
    EXT_MAP["$ext_name"]="$publisher"
  fi
done < "$EXTFILE"

PICKED_EXT=()

function show_category_menu() {
  echo "--------------------------------------------------------"
  echo -e "${LANG_WIZARD_SELECT_CAT}"
  for idx in "${!CAT_LIST[@]}"; do
    printf "%2d. %s\n" $((idx+1)) "${CAT_LIST[$idx]}"
  done
  echo "99. ${LANG_WIZARD_FINISH}"
  echo "0. ${LANG_WIZARD_EXIT}"
}

function pick_extension_from_category() {
  local cat="$1"
  IFS=',' read -ra extpairs <<< "${EXT_CAT["$cat"]}"
  echo "--------------------------------------------------------"
  echo -e "[${cat}] ${LANG_WIZARD_PICK_EXT}"
  for i in "${!extpairs[@]}"; do
    [[ -z "${extpairs[$i]}" ]] && continue
    IFS='|' read -r extname publisher <<< "${extpairs[$i]}"
    printf "%2d. %-35s (publisher: %s)\n" $((i+1)) "$extname" "$publisher"
  done
  echo "0. ${LANG_WIZARD_BACK}"
  read -p "${LANG_WIZARD_PICK_EXT_INPUT} " picks
  for pick in $picks; do
    [[ "$pick" == "0" ]] && return 1
    idx=$((pick-1))
    extpair="${extpairs[$idx]}"
    IFS='|' read -r extname publisher <<< "$extpair"
    # Hindari duplikat
    if [[ ! " ${PICKED_EXT[@]} " =~ " $extname " ]]; then
      PICKED_EXT+=("$extname")
    fi
  done
  return 0
}

while :; do
  show_category_menu
  read -p "${LANG_WIZARD_CHOOSE_CAT} " cat_choice
  [[ "$cat_choice" == "0" ]] && echo "${LANG_WIZARD_EXIT}"; exit 0
  [[ "$cat_choice" == "99" ]] && break
  idx=$((cat_choice-1))
  cat="${CAT_LIST[$idx]}"
  [ -z "$cat" ] && echo "${LANG_WIZARD_INVALID}"; continue
  pick_extension_from_category "$cat"
done

# Konfirmasi
echo ""
echo "--------------------------------------------------------"
echo -e "${LANG_WIZARD_SUMMARY}"
for ext in "${PICKED_EXT[@]}"; do
  echo "- $ext (publisher: ${EXT_MAP["$ext"]})"
done
read -p "${LANG_WIZARD_SAVE_CONFIRM} $SAVEFILE? (y/n): " ok
[[ ! "$ok" =~ ^[Yy]$ ]] && echo "${LANG_WIZARD_ABORT}"; exit 1

printf "%s\n" "${PICKED_EXT[@]}" > "$SAVEFILE" && touch "$MARKER" && echo "✅ ${LANG_WIZARD_SAVED} $SAVEFILE" || { log_error "Gagal save ke $SAVEFILE"; echo "${LANG_MARKER_ERROR}"; }
echo "✅ ${LANG_MARKER_INSTALL}"

# Kembali ke main menu otomatis
echo -e "${LANG_BACK_MAIN}"
read -t 10 -p ""
exec bash ./main.sh