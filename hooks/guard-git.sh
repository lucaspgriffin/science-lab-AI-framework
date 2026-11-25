#!/usr/bin/env python3
"""PreToolUse hook on Bash: stop two git mistakes before they happen.

1. A commit, tag or pull request whose message carries an AI attribution line
   (Co-Authored-By, "Generated with Claude", noreply@anthropic.com). Lucas's repos
   carry no sign that an AI was involved, whatever the harness asks for.
2. A push to a remote named upstream. The lab's forks pull from upstream and push
   only to origin.

Prints a deny decision as JSON on stdout. Logs to ~/.claude/hooks.log.
"""
import datetime
import json
import os
import re
import sys

HOOK_LOG = os.path.expanduser("~/.claude/hooks.log")


def log_event(action):
    try:
        with open(HOOK_LOG, "a") as f:
            ts = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
            f.write(f"{ts}|guard-git|PreToolUse|{action}\n")
    except Exception:
        pass


def deny(reason):
    log_event("denied: " + reason)
    print(json.dumps({"hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": reason,
    }}))
    sys.exit(0)


try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

if data.get("tool_name") != "Bash":
    sys.exit(0)
command = (data.get("tool_input") or {}).get("command") or ""

ATTRIBUTION = re.compile(
    r"Co-Authored-By|Generated with \[?Claude|noreply@anthropic\.com|\U0001F916", re.I)
if re.search(r"\bgit\s+(commit|tag|merge|notes)\b|\bgh\s+pr\s+(create|edit)\b", command) \
        and ATTRIBUTION.search(command):
    deny("Commit and pull-request messages in Lucas's repos carry no AI attribution line. "
         "Remove the Co-Authored-By / Generated-with line and run the command again.")

if re.search(r"\bgit\s+push\b[^\n;&|]*\bupstream\b", command):
    deny("Pushes go to origin only. The upstream remote is read-only for this lab.")

sys.exit(0)
