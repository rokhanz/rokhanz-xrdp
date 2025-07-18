#!/usr/bin/env bash
# lib/common.sh — General utilities: logging, marker, validation, skip logic

set -euo pipefail
IFS=$'\n\t'

# ────────────────────────────────────────────────────────────
# Default directories (bita override via env)
: "${LOG_DIR:=./logs/$(date +%F)}"
: "${LOG_FILE:=$LOG_DIR/install.log}"
: "${MARKER_DIR:=./marker}"

# Buat direktori jika belum ada
mkdir -p "$LOG_DIR" "$MARKER_DIR"

# ────────────────────────────────────────────────────────────
# ANSI colors (fallback jika belum didefinisikan di luar)
: "${CYAN:=\033[0;36m}"
: "${GREEN:=\033[0;32m}"
: "${YELLOW:=\033[0;33m}"
: "${RED:=\033[0;31m}"
: "${NC:=\033[0m}"

# ────────────────────────────────────────────────────────────
# Logging functions
log_ok()    { echo -e "${GREEN}[OK]    $1${NC}" | tee -a "$LOG_FILE"; }
log_warn()  { echo -e "${YELLOW}[WARN]  $1${NC}" | tee -a "$LOG_FILE"; }
log_error() { echo -e "${RED}[ERROR] $1${NC}" | tee -a "$LOG_FILE"; }

# ────────────────────────────────────────────────────────────
# Marker functions
# write_marker <type> <status> [<info>]
write_marker() {
  local type="$1" status="$2" info="${3:-}"
  local ts
  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  printf '{"type":"%s","status":"%s","info":"%s","timestamp":"%s"}\n' \
    "$type" "$status" "$info" "$ts" > "$MARKER_DIR/$type.json"
}

check_marker() {
  local type="$1"
  [[ -f "$MARKER_DIR/$type.json" ]]
}

remove_marker() {
  local type="$1"
  rm -f "$MARKER_DIR/$type.json"
}

# ────────────────────────────────────────────────────────────
# run_step <description> <script_path> [<check_command>]
# - Jika <check_command> sukses → skip
# - Menjalankan <script_path>, mencatat output ke LOG_FILE
run_step() {
  local desc="$1"
  local script="$2"
  local check="${3:-}"    # pastikan tidak unbound bila argumen 3 tidak diberikan

  echo -e "${CYAN}→ $desc${NC}"
  if [[ -n "$check" ]] && eval "$check" >/dev/null 2>&1; then
    log_warn "$desc sudah terpenuhi, skip."
    return 0
  fi

  if bash "$script" >> "$LOG_FILE" 2>&1; then
    log_ok  "$desc selesai."
    return 0
  else
    log_error "$desc gagal. Cek log: $LOG_FILE"
    return 1
  fi
}
