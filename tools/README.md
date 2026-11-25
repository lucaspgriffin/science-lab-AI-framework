# tools/

## Purpose

Tools are the supporting utilities that surround the framework's text-based core. Paper §4 notes that even a fully text-defined framework benefits from a small amount of tooling for visibility (what is set up, what is missing) and orchestration (build artifacts, dashboards). This folder ships one such utility: a system-state dashboard generator that scans the framework, reports current state, and renders a browsable HTML view.

The folder is intentionally small. Most of the framework's behaviour lives in Markdown that an AI assistant reads at runtime; tools are limited to things that genuinely benefit from being scripted.

## Structure

```
tools/
├── README.md                this file
├── generate-state.js        scans the framework, writes system-state.json
├── system-dashboard.html    self-contained HTML viewer for system-state.json
├── system-state.json        machine-readable snapshot (output of generate-state.js)
├── check_headings.py        heading-rule checker (command line, or PostToolUse hook with --hook)
├── check_tells.py           tell scan for prose: em dashes, announcer sentences, AI vocabulary
├── check_r_style.py         R style checker and Rscript parse check for .R, .Rmd and .qmd
├── git-hooks/pre-commit     regenerates the dashboard when framework files are staged
└── tracked-changes/         OOXML tracked-changes renderer used by the reviewer-reply
    ├── README.md            workflows; depends on Python 3.8+, lxml, and pandoc
    ├── apply_tracked_changes.py
    └── render_tracked_docx.py
```

`system-dashboard.html` renders six panels: Overview, Skills, Agents, Knowledge base, Conventions, Setup. It reads its data in two ways. The generator injects the latest `system-state.json` directly into the HTML as an inline `<script type="application/json" id="state">` block, so the dashboard works when opened via `file://` (no HTTP server needed). As a fallback, if the inline block is empty, the dashboard fetches `./system-state.json` from the same directory.

The HTML viewer has no external dependencies.

## Usage

The dashboard generator runs as-is once Node.js is installed:

```bash
node tools/generate-state.js                    # scans, writes JSON, embeds it into the HTML
open tools/system-dashboard.html                # macOS; use xdg-open or start elsewhere
```

That is the full loop. Re-run `generate-state.js` any time the framework changes; the dashboard picks up the new state on next reload.

If you prefer to serve over HTTP (useful for live-editing the JSON or hosting on a server):

```bash
python3 -m http.server 8000
# then open http://localhost:8000/tools/system-dashboard.html
```

### Command-line options

```text
--root <path>   Scan a different framework root.
                Default: the directory containing tools/generate-state.js.
--out  <path>   Write the JSON somewhere other than the default
                (<root>/tools/system-state.json).
--pretty        Multi-line JSON output (useful for diffing).
--help          Show usage.
```

Example: regenerate state for a forked framework in another directory.

```bash
node tools/generate-state.js \
  --root /path/to/forked-framework \
  --out  /path/to/forked-framework/tools/system-state.json
```

**Dependency.** Node.js (any version 18 or newer). No npm packages are required; the generator uses only the Node standard library (`fs`, `path`). The lab can run the generator on a laptop, on CI, or as part of a setup script.

**Customisation.** The generator scans for files matching expected patterns (`skills/simple/*/SKILL.md`, `skills/workflows/*/SKILL.md`, `conventions/*.md`, `conventions/*.template.md`, `agents/*.md`, `knowledge_base/*/`). If the lab restructures the framework (e.g., adds a new top-level workflow category), edit `generate-state.js` to add the new scan path. The script is short and uncomplicated; expect to spend ten minutes adapting it.

## Panels

**Overview.** Total counts (skills, agents, knowledge-base topics, conventions populated) and an adopter checklist marking which framework areas are set up.

**Skills.** Workflow skills and simple skills with their frontmatter description, file path, and modification date.

**Agents.** The core agent roster from `agents/*.md`. Domain-specialist templates (`_*.template.md` or `*.template.md`) appear in a separate section.

**Knowledge base.** Topic folders under `knowledge_base/`, with article counts and INDEX.md presence. Folders prefixed with `_` are flagged as templates.

**Conventions.** Each file under `conventions/` with status: `opinionated` (ships filled-in), `populated` (template has a sibling `.md` copy), or `template only` (still needs adopter content).

**Setup.** Onboarding prompts under `setup/prompts/` plus a recap of which conventions are populated.

## Extensions

The JSON shape is documented in the header comment of `generate-state.js`. To add a new panel:

1. Add a scanner function in `generate-state.js` that returns a structured array or object, and include it in the assembled `state` object.
2. In `system-dashboard.html`, add a tab button (under `nav.tabs`) and a `<div class="panel">` container.
3. Write a `renderXxx(state)` function in the script block and call it from `bootstrap(state)`.

The renderers use a small `el(tag, attrs, children)` helper for DOM construction; mirror the pattern from `renderConventions` or `renderSkills`.

## Connections

- **Skills, agents, conventions, knowledge_base.** The generator reads from all four to compile the system state. When a lab adds a skill or populates a convention template, the next `generate-state.js` run picks it up.
- **Setup.** A useful sanity check after running setup is to regenerate the dashboard; gaps in the populated coverage indicate where setup is incomplete.
- **System-improvement protocol.** When the protocol triggers a framework change (e.g., a new convention, a renamed skill), regenerating the dashboard surfaces whether the change propagated to all referencing files.
