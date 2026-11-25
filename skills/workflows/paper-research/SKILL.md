---
name: paper-research
description: |
  End-to-end AI-assisted workflow for taking analysis findings and producing a publication-ready manuscript reference document. Use this skill whenever the user mentions: writing a paper, preparing a manuscript, needing background literature, filling in an introduction or discussion section, turning results into a publishable paper, or needing to contextualize research findings within existing literature. Also trigger when users ask for help synthesizing literature for any section of a scientific paper, or want to prepare context documents for manuscript drafting. The skill handles everything from theme extraction through literature synthesis, contradiction-checking, and structured reference document generation: the user should NOT need to manually find or upload PDFs.
cost: heavy
---

# Paper Research Workflow

A structured workflow for converting analysis findings into a rich, verified reference document suitable for manuscript drafting. Designed for empirical scientists. Outputs a structured `.md` reference document organized by paper section, with sourced claims, confidence tags, and contradiction flags: ready to feed into any manuscript drafting context.

---


## Required references: load before any drafting

Load from `conventions/`:
- `conventions/voice.template.md`: core writing voice (also covers sentence-level construction patterns)
- `conventions/manuscript-format.template.md`: section structure, citation density, headings
- `conventions/research.md`: source-faithfulness contract, citation rules
- `conventions/figure-format.template.md`: when producing figures

Loading these is mandatory before any drafting work. They define the lab's voice, format, and integrity rules.

---
## Overview

The workflow has eight phases:

0. **Journal Targeting & Paper Planning**: Establish the outlet, audience, scope, and structural plan before any research begins
1. **Theme Extraction**: Identify the narrative threads the paper needs to address
2. **Literature Synthesis**: Run targeted searches to populate each thread with sourced claims
3. **Citation Validation**: Verify every citation exists, metadata is accurate, and abstract supports the claim
4. **Contradiction Audit**: Actively search for papers that challenge key claims
5. **Centrality Tagging**: Flag load-bearing vs. contextual claims
6. **Reference Document Assembly**: Output a structured, section-organized document ready for downstream drafting
7. **Markdown Manuscript Drafting**: Citation reliability tiers control sentence-level writing; markdown manuscript is marked up by tier so the author knows exactly where to focus review effort

WARNING: **Phase 3 (Citation Validation) is non-negotiable and cannot be skipped.** Every citation in the final reference document must pass all three validation checks before it is included. Unvalidated citations are never passed to the user as usable references.

---

## Phase 0: Journal Targeting & Paper Planning

This phase runs before anything else. It establishes the outlet, audience, and structural plan that governs every downstream decision: citation style, scope, content depth, framing of implications, and what the downstream prompts will ask for.

**Do not proceed to Phase 1 until journal targeting is resolved.**

---

### Step 0a: Elicit Journal Information

If the user has not specified a target journal, ask explicitly before proceeding:

> *"Before we start, do you have a target journal in mind? This affects citation style, word limits, audience assumptions, and how we frame the scope of the paper. If you are not sure yet, I can suggest options based on your topic and findings."*

If the user provides a journal: proceed to Step 0b.

If the user is undecided: run Step 0c (journal recommendation) first, then return to 0b once a target is selected.

If the user explicitly says they do not want to commit yet: record as `[JOURNAL: TBD]`, apply generic CSE author-date citation style as default, and flag at the top of the reference document that formatting will need to be adjusted once a journal is selected.

---

### Step 0b: Journal Profile Lookup

Once a journal is identified, retrieve its current author guidelines using `web_search` and `web_fetch`. Build a **Journal Profile** that will be attached to the reference document and passed to the drafting phase.

Search: `[Journal name] author guidelines instructions for authors [year]`

Fetch the official guidelines page and extract:

```
## Journal Profile: [Journal Name]

**Publisher:** [Publisher]
**Scope:** [1 to 2 sentence scope statement from the journal]
**Audience:** [Who reads this journal: generalist ecologists, applied conservation scientists, quantitative ecologists, etc.]

**Structural requirements:**
- Word limit: [total / by section if specified]
- Abstract: [structured or unstructured; word limit]
- Sections required: [e.g., Introduction, Methods, Results, Discussion, or combined]
- Figures/tables: [limits if any]

**Citation style:**
- Format: [Author-date / numbered / Vancouver / etc.]
- In-text format: [e.g., (Smith et al. 2019) or (Smith et al., 2019) or [1]]
- Reference list format: [full example from guidelines]
- DOI/URL: [required, optional, or format specified]
- Special rules: [e.g., "et al." after 3 authors, journal name abbreviation style]

**Journal scope classification:** [One of: broad-scope / taxon-or-system-specific / methods-focused / applied]
  - broad-scope: General biology, multidisciplinary (e.g., Nature, PNAS, Ecology Letters)
  - system-specific: Focused on a system or taxon (e.g., Journal of Animal Ecology, Journal of Mammalogy)
  - methods-focused: Emphasis on methodological contribution (e.g., Methods in Ecology and Evolution)
  - applied: Translational or applied science (e.g., Journal of Applied Ecology, Conservation Biology)

  This classification controls the Introduction funnel structure in Phase 7.

**Scope fit assessment:**
- Does this paper's topic, system, and findings align with this journal's stated scope? [Yes / Partial / Flag]
- If partial or flag: [note what may need reframing to fit]

**Typical citation density:** [If observable from published papers, e.g., "typically 40 to 60 refs for empirical papers"]

**Strategic notes:**
- [Anything notable about this journal's editorial preferences, typical paper length, citation density, or audience expectations that should shape drafting]
```

If the journal guidelines cannot be retrieved: note this and use the journal's known style from general knowledge, flagging that guidelines should be manually confirmed.

---

### Step 0c: Journal Recommendation (if undecided)

If the user has not identified a journal, propose 3 to 4 options ranked by fit. Base recommendations on:
- Topic and system focus
- Paper type (empirical, methodological, synthesis)
- Likely impact scope (system-specific vs. broadly applicable findings)
- The user's stated or inferred preference (open access, turnaround speed, prestige)

Present as a brief comparison:

```
Based on your findings, here are journal options to consider:

1. **[Journal A]**: Best fit for [reason]. Audience: []. Typical length: []. Citation style: []. OA: [yes/no/hybrid].
2. **[Journal B]**: Strong fit if [condition]. More generalist readership. Would require framing implications more broadly.
3. **[Journal C]**: Good fit if methodological novelty is a primary contribution. Narrower audience.
4. **[Journal D]**: Consider if you want faster turnaround or open access. Slightly lower prestige but good visibility in [field].

Which direction are you leaning, or would you like to discuss tradeoffs?
```

Wait for the user to select before proceeding to 0b.

---

### Step 0d: Paper Planning

With the journal confirmed, draft a **Paper Plan**: a structural outline that frames what each section needs to accomplish for this specific outlet and finding. This becomes the scaffolding the drafting phase works from in Phase 7.

```
## Paper Plan: [Working Title]

**Target journal:** [Journal]
**Paper type:** [Empirical study / Methods paper / Synthesis]
**Core finding (one sentence):** [User-provided or inferred from context]
**Central argument:** [What this paper claims and why it matters]
**Knowledge gap being addressed:** [The specific gap this paper fills]

---

### Introduction
**Goal:** Establish [field context], narrow to [specific system/question], identify gap, state objective
**Approximate length:** [N words, per journal profile]
**Key moves:**
- Paragraph 1: [Broad biological/biomedical context]
- Paragraph 2: [Narrow to focal system/method]
- Paragraph 3: [Identify the specific knowledge gap]
- Paragraph 4: [State objectives and briefly preview approach]
**Audience calibration:** [What level of background knowledge to assume]

### Methods
**Goal:** Justify approach; enable replication
**Approximate length:** [N words]
**Methodological precedent needed:** [What prior work needs to be cited to justify the approach]
**Level of detail:** [Per journal norms: high detail for methods papers, lighter for applied journals]
**Figure-driven requirements:** [Populated from Figure Plan: each figure's "Methods requirements" field lists what must be described here]
**Voice:** Passive voice throughout Methods. Avoid "We [verb]" constructions. Each methods paragraph should open with a rationale statement ("To quantify X, Y analysis was performed...") before describing the procedure.
**Subsections:** Use numbered subsections (2.1, 2.2, etc.) with italicized headings.

### Results
**Goal:** Present findings without interpretation
**Note:** This section is not drafted from the reference document: driven entirely by analysis outputs
**Organization:** Structured around the Figure Plan (Step 0e): each figure/table typically anchors its own paragraph
**Figures/tables planned:** [Populated in Step 0e: do not finalize Paper Plan without completing Figure Planning]

### Discussion
**Goal:** Interpret findings, compare to literature, implications (with limitations woven in), conclusion
**Approximate length:** [N words]
**Key moves:**
- Paragraph 1: [Restate core finding in context: no new citations]
- Paragraphs 2 to N: [Comparators, mechanisms, broader patterns: literature-heavy. Each paragraph organized around a single theme with clear internal flow. Limitations and caveats woven into interpretation where pertinent: NOT in a dedicated paragraph]
- Final paragraph: [Translational, biological, or conservation implications and future directions]
**Tone calibration:** [How boldly to frame implications given this journal's audience]
**HARD RULE:** Do NOT create a dedicated "Limitations" paragraph or section. Limitations must be woven into interpretation paragraphs when contextually relevant. This is a non-negotiable convention.

### Abstract
**Style:** [Structured / unstructured per journal]
**Word limit:** [N]
**Drafted last**: after full manuscript is assembled

---

**Citation density target:** [Approximate citations per section, based on journal norms]
**Citation style:** [Per journal profile]
**Flags for this paper:**
- [Any scope fit concerns to address in framing]
- [Any sections where findings may need to be presented more cautiously for this outlet]
```

Present the Paper Plan to the user and confirm before proceeding to Step 0e (Figure & Table Planning).

---

### Step 0e: Figure & Table Planning

Figures and tables are the backbone of the Results section and anchor the Discussion. Planning them early ensures the Introduction sets up the right context, the Methods describes the right analyses, and the Discussion interprets the right outputs. **This step is interactive: the user must be prompted to review and select options.**

#### Step 0e-1: Gather Analysis Context

Before proposing figures, collect what the user has available. Ask (or infer from provided context):

> *"To plan the figures and tables, I need to understand what analyses you have run and what outputs are available. Can you share any of the following?*
> - *Summary of key results or findings*
> - *Types of analyses performed (e.g., GLMMs, occupancy models, hierarchical N-mixture, ordination, structural equation models)*
> - *Available data types (e.g., camera-trap detection histories, mark-recapture captures, vegetation transect counts, climate-covariate rasters)*
> - *Any preliminary plots or figures you have already made*
> - *Sample sizes and study design overview"*

If the user has provided results context earlier (e.g., in the core finding or Paper Plan), use that directly without re-asking.

#### Step 0e-2: Propose Figure & Table Options

Based on the analysis context, paper type, and journal constraints, generate a **candidate list of 6 to 10 possible figures and tables**. For each candidate, provide:

```
## Candidate Figures & Tables

### Candidate 1: [Descriptive title]
- **Type:** [Site-map / Heatmap / Time series / Boxplot / Table / Barplot / Scatter / Partial-effect plot / Ordination / Conceptual diagram / etc.]
- **Shows:** [What this figure communicates in 1 sentence]
- **Data source:** [Which analysis or data this draws from]
- **Section:** [Results / Methods / Supplementary]
- **Priority:** [Essential, core finding / Important, supports narrative / Optional, nice to have]
- **Rationale:** [Why this figure matters for the paper's argument]

### Candidate 2: [Descriptive title]
...
```

**Candidate generation guidelines:**
- **Always include a study design / data overview figure** (e.g., site map, sampling design, effort summary): reviewers expect this
- **Lead with the core finding figure**: the single visualization that shows what the paper claims
- **Include at least one methods figure** if the approach has analytical complexity (e.g., pipeline schematic, model architecture, validation scheme)
- **Consider summary tables** for sample sizes, model outputs, or descriptive statistics: these are often essential but overlooked in planning
- **Think about what the Discussion needs to interpret**: if you will compare to literature, the figure should make that comparison intuitive
- **Check journal figure limits** from the Journal Profile. If the journal allows 6 figures, propose 4 to 5 main + 2 to 3 supplementary candidates
- **Consider combined/multi-panel figures** where related results can be shown together to stay within figure limits
- **For methods papers:** prioritize figures showing the method's performance, validation, or comparison to alternatives
- **For applied papers:** include at least one translationally relevant output

#### Step 0e-3: User Selection

Present the candidate list to the user and prompt for selection (use a multi-select prompt):

```
Based on your results and the target journal, I have identified [N] candidate figures and tables.

Which figures and tables should be included in the manuscript?
```

Offer each candidate as an option with its title as the label and its "Shows" description as the description. Include options for:
- Each candidate figure/table
- Let the user add custom figures via the "Other" option

After selection, ask a follow-up if needed:

> *"For the figures you selected, do you have specific preferences on:*
> - *Presentation order (which figure is Figure 1, 2, etc.)?*
> - *Any figures that should be combined into multi-panel figures?*
> - *Which figures should go to supplementary material vs. main text?*
> - *Any specific visual style preferences?"*

#### Step 0e-4: Build the Figure Plan

From the user's selections, create a structured **Figure Plan** that becomes part of the Paper Plan:

```
## Figure Plan

**Total main figures:** [N] (journal limit: [N])
**Total main tables:** [N]
**Supplementary figures:** [N]
**Supplementary tables:** [N]

---

### Figure 1: [Title]
- **Type:** [Site-map / Heatmap / etc.]
- **Shows:** [1 sentence]
- **Data source:** [Analysis/data it draws from]
- **Methods requirements:** [What needs to be described in Methods for this figure to make sense, e.g., "describe camera-trap detection thresholds", "explain model selection criteria"]
- **Results text:** [What the Results section needs to say about this figure, e.g., "report species-level occupancy estimates by stratum", "describe canopy-cover response curves"]
- **Discussion relevance:** [How this figure connects to Discussion paragraphs, e.g., "compare community response to Smith et al. 2019 findings"]
- **Status:** [User has this / Needs to be created / Conceptual: will sketch]

### Figure 2: [Title]
...

### Table 1: [Title]
- **Type:** [Summary statistics / Model output / Comparison / etc.]
- **Shows:** [1 sentence]
- **Columns:** [Expected column structure if known]
- **Methods requirements:** [What needs to be described]
- **Results text:** [What the Results section says about this table]
- **Status:** [User has this / Needs to be created]

### Supplementary Figure S1: [Title]
...
```

#### How the Figure Plan Flows Downstream

The Figure Plan is attached to the Paper Plan and passed to all downstream phases. It governs:

- **Phase 1 (Theme Extraction):** Themes should include literature needed to contextualize what each figure shows. If Figure 1 is a site map of the camera-trap array across a canopy gradient, there should be a theme on small-mammal microhabitat selection in the focal system.
- **Phase 2 (Literature Synthesis):** Search themes should cover the methodological and biological context each figure needs. Subagents for Discussion-targeted themes should know which figures they are interpreting.
- **Phase 7 (Manuscript Drafting):**
  - **Methods section** must describe the analytical approach behind each figure (see "Methods requirements" in the Figure Plan)
  - **Results section** is organized around figures: each figure/table typically gets its own paragraph or subsection of text
  - **Discussion** paragraphs should reference specific figures when interpreting results
  - Figure references in text use markdown format: `(Fig. 1)`, `(Table 1)`, `(Fig. S1)`: the `manuscript-builder` skill handles formatting these for the target journal

**If the user adds or removes figures later**, update the Figure Plan and flag any downstream sections that need revision (if a figure is removed, its Results paragraph and Discussion interpretation may need rewriting).

---

### How Journal Profile and Paper Plan Flow Downstream

The Journal Profile and Paper Plan are attached to the reference document header and passed to the drafting phase in every prompt. They govern:

- **Citation formatting**: in-text style and reference list format applied automatically throughout
- **Section word targets**: drafting aims for approximate length per journal norms
- **Audience calibration**: level of background explanation, terminology assumptions
- **Implication framing**: how boldly to state translational or applied significance
- **Abstract structure**: structured vs. unstructured, word limit enforced

If journal changes after drafting has begun, flag all sections as `[JOURNAL CHANGE: reformatting required]` and regenerate the Journal Profile before continuing.

---

## Phase 1: Theme Extraction

With the Journal Profile and Paper Plan confirmed from Phase 0, identify the specific literature questions the paper needs to address.

Ask the user (or infer from provided results/context) for:

- **The core finding**: one sentence: what did the analysis show?
- **System / method**: what is the empirical focus?
- **Intended sections needing support**: typically: Introduction (background + knowledge gap), Methods (precedent for approach), Discussion (comparators, implications, broader context)

### Contribution calibration (mandatory sub-step before thread extraction)

Before defining threads, produce a short calibration of the paper's contribution against the existing literature. This is not pitch generation: it is the brake on overclaiming that creeps in when Introductions get drafted after the analysis is finished. The goal is an honest, narrow accounting of what is established, what is contested, and what this specific analysis legitimately adds.

Run one quick scoping search on the core finding's topic and return:

- **Known**: what is well-established in this area (1 to 3 sentences). Use foundational + recent primary sources to characterize the consensus.
- **Contested**: what is actively debated, where studies disagree, or where the evidence is mixed (1 to 3 sentences). If nothing is clearly contested, say so.
- **New**: what this analysis adds that is not already in the published record, framed at the smallest, most accurate scale of generality (1 to 2 sentences). Avoid superlative framing ("novel," "first to show"); state the increment honestly.

Present these three answers to the user and confirm before defining threads. The **New** statement is the load-bearing claim the manuscript will eventually make: it has to be defensible against the **Known** and **Contested** record. If **New** is hard to defend honestly at the current scale of generality, the right move is to narrow the claim now (e.g., "in mouse peri-implantation epiblast" rather than "in mammalian early development") rather than to soften the language later in revision.

Threads (below) should then be tied to: supporting the **New** framing, contextualizing the **Known** background, or engaging with the **Contested** debate.

---

Use the Paper Plan's section goals and key moves to generate **4 to 8 narrative threads**: each thread is a discrete literature question tied to a specific section need. These become the search units for Phase 2.

**Example thread extraction:**

> Core finding: "Small-mammal community occupancy tracks canopy-cover heterogeneity in a temperate-forest study system"
>
> -> Thread 1: Canopy-cover structure and microhabitat selection in temperate small mammals
> -> Thread 2: Multi-species occupancy modelling for forest small-mammal communities
> -> Thread 3: Camera-trap detection probability for small mammals (a known weak point)
> -> Thread 4: Vegetation-transect-based covariates and how they couple to small-mammal selection
> -> Thread 5: Co-occurrence and joint species distribution modelling
> -> Thread 6: Applied implications for forest-management practices

Present the threads to the user and confirm/adjust before proceeding. Threads that are too broad (e.g., "gene regulation") should be narrowed; threads with clear precedent in the user's own prior work can be deprioritized.

---

## Phase 2: Literature Synthesis (Subagent Architecture)

Phase 2 uses **parallel subagents**: one per theme from Phase 1, to achieve deep, independent literature searches. Each subagent runs in isolation with its own context, allowing it to pursue citation trails, run many queries, and go deeper than a single sequential pass could achieve.

### Why subagents

A single-pass search across 4 to 8 themes fills the context window quickly, forcing shallow coverage per theme. By giving each theme its own agent, we get:
- **More queries per theme** (6 to 10 instead of 2 to 3)
- **Citation trail following**: agents can chase references from key papers
- **Better citation density**: each agent aims for 8 to 15 claims per theme, not 3 to 5
- **Independent depth**: some themes need deeper coverage than others

### Launching subagents

After Phase 1 themes are confirmed, launch one sub-agent per theme. All theme agents can run **in parallel** since they are independent.

**Subagent prompt template:**

```
You are a research literature specialist conducting a deep search on ONE theme for an academic manuscript.

## Your Theme
Thread name: [Thread N name]
Thread description: [1 to 2 sentence description of what this thread needs to cover]

## Paper Context
- Core finding: [one-sentence core finding from Phase 1]
- Target journal: [journal name]
- Journal scope: [broad-scope / system-specific / methods-focused / applied]
- Intended placement: [Intro background / Intro gap / Methods precedent / Discussion comparator / Discussion implication]

## Search Instructions

Run a MINIMUM of 6 searches for this theme, using progressively refined queries:

1. **Broad anchor search**: establishes the landscape
   Example: `[topic] review`
2. **Focused empirical search**: targets specific mechanisms or methods
   Example: `[topic] [system] [method] empirical`
3. **Recency search**: catches recent publications (last 3 years)
   Example: `[topic] [system] 2023 2024 2025`
4. **Adjacent-system search**: finds parallel work in related systems
   Example: `[broader system] [topic]`
5. **Methodological search**: finds papers using similar approaches
   Example: `[method] [application] [data type]`
6. **Foundational/seminal search**: identifies the classic papers reviewers expect to see
   Example: `[topic] review foundational` OR chase references from papers found above
7. **Complicating / disconfirming search (mandatory)**: actively seeks evidence that contradicts, qualifies, or fails to replicate the working claim. This is not optional and is not satisfied by "I did not find any." Examples:
   - `[claim] inconsistent` / `[claim] limitations` / `[claim] reanalysis`
   - `[opposite of claim] evidence` / `[claim] failure to replicate`
   - Search the recent record for critical commentary, methodological critiques, or systems where the pattern does not hold

Additional searches (8 to 10) should follow citation trails: when a found paper's title or abstract references another relevant study, search for that study specifically.

## Citation Targets

- **Minimum 8 claims** for this theme. Aim for 12 to 15 if the literature supports it.
- Each claim must include: Author(s), Year, a URL or DOI if findable, and the specific claim attributed to it.
- Prefer primary empirical papers over reviews for specific claims.
- If only a review is found, note it as a review and flag for tracing to primary sources.
- If a claim appears in multiple independent sources, note convergence.
- If search returns only tangentially relevant results, note the gap explicitly.
- For broad context themes (Intro background): prioritize breadth, many papers establishing the field.
- For knowledge gap themes: prioritize precision, the exact boundary of current knowledge.
- For discussion comparator themes: prioritize methodological match to the focal study.
- **Return at least 2 primary sources that complicate or contradict the working claim for this theme**, even if the overall synthesis lands on "supported." If no complicating evidence is found after the deliberate search in step 7, state that explicitly and describe what was searched. Confirmation-only output is a search failure, not a clean result. See `conventions/research.md` Rule M9.

## Output Format

Return your findings in EXACTLY this format:

```
## Thread: [Thread Name]

**Searches run:** [N]
**Papers found:** [N]

**Summary:** [3 to 5 sentence synthesis of what the literature says on this theme]

**Key claims:**
1. [Specific factual claim]: Author et al. (Year): [URL or DOI]: [primary empirical / review / meta-analysis / grey literature]
2. [Specific factual claim]: Author and Author (Year): [URL or DOI]: [type]
...

**Citation trails followed:** [List any papers found by chasing references from other papers]

**Complicating evidence:** [At least 2 primary sources that complicate, qualify, or contradict the working claim for this theme. One-line note per source on how it complicates the claim. If none found after deliberate search, state that explicitly and describe what was searched (terms used, databases queried).]

**Knowledge gaps / contested areas:** [Anything the literature treats as unresolved or actively debated]

**Suggested paper placement:** [Intro background / Intro gap / Methods precedent / Discussion comparator / Discussion implication]

**Coverage assessment:** [Well-covered / Adequate / Sparse, with note on why if sparse]
```
```

### Merging subagent results

Once all theme agents return, merge their outputs into a unified working document:

1. **Collect** all thread blocks into a single document
2. **Check for duplicates**: the same paper may appear in multiple threads. Keep the citation in each thread where it is relevant, but note cross-thread papers.
3. **Assess total citation count**: across all threads, the merged result should contain **30 to 60 unique papers** for a standard empirical manuscript. If total is below 25, flag themes with sparse coverage for a second-pass deepening search.
4. **Identify coverage gaps**: look for sections (from the Paper Plan) that have fewer than 5 supporting claims. These sections will be undercited in the manuscript.
5. **Flag high-value citation trails**: if multiple agents independently found the same paper, it is likely a foundational reference that should be cited.

### Second-pass deepening (if needed)

If the merge reveals sparse coverage on specific themes (fewer than 5 claims, or a "Sparse" coverage assessment from the subagent), launch a follow-up agent for just those themes with an expanded prompt:

```
Your previous search on "[Theme]" returned only [N] claims. Run 4 to 6 additional searches focusing on:
- Adjacent systems that may have relevant findings
- Older foundational literature (pre-2015) that may have been missed
- Grey literature (technical reports, preprint servers) if peer-reviewed sources are limited
- Conference proceedings or preprints if the topic is very recent

Target: at least 5 additional claims to supplement the [N] already found.
```

### Per-thread output format

Each thread's final output follows this structure (same as the subagent prompt template above):

```
## Thread: [Thread Name]

**Summary:** [3 to 5 sentence synthesis of what the literature says]

**Key claims:**
- [Claim 1]: [Author, Year]: Source: [URL or DOI if available]: [primary / review / grey]
- [Claim 2]: [Author, Year]: Source: [URL or DOI if available]: [primary / review / grey]
- ...

**Complicating evidence:** [>=2 sources complicating/contradicting the claim, or explicit statement that none found after deliberate search]

**Knowledge gaps / contested areas:** [anything the literature treats as unresolved]

**Suggested paper placement:** [Intro background / Intro gap / Methods precedent / Discussion comparator / Discussion implication]

**Coverage assessment:** [Well-covered / Adequate / Sparse]
```

### Search quality standards

- Prefer primary empirical papers over review articles for specific claims
- If only a review is found, note this and flag for the user to trace to primary sources
- If a claim appears in multiple independent sources, note convergence: this increases confidence
- If search returns only tangentially relevant results, note the gap explicitly rather than substituting a loosely related claim
- **Minimum total unique citations across all threads: 30** for a standard empirical paper. Below this threshold, run second-pass deepening.
- Each Introduction-targeted thread should yield at least 8 claims (to support the citation density rules in Phase 7)
- Each Discussion-targeted thread should yield at least 6 claims

---

## Phase 3: Citation Validation

This is the most critical quality gate in the workflow. Every citation identified in Phase 2 must pass all three checks below before it enters the reference document. A citation that fails any check is either corrected, replaced, or dropped: never passed through unresolved.

The three failure modes this phase guards against:
- **Hallucinated papers**: plausible-sounding citations that do not exist
- **Metadata errors**: real papers with wrong authors, year, journal, or title
- **Claim-abstract mismatch**: real papers that do not actually support the attributed claim

---

### Check 1: Existence Verification

For every cited paper, confirm it exists using at least one of these API lookups. Use `web_fetch` for each call.

**Crossref API (preferred, works for all disciplines):**
```
https://api.crossref.org/works?query.title=[TITLE]&query.author=[FIRST_AUTHOR_SURNAME]&rows=3
```
Or if a DOI is available:
```
https://api.crossref.org/works/[DOI]
```

**PubMed API (for biomedical / life sciences literature):**
```
https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=[TITLE]+[AUTHOR]&retmode=json
```
Then fetch the abstract:
```
https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=[PMID]&rettype=abstract&retmode=text
```

**Semantic Scholar (good fallback):**
```
https://api.semanticscholar.org/graph/v1/paper/search?query=[TITLE]&fields=title,authors,year,journal,abstract
```

**Existence check outcome:**

| Result | Action |
|--------|--------|
| Paper found, metadata matches | PASS, proceed to Check 2 |
| Paper found, metadata partially mismatches | WARN, correct metadata, note discrepancy |
| No paper found on first API | Try second API before failing |
| No paper found on two APIs | FAIL, mark as `[EXISTENCE UNVERIFIED]`, do not include without user confirmation |

A paper that cannot be found on any API is treated as potentially hallucinated and must be flagged explicitly. Never assume it exists because the title sounds plausible.

---

### Check 2: Metadata Accuracy

Once a paper is confirmed to exist, validate every metadata field against the API response.

Fields to validate:

| Field | Validation standard | Common error type |
|-------|-------------------|-------------------|
| **First author surname** | Must match exactly | Wrong author attributed to a finding |
| **Year** | Must match publication year | Off-by-one or decade errors |
| **Journal name** | Must match (abbreviations acceptable) | Wrong journal |
| **Title** | Should closely match (minor wording differences OK) | Confabulated titles |
| **DOI** | Verify it resolves correctly via `https://doi.org/[DOI]` | Transposed digits, wrong DOI |
| **Volume/Issue/Pages** | Verify if available, required for final citation | Often missing or wrong from search snippets |

**Metadata correction protocol:**
- If a field is wrong but the paper is confirmed correct: silently correct it and note in validation log
- If author or year is wrong: flag prominently, may indicate a different paper was confused with the intended one
- If DOI resolves to a different paper entirely: treat as FAIL

---

### Check 2b: Confirmed Hyperlink

Every citation must exit validation with a confirmed, live hyperlink. This is mandatory: no citation enters the reference document or manuscript without one.

**Link resolution priority:**

1. **DOI link** (preferred): construct as `https://doi.org/[DOI]` and confirm it resolves to the correct paper via `web_fetch`. This is the most stable, permanent link and should always be used when a DOI exists.

2. **PubMed link**: if no DOI but PMID confirmed: `https://pubmed.ncbi.nlm.nih.gov/[PMID]/`

3. **Journal page URL**: if DOI unavailable, use the direct URL from the journal website retrieved during abstract fetching. Confirm it resolves and points to the correct paper.

4. **Semantic Scholar URL**: fallback: `https://www.semanticscholar.org/paper/[paperID]` from API response. Less stable than DOI but acceptable if nothing else is available.

**Link confirmation check:**
- Fetch the resolved URL and confirm the page title / authors match the cited paper
- If the DOI redirects to a paywall landing page, that is acceptable: the DOI is still valid
- If the DOI returns a 404 or resolves to a different paper: attempt the PubMed or journal URL fallback before failing
- If no working link can be confirmed from any source: mark citation as `[LINK UNAVAILABLE]` and flag for manual lookup

**In the reference document**, every citation is formatted as:
```
Smith et al. (2019): [Journal of Animal Ecology](https://doi.org/10.xxxx/xxxxx)
```

**In the markdown manuscript**, every citation in the reference list and every in-text citation callout includes a clickable hyperlink. In-text, add the hyperlink to the year: `Smith et al. ([2019](https://doi.org/10.xxxx/xxxxx))`. The `manuscript-builder` skill will convert these to proper hyperlink fields in the final .docx.

---

### Check 3: Abstract-Claim Alignment

Fetch the abstract of every confirmed paper and verify that the attributed claim is actually supported by what the abstract says.

**Fetch the abstract via:**
- PubMed efetch (if PMID available, best for life sciences)
- DOI resolver + `web_fetch` on journal page
- Semantic Scholar abstract field from API response
- Direct `web_fetch` of DOI landing page as fallback

**Alignment levels:**

| Level | Definition | Action |
|-------|-----------|--------|
| **Strong** | Abstract directly states or demonstrates the claim | Include as-is |
| **Partial** | Abstract is consistent with claim but does not directly state it | Soften claim language; note "consistent with" |
| **Inferential** | Claim requires inference beyond what the abstract states | Flag: "Claim extends beyond abstract: verify full paper" |
| **Mismatch** | Abstract does not support the claim, or contradicts it | Drop claim entirely; search for better-matched paper |
| **Unavailable** | Cannot retrieve abstract | Mark as `[ABSTRACT UNVERIFIED]`; include only if source URL is confirmed |

**Common mismatch patterns to actively look for:**
- Claim uses stronger causal language than the abstract supports (e.g., abstract says "associated with", claim says "causes")
- Claim applies a finding to a different species, system, or context than the study examined
- Claim cites a review as primary evidence
- Claim attributes a finding to the wrong paper in a series by the same author group

---

### Validation Log

Every paper gets an entry in a running validation log:

```
### Citation Validation Log

| Paper | Existence | Metadata | Abstract Alignment | Link | Status |
|-------|-----------|----------|-------------------|------|--------|
| Smith et al. (2019) J Anim Ecol | Crossref | Confirmed | Strong | [DOI](https://doi.org/10.xxxx/xxxxx) | PASS |
| Jones & Lee (2021) Ecography | PubMed | Year corrected: 2022 | Partial | [DOI](https://doi.org/10.xxxx/xxxxx) | PASS (softened) |
| Brown et al. (2018) Ecology | Not found on Crossref or PubMed | : | : | : | FAIL, DROPPED |
| Wilson (2020) Methods Ecol Evol | Semantic Scholar | Confirmed | Inferential | [DOI](https://doi.org/10.xxxx/xxxxx) | FLAGGED, verify full text |
| Davies (2017) Funct Ecol | Crossref | Confirmed | Strong | [LINK UNAVAILABLE] | PASS, manual link needed |
```

Present the validation log alongside the reference document so the user has full transparency into which citations are robustly verified and which require additional scrutiny.

---

### Validation Failure Handling

1. **Can the claim be re-sourced?** Run a new targeted search for the same claim. If a validated replacement is found, substitute it.
2. **Is the claim load-bearing and irreplaceable?** Include as `[SOURCE NEEDED: claim unverified]` so the user knows to find it manually.
3. **Is the claim peripheral/contextual?** Drop silently.

Never pass a failed citation to the user as a usable reference.

---

## Phase 4: Contradiction Audit

For every claim tagged as **load-bearing** (see Phase 5), run at least one active contradiction search before finalizing.

### Contradiction search pattern

For each load-bearing claim, run:

1. **Challenge search**: explicitly looking for contradicting evidence:
   `[topic] contradicts challenges evidence against [specific claim]`

2. **Update search**: looking for more recent work that supersedes the cited study:
   `[topic] [year range: 3 years after original paper to present]`

3. **Limitation search**: looking for known methodological critiques:
   `[method or approach] limitations criticism reliability`

### Documenting contradictions

If contradiction or update evidence is found, add to the relevant thread block:

```
**Contradiction flag:** [Brief description of contradicting finding]: [Author, Year]
**Implication:** [Does this invalidate the claim, nuance it, or reflect a different context?]
**Recommended action:** [Cite both / Revise claim / Drop claim / Note as contested]
```

If no contradiction is found after active searching, mark the claim:
`Contradiction search: no contradicting evidence found [date of search]`

---

## Phase 5: Centrality Tagging

Before assembling the reference document, tag every claim in every thread as one of:

| Tag | Meaning | Verification standard |
|-----|---------|----------------------|
| **LOAD-BEARING** | Claim directly underpins the paper's argument or interpretation | Contradiction audit required; user should verify against original abstract |
| **SUPPORTING** | Claim adds important context but paper does not stand or fall on it | Contradiction audit recommended |
| **CONTEXTUAL** | Background texture; widely accepted general knowledge | No additional verification required |

### Tagging heuristics

- If removing the claim would require rewriting a key sentence in the intro or discussion: LOAD-BEARING
- If the claim establishes the knowledge gap that motivates the paper: LOAD-BEARING
- If the claim supports the interpretation of results but alternatives exist: SUPPORTING
- If the claim is general background a reviewer would expect to see but would not dispute: CONTEXTUAL

Present the tag distribution to the user. A typical empirical paper reference doc should have:
- 3 to 8 LOAD-BEARING claims
- 8 to 20 SUPPORTING claims
- As many CONTEXTUAL as needed

If there are more than ~12 LOAD-BEARING claims, the paper may be trying to argue too many things: flag this to the user.

---

## Phase 6: Reference Document Assembly

Compile all threads into a single structured reference document. Organize by **paper section** rather than by thread: the user will be working section-by-section in downstream drafting.

### Output format

```markdown
# Research Reference Document
**Paper:** [Working title or description]
**Generated:** [Date]
**Threads covered:** [N]
**Total claims:** [N] ([N] load-bearing, [N] supporting, [N] contextual)
**Citation validation:** [N] passed / [N] corrected / [N] flagged / [N] dropped

---

## For Use in: INTRODUCTION

### Background & Context
Each claim must include a confirmed hyperlink (DOI preferred):
- [Claim]: Author et al. ([Year](https://doi.org/10.xxxx/xxxxx)): CONTEXTUAL
- [Claim]: Author and Author ([Year](https://doi.org/10.xxxx/xxxxx)): SUPPORTING

### Knowledge Gap
- [Claim]: Author et al. ([Year](https://doi.org/10.xxxx/xxxxx)): LOAD-BEARING

---

## For Use in: METHODS

### Methodological Precedent
- [Claim]: Author et al. ([Year](https://doi.org/10.xxxx/xxxxx)): SUPPORTING

---

## For Use in: DISCUSSION

### Comparator Studies
- [Claim]: Author et al. ([Year](https://doi.org/10.xxxx/xxxxx)): LOAD-BEARING

### Broader Implications
- [Claim]: Author et al. ([Year](https://doi.org/10.xxxx/xxxxx)): SUPPORTING

### Caveats & Limitations Context
[Any contradiction-flagged claims; contested areas in the literature]

---

## Unplaced Claims
[Claims that emerged from search but do not fit a clear section: leave for user to place or discard]

---

## Sources Needing Manual Verification
[Any claims marked [SOURCE NEEDED] or [ABSTRACT UNVERIFIED]: user must resolve before submission]

---

## Citation Validation Log
[Full validation table from Phase 3: all papers, all checks, all outcomes]

---

## Search Coverage Notes
[Any threads where search returned limited results, gaps in coverage, grey literature flags]
```

---

## Phase 7: Markdown Manuscript Drafting

This phase governs how the reference document is handed to the drafting layer for manuscript construction. Citation reliability tiers control sentence-level writing decisions. The output is a **markdown manuscript** (.md) with YAML frontmatter, not a Word document. The manuscript stays in markdown throughout all creative and revision phases. Conversion to .docx happens only at the end, via the `manuscript-builder` skill.

> **Writing style:** Before drafting any section, read `conventions/manuscript-format.template.md` and `conventions/voice.template.md` and apply those conventions throughout all drafting prompts and drafted text. All style, tone, voice, and structural preferences defined there take precedence over generic drafting defaults. Include the instruction `Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md` in every drafting prompt template below.

> **Manuscript format:** The output .md file must follow the structure defined in `conventions/manuscript-format.template.md`. This includes YAML frontmatter with journal profile metadata, standard section organization, and citation handling conventions.

---

### Citation Reliability Tiers

Every citation in the reference document carries a tier assigned from Phase 3 validation outcomes. These tiers directly control how the drafting layer uses each source when drafting.

| Tier | Label | Phase 3 origin | What it means |
|------|-------|---------------|---------------|
| **T1** | Verified | Existence + Metadata + Abstract Strong | Fully validated. Cite freely. |
| **T2** | Softened | Abstract alignment: Partial | Real paper, but claim is consistent with rather than directly stated by the abstract. Language must be hedged. |
| **T3** | Inferential | Abstract alignment: Inferential | Real paper, but full text needed to confirm claim. Treat as provisional until verified. |
| **T4** | Contradiction-flagged | Passed validation but contradicted in Phase 4 | Real paper with contested finding. Must be framed as contested; cannot be used as sole support. |
| **T5** | Unverified | Existence or metadata failed | Could not be confirmed. Placeholder only, must not appear as a real citation in the manuscript. |

---

### Drafting Rules Per Tier

The drafting layer must follow these rules when constructing sentences that cite sources. These are not stylistic preferences: they are reliability constraints.

**T1, Verified:**
- Use directly and cite normally
- Can be used as sole support for a claim
- No special markup needed
- Example sentence form: *"Small-mammal occupancy across the canopy-cover gradient tracks understorey structural complexity (Smith et al. 2019)."*

**T2, Softened:**
- Use hedged language: "consistent with", "suggests", "is broadly supported by"
- Can be cited but claim must not overstate what the abstract shows
- Mark with an HTML comment after the citation: `<!-- T2: language hedged; abstract partially supports this claim -->`
- Example sentence form: *"Evidence suggests that small-mammal microhabitat selection is influenced by short-term temperature variability (Jones and Lee 2022). <!-- T2: hedged; abstract partially supports --> Though direct mechanistic evidence remains limited."*

**T3, Inferential:**
- Use with explicit acknowledgement of inference: "may", "likely", "preliminary evidence indicates"
- Must not be used as sole support for a load-bearing claim
- Mark with an HTML comment: `<!-- T3: inferential; verify full text before submission -->`
- Should be paired with a T1 or T2 source wherever possible
- Example sentence form: *"Understorey structure may act as a buffer for small-mammal activity under fluctuating canopy-light conditions (Wilson 2020). <!-- T3: inferential; verify full text -->"*

**T4, Contradiction-flagged:**
- Must be framed as contested in the text, never as settled fact
- Both the original finding and the contradicting study should be cited together
- Mark with an HTML comment: `<!-- T4: contested finding; contradicted by [Author Year]; frame as debate -->`
- Example sentence form: *"While early studies reported X (Author A 2018), subsequent work has questioned this interpretation under different vegetation contexts (Author B 2021). <!-- T4: contested -->"*

**T5, Unverified:**
- Must NOT be written into the manuscript as a real citation
- Insert as a bracketed placeholder only: `[CITE: claim about X, source unverified, manual lookup needed]`
- Draft the surrounding prose but leave the citation slot empty

---

### Priority Hierarchy When Multiple Sources Support a Claim

When the reference document contains multiple citations for the same claim, prioritize them in this order:

1. **T1 primary empirical study**: always preferred over reviews, regardless of journal tier
2. **T1 review or meta-analysis**: use when synthesizing a well-established field; note it is a review
3. **T2 primary empirical study**: acceptable with hedged language
4. **T1 paper from adjacent system/species**: acceptable with explicit domain-transfer caveat
5. **T2/T3 review**: last resort; flag prominently

When multiple T1 sources exist for the same claim, prefer:
- More recent over older (unless older is the foundational/seminal paper, in which case cite both)
- Higher methodological match to the focal paper's system
- Multiple independent sources over a single source: cite 2 to 3 where they exist for load-bearing claims

---

### Markdown Manuscript Markup Conventions

The output manuscript uses HTML comments to preserve citation tier information without affecting the rendered text. This markup is invisible in rendered markdown but preserved for downstream processing by `expert-review` and `manuscript-builder`.

| Markup | Meaning | Author action required |
|--------|---------|----------------------|
| No markup | T1 citation, clean claim | None, ready for submission review |
| `<!-- T2: ... -->` | Softened claim | Read comment; confirm hedged language is appropriate |
| `<!-- T3: ... -->` | Inferential claim | Obtain full text and verify before submission |
| `<!-- T4: ... -->` | Contested finding | Must resolve before submission |
| `[CITE: ...]` placeholder | No verified source | Manual lookup required; do not submit with placeholder |
| `[SOURCE NEEDED]` | Claim with no source found | Either find a source or remove the claim |

**Before submission, the manuscript should have:**
- Zero `<!-- T4: ... -->` markers remaining unresolved
- Zero `[CITE:]` and `[SOURCE NEEDED]` placeholders
- `<!-- T3: ... -->` markers either resolved (full text verified) or explicitly accepted by the author
- `<!-- T2: ... -->` markers reviewed and hedged language confirmed appropriate

---

### Introduction Structure: The Funnel Principle

The introduction must follow a **broad-to-specific funnel** structure. This is critical: do NOT begin the introduction with system-specific or method-specific information. The opening paragraphs must establish the broader scientific context before narrowing to the focal system or question.

**Standard funnel structure (3 to 5 paragraphs):**

1. **Broad topical context** (1 to 2 paragraphs): Establish the overarching theme at the field level. For example, if the paper is about small-mammal occupancy across a canopy-cover gradient, start with the broader question of how habitat structural heterogeneity shapes community composition, NOT with the focal species or method. This paragraph should be relevant to the journal's readership broadly.

2. **Narrowing to the focal system/method** (1 paragraph): Transition from the broad theme to the specific study system or question. Introduce the focal system in the context of the broader themes established above.

3. **Knowledge gap** (1 paragraph): What remains unknown? This is the most load-bearing paragraph: every claim must be T1 or T2 at minimum.

4. **Gap-to-objectives transition**: Before stating objectives, include a transitional sentence or two linking the knowledge gap to why this work is needed. Do NOT jump straight from reviewing literature to "Our objective was to..."; bridge the gap with a sentence framing why the gap matters practically.

5. **Objectives + value statement** (1 short paragraph or final sentences): State what this study does and how. End with a brief statement on the value or significance of the work: what this will contribute.

**Citation detail in introductions**: When referencing prior work, focus on the finding or conclusion relevant to the argument. Do NOT include granular quantitative details from cited studies (sample sizes, specific date ranges, raw numbers) unless those values are specifically relevant to the point being made. The introduction frames the knowledge landscape: it is not a detailed accounting of prior results.

**Journal-aware flexibility:** The degree of broadness in paragraph 1 depends on the target journal's scope:
- **Broad-scope journals** (e.g., Nature, Ecology Letters, PNAS): Start very broad: the first paragraph should be accessible to ecologists outside the focal subdiscipline. 2 broad paragraphs before narrowing.
- **System-specific journals** (e.g., Journal of Animal Ecology, Journal of Mammalogy): Can narrow faster: 1 broad paragraph establishing the ecological context, then move to the focal system.
- **Methods-focused journals** (e.g., Methods in Ecology and Evolution): Lead with the methodological challenge, not the focal system.
- **Applied/translational journals** (e.g., Journal of Applied Ecology, Conservation Biology): Lead with the applied or management problem before the mechanistic details.

The `journal_profile.scope` field (from Phase 0) should inform which pattern to use. When in doubt, default to the broad-scope pattern: it is always acceptable and never wrong to provide more context.

---

### Citation Density Rules

Manuscripts must meet minimum citation density thresholds to properly situate the work within existing literature. Sparse referencing undermines the paper's scholarly credibility and signals to reviewers that the literature review was superficial.

**Minimum citation targets per section:**

| Section | Minimum citations per paragraph | Notes |
|---------|-------------------------------|-------|
| Introduction, Broad context | 3 to 5 per paragraph | Multiple citations per claim expected; cluster related refs |
| Introduction, Narrowing | 3 to 4 per paragraph | Key empirical studies in the focal system |
| Introduction, Knowledge gap | 2 to 3 per paragraph | Quality over quantity, but gap claims need support |
| Discussion, Comparators | 3 to 5 per paragraph | Every comparison to literature needs a citation |
| Discussion, Implications | 2 to 3 per paragraph | Speculative sections can be lighter |
| Discussion, Caveats/Limitations | 1 to 2 per paragraph | Methodological citations where relevant |

**Density rules:**
- **No uncited factual claims.** Every factual statement (not the author's own results) should have at least one citation. If a claim is well-established, cite a review or foundational paper.
- **Cluster citations for established facts.** When multiple studies support the same well-known claim, cite 2 to 3 together: `(Smith 2018; Jones et al. 2019; Lee and Park 2021)`. This demonstrates breadth of literature awareness.
- **Load-bearing claims need 2+ citations.** Any claim that is central to the paper's argument should be supported by at least two independent sources where available.
- **One-citation paragraphs are a red flag.** If a paragraph in the Introduction or Discussion has only one citation, either the paragraph is too thin or citations are missing. The only exception is a paragraph reporting only the author's own results.
- **Reference list size guideline.** As a rough benchmark, aim for 30 to 60 references for a standard empirical paper. Fewer than 20 for a full-length paper is almost certainly too sparse. Adjust based on journal norms (check `journal_profile.typical_reference_count` if available).

These minimums are targets, not hard caps. More citations are always better than fewer, provided they are relevant and properly tiered.

---

### Drafting Prompt Templates

Use these prompt patterns when handing off to the drafting layer for each manuscript section. The reference document section and citation tiers must be included in context.

**Introduction, Broad context paragraphs:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Using the Background & Context claims from the reference document below, draft 1 to 2 opening paragraphs that establish the BROAD biological/scientific context for a [journal] manuscript.

CRITICAL STRUCTURE RULE: Do NOT start with the focal system or method. Begin at the field level: the overarching biological theme. The first paragraph should be accessible and relevant to the journal's broad readership.

Journal scope: [broad / system-specific / methods-focused / applied, from journal_profile]
- If broad-scope journal: Start very broadly (e.g., how cells make fate decisions, how non-coding sequence encodes regulatory logic). The focal system should NOT appear in paragraph 1.
- If system-specific journal: Start with the biological context for the system group, then narrow.
- If applied journal: Start with the translational problem.

Citation density: Aim for 3 to 5 citations per paragraph. Cluster related references. No uncited factual claims.

Output format: markdown with standard paragraph structure.

Tier rules:
- T1 citations: use directly
- T2 citations: hedge language, add <!-- T2: ... --> comment
- T3 citations: use "may" / "suggests", pair with stronger source, add <!-- T3: ... --> comment
- T4 citations: frame as debate, add <!-- T4: ... --> comment
- T5 citations: insert [CITE: placeholder] only

[Paste Background & Context section of reference doc]
```

**Introduction, Narrowing to focal system:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Draft 1 paragraph that transitions from the broad context (already written above) to the specific study system or question. Introduce the focal system in the context of the broader themes. This is the bridge between "the field" and "this study."

Citation density: 3 to 4 citations. Include key empirical studies in the focal system.

Tier rules: [same as above]

[Paste relevant narrowing claims from reference doc]
[Paste the broad context paragraphs already drafted, for continuity]
```

**Introduction, Knowledge gap paragraph:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Using the Knowledge Gap claims from the reference document below, draft the paragraph establishing what is unknown and motivating this study. This is the most load-bearing paragraph in the introduction: every claim must be T1 or T2 at minimum. Flag any T3+ claims prominently.

Citation density: 2 to 3 citations minimum. Gap claims need support: cite studies that established the boundary of current knowledge.

Output format: markdown.

[Paste Knowledge Gap section of reference doc]
```

**Results, Figure-anchored paragraphs:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Draft the Results section for a [journal] manuscript. The Results section is organized around the Figure Plan: each figure or table anchors its own paragraph or subsection.

CRITICAL: Results text reports findings WITHOUT interpretation. Save interpretation for the Discussion. Use past tense.

## Figure Plan
[Paste the Figure Plan from Step 0e]

## Instructions
For each figure/table in the Figure Plan, draft a paragraph that:
1. Opens by directing the reader to the figure/table: "Occupancy declined along the canopy-cover gradient (Fig. 1)" or "Model comparison statistics are summarized in Table 2"
2. Reports the key finding shown in that figure/table
3. Provides specific quantitative details (means, ranges, sample sizes, test statistics, p-values) as available
4. References the "Results text" field from the Figure Plan for what to emphasize

Paragraph order should follow the Figure Plan numbering (Figure 1 first, then Figure 2, etc.) unless the user specifies a different narrative order.

Supplementary figures/tables should be referenced parenthetically: "(Fig. S1)" rather than anchoring their own paragraph.

No literature citations in Results: this section reports only the author's own findings.

## User-provided results summary
[Paste user's results/analysis outputs]
```

**Discussion, Comparators:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Using the Comparator Studies from the reference document and the results summary below, draft the discussion section comparing our findings to the existing literature. Where findings agree, state agreement directly. Where findings diverge, frame divergence constructively. Apply tier-appropriate language and HTML comment markers throughout.

IMPORTANT: Reference specific figures when interpreting results. Use the Figure Plan to connect each discussion paragraph to the figure it interprets. For example: "The community-level patterns we observed (Fig. 2) are consistent with..." or "Our species-level occupancy estimates (Table 1) compare favorably to..."

Citation density: 3 to 5 citations per paragraph. Every comparison to existing literature needs a citation. Cluster related refs where appropriate.

## Figure Plan
[Paste Figure Plan: use the "Discussion relevance" field to guide which figures to reference in each paragraph]

Results summary: [paste]
[Paste Comparator Studies section of reference doc]
```

**Discussion, Implications:**
```
Apply writing style from conventions/manuscript-format.template.md and conventions/voice.template.md.

Using the Broader Implications claims from the reference document, draft 1 to 2 paragraphs on the significance of these findings for [translational application / field / mechanistic context]. T2 and T3 sources are acceptable here given the speculative nature of implications sections, but apply appropriate hedging and tier markers.

Where relevant, reference specific figures that illustrate the implications being discussed.

Citation density: 2 to 3 citations per paragraph. Implications sections can be lighter but still need literature support for claims about broader significance.

[Paste Broader Implications section of reference doc]
```

---

### Subagent Section Drafting (Optional)

For manuscripts with extensive reference documents (30+ claims across 6+ threads), consider using **parallel subagents for section drafting**. Each agent drafts one major section independently, then results are merged and harmonized.

**When to use subagent drafting:**
- Reference document has 6+ themes with dense claims
- Multiple sections need heavy literature integration (Introduction + Discussion)
- Time efficiency is a priority

**When NOT to use subagent drafting:**
- Short manuscripts or letters (fewer than 4 themes)
- User wants tight control over voice and flow between sections
- Manuscript is a revision (where continuity with the previous draft matters)

**Subagent drafting architecture:**

Launch up to 3 section-drafting agents in parallel:

1. **Introduction agent**: receives Background & Context + Knowledge Gap claims from reference doc, Journal Profile, Paper Plan Introduction section, manuscript-format and voice conventions, funnel structure rules, citation density rules
2. **Discussion agent**: receives Comparator Studies + Broader Implications + Caveats claims, results summary, Journal Profile, Paper Plan Discussion section, manuscript-format and voice conventions, citation density rules
3. **Methods agent** (if needed): receives Methodological Precedent claims, user-provided methods notes, Journal Profile. **IMPORTANT: Methods must use passive voice and rationale-first paragraph structure. No "We [verb]" constructions.**

**Subagent drafting prompt template:**

```
You are drafting the [SECTION] of an academic manuscript for [journal].

## Writing Style
[Paste contents of conventions/manuscript-format.template.md and conventions/voice.template.md]

## Section Requirements
[Paste relevant section from Paper Plan: goals, key moves, approximate length]

## Journal Context
- Journal: [name]
- Scope classification: [broad-scope / system-specific / etc.]
- Word limit for this section: [approximate, from Paper Plan]

## Citation Tier Rules
[Paste full tier rules from Phase 7]

## Citation Density Rules
[Paste density minimums for this section type]

## Introduction Funnel Structure (Introduction agent only)
[Paste full funnel principle section]

## Reference Document Claims for This Section
[Paste ONLY the relevant section(s) of the reference document]

## Instructions
- Draft the complete [section] in markdown format
- Apply all tier markers as HTML comments
- Follow citation density minimums: flag if you cannot meet them from available claims
- Use the funnel structure (Introduction only)
- **Methods sections:** Use passive voice throughout. Each paragraph opens with rationale ("To quantify X, Y was performed..."). NO "We [verb]" constructions. Vary sentence structure to avoid repetitive openings
- **Introduction:** Include transitional preamble before objectives linking the knowledge gap to why this work is needed. End objectives with a brief value statement. Do NOT include granular quantitative details from cited studies unless specifically relevant to the point
- **Discussion:** Each paragraph organized around a single theme with clear internal flow. Limitations woven into interpretation: NO dedicated limitations paragraph. Ensure good transitions between paragraphs
- **Tables:** Prefer statistical tables (model outputs, coefficients, AIC comparisons) over descriptive summary tables. Simple summary statistics belong in text, not tables
- Output pure markdown with no YAML frontmatter (that will be added during assembly)
```

**After subagent drafting, Harmonization pass:**

Once all section agents return, a single pass must:
1. **Check voice consistency**: ensure tone, tense, and formality are uniform across sections. **Methods must use passive voice; Intro/Results/Discussion use active voice.** Flag any "We [verb]" constructions in Methods
2. **Check sentence variety**: flag repetitive sentence openings, especially consecutive "We [verb]" patterns in Methods or anywhere else
3. **Resolve cross-section references**: Introduction promises should match Discussion delivery
4. **Deduplicate citations**: same claim cited in both Intro and Discussion is fine, but wording should not be copy-pasted
5. **Verify the narrative arc**: Introduction funnel, Methods, Results, Discussion interpretation should tell a coherent story
6. **Check discussion paragraph structure**: each paragraph should be organized around a single clear theme with good internal flow and transitions. Flag weak/unfocused paragraphs
7. **Verify no dedicated limitations section**: limitations must be woven into Discussion interpretation, not concentrated in a single paragraph
8. **Check table types**: flag any descriptive summary tables (basic counts, sample sizes) that should be reported in text instead
9. **Apply YAML frontmatter** and assemble into the final .md manuscript format

If subagent drafting is NOT used, the standard sequential drafting prompts above work as before.

---

### Manuscript Output Format

The final output is a single .md file following the structure defined in `conventions/manuscript-format.template.md`:

```markdown
---
title: "[Title]"
authors:
  - name: "[Author]"
    affiliation: "[Affiliation]"
    email: "[Email]"
    corresponding: true
journal_target: "[Journal]"
journal_profile:
  # ... from Phase 0 ...
paper_plan:
  # ... from Phase 0 ...
figure_plan:
  # ... from Phase 0e ...
workflow_state: "draft"
revision_number: 0
last_modified: "[timestamp]"
---

# Abstract
[Abstract text]

**Keywords:** [keywords]

---

# Introduction
[Introduction paragraphs with citations and tier markers]

---

# Methods
[...]

# Results
[...]

# Discussion
[...]

# Acknowledgements
[...]

# References
[Formatted reference list]

# Tables

## Table 1
**Table 1.** [Complete, standalone caption describing table contents.]

[Markdown pipe-delimited table if data is available from the analysis context, OR placeholder:]

*[Table to be inserted: see analysis report for source data]*

[Repeat for each table in the Figure Plan]

# Figures

## Figure 1
![Figure 1](figures/paper/fig1.png)

**Fig. 1.** [Complete, standalone caption: what the figure shows, relevant statistical details, sample sizes, legend explanations. Follow journal caption style.]

[If the image file does not yet exist, omit the ![image] link and use a placeholder:]

*[Figure to be inserted]*

**Fig. 1.** [Caption text]

[Repeat for each figure in the Figure Plan]

# Supplementary Material

[If supplementary figures/tables were planned in Step 0e, include them here using S1, S2, etc. numbering and the same format. Image paths: figures/appendix/figS[N].png]
```

**Figure & Table section rules:**
- Tables and Figures sections MUST appear after References. This is standard for journal submissions where tables and figures are placed at the end of the manuscript, each starting on its own page.
- Every figure and table referenced in the body text (e.g., `(Fig. 1)`, `(Table 2)`) MUST have a corresponding entry in the Tables or Figures section. Conversely, every entry in these sections must be referenced in the body text.
- Captions are complete, standalone descriptions: a reader should understand the figure/table from the caption alone without reading the body text. Use the Figure Plan's "Shows" field as the basis, expanded with relevant details.
- Image paths follow a consistent convention: `figures/paper/fig[N].png` for main figures, `figures/appendix/figS[N].png` for supplementary. These paths are relative to the manuscript workspace root.
- If the user's analysis report or code output contains tables (model outputs, summary statistics, etc.), extract and render them as markdown pipe-delimited tables in the Tables section.
- Tables come before Figures (matching most journal style guides).

Save the manuscript to the user's workspace as `[descriptive-title]_draft.md`.

### No Word Document Output

Do NOT call the `docx` skill from Phase 7. The manuscript stays in markdown format throughout all creative and revision phases. When the author is ready for journal submission, use the `manuscript-builder` skill to convert the final .md to a properly formatted .docx.

This separation enables natural iterative revision with visible inline markup, clean diffs between revision rounds, and clear separation between content creation (markdown) and formatting (Word).

---

### Pre-Submission Checklist

Before the manuscript leaves for co-author review or journal submission, run through this checklist against the markdown manuscript:

- [ ] All `<!-- T4: ... -->` contested-finding markers resolved or explicitly accepted
- [ ] All `[CITE:]` and `[SOURCE NEEDED]` placeholders replaced or removed
- [ ] All `<!-- T3: ... -->` inferential markers reviewed: full text obtained for load-bearing T3 citations
- [ ] `<!-- T2: ... -->` markers reviewed and hedged language confirmed appropriate
- [ ] T4 contested findings framed as debate in text, not as settled fact
- [ ] No causal language used where only associative language is supported
- [ ] Citation metadata (authors, year, journal) spot-checked against final reference list
- [ ] No citation appears only in the reference list without appearing in the text (or vice versa)
- [ ] Domain-mismatch flags reviewed: cross-system claims explicitly caveated in text
- [ ] Section structure matches journal requirements
- [ ] Word count within journal limits
- [ ] YAML frontmatter complete and accurate
- [ ] All figures referenced in body text (Fig. 1, Fig. 2, etc.) have corresponding entries in the Figures section
- [ ] All tables referenced in body text (Table 1, Table 2, etc.) have corresponding entries in the Tables section
- [ ] No figures or tables appear in the Tables/Figures sections without being referenced in the body text
- [ ] Figure and table captions are complete, standalone descriptions
- [ ] Image file paths in `![Figure N](path)` links point to existing files, or placeholders are clearly marked for figures not yet generated
- [ ] Figure and table numbering is sequential with no gaps
- [ ] Number of main figures and tables is within journal limits (from Journal Profile)
- [ ] Methods sections use passive voice consistently (no "We [verb]" constructions)
- [ ] Methods paragraphs open with rationale statements before describing procedures
- [ ] Introduction includes transitional preamble before objectives and value statement after objectives
- [ ] No dedicated limitations paragraph/section: limitations woven throughout discussion
- [ ] Discussion paragraphs each organized around a single clear theme with logical transitions
- [ ] Tables are analytical (model outputs, statistics), not simple descriptive summaries
- [ ] Font, heading numbering, and paragraph indentation match manuscript-format conventions defaults

---

## Quality Standards

Throughout the workflow, maintain these standards:

- **Never fabricate citations.** If a claim cannot be sourced from search results, mark it as `[SOURCE NEEDED]` rather than inventing a plausible-sounding reference.
- **Phase 3 is mandatory.** No citation enters the reference document without passing existence, metadata, and abstract-alignment checks. This is not a nice-to-have.
- **Distinguish synthesis from quotation.** All claims in the reference document are paraphrased syntheses, not quotes from papers or search results.
- **Use the APIs.** Crossref, PubMed, and Semantic Scholar are free and reliable. Prefer them over inferring metadata from search snippets, which are a primary source of metadata errors.
- **Flag recency.** For rapidly evolving areas, note if the most recent literature found is more than 5 years old.
- **Flag domain mismatch.** If the best available evidence comes from a different system or context than the focal paper, note this explicitly.
- **Be honest about confidence.** If synthesis is based on 1 to 2 papers only, note this. Convergent evidence from multiple independent studies should be highlighted.
- **Causal language discipline.** Never strengthen a claim beyond what the abstract supports. "Associated with" stays "associated with." Do not upgrade to "causes" or "drives" unless the abstract explicitly uses that framing.

---

## Invocation Patterns

This skill should be triggered when the user says things like:

- "Help me write the intro/discussion for my paper on X"
- "I have my analysis results, now I need to put together the manuscript"
- "Can you find the background literature for a paper on [topic]?"
- "I need a reference doc for the drafting layer to work from"
- "What does the literature say about [topic] for my [journal] paper?"
- "Turn these results into a publishable paper"

---

## Notes on Tool Use

- Use `web_search` as the primary search tool throughout. Run multiple targeted queries per thread rather than one broad query.
- Use `web_fetch` to retrieve full text of key papers or abstracts when search snippets are insufficient to confirm a claim.
- Do not ask the user to upload PDFs: the workflow is designed to not require manual document handling.
- If the user has a specific paper they want incorporated, they can paste the abstract or DOI and it can be integrated into the relevant thread.
