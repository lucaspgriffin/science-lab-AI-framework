---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida (Department of Integrative Biology)
generated: 2026-05-26
mode: chat-driven onboarding (via Claude Code in `~/Desktop/stjoe/SJB_Receiver_Map_App`)
operator: Claude Opus 4.7 (1M context)
---

# Onboarding record: Griffin Lab science-lab-AI-framework

This file is the audit trail of the AI-assisted onboarding session that turned the upstream
`jakebrownscombe/science-lab-AI-framework` fork into the Griffin Lab's working framework.
Re-running the onboarding (e.g., after a major framework update) can use this record as the
starting point and only re-ask the phases that changed.

---

## Source upstream

- Upstream repo: https://github.com/jakebrownscombe/science-lab-AI-framework (v0.2)
- Fork: https://github.com/lucaspgriffin/science-lab-AI-framework
- Install path: `/Users/lucasgriffin/science-lab-AI-framework`
- Remotes: `origin` (lucaspgriffin fork), `upstream` (jakebrownscombe canonical)

## Mode

Chat-driven onboarding via the `setup/SKILL.md` orchestrator, not the HTML form. Lucas
opted to run the interview in chat and let the operator (Claude Opus 4.7 with the
`griffin-writing-style` skill loaded) pre-populate as much as possible from existing
artefacts (the `griffin-writing-style` skill, public publications, lab project repos).

## Phase 1: Lab identity

- **Lab name**: Griffin Lab
- **PI**: Lucas P. Griffin
- **Institution**: University of South Florida, Department of Integrative Biology
- **Domain**: marine ecology, fisheries science, movement ecology
- **Subfield emphasis**: passive acoustic telemetry of marine and estuarine fishes,
  movement-derived stock structure, catch-and-release survival, species distribution
  modelling, recreational-fishery management framing.
- **Methods stack**: acoustic telemetry (VPS, gates, grids), mark-recapture, occupancy /
  N-mixture, hidden Markov models, state-space models, integrated SDMs (INLA-SPDE,
  inlabru, BRT), spatial cross-validation, marine environmental covariate workflows
  (GLORYS, OISST, MUR SST, GEBCO, Copernicus / CMEMS).
- **Primary outputs**: primary research manuscripts, grant proposals (NOAA, USGS, DoD,
  NSF, Gulf Research Program, Bonefish & Tarpon Trust, Sloan, state foundations), Shiny
  dashboards (SJB-Receiver-Map-App, tarpon dashboard, cobia app), open-source R code.
- **Target journals** (per contribution type): *Fish and Fisheries*, *Movement Ecology*,
  *Ecological Applications*, *Methods in Ecology and Evolution*, *Animal Biotelemetry*,
  *Marine Ecology Progress Series*, *ICES Journal of Marine Science*, *Canadian Journal
  of Fisheries and Aquatic Sciences*, *Fisheries Research*, *Marine Biology*,
  *Environmental Biology of Fishes*, *Marine Policy*, *Frontiers in Marine Science*.

## Phase 2: Voice

Voice was **ported in full from the `griffin-writing-style` skill**
(`~/github/claude_skills/writing/griffin-writing-style/SKILL.md`), which was previously
calibrated to Lucas's voice across 21+ peer-reviewed papers and 25+ proposals (2017-2025).
The framework-native `conventions/voice.md` is a mirror of that skill's voice surface,
adapted to the framework's template structure.

Notable Griffin Lab voice deltas vs framework defaults:

- Em-dash ban (matches framework default; lab confirms).
- First-person plural throughout ("we"), active voice dominant (~80%).
- Hedging calibrated to evidence; no reflexive hedging.
- Federal-proposal language: "Gulf of America" not "Gulf of Mexico"; avoid "climate
  change" (use "environmental change", "environmental stressors", "environmental trends").
- No absolute methodological claims ("avoids" not "eliminates").
- Word document defaults: Times New Roman 12 pt black; manual paragraph spacing; no
  running page headers or footnotes.

Voice exemplars (`conventions/voice.md` section 9), refreshed 2026-05-26 from the lab's
Google Scholar profile (https://scholar.google.com/citations?user=scPoGrkAAAAJ&hl=en):

Primary exemplars (most recent first-author work):
- Griffin et al. 2025, *Fish and Fisheries* (Entrainment Hypothesis synthesis for Atlantic
  tarpon).
- Griffin et al. 2025, *Fisheries* (Habitat management and restoration in flats
  ecosystems).
- Griffin et al. 2023, *Environmental Biology of Fishes* (bonefish site fidelity in
  Culebra).

Secondary exemplars: Griffin et al. 2025 *Fisheries Research* (bonefish post-release
predation); Griffin et al. 2024 *CJFAS* (angler-fish interactions); Griffin et al. 2023
*Marine Policy* (tarpon angler perceptions); Griffin et al. 2023 *EBF* (red tide tarpon);
Griffin et al. 2022 *Ecological Applications* (predator-prey landscapes); Griffin et al.
2022 *MEPS* (tarpon phenology).

Foundational exemplar: Griffin et al. 2018 *Fisheries Research* (Silver King cooperative
telemetry, the original lab-voice paper).

Note: the initial onboarding mistakenly listed Brownscombe et al. 2022 *J Applied Ecology*
and Danylchuk et al. 2023 *EBF* as Griffin first-author exemplars; both are co-authored.
Corrected on Scholar re-fetch.

## Phase 3: Manuscript norms

Manuscript format ported from
`griffin-writing-style/references/manuscript-architecture.md` and `journal-profiles.md`.

- Default journal: contribution-dependent (no single default). See
  `conventions/manuscript-format.md` section 1.
- Citation style: author-year alphabetical (CSE / Harvard) for the dominant target
  journals; journal template followed exactly at submission.
- Methods: integrated (not deferred to supplementary). Package versions explicit.
- Source-integrity stance: strict per `conventions/research.md`; the lab does not
  fabricate citations or invent unpublished data.

## Phase 4: Code stack

Code format inferred from observed practice across
`~/github/cobia_sdm_explore/`, `~/github/tarpon_dashboard/`, `~/github/BlueShark_ISDM/`,
`~/Desktop/stjoe/SJB_Receiver_Map_App/`, `~/github/terrapin_*/`, and related repos.

- **Primary language**: R (dominant). Python used selectively (e.g., `python-pptx`
  utilities, occasional `xarray`).
- **Tidyverse-dominant**; `data.table` for very large detection tables.
- **Plotting**: `ggplot2` + `patchwork` + `ggspatial`; `leaflet` for Shiny / interactive
  maps; `gganimate` for movement animations.
- **Environment management**: `renv` for publication-bound projects and Shiny
  deployments; system-level for lightweight exploratory work.
- **Project layout**: numbered analysis scripts (`00_config.R`, `01_*.R`, `02a_*.R`,
  ...), `data/raw/` and `data/processed/` gitignored, `outputs/` for artefacts.
- **Version control**: git + GitHub. Public for published work, private for in-progress.
  Imperative-mood commit messages.
- **Deployment**: Shiny apps via `Rscript -e "rsconnect::deployApp()"` from repo root
  (lab preference, recorded in `[[deployment-method]]` memory).
- **Reproducibility**: `renv.lock` committed for publication-bound projects; per-script
  `sessionInfo()` written to logs; `00_config.R` holds all run parameters.

## Phase 5: Agent roster

Five domain-specialist agents created (in addition to the framework's five-agent core
roster):

1. **Acoustic Telemetry Specialist** (`agents/acoustic-telemetry-specialist.md`):
   receiver array design, VPS, detection probability, range testing, cooperative
   networks.
2. **Movement Ecology Specialist** (`agents/movement-ecology-specialist.md`): home range,
   HMMs, state-space models, step selection, migratory connectivity.
3. **Fisheries Stock & Management Specialist**
   (`agents/fisheries-stock-management-specialist.md`): stock structure, SEDAR, C&R
   survival, management framing, council jurisdiction.
4. **Species Distribution Modelling Specialist**
   (`agents/species-distribution-modelling-specialist.md`): INLA-SPDE / inlabru iSDM,
   BRT, climate projections.
5. **Geospatial & Environmental Data Specialist**
   (`agents/geospatial-environmental-data-specialist.md`): GLORYS / OISST / Copernicus,
   ERDDAP, raster / sf / terra workflows.

Lab-specific keyword-to-specialist routing table appended to `CLAUDE.md`. The Lab
Director (`agents/lab-director.md`) consults that table first when dispatching requests.

## Phase 6: Knowledge-base seed

Four KB topics seeded (Lucas requested all four from the option set):

1. **acoustic-telemetry-methods** (owned by Acoustic Telemetry Specialist).
   Seed article: `detection-efficiency-and-range-testing`.
2. **catch-and-release-survival** (owned by Fisheries Stock & Management; co-owned by
   Acoustic Telemetry).
   Seed article: `post-release-survival-design`.
3. **movement-ecology-analysis** (owned by Movement Ecology; co-owned by Acoustic
   Telemetry).
   Seed article: `home-range-and-utilisation-distributions`.
4. **species-distribution-modelling** (owned by SDM Specialist).
   Seed article: `integrated-sdm-with-inla-spde`.

Each seed article is a `stub`: structural scaffolding with TODO markers for verbatim
extraction. Promote to `draft` after `agents/literature-extractor.md` ingests the cited
sources; promote to `published` after `agents/extraction-validator.md` confirms
claim-citation alignment.

## Phase 7: Quality preferences

Overrides recorded in `conventions/research-quality-gates-lab-overrides.md`:

- Gate 2 renamed "Domain Gate" → "**Ecological Gate**".
- Added Ecological Gate criteria: detection-process honesty, movement-scale alignment,
  management-context plausibility, federal-proposal language compliance,
  species-vocabulary compliance.
- Added Visual Gate criteria: map completeness (scale bar, north arrow), projection
  consistency, colourblind-safe palette.
- Literature Gate applies from Phase 3 onwards (not deferred to manuscript-late phase).
- Framing Gate enforced for management-leaning outputs; may be waived for pure methods
  papers.

## Phase 8: File generation

Files written or updated by this onboarding (one-pass generation):

| Path | Notes |
|---|---|
| `CLAUDE.md` | Updated: added Griffin Lab keyword-to-specialist routing table |
| `conventions/voice.md` | Created (from griffin-writing-style skill port) |
| `conventions/manuscript-format.md` | Created (from manuscript-architecture port) |
| `conventions/reply-format.md` | Created (from reviewer-response port) |
| `conventions/code-format.md` | Created (from observed repo practice) |
| `conventions/figure-format.md` | Created (R + ggplot2 + Okabe-Ito + ggspatial) |
| `conventions/research-quality-gates-lab-overrides.md` | Created (gate renames / additions) |
| `agents/acoustic-telemetry-specialist.md` | Created |
| `agents/movement-ecology-specialist.md` | Created |
| `agents/fisheries-stock-management-specialist.md` | Created |
| `agents/species-distribution-modelling-specialist.md` | Created |
| `agents/geospatial-environmental-data-specialist.md` | Created |
| `knowledge_base/acoustic-telemetry-methods/INDEX.md` | Created |
| `knowledge_base/acoustic-telemetry-methods/articles/detection-efficiency-and-range-testing.md` | Created (stub) |
| `knowledge_base/catch-and-release-survival/INDEX.md` | Created |
| `knowledge_base/catch-and-release-survival/articles/post-release-survival-design.md` | Created (stub) |
| `knowledge_base/movement-ecology-analysis/INDEX.md` | Created |
| `knowledge_base/movement-ecology-analysis/articles/home-range-and-utilisation-distributions.md` | Created (stub) |
| `knowledge_base/species-distribution-modelling/INDEX.md` | Created |
| `knowledge_base/species-distribution-modelling/articles/integrated-sdm-with-inla-spde.md` | Created (stub) |
| `setup/onboarding-record.md` | This file |

## Post-onboarding wiring (also performed in the same session)

- `~/.claude/CLAUDE.md` symlinked to
  `/Users/lucasgriffin/science-lab-AI-framework/CLAUDE.md` (no prior global CLAUDE.md
  existed; no backup needed).
- `claude` shell alias in `~/.zshrc` updated to include
  `--add-dir /Users/lucasgriffin/science-lab-AI-framework`.
- Dashboard regenerated via `node tools/generate-state.js`; view at
  `tools/system-dashboard.html`.

## Next steps for Lucas

1. Read each generated file end to end; edit anything that does not match actual
   practice.
2. For each KB stub article, run the `literature-extractor` agent to ingest the cited
   sources, then `extraction-validator` to confirm alignment, then promote to `published`.
3. Add domain-specialist agents as gaps emerge (the framework is non-stationary).
4. Re-run this onboarding by re-invoking `setup/SKILL.md` if any phase needs revising.
5. Commit the populated framework to the fork
   (`lucaspgriffin/science-lab-AI-framework`) with a clear message.

## Operator notes

The pre-existing `griffin-writing-style` skill made this onboarding substantially faster:
roughly 60% of the conventions content was a direct port from that skill, rather than
elicited fresh. The skill remains the source of truth for the lab's writing voice; the
framework's `conventions/voice.md` is the framework-native mirror so that downstream
skills loading `conventions/voice.md` get equivalent content.

The lab's repo patterns (numbered scripts, `00_config.R`, renv, Shiny deployment via
`rsconnect::deployApp`) informed `conventions/code-format.md` directly.

The cobia SDM project memory
(`~/.claude/projects/-Users-lucasgriffin-github/memory/MEMORY.md`) informed the
INLA-SPDE / inlabru / 1D-SPDE detail in
`agents/species-distribution-modelling-specialist.md` and the seed article
`integrated-sdm-with-inla-spde.md`.

No credentials, API tokens, or sensitive site coordinates were written into any framework
file.
