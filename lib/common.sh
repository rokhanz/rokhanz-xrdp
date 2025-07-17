#!/usr/bin/env bash
# lib/common.sh — General utilities (v1.1.0)

# ── Muat bahasa (harusnya sudah disebut di main.sh) ──
# Jika belum disource, coba:
if [[ -f "$(dirname "${BASH_SOURCE[0]}")/../set/set-language.sh" ]]; then
  source "$(dirname "${BASH_SOURCE[0]}")/../set/set-language.sh"
fi

# ── Direktori default & buat jika perlu ──
: "${LOG_DIR:=./logs/$(date +%F)}"
: "${LOG_FILE:=$LOG_DIR/install.log}"
: "${MARKER_DIR:=./marker}"
mkdir -p "$LOG_DIR" "$MARKER_DIR"

# ── ANSI Colors fallback ──
: "${CYAN:=\033[0;36m}"
: "${GREEN:=\033[0;32m}"
: "${YELLOW:=\033[0;33m}"
: "${RED:=\033[0;31m}"
: "${NC:=\033[0m}"

# ── Logging functions ──
log_ok()    { echo -e "${GREEN}${LANG_OK_EMOJI}  ${LANG_LOG_OK_PREFIX}${NC}  $1" | tee -a "$LOG_FILE"; }
log_warn()  { echo -e "${YELLOW}${LANG_WARN_EMOJI}  ${LANG_LOG_WARN_PREFIX}${NC}  $1" | tee -a "$LOG_FILE"; }
log_error() { echo -e "${RED}${LANG_ERROR_EMOJI}  ${LANG_LOG_ERROR_PREFIX}${NC}  $1" | tee -a "$LOG_FILE"; }

# ── Marker functions ──
write_marker() {
  local type="$1" status="$2" info="${3:-}"
  local ts="$(date '+%Y-%m-%d %H:%M:%S')"
  printf '{"type":"%s","status":"%s","info":"%s","time":"%s"}\n' \
    "$type" "$status" "$info" "$ts" > "$MARKER_DIR/$type.json"
}
check_marker()   { [[ -f "$MARKER_DIR/$1.json" ]]; }
remove_marker()  { rm -f "$MARKER_DIR/$1.json"; }

# ── Utility helpers ──
require_root() {
  if [ "$EUID" -ne 0 ]; then
    log_error "${LANG_REQUIRE_ROOT:-Root access required!}"
    exit 1
  fi
}
ensure_cmd() {
  if ! command -v "$1" &>/dev/null; then
    log_error "$(printf "${LANG_CMD_NOT_FOUND:-Command '%s' not found.}" "$1")"
    exit 1
  fi
}
confirm_or_abort() {
  read -p "$1 (y/n): " ans
  if [[ ! "$ans" =~ ^[Yy]$ ]]; then
    log_warn "${LANG_ABORT_BY_USER:-Cancelled by user.}"
    exit 0
  fi
}
pause() {
  local prompt="${1:-$LANG_PAUSE_PROMPT}"
  local timeout="${2:-0}"
  if (( timeout>0 )); then
    read -r -t "$timeout" -p "$prompt"
  else
    read -r -p "$prompt"
  fi
}

# ── run_step helper ──
run_step() {
  local desc="$1" script="$2" check="$3"
  echo -e "${CYAN}→ $desc${NC}"
  if [[ -n "$check" ]] && eval "$check" &>/dev/null; then
    log_warn "$desc $LANG_ALREADY_DONE"
    return 0
  fi
  if bash "$script" >> "$LOG_FILE" 2>&1; then
    log_ok "$desc $LANG_STEP_DONE"
    return 0
  else
    log_error "$desc $LANG_FAIL_EMOJI Lihat log: $LOG_FILE"
    return 1
  fi
}
