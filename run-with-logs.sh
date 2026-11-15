#!/usr/bin/env bash
# Creator Studio live diagnostic log stream.
# Run with: bash run-with-logs.sh
set -u
cd "$(dirname "$0")"

export TWIX_LOG_STDOUT=1
export CREATOR_STUDIO_VERBOSE=1
export TWIX_VERBOSE=1
export ELECTRON_ENABLE_LOGGING=1
export ELECTRON_ENABLE_STACK_DUMPING=1

EXE="./creator-studio"
if [ ! -x "$EXE" ]; then
  EXE="./linux-unpacked/creator-studio"
fi
if [ ! -x "$EXE" ]; then
  echo "creator-studio was not found next to this script."
  exit 1
fi

CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
LOG_DIR="$CONFIG_ROOT/Creator Studio/data/logs"
ALT_LOG_DIR="$CONFIG_ROOT/3d-creator-studio-twilight/data/logs"
mkdir -p "$LOG_DIR" "$ALT_LOG_DIR"

STAMP="$(date +%Y%m%d-%H%M%S)"
CONSOLE_LOG="$LOG_DIR/console-$STAMP.log"
: > "$CONSOLE_LOG"

echo "Creator Studio - live diagnostic log"
echo "=================================="
echo "Starting Creator Studio and streaming main, backend, renderer, GPU and"
echo "driver messages to this terminal."
echo "Close this terminal when you are finished watching; Creator Studio keeps running."
echo
echo "Launching $EXE"
"$EXE" "$@" >>"$CONSOLE_LOG" 2>&1 &
APP_PID=$!
echo "Creator Studio started (pid $APP_PID)."
echo

# Wait briefly for the first structured log entry so the header can show it.
LATEST=""
for _ in $(seq 1 30); do
  LATEST="$(ls -t "$LOG_DIR"/electron-*.jsonl "$ALT_LOG_DIR"/electron-*.jsonl 2>/dev/null | head -n 1)"
  [ -n "$LATEST" ] && break
  sleep 0.2
done

echo "Live console log : $CONSOLE_LOG"
if [ -n "$LATEST" ]; then
  echo "Structured log   : $LATEST"
fi
echo
echo "Press Ctrl+C to stop watching. The application keeps running."
echo

tail -n 30 -F "$CONSOLE_LOG"
