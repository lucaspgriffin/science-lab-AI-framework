---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida
generated: 2026-05-26
source: ported from griffin-writing-style/references/manuscript-architecture.md and journal-profiles.md
---

# Manuscript format: Griffin Lab manuscript conventions

This file encodes document-level architecture: section structure, citation density, length
targets, figure-to-result pairing, and journal-specific defaults. Voice (`conventions/voice.md`)
handles sentence-level register; this file handles document architecture.

For the full per-section architecture and journal calibration, defer to the canonical
`griffin-writing-style/references/manuscript-architecture.md` and `journal-profiles.md`. This
file is the framework-native summary that downstream skills load.

---

## 1. Default journal and architecture

The lab does not have a single default journal: the choice depends on the paper's contribution.

| Contribution type | Target journals (preferred order) |
|---|---|
| Movement / spatial-ecology synthesis | *Fish and Fisheries*, *Movement Ecology*, *Ecological Applications* |
| Telemetry methods / array design | *Methods in Ecology and Evolution*, *Animal Biotelemetry*, *Marine Ecology Progress Series* |
| Species distribution / habitat modelling | *Ecological Applications*, *Marine Ecology Progress Series*, *ICES Journal of Marine Science*, *Diversity and Distributions* |
| Stock / fisheries management application | *Canadian Journal of Fisheries and Aquatic Sciences*, *ICES Journal of Marine Science*, *Fisheries Research* |
| Catch-and-release physiology / behaviour | *Fisheries Research*, *Journal of Experimental Marine Biology and Ecology*, *Environmental Biology of Fishes*, *Marine Biology* |
| Climate / multi-stressor framing | *Environmental Biology of Fishes*, *Marine Policy*, *Frontiers in Marine Science* |
| Conservation / management policy framing | *Marine Policy*, *Conservation Letters*, *Frontiers in Marine Science* |

Reference style is journal-specific; for the dominant venues the lab uses author-year (CSE /
Harvard style) parenthetical citations.

---

## 2. IMRAD skeleton

Default section order for a primary research manuscript:

1. **Title** (under 15 words where possible; common name + scientific name in titles where
   relevant)
2. **Abstract** (250–350 words; structured or unstructured per journal)
3. **Introduction** (3–7 paragraphs; funnel structure, see section 3.2)
4. **Methods** (integrated; subsections per analytical step)
5. **Results** (subsections paired one-to-one with main figures where possible)
6. **Discussion** (4–6 paragraphs; opening synthesis, body interpretation, limitations,
   management implications closer)
7. **References**
8. **Figure legends**
9. **Tables** (inline or separate file per journal)
10. **Supplementary materials** (separate document)

---

## 3. Section-by-section conventions

### 3.1 Abstract

Single paragraph (unstructured) or structured headings (Background, Methods, Results,
Conclusions) per journal. Target 250–350 words.

Opening sentence: a one-line framing of why the question matters in the lab's domain (movement
ecology, fisheries, or marine conservation). Do not open with "Recent advances have ..." or
"It is well known that ...".

Body: one-sentence study system framing, methods summary, key results with at least one
quantitative statistic and a credible/confidence interval, and a one-to-two-sentence
management or ecological takeaway.

### 3.2 Introduction

Funnel structure. Every introduction narrows from broad ecological or societal context to the
specific study contribution.

- **Paragraph 1, broad relevance**: societal, ecological, or economic context that makes the
  research matter. Lead with a strong, confident, unhedged statement. If a compelling number
  exists (economic value, participation rate, population decline), put it here.
- **Paragraphs 2–3, literature and concepts**: narrow from broad context to the conceptual
  framework. Define key terms at first use with formal citations. Each paragraph has a clear
  topic sentence and advances the argument; do not catalog literature.
- **Penultimate paragraph, the gap**: identify what is not known, or what has not been tested
  at the right scale, with the right methods, or in the right system. Use contrast structures
  ("Despite considerable advances in X, relatively little is known about Y"; "While X has been
  well documented in [system A], [system B] lacks equivalent data"). The gap should be
  specific, solvable, and consequential.
- **Final paragraph, objectives**: state what this study does to address the gap. Be specific
  ("Using [methods], we examined [questions] in [system] over [timeframe]"). Present multiple
  objectives as a logical sequence rather than a numbered list. Close with a one-sentence
  significance statement.

Length by journal tier:
- Tier 1 (*Fish and Fisheries*, *Ecological Applications*, *Movement Ecology*): 5–7 paragraphs
- Tier 2 (*Marine Biology*, *Marine Ecology Progress Series*, *CJFAS*, *ICES JMS*): 4–5
  paragraphs
- Tier 3 (*Fisheries Research*, *Environmental Biology of Fishes*, *Animal Biotelemetry*):
  3–4 paragraphs

Citation density: high, 6–12 per paragraph, balanced 15–20% landmark (10+ years),
55–65% recent core (3–10 years), 20–25% cutting-edge (0–3 years). See section 4 below.

### 3.3 Methods

Subsection per analytical step. Typical structure for a telemetry / SDM / catch-and-release
study:

1. Study system and area
2. Field protocols (tagging, sampling, deployment, observation)
3. Data processing and quality control
4. Statistical analysis (model structure, covariate set, software / packages with versions)
5. Model evaluation and diagnostics
6. Code and data availability

Voice in Methods: active where the agent matters ("We deployed 25 receivers in a 5 × 5 grid
across the study site"), passive where it does not. Package versions are explicit (e.g.,
`unmarked 1.4.1`, `INLA 24.05.10`, `inlabru 2.10.1`, `glmmTMB 1.1.10`, `terra 1.7-83`).
Anything not reproducible from the Methods alone moves to a supplementary protocol.

### 3.4 Results

Subsections paired one-to-one with main figures where possible. Subsection opening sentence
names the analytical question, not the result ("We asked whether ...", "To assess ..."). No
interpretation or speculation in Results; that belongs in Discussion. Statistics reported with
effect sizes and intervals, not just p-values. Cite specific test, effect direction, and
magnitude.

### 3.5 Discussion

Opening paragraph: synthesise key findings framed around the study's original questions. Do
not open with "In this study, we found ..." (mechanical). Lead with the most important finding
and build from there.

Body paragraphs: each body paragraph addresses one major finding or theme. Internal structure:
1. State the finding clearly.
2. Interpret it mechanistically: propose *why* this pattern exists.
3. Compare with existing literature ("Our results align with ..." or "In contrast to ...").
4. Note implications for the system, species, or management context.

Move from the strongest or most novel findings to more confirmatory or secondary ones.

Limitations paragraph: brief, confident, forward-looking. Acknowledge limitations honestly but
pivot each one to a future research opportunity ("While our study was limited to X, future
work incorporating Y could reveal whether ..."). Do not apologise or undermine the study's
contributions.

**Final paragraph, management implications**: non-negotiable. Every Discussion closes with
actionable recommendations connecting the science to practice. Be specific: name the
management action, the geographic or policy context, and why the findings support it.

Citation density in Discussion: high (8–15 per paragraph). Each interpretation paragraph
cites at least one supporting and one complicating reference where the literature is mixed.

---

## 4. Citation density and integration

- **Parenthetical citations** are the default, placed at the end of clauses or sentences. Lead
  with the lab's analytical voice; citations support rather than dominate.
- **Narrative citations** used sparingly to emphasise foundational or contrasting work. Place
  the author as the grammatical subject of an **active** verb: "Secor (1999) proposed ...",
  "Griffin et al. (2023) demonstrated ...". Never use passive constructions like "described by"
  or "reported by"; if a citation cannot be framed actively, make it parenthetical.
- Multiple related citations: group with semicolons, order chronologically.
- Self-citation included where directly relevant; the lab does not pad references with its
  own work.
- Reference balance: 15–20% landmark (10+ years, foundational concepts and methods); 55–65%
  recent core (3–10 years, main body of evidence); 20–25% cutting-edge (0–3 years, signals
  currency).
- **No fabricated citations**: no invented "Griffin, unpublished" or imagined DOIs. If a DOI
  cannot be verified, leave the in-text citation as plain unlinked text. Full protocol:
  `griffin-writing-style/references/reference-quality-protocol.md` and
  `conventions/research.md`.

---

## 5. Figure and table conventions (document-level)

Render-time rules live in `conventions/figure-format.md`. Document-level rules:

- Main figures: 4–6 typical, paired one-to-one with Results subsections where possible.
- Multi-panel figures: 2–6 panels with letter labels (A, B, C, ...) in a consistent corner.
- Figure legends: 80–150 words, structured (one-sentence overview, then per-panel descriptions,
  then statistical-test summary).
- Tables: 1–3 main tables, used for model parameter summaries, deployment/sample-design tables,
  or species-level results that do not benefit from visualisation.
- Supplementary figures: typically 5–15 per paper for a telemetry or SDM analysis.

---

## 6. Supplementary materials

- Single PDF for supplementary figures and tables (Supp Fig 1 through N, Supp Table 1 through
  N), plus a separate supplementary protocol document for methods detail when needed.
- Large data tables go as `.csv` or `.xlsx`.
- Code: deposited on GitHub with a commit-pinned release tag; the methods section cites the
  release tag and DOI (Zenodo if archived).
- Field data archived on a public repository with a DOI (Movebank for telemetry; Dryad,
  Figshare, or OBIS for spatial / biological data). Sensitive site coordinates or species
  locations are perturbed prior to deposit where regulatory or stewardship constraints apply.

---

## 7. Length targets

| Section | Typical word count |
|---|---|
| Title | < 15 words |
| Abstract | 250–350 (unstructured) or per journal structured limit |
| Introduction | 800–1,500 |
| Methods | 1,500–3,000 (excess goes to supplementary protocol) |
| Results | 1,500–3,000 |
| Discussion | 1,200–2,000 |
| Total body (including Methods) | 5,500–8,500 |
| References | 60–120 for a primary research paper |

These are starting points; the actual target is set by the journal.

---

## 8. Reference list conventions

- Style: author-year alphabetical for the dominant journals (*MEPS*, *CJFAS*, *Fish and
  Fisheries*, *Ecological Applications*, *Marine Biology*, *Fisheries Research*); journal
  template followed exactly at submission.
- In-text: "Author et al." for papers with > 2 authors; "Author and Author" for two-author
  papers.
- Preprints (bioRxiv, EcoEvoRxiv) cited with the preprint flag and replaced when published.
- Reference manager: not enforced; the lab works in mixed Zotero / EndNote / Paperpile
  depending on collaborator. Each project picks one and stays with it.

---

## 9. Cover letter and submission

Single page. Architecture:

1. **Paragraph 1**: the problem and why it matters.
2. **Paragraph 2**: the approach and the key finding (one sentence with a number).
3. **Paragraph 3**: why this journal specifically (audience fit, prior related work in the
   venue).
4. **Paragraph 4**: suggested reviewers (4–6 names) and any reviewers to exclude (with brief
   justification).

No performative filler ("we are pleased to submit ...", "we believe this work is a strong fit
..."). Lead with substance.

---

## Cross-references

- Sentence-level voice: `conventions/voice.md`
- Render conventions for figures and tables: `conventions/figure-format.md`
- Source-faithfulness and citation verification: `conventions/research.md`
- Reviewer reply (document-level delta on this file): `conventions/reply-format.md`
- Full per-journal calibration: `griffin-writing-style/references/journal-profiles.md`
- Manuscript section architecture (paragraph-level patterns):
  `griffin-writing-style/references/manuscript-architecture.md`
