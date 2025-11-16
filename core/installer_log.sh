LOG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/hyprnosis/logs"
LOG_PATH="$LOG_DIR/hyprnosis.log"

_ICON_STEP="▸"
_ICON_INFO="→"
_ICON_SUCCESS="✓"
_ICON_ERROR="✗"

create_log() {
  mkdir -p "$LOG_DIR"
  touch "$LOG_PATH"
}

log_step() {
  clear
  header "hyprnosis"
  local text="$1"
  gum style --foreground 99 --bold "$_ICON_STEP $text" | tee -a "$LOG_PATH"
}

log_info() {
  local text="$1"
  gum style --foreground 69 "  $_ICON_INFO $text"
}

log_success() {
  local text="$1"
  gum style --foreground 37 "  $_ICON_SUCCESS $text" | tee -a "$LOG_PATH"
}

log_error() {
  local text="$1"
  gum style --foreground 19 --bold "  $_ICON_ERROR $text" | tee -a "$LOG_PATH"
}
