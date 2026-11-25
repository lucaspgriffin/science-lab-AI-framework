#!/usr/bin/env python3
"""SessionStart hook: load the lab's private context files into the session.

Reads every Markdown file under ~/.claude/griffin-lab/ (a project roster, partner
notes, anything the lab keeps out of its public repositories) and injects the text
as additional context. The folder is private to this machine; the framework
repository holds only this loader.
"""
import datetime
import glob
import json
import os
import sys

FOLDER = os.path.expanduser("~/.claude/griffin-lab")
HOOK_LOG = os.path.expanduser("~/.claude/hooks.log")
MAX_CHARS = 12000


def log_event(action):
    try:
        with open(HOOK_LOG, "a") as f:
            ts = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
            f.write(f"{ts}|session-context|SessionStart|{action}\n")
    except Exception:
        pass


try:
    json.load(sys.stdin)
except Exception:
    pass

files = sorted(glob.glob(os.path.join(FOLDER, "*.md")))
if not files:
    sys.exit(0)

parts = []
for path in files:
    try:
        parts.append(open(path, encoding="utf8").read().strip())
    except Exception:
        continue
text = "\n\n".join(parts)
if len(text) > MAX_CHARS:
    text = text[:MAX_CHARS] + "\n\n[truncated: shorten the files under ~/.claude/griffin-lab/]"

log_event("injected: " + ", ".join(os.path.basename(f) for f in files))
print(json.dumps({"hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Griffin Lab context (private, from ~/.claude/griffin-lab/). "
                         "Use it to find repos and avoid settled mistakes; update "
                         "projects.md when a project's state changes.\n\n" + text,
}}))
