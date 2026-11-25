---
name: analysis-planning
description: |
  Researches statistical approaches and published examples to produce a structured analysis plan for scientific data. Use this skill when the user mentions: planning an analysis, choosing a statistical model, designing an analytical approach, deciding between model types, preparing for a new analysis, or wanting to understand which methods to use. Also trigger when users describe a research question and dataset and want help selecting appropriate models. The skill runs parallel sub-agents to research fundamentals, find published examples, and assess detection or measurement bias (if applicable), then synthesizes into a justified plan with diagnostics checklist. Works standalone or as the first step in the analysis-pipeline.
cost: medium
---

# Analysis Planning Skill

A structured approach to planning statistical analyses for scientific data. Parallel sub-agents research fundamentals, published precedents, and bias considerations, then merge into a justified analysis plan with diagnostics checklist and sensitivity design.


## Required references: load before any work

For code structure and figure/table conventions:
- `conventions/code-format.template.md`
- `conventions/figure-format.template.md` (when producing figures or tables)

For any literature research, citations, or source handling:
- `conventions/research.md`

These are non-negotiable. Load them before substantive work.

---
## Overview

This skill orchestrates a six-phase planning process:
1. **Phase 0**: Question clarification: parse scientific + statistical components
2. **Phase 1**: Methods & literature research: parallel sub-agents
3. **Phase 2**: Random effects & hierarchical structure
4. **Phase 3**: Sensitivity analysis design
5. **Phase 4**: Diagnostics & validation plan
6. **Phase 5**: Model comparison & recommendation

The output is a set of markdown documents: a structured analysis plan (with YAML frontmatter), a methods evidence file (literature citations + model examples), and a diagnostics checklist.

---

## Before You Begin

**Read the lab's conventions:**
- `conventions/code-format.template.md`: code conventions, section headers, inline output, project structure
- `conventions/figure-format.template.md`: figure conventions if plots are part of the plan

**Check for any domain-specific extensions** the lab maintains (lab-specific; if present, these inject domain patterns into each phase). If a domain extension applies, read it and integrate its additions into each phase.

---

## Phase 0: Question Clarification

### Objective
Parse the user's research question into scientific and statistical components. Identify the response variable type, sample structure, and potential confounds.

### Process

**Step 1: Extract Key Components**

From the user's description, identify:
- **Research question**: The scientific question in plain language
- **Response variable**: What is being measured? What type? (continuous, count, proportion, binary, time-to-event)
- **Response distribution characteristics**: Zeros? Bounded? Overdispersed? Skewed?
- **Predictor variables**: Fixed effects (continuous and categorical)
- **Sample structure**: Any nesting? Repeated measures? Crossed designs?
- **Sample size**: Approximate n, number of groups/individuals
- **Potential confounds**: Temporal autocorrelation? Spatial non-independence? Measurement or detection probability?
- **Domain**: General or domain-specific (refer to any extension the lab maintains)

**Step 2: Confirm Understanding**

Present the parsed components back to the user. Use AskUserQuestion if there are ambiguities about:
- Response variable type (e.g., is it truly a proportion or a count ratio?)
- Whether zeros are structural or sampling zeros
- Whether the hierarchical structure matters (random effects needed?)
- Whether measurement or detection bias is a concern

### Output
Internal working document: the parsed question components are carried forward to all subsequent phases.

### USER CHECKPOINT
Confirm question framing before proceeding to research.

---

## Phase 1: Methods & Literature Research

### Objective
Research statistical approaches and find published examples using parallel sub-agents. This is the most important phase: it provides the evidence base for the entire analysis plan.

### Why Sub-agents

Three independent research tasks need to happen simultaneously:
- **Fundamentals**: What models are appropriate for this response type?
- **Published examples**: Who has used these models on similar data?
- **Detection/measurement bias**: Is observational bias a concern, and how have others handled it?

Each task benefits from full context dedication and independent search strategies. Running them in parallel also saves time.

### Launching Sub-agents

After Phase 0 confirmation, launch sub-agents using the `Agent` tool with `subagent_type: "general-purpose"`. All three run **in parallel** since they are independent.

The bias agent is **conditional**: only launch it if the data involves observational sampling where measurement or detection probability matters.

---

#### Sub-agent 1: Fundamentals Agent

**Prompt template:**

```
You are a statistical methods researcher preparing a thorough review of analytical approaches for a scientific analysis. Your job is to research the fundamentals of appropriate statistical models for the given response type and data structure.

## Analysis Context
- Research question: [from Phase 0]
- Response variable: [name and description]
- Response type: [from Phase 0, e.g., "proportion with zeros", "overdispersed count"]
- Distribution characteristics: [zeros, bounds, skew, etc.]
- Data structure: [hierarchical? repeated measures? crossed?]
- Sample size: [approximate n, groups]
- Predictor types: [continuous, categorical, interactions expected]

## Your Task

Research and document the following, using web search and PubMed where helpful:

### 1. Distribution Family Options
For the identified response type, list ALL plausible distribution families:
- Family name, link function, and when it's appropriate
- Library syntax (e.g., mgcv `family = tw()`, statsmodels GLM family, etc.)
- Strengths and limitations of each

### 2. Model Structure Options
- GAM vs GAMM vs GLMM trade-offs for this data
- Which appropriate libraries best handle this (e.g., mgcv, brms, glmmTMB in R; statsmodels, pymc, lme4-equivalents in Python)
- Smooth term or basis specifications (s(), te(), ti(), splines, etc.)
- Concurvity or collinearity concerns with the proposed predictors

### 3. Assumptions & Requirements
For each candidate model family:
- What assumptions must hold?
- What sample size is needed for reliable estimation?
- What are common violations and how to detect them?
- What happens if assumptions are violated (consequences for inference)?

### 4. Diagnostics for Each Family
Specify exact diagnostic checks:
- Which functions to call (gam.check, k.check, DHARMa-equivalent, residual analyses)
- What to look for in each diagnostic plot
- Thresholds for concern (e.g., k' / edf ratio, dispersion parameter range)
- Troubleshooting: if a diagnostic fails, what's the next step?

### 5. Recommendation
Based on the response type and data structure, rank the candidate approaches from most to least appropriate. For each, give a 1-sentence justification.

## Output Format
Return your findings as a structured markdown document with clear headers for each section above. Include code examples where relevant. Cite sources (author, year, journal) when referencing methodological papers.
```

---

#### Sub-agent 2: Published Examples Agent

**Prompt template:**

```
You are a literature researcher finding published papers that use statistical models similar to what we're planning. Your job is to find 8 to 15 high-quality papers using similar analytical approaches on similar data types.

## Analysis Context
- Research question: [from Phase 0]
- Response variable type: [e.g., "proportion with zeros", "overdispersed count"]
- Candidate model types: [e.g., "hurdle GAM", "zero-inflated beta", "negative binomial GAMM"]
- Scientific domain: [e.g., small-mammal community ecology, vegetation-climate response, camera-trap detection probability]
- Data structure: [hierarchical, time series, spatial, etc.]

## Your Task

Search PubMed and the web for published papers that:
1. Use the same or very similar model types (e.g., hurdle GAMs on proportion data)
2. Analyze data with similar structure (e.g., repeated measures across cells / individuals / replicates)
3. Are from reputable journals in the relevant field
4. Were published in the last 10 years (prioritize recent papers)

### For Each Paper Found, Extract:

| Field | Details |
|-------|---------|
| **Citation** | Authors (year). Title. Journal. DOI |
| **Model formula** | The actual model specification (as close to code as possible) |
| **Response variable** | What they measured and how |
| **Sample size** | n observations, n groups/individuals |
| **Distribution family** | What family/link they used |
| **Random effects** | How they handled hierarchical structure |
| **Diagnostics reported** | Which checks they ran and reported |
| **Validation approach** | Cross-validation, holdout, AIC comparison, etc. |
| **Key finding** | 1-sentence summary of main result |
| **Relevance** | Why this paper is useful as a precedent for our analysis |

### Search Strategy
- Use PubMed with terms combining the model type + scientific domain
- Search web for methods papers describing the statistical approach
- Look for papers in target journals appropriate to the lab's field
- Check reference lists of key papers for additional examples

### Quality Filter
- Prioritize papers that report full diagnostics
- Prioritize papers where the data structure closely matches ours
- Flag papers where the methods description is unusually clear (useful as a template for our own methods section)

## Output Format
Return a structured document with:
1. Summary table of all papers found (key columns: citation, model type, sample size, diagnostics)
2. Detailed extraction for each paper (using the fields above)
3. Synthesis: what consensus emerges about best practices for this model type?
4. Gaps: anything the published examples DON'T address that we should be careful about?
```

---

#### Sub-agent 3: Detection / Measurement Bias Agent (Conditional)

**Launch condition:** Only if the data involves observational sampling where detection or measurement probability is below 1, or where capture rate varies across the study. Common triggers: camera-trap surveys (per-station detection varies), live-trapping with mark-recapture (capture probability varies), visual point counts, transect surveys with observer effects, eDNA, acoustic surveys.

**Prompt template:**

```
You are a measurement-bias specialist assessing whether and how observational bias should be addressed in this analysis.

## Analysis Context
- Research question: [from Phase 0]
- Data collection method: [e.g., camera-trap array with imperfect detection, live-trapping with mark-recapture, repeat-survey transects with observer effects]
- Response variable: [what is being measured]
- Sample structure: [how data were collected: replicates, transects, repeated visits, etc.]

## Your Task

### 1. Bias Assessment
- Is measurement / detection probability likely to vary across the study? If so, by what factors?
- Could measurement variation confound the biological patterns of interest?
- Is this a known issue in the published literature for this data type?
- What is the expected detection / capture probability range? (cite published estimates if available)

### 2. Modeling Approaches for Bias
For this type of data, what options exist to account for measurement / detection probability?
- Observation-level random effects
- Occupancy or mixture models
- Capture-recapture style approaches
- Minimum detection thresholds (filtering approach)
- Explicit covariates for capture / detection rate
For each, provide: appropriate library, basic syntax, applicability to our data structure

### 3. Published Precedents
Search PubMed and web for papers that:
- Used the same data collection method AND addressed measurement / detection bias
- Report bias estimates for similar systems
For each paper: citation, approach used, key estimates, lessons learned

### 4. Sensitivity Analysis Recommendations
What sensitivity analyses could assess the impact of measurement bias?
- Minimum threshold tests
- Detection/capture probability as a covariate
- Subset analysis comparing high-detection vs low-detection conditions

### 5. Recommendation
Given this specific dataset and question:
- Is formal bias modeling necessary, or is a sensitivity analysis sufficient?
- What's the minimal adequate approach?
- What should be reported in the methods/results to address reviewer concerns?

## Output Format
Structured markdown with clear headers for each section. Include code examples for recommended approaches. Cite sources with full bibliographic details.
```

---

### Merging Sub-agent Results

After all sub-agents complete, merge their outputs:

1. **Coverage assessment**: Did all three agents cover complementary ground? Are there gaps?
2. **Consistency check**: Do the fundamentals agent and published examples agent agree on recommended approaches? Flag any contradictions.
3. **Integration**: Combine the bias assessment with the model recommendations. If bias is a concern, does the primary model recommendation still hold, or does it need modification?
4. **Optional deepening**: If any area has sparse coverage (e.g., only 2-3 published examples found, or the fundamentals agent identified an approach not covered by published examples), launch a follow-up agent to fill the gap.

### Reference Verification (MANDATORY)

**Never skip this step.** Sub-agents may generate inaccurate citations (wrong authors, wrong year, wrong journal, or misattributed claims). Every reference cited in the analysis plan must be verified.

Launch a verification agent (or do inline) that:

1. **For each cited reference**, web search the exact title + authors to confirm:
   - Correct author list and year
   - Correct journal name
   - That the paper actually exists and is accessible
2. **For each claim attributed to a reference**, verify the paper actually supports that claim by checking the abstract or full text
3. **Flag and remove** any reference that cannot be confirmed or does not support the attributed claim
4. **Replace** flagged references with verified alternatives if possible
5. **Mark uncertainty**: if a claim is well-established but a specific reference cannot be confirmed, note "widely established in the literature" rather than citing an unverified source

This step is critical for scientific credibility. An analysis plan with incorrect citations undermines the entire framework.

### Output
- `[name]_methods_evidence.md`: Combined findings from all sub-agents, organized by topic, with all references verified

---

## Phase 2: Random Effects & Structure

### Objective
If the data are hierarchical, research the optimal random effects specification.

### Conditional
Only execute this phase if Phase 0 identified hierarchical structure (repeated measures, nested groups, crossed designs).

### Process

**Option A: Simple RE**: If the structure is straightforward (e.g., individuals as random intercepts), specify directly:
- `s(subject_id, bs = "re")` for random intercepts in mgcv (R)
- `s(subject_id, x, bs = "re")` for random slopes
- `s(x, subject_id, bs = "fs")` for factor-smooth interactions
- Equivalent specifications in lme4, brms, glmmTMB (R) or statsmodels MixedLM, pymc (Python)

**Option B: Complex RE**: If the structure is complex (crossed designs, multiple nesting levels, random smooth interactions), launch an optional sub-agent:

```
You are a mixed-effects modeling specialist. Research the optimal random effects specification for the following data structure:

## Data Structure
- [Describe nesting: e.g., cells within samples, samples within donors, donors within batches]
- [Describe crossing: e.g., samples measured across multiple conditions]
- [Sample sizes at each level: n observations, n samples, n donors]

## Candidate Approaches
Compare these RE implementations for this specific structure:
1. mgcv bs="re" and bs="fs"
2. gamm4::gamm4() with lme4-style random effects
3. brms with explicit RE formulas
4. INLA with spatial/temporal correlation structures
5. Python alternatives (statsmodels MixedLM, pymc) if applicable

For each, provide: exact syntax, computational cost, ability to handle the specified structure, and known limitations.

## Published Examples
Find 3 to 5 papers with similar hierarchical structures that discuss their RE specification choice.
```

### Output
RE specification recommendation integrated into the analysis plan.

---

## Phase 3: Sensitivity Analysis Design

### Objective
Identify ad hoc thresholds and analytical choices that could influence results, and design robustness tests for each.

### Process

**Step 1: Identify Thresholds**

Review the analysis plan for any decision points involving arbitrary cutoffs:
- Data inclusion criteria (minimum sample size per group, date ranges, outlier removal thresholds)
- Model specification choices (basis dimension k, correlation structure, distribution family)
- Derived variable definitions (bin widths, time windows, spatial scales, normalization choices)

**Step 2: Design Robustness Tests**

For each identified threshold:
- Define 2 to 3 alternative values to test
- Specify what changes in the results would constitute "sensitivity" (e.g., sign change, loss of significance, >20% change in effect size)
- Find published precedents for similar sensitivity analyses (reference the published examples from Phase 1)

**Step 3: Domain-Specific Tests**

If a domain extension applies, layer in domain-specific sensitivity tests (e.g., independent-detection threshold for camera traps, covariate-set selection for occupancy models, cover-class breakpoint choice for vegetation transects).

### Output
Sensitivity analysis plan appended to `[name]_analysis_plan.md`

---

## Phase 4: Diagnostics & Validation Plan

### Objective
For each candidate model, specify exactly what diagnostic checks will be run, what outputs are expected, and what to do if diagnostics fail.

### Process

**Step 1: Per-Model Diagnostic Checklist**

For the primary model and each alternative, create a checklist:

```markdown
### Model: [name], [family, e.g., Hurdle GAM (binomial + beta)]

#### Required Diagnostics
- [ ] `gam.check(model)`: residual plots, basis dimension check
  - Expected: no pattern in residuals, k' index > 1.0 for all smooths
  - If fail: increase k, check for missing covariates
- [ ] `k.check(model)`: formal test of basis adequacy
  - Expected: p-value > 0.05 for all smooths
  - If fail: increase k incrementally (k = k + 5), refit, recheck
- [ ] `DHARMa::simulateResiduals(model)`: quantile residual diagnostics
  - Expected: uniform QQ plot, no overdispersion, no zero-inflation
  - If fail: switch family (e.g., Poisson to NB), add zero-inflation component
- [ ] Autocorrelation check: `acf(residuals(model))`
  - Expected: no significant lags beyond lag 0
  - If fail: add AR1 correlation (`bam(..., rho = rho_est)`) or temporal smoother
```

Customize based on the model family (not all diagnostics apply to all models).

**Step 2: Validation Design**

- If n is large enough: k-fold cross-validation or train/test split
- If n is limited: leave-one-group-out cross-validation (e.g., leave one donor out)
- Specify the metric: RMSE, AUC, deviance explained, etc.

**Step 3: Troubleshooting Contingencies**

For each common diagnostic failure, specify the remediation path:
- Overdispersion: switch to NB, add observation-level RE, or use quasi-family
- Zero-inflation: hurdle model, zero-inflated family, or filter + note limitation
- Autocorrelation: AR1 in bam(), or explicit temporal smoother
- Concurvity: check `concurvity(model)`, simplify smooth terms
- Convergence failure: simplify RE structure, increase iterations, try different optimizer

### Output
- `[name]_diagnostics_checklist.md`: Per-model diagnostic expectations and troubleshooting

---

## Phase 5: Model Comparison & Recommendation

### Objective
Synthesize all research into a final recommendation with comparison table.

### Process

**Step 1: Comparison Table**

```markdown
| Criterion | Primary: [model] | Alternative 1: [model] | Alternative 2: [model] |
|-----------|-------------------|------------------------|------------------------|
| Distribution family | | | |
| Random effects support | | | |
| Handles zeros | | | |
| Handles autocorrelation | | | |
| Computational cost | | | |
| Published precedent | | | |
| Reviewer acceptance | | | |
| Diagnostic tools | | | |
| Library syntax | | | |
```

**Step 2: Recommendation Narrative**

Write a brief (2 to 3 paragraph) recommendation explaining:
- Why the primary model is preferred
- Under what circumstances the alternative would be better
- What reviewers might challenge and how to defend the choice
- Key references supporting the approach

**Step 3: Anticipated Reviewer Challenges**

List 3 to 5 likely reviewer criticisms of the chosen approach and prepare brief defenses:
- "Why not use [alternative method]?": Because...
- "How did you account for [bias/confound]?": We addressed this by...
- "Is your sample size adequate for [model complexity]?": Based on [reference], we have sufficient...

### Output
- `[name]_analysis_plan.md`: Complete analysis plan with YAML frontmatter

### USER CHECKPOINT
Present the complete plan for approval before proceeding to code-writing.

---

## YAML Frontmatter Format

The analysis plan should begin with structured metadata:

```yaml
---
analysis_title: "[descriptive title]"
research_question: "[plain language question]"
response_variable: "[variable name and description]"
response_type: "[e.g., proportion_with_zeros, overdispersed_count, binary]"
sample_size: [n]
sample_units: "[e.g., 8000 cells, 12 donors, 4 conditions]"
data_structure: "[e.g., hierarchical (cells nested in donor nested in batch)]"
primary_model: "[e.g., Hurdle GAM (binomial + beta)]"
alternative_models: ["[alt 1]", "[alt 2]"]
random_effects: "[e.g., donor_id as random intercept, batch as random intercept]"
bias_concern: [true/false]
domain_extension: "[lab-specific extension name or none]"
expected_diagnostics: ["gam.check", "k.check", "DHARMa", "acf"]
sensitivity_tests: ["[test 1]", "[test 2]"]
key_references: ["[Author (Year) Journal]", "[Author (Year) Journal]"]
phase: "planning_complete"
last_modified: "[date]"
---
```

---

## File Naming Convention

```
[name]_analysis_plan.md            Analysis plan with YAML frontmatter
[name]_methods_evidence.md         Literature + fundamentals from sub-agents
[name]_diagnostics_checklist.md    Per-model diagnostic expectations
```

Where `[name]` is a short descriptive identifier (e.g., `occupancy_canopy_gam`, `mammal_mark_recapture`).

---

## Key Principles

1. **Evidence-based planning.** Every methodological choice should be justified by fundamentals AND published precedent. The sub-agents provide both.
2. **Diagnostics are planned, not afterthoughts.** The diagnostics checklist is written BEFORE any code runs. Every diagnostic has an expected result and a contingency if it fails.
3. **Sensitivity design is proactive.** Identify arbitrary thresholds now and plan robustness tests before results are known. This prevents post-hoc rationalization.
4. **Domain context matters.** The same statistical model may need different diagnostics or sensitivity tests depending on the scientific domain. Use lab-maintained extensions.
5. **Reviewer anticipation.** The plan explicitly addresses what reviewers will challenge. This saves revision cycles later.
6. **Independence of sub-agents.** Each research sub-agent works independently to avoid confirmation bias. The merge step reconciles differences.
7. **Reference existing conventions.** This skill orchestrates research: it does NOT duplicate the coding conventions in `conventions/code-format.template.md`. It references and builds on them.

---

## Troubleshooting

**Q: The published examples agent found very few papers using this model type.**
A: This is itself informative: the approach may be novel for this application. Launch a deepening agent focused on the methodology itself (not the scientific application) to find methods papers. Note the novelty in the plan as both a strength (contribution) and risk (no precedent).

**Q: The fundamentals agent and published examples agent disagree on the best approach.**
A: Present both perspectives in Phase 5. The disagreement often reveals that the "textbook" approach differs from "what working scientists actually do." This is worth noting for the methods discussion.

**Q: The bias agent identified a serious concern but there's no clean modeling solution.**
A: Add it to the sensitivity analysis plan. A robust sensitivity analysis that shows results are insensitive to bias assumptions is often more convincing than a complex bias-correction model.

**Q: The user's data doesn't fit neatly into any standard response type.**
A: Consider data transformations, alternative parameterizations, or composite approaches (e.g., hurdle models for data that doesn't fit a single family). The fundamentals agent should identify these options.

**Q: Phase 2 (RE structure) is taking too long: too many options.**
A: Default to the simplest RE structure that accounts for the primary source of non-independence. Random intercepts by individual or donor are almost always the starting point. More complex structures can be tested as alternatives.
