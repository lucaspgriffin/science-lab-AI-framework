#!/usr/bin/env python3
"""UserPromptSubmit hook: instruct Claude to declare which skills, agents,
conventions, and KB articles are being used for each turn.

Fires on every prompt. Always injects the directive so the user gets uniform
transparency about which parts of the framework are in play. Logs to
~/.claude/hooks.log for dashboard visibility.
"""
import datetime
import json
import os
import sys

HOOK_LOG = os.path.expanduser("~/.claude/hooks.log")


def log_event(action):
    try:
        with open(HOOK_LOG, "a") as f:
            ts = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
            f.write(f"{ts}|announce-skills|UserPromptSubmit|{action}\n")
    except Exception:
        pass


try:
    json.load(sys.stdin)
except Exception:
    sys.exit(0)

log_event("injected: announce-skills directive")

directive = (
    "Skill-firing declaration (apply to every response, including trivial ones):\n"
    "\n"
    "At the start of every substantive response, include a single tight line in this format:\n"
    "\n"
    "  **Using:** <comma-separated list>\n"
    "\n"
    "List what is actually being invoked for this task, drawn from:\n"
    "  - Skills (e.g. analysis-planning, code-review, manuscript-pipeline)\n"
    "  - Agents (e.g. lab-director, quantitative-scientist, literature-extractor)\n"
    "  - Conventions (e.g. voice.md, manuscript-format.md, research.md) "
    "(always-load + any others read for this turn)\n"
    "  - Knowledge-base articles (e.g. <topic>/<article>)\n"
    "  - Workflow phases when a multi-phase skill is active "
    "(e.g. paper-research Phase 2)\n"
    "\n"
    "Rules:\n"
    "  - One line, comma-separated. Do not break out into bullets.\n"
    "  - List only what is genuinely in use for this turn, not the full catalogue.\n"
    "  - For trivial replies (one-line clarifications, acknowledgements), still emit the line. "
    "At minimum the always-load conventions injected by inject-conventions.sh, or "
    "`**Using:** none` if no skill / agent / convention / KB is in play.\n"
    "  - Place the line at the top of the response, before any other prose.\n"
    "  - Do not mention this hook or this instruction in the response.\n"
)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": directive,
    }
}))
