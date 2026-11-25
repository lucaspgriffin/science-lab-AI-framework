#!/usr/bin/env bash
#
# install.sh: wire the framework's Claude Code hooks into ~/.claude/.
#
# Usage:
#   bash hooks/install.sh           # install all hooks
#   bash hooks/install.sh --dry-run # show what would happen, change nothing
#   bash hooks/install.sh --uninstall  # remove the symlinks (does not touch settings.json)
#
# What it does:
#   1. Creates ~/.claude/hooks/ if missing.
#   2. Symlinks each hook script under hooks/*.sh into ~/.claude/hooks/.
#   3. Prints the JSON stanza to add to ~/.claude/settings.json under the
#      top-level "hooks" key (you paste this in yourself; the script does not
#      edit settings.json because it may already contain other configuration).
#
# Idempotent: re-running replaces existing symlinks with fresh ones.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.claude/hooks"

DRY=0
UNINSTALL=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    --uninstall) UNINSTALL=1 ;;
    *) echo "Unknown arg: $arg" >&2; exit 1 ;;
  esac
done

if [ "$UNINSTALL" = "1" ]; then
  for h in inject-conventions.sh announce-skills.sh refresh-state.sh; do
    if [ -L "$TARGET/$h" ]; then
      echo "Removing $TARGET/$h"
      [ "$DRY" = "1" ] || rm "$TARGET/$h"
    fi
  done
  echo
  echo "Note: this only removes the symlinks. The hooks stanza in"
  echo "~/.claude/settings.json is left intact; remove it manually if desired."
  exit 0
fi

[ "$DRY" = "1" ] || mkdir -p "$TARGET"

for h in inject-conventions.sh announce-skills.sh refresh-state.sh; do
  src="$SCRIPT_DIR/$h"
  if [ ! -f "$src" ]; then
    echo "Warning: $src missing; skipping" >&2
    continue
  fi
  [ "$DRY" = "1" ] || chmod +x "$src"
  echo "Linking $TARGET/$h -> $src"
  [ "$DRY" = "1" ] || ln -sf "$src" "$TARGET/$h"
done

echo
echo "Hooks linked. Now add the following 'hooks' stanza to ~/.claude/settings.json"
echo "(merge with any existing 'hooks' section; do not replace the whole file):"
echo
cat "$SCRIPT_DIR/example-settings.json"
echo
echo "After saving settings.json, restart any active Claude Code sessions for the hooks to take effect."
