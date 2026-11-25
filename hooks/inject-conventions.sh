#!/usr/bin/env python3
"""UserPromptSubmit hook: inject Always-Load Contracts based on prompt keywords.

Reads the user's prompt from stdin (as Claude Code passes it) and matches
against a small set of keyword rules. For each rule that matches, the relevant
convention file is added to a reminder that Claude Code injects as additional
context for the turn.

This implements the "Always-Load Contracts" table from CLAUDE.md without
relying on Claude to remember to do it manually.

Environment:
  SLAF_FRAMEWORK_ROOT  Absolute path to the framework root. Defaults to two
                       levels up from this script (its parent's parent), which
                       is correct when the script is symlinked from
                       ~/.claude/hooks/ back into the framework's hooks/ folder.
"""
import datetime
import json
import os
import re
import sys

# Where this hook lives. Resolved via the symlink target so the hook can be
# symlinked into ~/.claude/hooks/ and still find the framework files.
SCRIPT_REAL_PATH = os.path.realpath(__file__)
DEFAULT_FRAMEWORK_ROOT = os.path.dirname(os.path.dirname(SCRIPT_REAL_PATH))
FRAMEWORK_ROOT = os.environ.get("SLAF_FRAMEWORK_ROOT", DEFAULT_FRAMEWORK_ROOT)

HOOK_LOG = os.path.expanduser("~/.claude/hooks.log")


def log_event(action):
    try:
        with open(HOOK_LOG, "a") as f:
            ts = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
            f.write(f"{ts}|inject-conventions|UserPromptSubmit|{action}\n")
    except Exception:
        pass


try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

prompt = (data.get("prompt") or "").lower()

# Pattern -> list of conventions to recommend loading.
# Adopters can add or refine rules to match their own conventions.
rules = [
    (r"\b(write|draft|edit|revis|polish|paragraph|sentence|manuscript|paper|"
     r"reply|reviewer|response|synthesis|abstract|introduction|discussion)\b",
     ["conventions/voice.md"]),
    (r"\b(manuscript|paper|introduction|methods section|discussion section|abstract)\b",
     ["conventions/manuscript-format.md"]),
    (r"\b(reviewer|rebuttal|reply to (a |the )?(comment|review)|r\d+-c\d+|"
     r"response to (revi|reviewer))\b",
     ["conventions/reply-format.md", "conventions/manuscript-format.md"]),
    (r"\b(figure|ggplot|matplotlib|plot|table|chart|caption)\b",
     ["conventions/figure-format.md"]),
    (r"\b(cite|citation|reference|literature|lit search|verify (a |the )?cit|"
     r"doi|crossref|bibliography|hallucinat)\b",
     ["conventions/research.md"]),
    (r"\b(r script|rscript|\.r\b|ggplot|tidyverse|python|\.py\b|"
     r"analysis script|pipeline|glmm|gam|model fitting|refactor|debug)\b",
     ["conventions/code-format.md"]),
    (r"\b(iterate|iteration|refine|quality gate|publication-ready|"
     r"visual review|render-and-read)\b",
     ["conventions/iteration-workflow.md",
      "conventions/research-quality-gates.md",
      "conventions/visual-review-protocol.md"]),
]

required = []
seen = set()
for pattern, files in rules:
    if re.search(pattern, prompt):
        for f in files:
            if f not in seen:
                required.append(f)
                seen.add(f)

if not required:
    sys.exit(0)

log_event("injected: " + ", ".join(f.replace("conventions/", "") for f in required))

lines = ["Always-Load Contracts apply for this prompt. Before substantive work, read:"]
for f in required:
    lines.append(f"  - {FRAMEWORK_ROOT}/{f}")
lines.append("")
lines.append('(See CLAUDE.md "Always-load conventions" table for the rule that triggered this.)')

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": "\n".join(lines),
    }
}))
