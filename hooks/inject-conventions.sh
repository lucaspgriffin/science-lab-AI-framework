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


# Griffin Lab routing: mirrors the keyword-to-specialist table in CLAUDE.md.
# Each rule names the agent role file(s) and knowledge-base article(s) to read
# before substantive work. Patterns are matched against the lowercased prompt.
lab_rules = [
    (r"\b(acoustic telemetry|vps|receiver|detection efficiency|detection probability|"
     r"range test|tag retention|tag shedding|fact network|otn|itag|innovasea|vr2|vr4|"
     r"residency|detection histor)",
     ["agents/acoustic-telemetry-specialist.md",
      "agents/quantitative-scientist.md",
      "knowledge_base/acoustic-telemetry-methods/INDEX.md"]),
    (r"\b(home range|kde|akde|brownian bridge|hmm|hidden markov|behaviou?ral state|"
     r"step selection|ssf|state-space|state space model|migratory connectivity|"
     r"movescape|utilisation distribution|utilization distribution|contingent|entrainment)",
     ["agents/movement-ecology-specialist.md",
      "agents/quantitative-scientist.md",
      "knowledge_base/movement-ecology-analysis/INDEX.md"]),
    (r"\b(stock structure|sedar|mrip|fmp|safmc|gmfmc|asmfc|catch-and-release|catch and release|"
     r"c&r|post-release|post release|release mortality|management implications|allocation)",
     ["agents/fisheries-stock-management-specialist.md",
      "knowledge_base/catch-and-release-survival/INDEX.md"]),
    (r"\b(sdm|species distribution|isdm|inla|inlabru|spde|brt|boosted regression|habitat model|"
     r"niche model|habitat suitability|climate scenario|hurdle)",
     ["agents/species-distribution-modelling-specialist.md",
      "agents/geospatial-environmental-data-specialist.md",
      "agents/quantitative-scientist.md",
      "knowledge_base/species-distribution-modelling/INDEX.md"]),
    (r"\b(glorys|oisst|mur sst|copernicus|erddap|rerddap|gebco|bathymetry|chlorophyll|"
     r"covariate raster|extract covariates|regrid|reproject|terra|raster|sf object)",
     ["agents/geospatial-environmental-data-specialist.md"]),
    (r"(stable isotope|\bsia\b|δ13c|δ15n|δ34s|d13c|d15n|d34s|mixsiar|simmr|isoscape|"
     r"trophic position|trophic level|diet analysis|ontogenetic|fecal edna|gut content|"
     r"lipid extraction|\btdf\b|\bcsia\b)",
     ["agents/stable-isotope-and-trophic-ecology-specialist.md",
      "agents/quantitative-scientist.md",
      "knowledge_base/stable-isotopes-and-trophic-ecology/INDEX.md"]),
    (r"\b(vessel strike|ship strike|\bais\b|global fishing watch|gfw|maritime connector|"
     r"vessel traffic|vessel speed|dwas|whale shark|rice'?s whale|right whale|marine mammal|"
     r"cetacean|biologger|cats tag|opentag|tourism compliance|provisioning|wildlife watching|"
     r"distance sampling|baci|encounter rate)",
     ["agents/marine-megafauna-anthropogenic-impacts-specialist.md",
      "knowledge_base/marine-traffic-and-anthropogenic-impacts/INDEX.md"]),
    (r"\b(grant|proposal|\bloi\b|fellowship|broader impacts|specific aims|budget justification)",
     ["agents/science-writer.md"]),
    (r"\b(reviewer|rebuttal|response to (the )?revi|revision letter|decision letter)",
     ["agents/science-writer.md"]),
    (r"\b(ingest|knowledge base|\bkb\b|extract (the )?(numbers|values|estimates)|verbatim)",
     ["agents/literature-extractor.md",
      "agents/extraction-validator.md",
      "knowledge_base/SKILL.md"]),
]

# Writing tasks also load the griffin-writing-style skill, which carries the
# per-journal and per-funder calibration that conventions/voice.md mirrors.
WRITING_SKILL = os.path.expanduser(
    "~/github/claude_skills/writing/griffin-writing-style/SKILL.md")
writing_pattern = (r"\b(write|draft|edit|revis|polish|tighten|paragraph|manuscript|paper|"
                   r"abstract|introduction|discussion|proposal|grant|loi|fellowship|"
                   r"reviewer|rebuttal|summary|report|readme|caption|heading)")

required = []
seen = set()
for pattern, files in rules:

    if re.search(pattern, prompt):
        for f in files:
            if f not in seen:
                required.append(f)
                seen.add(f)

lab_required = []
lab_seen = set()
for pattern, files in lab_rules:
    if re.search(pattern, prompt):
        for f in files:
            if f not in lab_seen:
                lab_required.append(f)
                lab_seen.add(f)

load_writing_skill = bool(re.search(writing_pattern, prompt)) and os.path.isfile(WRITING_SKILL)

if not required and not lab_required and not load_writing_skill:
    sys.exit(0)

log_event("injected: " + ", ".join(
    [f.replace("conventions/", "") for f in required]
    + [os.path.basename(os.path.dirname(f)) if f.endswith("INDEX.md") else os.path.basename(f) for f in lab_required]
    + (["griffin-writing-style"] if load_writing_skill else [])))

lines = []
if required:
    lines.append("Always-Load Contracts apply for this prompt. Before substantive work, read:")
    for f in required:
        lines.append(f"  - {FRAMEWORK_ROOT}/{f}")
    lines.append('(See CLAUDE.md "Always-load conventions" table for the rule that triggered this.)')
if lab_required:
    if lines:
        lines.append("")
    lines.append("Griffin Lab routing applies. Read these specialist and knowledge-base files, "
                 "then follow the dispatch pattern in CLAUDE.md:")
    for f in lab_required:
        lines.append(f"  - {FRAMEWORK_ROOT}/{f}")
if load_writing_skill:
    if lines:
        lines.append("")
    lines.append("This is a writing task. Load the griffin-writing-style skill:")
    lines.append(f"  - {WRITING_SKILL}")

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": "\n".join(lines),
    }
}))
