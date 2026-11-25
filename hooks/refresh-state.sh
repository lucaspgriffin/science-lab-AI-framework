#!/bin/bash
#
# Stop hook: regenerate the dashboard at session end if any framework source
# file has changed since the last state snapshot. Complements the pre-commit
# git hook by covering in-session edits that haven't been committed yet.
#
# Silent on no-op. Does not open the dashboard.
#
# Environment:
#   SLAF_FRAMEWORK_ROOT  Absolute path to the framework root. Defaults to two
#                        levels up from this script (its parent's parent).

set -e

SCRIPT_REAL_PATH=$(python3 -c "import os; print(os.path.realpath('$0'))" 2>/dev/null || readlink -f "$0" 2>/dev/null || echo "$0")
DEFAULT_ROOT=$(dirname "$(dirname "$SCRIPT_REAL_PATH")")
ROOT="${SLAF_FRAMEWORK_ROOT:-$DEFAULT_ROOT}"

HOOK_LOG="$HOME/.claude/hooks.log"

log_event() {
  ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  echo "$ts|refresh-state|Stop|$1" >> "$HOOK_LOG" 2>/dev/null || true
}

# If the root has no generator, this hook is in the wrong place; exit quietly.
GEN="$ROOT/tools/generate-state.js"
[ -f "$GEN" ] || exit 0

# Check node is available
command -v node >/dev/null 2>&1 || { log_event "skipped: node not found"; exit 0; }

STATE="$ROOT/tools/system-state.json"

# If state doesn't exist yet, regenerate unconditionally.
if [ ! -f "$STATE" ]; then
  (cd "$ROOT" && node tools/generate-state.js >/dev/null 2>&1) || true
  log_event "initial regen (state file missing)"
  exit 0
fi

# Otherwise only regenerate if any tracked source is newer than the state file.
newer=$(find "$ROOT/conventions" "$ROOT/agents" "$ROOT/skills" "$ROOT/knowledge_base" "$ROOT/setup" \
    -type f \( -name '*.md' -o -name '*.html' \) -newer "$STATE" 2>/dev/null | head -1)

if [ -n "$newer" ]; then
  (cd "$ROOT" && node tools/generate-state.js >/dev/null 2>&1) || true
  log_event "regen (source newer than state)"
fi

exit 0
