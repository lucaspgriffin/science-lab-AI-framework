# hooks/

Event-triggered automation scripts that complement the framework's skills. Where skills run on **intent** (the user asks the AI to do something), hooks run on **events** (a commit happens, a Claude session starts, a file is edited). They keep derived state in sync and enforce conventions without the scientist or the AI having to remember.

## Contents

```
hooks/
├── README.md                 this file
├── install.sh                wires the Claude Code hooks into ~/.claude/
├── example-settings.json     the settings.json stanza adopters add
├── inject-conventions.sh     UserPromptSubmit: route prompts to always-load conventions
├── announce-skills.sh        UserPromptSubmit: enforce the "Using:" declaration
├── refresh-state.sh          Stop: regenerate the dashboard on session end
├── guard-git.sh              PreToolUse (Bash): block AI attribution lines and pushes to upstream
└── session-context.sh        SessionStart: load private lab files from ~/.claude/griffin-lab/
```

The checkers in `tools/` double as hooks: `check_headings.py`, `check_tells.py` and `check_r_style.py` run after every Write or Edit and report heading-rule failures, AI-written tells, and R style breaks back to the model.

A git pre-commit hook also ships at `tools/git-hooks/pre-commit` (separate from the Claude Code hooks here because it lives in the git layer, not the Claude layer).

## Hooks

### `inject-conventions.sh` (UserPromptSubmit)

Pattern-matches the user's prompt against keyword rules and tells Claude which convention files to load before doing the work. For example, a prompt containing "manuscript" triggers `conventions/voice.md` and `conventions/manuscript-format.md`; a prompt containing "figure" or "ggplot" triggers `conventions/figure-format.md`. Implements the "Always-load conventions" table from `CLAUDE.md` mechanically rather than relying on Claude to remember.

Adopters extend the rules table at the top of the script to match their own conventions. The Griffin Lab fork adds a second table, `lab_rules`, that mirrors the keyword-to-specialist routing in `CLAUDE.md`: a prompt about acoustic telemetry, movement ecology, stock assessment, species distribution modelling, environmental covariates, stable isotopes or marine megafauna points Claude at the matching specialist agent files and knowledge-base index. Writing prompts also point at the `griffin-writing-style` skill in `~/github/claude_skills/`.

### `announce-skills.sh` (UserPromptSubmit)

Tells Claude to emit a single `**Using:** <list>` line at the top of every response, naming the skills, agents, conventions, and knowledge-base articles actually in play for that turn. Makes the AI's reasoning transparent and helps newcomers learn what the framework is doing under the hood.

### `guard-git.sh` (PreToolUse, Bash)

Denies a `git commit`, `git tag`, `git merge` or `gh pr create` whose message carries an AI attribution line (Co-Authored-By, "Generated with Claude", noreply@anthropic.com), and any `git push` to a remote named `upstream`. The lab's repositories carry no sign that an AI was involved, and forks pull from upstream but push only to origin. The `attribution` setting in `settings.json` stops the harness adding those lines in the first place; the hook is the backstop.

### Checkers (PostToolUse, Write|Edit)

Report-only checkers in `tools/`. `check_tells.py` scans prose in Markdown, R Markdown, HTML and Word files for em dashes, announcer sentences, AI vocabulary, sentences that open with an acronym, internal labels, dated history and placeholders. `check_r_style.py` scans R scripts and notebook chunks for `setwd()`, absolute paths, `cat()` and `print()`, `tryCatch()`, `.RData`, figure titles, `=` assignment, bare `T`/`F`, mixed pipes, `pkg::` prefixes and helper wrappers, and parses `.R` files with Rscript so a syntax error is caught at the edit. Each also runs from the command line on any list of files and exits 1 on a hit.

### `session-context.sh` (SessionStart)

Reads every Markdown file under `~/.claude/griffin-lab/` and injects it at session start. The lab keeps its project roster there: repo paths, who the partners are, which decisions are settled. The folder lives outside any repository, so the public framework holds only the loader.

### `refresh-state.sh` (Stop)

Fires when a Claude session ends. Regenerates `tools/system-state.json` and embeds it back into `tools/system-dashboard.html` if any file under `conventions/`, `agents/`, `skills/`, `knowledge_base/`, or `setup/` has changed since the last regeneration. Silent on no-op. Complements the pre-commit hook by covering in-session edits that have not yet been committed.

## Installation

```bash
# From the framework root:
bash hooks/install.sh
```

This creates symlinks from `~/.claude/hooks/` back into the framework's `hooks/` folder, then prints the JSON stanza you paste into `~/.claude/settings.json` under the `hooks` key. The settings.json edit is the only manual step (the script does not modify settings.json itself because that file usually contains other configuration).

After saving settings.json, restart any active Claude Code sessions for the hooks to take effect.

To uninstall: `bash hooks/install.sh --uninstall` (removes symlinks; leaves settings.json untouched).

## Configuration

The two scripts that need to know where the framework lives (`inject-conventions.sh`, `refresh-state.sh`) resolve their own location through the symlink, so they work out of the box when installed via `install.sh`. If you need to override the framework root explicitly (e.g., the hook lives somewhere unusual), set the environment variable:

```bash
export SLAF_FRAMEWORK_ROOT=/absolute/path/to/your/forked-framework
```

## Logging

All three Claude Code hooks append a line to `~/.claude/hooks.log` on each invocation. Format:

```
2026-05-28T01:42:11Z|inject-conventions|UserPromptSubmit|injected: voice.md, manuscript-format.md
2026-05-28T01:42:11Z|announce-skills|UserPromptSubmit|injected: announce-skills directive
2026-05-28T01:55:09Z|refresh-state|Stop|regen (source newer than state)
```

Useful for verifying the hooks are firing as expected, or for debugging if a hook fails silently.

## Writing additional hooks

The Claude Code hook events you can target:

- **UserPromptSubmit**: fires when the user submits a prompt. Receives the prompt as JSON on stdin. Can inject additional context via the `hookSpecificOutput.additionalContext` field in the JSON it prints to stdout.
- **PreToolUse**: fires before a tool call (Edit, Write, Read, Bash, etc.). Can block the tool by exiting non-zero with a message on stderr.
- **PostToolUse**: fires after a tool call. Receives the tool's input and result. Useful for reactive automation (rebuild artefacts, run validators).
- **Stop**: fires when the Claude session ends. Receives no prompt; runs to completion.
- **SessionStart**: fires when a Claude session begins.

A hook is just an executable script. Place it in `hooks/`, add it to `install.sh`'s loop, and register it in `example-settings.json`. Adopters who want lab-specific hooks (e.g., "block edits to a read-only reference corpus", "run a linter after every code-writing call") add their own scripts here.

## Architecture

Skills and hooks are the framework's two automation surfaces:

| | Skills | Hooks |
|---|---|---|
| Triggered by | User intent ("draft a paragraph") | System event (commit, session end, file edit) |
| Lives in | `skills/` | `hooks/` (Claude Code) + `tools/git-hooks/` (git) |
| Invoked by | The LLM via its routing | The runtime (Claude Code, git) |
| Visible to user as | A skill firing in the chat | A reminder injected into context, or a regenerated artefact |

Together they let the framework feel like infrastructure rather than tools the user has to remember to use.
