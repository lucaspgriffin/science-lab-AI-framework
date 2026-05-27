# CLAUDE.md: Navigation and operating instructions

> **This file is the single source of truth for any AI instance using the `science-lab-AI-framework`.** Anthropic's Claude Code reads it automatically when the folder is in scope. Other model harnesses can be configured to load it at session start.

## What this is

A vendor-neutral reference framework for building a hybrid digital lab. The companion paper (Brownscombe et al., in preparation, *Beyond the AI Scientist: An architecture for human-AI scientific practice*) describes the architecture in §2-§4.

## How to use

Before starting a substantive task, read the relevant SKILL.md file(s) and the relevant convention files listed below. Skills contain detailed instructions, sub-agent architectures, and templates that improve output quality. Conventions encode voice, format, research-integrity, and methodological protocols that apply across tasks.

The rule is: match the task to its skill, read the skill, follow its instructions. Always load the relevant conventions.

## Always-load conventions

When the adopter has populated the templates, these files take the non-template name. Until then, the template stands in.

| Task type | Required conventions files |
|-----------|---------------------------|
| Any writing | `conventions/voice.md` (falls back to `voice.template.md` if not populated) |
| Manuscript drafting or revising | + `conventions/manuscript-format.md` |
| Reviewer reply | + `conventions/reply-format.md` and `conventions/manuscript-format.md` |
| Producing figures or tables | + `conventions/figure-format.md` |
| Citation, literature search, source handling | + `conventions/research.md` (ships opinionated, no template) |
| R or Python coding | + `conventions/code-format.md` |
| Iterative refinement of an analysis | + `conventions/iteration-workflow.md`, `conventions/research-quality-gates.md`, `conventions/visual-review-protocol.md` (all ship opinionated) |
| Updating the framework itself | + `conventions/system-improvement-protocol.md` (ships opinionated) |

These contracts apply to all skills, all agents, all workflows.

## Skill routing

### Simple skills (single-job)

| Skill | Path | Use when |
|-------|------|----------|
| analysis-planning | `skills/simple/analysis-planning/SKILL.md` | designing the statistical or computational approach |
| code-writing | `skills/simple/code-writing/SKILL.md` | writing the code from a plan |
| code-review | `skills/simple/code-review/SKILL.md` | reviewing code for correctness, style, and diagnostics |
| manuscript-writing | `skills/simple/manuscript-writing/SKILL.md` | ad-hoc daily writing without the full pipeline |
| manuscript-builder | `skills/simple/manuscript-builder/SKILL.md` | rendering a Markdown manuscript to journal-ready .docx |
| reply-writing | `skills/simple/reply-writing/SKILL.md` | ad-hoc single-comment reply work |
| reviewer-reply-planning | `skills/simple/reviewer-reply-planning/SKILL.md` | triaging reviewer comments and planning the revision |
| reviewer-reply-drafting | `skills/simple/reviewer-reply-drafting/SKILL.md` | drafting the reply and rendering the tracked-changes manuscript |
| topic-writing | `skills/simple/topic-writing/SKILL.md` | synthesis, perspective, brief, blog post |

### Workflows (multi-phase orchestrators)

| Skill | Path | Use when |
|-------|------|----------|
| analysis-pipeline | `skills/workflows/analysis-pipeline/SKILL.md` | orchestrating the full plan-implement-review loop |
| research-iterate | `skills/workflows/research-iterate/SKILL.md` | iterating a research analysis through quality gates until publication-ready |
| paper-research | `skills/workflows/paper-research/SKILL.md` | full multi-phase pipeline from findings to manuscript draft |
| expert-review | `skills/workflows/expert-review/SKILL.md` | simulated peer-review panel for a draft |
| manuscript-pipeline | `skills/workflows/manuscript-pipeline/SKILL.md` | orchestrating the full manuscript lifecycle |
| reviewer-reply-pipeline | `skills/workflows/reviewer-reply-pipeline/SKILL.md` | orchestrating the full reviewer-reply cycle |

## Agent roster

| Agent | Path | Expertise |
|-------|------|-----------|
| Lab Director | `agents/lab-director.md` | task routing, cross-domain integration, quality assurance |
| Quantitative Scientist | `agents/quantitative-scientist.md` | statistical modelling, ML, R/Python coding, diagnostics |
| Science Writer | `agents/science-writer.md` | literature research, manuscript drafting, expert review |
| Literature Extractor | `agents/literature-extractor.md` | verbatim quantitative extraction from sources with full provenance |
| Extraction Validator | `agents/extraction-validator.md` | source-faithfulness verification |
| Acoustic Telemetry Specialist | `agents/acoustic-telemetry-specialist.md` | receiver array design, VPS, detection probability, range testing, cooperative networks |
| Movement Ecology Specialist | `agents/movement-ecology-specialist.md` | home range, HMMs, state-space models, step selection, migratory connectivity |
| Fisheries Stock & Management Specialist | `agents/fisheries-stock-management-specialist.md` | stock structure, SEDAR, C&R survival, management framing, council jurisdiction |
| Species Distribution Modelling Specialist | `agents/species-distribution-modelling-specialist.md` | INLA-SPDE / inlabru iSDM, BRT, marine covariates, projections |
| Geospatial & Environmental Data Specialist | `agents/geospatial-environmental-data-specialist.md` | GLORYS / OISST / Copernicus, ERDDAP, raster / sf / terra workflows |
| Stable Isotope & Trophic Ecology Specialist | `agents/stable-isotope-and-trophic-ecology-specialist.md` | δ13C / δ15N / δ34S, MixSIAR mixing models, trophic-position, isoscapes, ontogenetic diet shifts |
| Marine Megafauna & Anthropogenic Impacts Specialist | `agents/marine-megafauna-anthropogenic-impacts-specialist.md` | AIS-based vessel strike risk, tourism / wildlife-watching compliance, biologger workflows for whales, whale sharks, and sea turtles |

## Griffin Lab keyword-to-specialist routing

The Lab Director consults this table first to dispatch a request. If a request falls outside
the listed terms, the Lab Director falls back to inspecting `knowledge_base/*/INDEX.md`.

| Request keywords / phrasing | Specialist(s) | Dispatch pattern |
|---|---|---|
| "acoustic telemetry", "VPS", "receiver", "detection efficiency", "range test", "tag retention", "FACT", "OTN", "ACT", "iTAG", "Innovasea", "VR2", "VR4" | acoustic-telemetry-specialist + quantitative-scientist | Pattern A |
| "home range", "KDE", "AKDE", "Brownian bridge", "HMM", "behavioural state", "step selection", "SSF", "state-space model", "migratory connectivity", "movescape" | movement-ecology-specialist + quantitative-scientist | Pattern A |
| "stock structure", "SEDAR", "MRIP", "FMP", "SAFMC", "GMFMC", "ASMFC", "catch-and-release", "C&R survival", "post-release mortality", "management implications", "allocation" | fisheries-stock-management-specialist (+ acoustic-telemetry-specialist for C&R survival) | Pattern A or B |
| "SDM", "species distribution model", "iSDM", "INLA", "inlabru", "SPDE", "BRT", "habitat model", "niche model", "projection", "climate scenario", "BlueShark", "cobia SDM" | species-distribution-modelling-specialist + geospatial-environmental-data-specialist + quantitative-scientist | Pattern B |
| "GLORYS", "OISST", "MUR SST", "Copernicus", "ERDDAP", "rerddap", "GEBCO", "bathymetry", "chlorophyll", "covariate raster", "extract covariates", "regrid", "reproject" | geospatial-environmental-data-specialist | Pattern A or D |
| "stable isotope", "SIA", "δ13C", "δ15N", "δ34S", "MixSIAR", "simmr", "isoscape", "trophic position", "trophic level", "diet analysis", "ontogenetic diet shift", "fecal eDNA", "gut content", "lipid extraction", "TDF", "CSIA" | stable-isotope-and-trophic-ecology-specialist + quantitative-scientist | Pattern A or B |
| "vessel strike", "ship strike", "AIS", "Global Fishing Watch", "GFW", "Maritime Connector", "vessel traffic", "vessel speed", "DWAS", "whale shark", "Rice's whale", "right whale", "marine mammal", "cetacean", "biologger", "CATS tag", "OpenTag", "tourism compliance", "provisioning", "wildlife watching", "distance sampling", "BACI", "encounter rate" | marine-megafauna-anthropogenic-impacts-specialist (+ geospatial-environmental-data-specialist for AIS workflow) | Pattern A or B |
| "tarpon", "permit", "bonefish", "cobia", "snook", "red drum" + biology/movement context | acoustic-telemetry-specialist + movement-ecology-specialist (+ fisheries-stock-management-specialist if management framing) | Pattern B |
| "tarpon", "permit", "bonefish", "cobia" + distribution / habitat | species-distribution-modelling-specialist + acoustic-telemetry-specialist + geospatial-environmental-data-specialist | Pattern B |
| "manuscript draft", "intro", "discussion", "abstract", "polish this section" | science-writer (consulting domain specialists; use griffin-writing-style skill) | Pattern C |
| "grant", "proposal", "LOI", "fellowship essay", "broader impacts" | science-writer (proposal mode; use griffin-writing-style skill) | Pattern C |
| "reviewer comments", "response to reviewers", "revision letter", "rebuttal" | science-writer + the domain specialist whose section is being defended | Pattern B |
| "interpret these results", "what does this mean ecologically" | relevant domain specialist (no analysis needed) | Pattern D |
| "review this code", "diagnose this pipeline" | quantitative-scientist + relevant domain specialist when the issue is domain-coupled | Pattern A or B |

**Quantitative Scientist rule** (per `agents/lab-director.md`): if a task involves any data
analysis, modelling, or code, the Quantitative Scientist is always involved.

Patterns are defined in `agents/lab-director.md`:
- **A (focused analysis)**: one domain specialist + quantitative-scientist.
- **B (cross-domain)**: multiple domain specialists in parallel + quantitative-scientist.
- **C (writing)**: science-writer leads, consults domain specialists as needed.
- **D (pure consultation)**: one specialist, no analysis.

Add or modify domain-specialist agents under `agents/` as the lab's work evolves. Use
`agents/_domain-specialist.template.md` as the starting skeleton.

## Griffin Lab skill catalog (external)

The lab maintains a separate skills repo at `~/github/claude_skills/` that holds skills
authored before (and outside) the framework. These remain the canonical source of truth
for their respective domains; the framework consults them by reference rather than
duplicating their content.

| Skill | Location | What it covers |
|---|---|---|
| griffin-writing-style | `~/github/claude_skills/writing/griffin-writing-style/` | Manuscript, proposal, LOI, fellowship, and reviewer-reply writing voice (full per-journal and per-funder calibration). The framework's `conventions/voice.md`, `manuscript-format.md`, and `reply-format.md` are framework-native mirrors of this skill's surface, but the skill carries richer detail (e.g., `references/funder-profiles.md`, `references/journal-profiles.md`, `references/species-vocabulary.md`, `references/opening-bank.md`, `references/paragraph-structure.md`, `references/reference-quality-protocol.md`). Load the skill directly for any writing task that benefits from per-journal or per-funder calibration. |
| r-coding-standards | `~/github/claude_skills/writing/r-coding-standards/` | R project structure, function design, testing, documentation, dependency management. Overlaps with `conventions/code-format.md` but provides additional worked-example detail; load the skill for R-heavy tasks that need rigorous structure beyond the framework conventions. |
| turtle-cold-stun-extraction | plugin-installed | End-to-end workflow for extracting handwritten "Cold Stun Event Turtle Data" forms (multi-page scanned PDFs) into clean CSV/XLSX with uncertainty flags. Highly task-specific; triggered automatically when Lucas provides scanned cold-stun stranding forms. |

These skills are auto-loaded by Claude Code via the plugin system when their trigger
descriptions match; the entries above are documentation, not invocation requirements.

## Knowledge base

The `knowledge_base/` folder is the lab's accumulated thinking, organised by topic. The framework ships with the scaffolding (`SKILL.md`, `GLOBAL-CONCEPTS.template.md`, `_topic.template/`). Populate with topics relevant to your lab.

Use `knowledge_base/SKILL.md` to ingest, compile, query, and maintain the knowledge base. Every ingest operation MUST load `conventions/research.md` and use `agents/literature-extractor.md` plus `agents/extraction-validator.md` for any quantitative extraction. Source faithfulness is non-negotiable.

## Setup and onboarding

If the adopter has not yet populated the templates, point them to `setup/SKILL.md` and `setup/lab-onboarding.html`. The setup skill walks them through an interview that generates lab-specific versions of every `*.template.md` file in `conventions/`, plus stubs for any domain-specialist agents and the first knowledge-base topics.

## Dashboard

A system-state dashboard can be generated via `tools/generate-state.js` and viewed in any browser:

```bash
node tools/generate-state.js
open tools/system-dashboard.html
```

The dashboard reports skill inventory, agent roster, knowledge-base coverage, and convention-population status. Useful for tracking what is set up and what remains.

## Always-load contracts

These files MUST be loaded before relevant tasks, regardless of which workflow or skill is invoked:

- Any writing → `conventions/voice.md` (or template)
- Manuscript work → `conventions/manuscript-format.md` (or template)
- Reviewer reply → `conventions/reply-format.md` (or template)
- Figures or tables → `conventions/figure-format.md` (or template)
- Citations or lit search → `conventions/research.md` (ships opinionated)
- R or Python coding → `conventions/code-format.md` (or template)
- Iteration of an analysis → `conventions/iteration-workflow.md`, `conventions/research-quality-gates.md`, `conventions/visual-review-protocol.md` (all ship opinionated)

If a skill produces written output without loading the relevant conventions, that is a routing failure to flag.

## Operating principles

These come from the paper's §3 and apply to every interaction:

1. **The scientist holds source authority.** The model proposes; the scientist disposes. Interpretations, hypotheses, judgments about quality belong to the scientist.
2. **Verify, do not trust.** Treat model outputs as draft-quality input. Reference accuracy, code correctness, and conceptual claims all require verification proportional to stakes.
3. **Externalise what the AI cannot internalise.** Conventions, defaults, voice, and methodological heuristics belong in the framework files rather than in repeated prompting.
4. **Use specialist sub-agents for division of cognitive labour.** Invoke specialists explicitly. Parallel critique catches more errors than serial review.
5. **Treat the knowledge base as compounding infrastructure.** Curate, do not auto-generate. Source faithfulness is non-negotiable.
6. **The framework is non-stationary.** Models and conventions change. Update the files, not the architecture.

## Status

This is v0.2 of the framework. See `README.md` for the roadmap.
