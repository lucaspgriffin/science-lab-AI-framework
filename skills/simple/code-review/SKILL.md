---
name: code-review
description: |
  Hybrid code review combining automated diagnostic execution with parallel reviewer sub-agents for scientific analyses. Use this skill when the user mentions: reviewing code, checking diagnostics, code review, validating an analysis, checking model assumptions, reviewing scripts, or wanting feedback on analysis code. Also trigger when users have completed an analysis and want quality assurance before finalizing. The skill first runs automated checks (execute scripts, capture diagnostics), then launches 3 parallel sub-agent reviewers (statistical methods, scientific interpretation, code quality) who provide independent assessments. Findings are synthesized into a priority-ranked report with inline code suggestions. Supports iterative review-revision cycles. Works standalone or as part of the analysis-pipeline.
cost: medium
---

# Code Review Skill (Hybrid)

Automated diagnostic execution followed by parallel reviewer sub-agents. Three-tier priority system (MUST FIX / SHOULD FIX / CONSIDER) with specific code suggestions.


## Required references: load before any work

For code structure and figure/table conventions:
- `conventions/code-format.template.md`
- `conventions/figure-format.template.md` (when producing figures or tables)

For any literature research, citations, or source handling:
- `conventions/research.md`

These are non-negotiable. Load them before substantive work.

---
## Overview

This skill orchestrates a five-phase review process:
1. **Phase 0**: Automated diagnostic run: execute scripts, capture outputs
2. **Phase 1**: Problem triage: flag issues from automated run
3. **Phase 2**: Parallel reviewer sub-agents: 3 independent expert perspectives
4. **Phase 3**: Synthesis & priority ranking: merge and rank all findings
5. **Phase 4**: Inline code suggestions: specific fixes for key issues

The hybrid approach catches objective issues (errors, warnings, diagnostic failures) through automation, then adds interpretive depth through persona-based review.

---

## Before You Begin

**Read the lab's conventions:**
- `conventions/code-format.template.md`: code conventions, section headers, inline output, project structure

**Gather context:**
- The analysis plan (`[name]_analysis_plan.md`) if it exists: to check plan-execution alignment
- The diagnostics checklist (`[name]_diagnostics_checklist.md`) if it exists: to verify all planned checks were run
- All analysis scripts in the project (`R/*.R` or `src/*.py`)
- All output files (figures, tables, model objects)

---

## Phase 0: Automated Diagnostic Run

### Objective
Execute the analysis scripts and capture all console output, warnings, errors, and diagnostic plots. This provides an honest, objective baseline before interpretive review.

### Process

**Step 1: Inventory Scripts**

List all scripts in order:
```
R/01_data_cleaning.R
R/02_exploration.R
R/03_models.R
R/04_predictions_figures.R
R/05_sensitivity.R
```

Verify they follow the expected naming convention from `conventions/code-format.template.md`.

**Step 2: Execute and Capture**

For each script (in order, since later scripts may depend on earlier ones):
- Source the script
- Capture ALL console output (including inline prints, summaries, warnings)
- Capture any error messages with full traceback
- Note which diagnostic plots were generated and saved
- Record execution time (flag if any script takes unusually long)

**Step 3: Diagnostic Output Collection**

Gather all diagnostic outputs:
- `gam.check()` output: basis dimension checks, residual plots
- `k.check()` output: formal edf/k' tests
- `DHARMa` diagnostic plots and test results
- ACF/PACF plots for autocorrelation assessment
- Model summary tables (coefficients, deviance explained, AIC)
- Any custom diagnostic outputs

**Step 4: Automated Flagging**

Flag issues automatically:
- **ERRORS**: Any script that fails to complete: MUST FIX
- **WARNINGS**: R/Python warnings during model fitting (convergence, singularity): flag for review
- **Diagnostic failures**: k.check p-value < 0.05, overdispersion detected, significant autocorrelation: flag for review
- **Missing diagnostics**: Any diagnostic from the checklist that wasn't run: flag as gap
- **Missing inline output**: Sections without summary prints: flag for code quality review

### Output
- `[name]_review_automated.md`: Complete capture of all console output, errors, warnings, and diagnostic results with automated flags

---

## Phase 1: Problem Triage

### Objective
Organize automated findings into categories and present to the user before launching the interpretive review.

### Process

**Organize by category:**

1. **Execution failures**: Scripts that didn't complete, missing dependencies, file path issues
2. **Diagnostic failures**: Model checks that indicate problems (overdispersion, basis inadequacy, autocorrelation)
3. **Warnings**: Warnings that may or may not indicate problems (convergence, near-singularity)
4. **Plan-execution gaps**: Things in the analysis plan that weren't implemented, or implementation that diverges from the plan
5. **Missing checks**: Diagnostics from the checklist that weren't run
6. **Code quality flags**: Missing section headers, no inline output, hardcoded paths

**Present summary to user:**

```markdown
## Automated Review Summary

### Execution: [PASS / N errors]
- [list any errors]

### Diagnostics: [N of M passed]
- [list failures and borderline results]

### Plan Alignment: [ALIGNED / N gaps]
- [list gaps between plan and execution]

### Code Quality: [N flags]
- [list notable issues]

### Recommendation
[Brief recommendation: proceed to expert review? fix critical issues first?]
```

### USER CHECKPOINT
Review the automated diagnostic outputs. Decide whether to fix critical issues before expert review, or proceed with review to get full feedback.

---

## Phase 2: Parallel Reviewer Sub-agents

### Objective
Generate 3 independent expert reviews from different perspectives. Each reviewer operates independently to avoid groupthink.

### Why Sub-agents

Each reviewer has a fundamentally different evaluation lens:
- **Statistical Methods** focuses on model correctness and diagnostic interpretation
- **Scientific Interpretation** focuses on whether the analysis answers the underlying scientific question
- **Code Quality** focuses on reproducibility, conventions, and maintainability

Running them independently ensures each perspective is fully developed without being diluted by the others. Sub-agents also allow parallel execution.

### Launching Sub-agents

After Phase 1 checkpoint, launch 3 `Agent` calls (subagent_type: `general-purpose`) **in parallel**.

Each sub-agent receives:
- The full scripts (all `R/*.R` or `src/*.py` files)
- The automated diagnostic summary from Phase 0
- The analysis plan (if available)
- Their specific reviewer persona and instructions

---

#### Sub-agent 1: Statistical Methods Reviewer

**Prompt template:**

```
You are a statistical methods reviewer for a scientific analysis. You have deep expertise in GAMs, GLMMs, mixed models, and applied statistics. Your job is to assess whether the statistical approach is sound, properly implemented, and correctly diagnosed.

## Analysis Context
- Analysis plan: [paste YAML frontmatter or plan summary from analysis_plan.md]
- Primary model: [model type and family]
- Automated diagnostic results: [paste key findings from Phase 0]

## Scripts to Review
[Paste all scripts, clearly labeled by filename]

## Diagnostic Outputs
[Paste gam.check, k.check, DHARMa results, model summaries]

## Review Focus Areas

Evaluate each of the following and provide a rating (PASS / CONCERN / FAIL) with specific justification:

### 1. Model Specification
- Is the distribution family appropriate for the response type?
- Are smooth terms specified correctly (appropriate k, basis type)?
- Are interactions modeled appropriately (te() vs ti() vs s())?
- Is the link function correct?
- Are there missing covariates that should be included?

### 2. Random Effects
- Is the RE structure appropriate for the data hierarchy?
- Is the RE implementation correct (bs="re" vs bs="fs" vs gamm4)?
- Are there enough levels for RE estimation to be reliable?
- Could the RE structure be simplified or expanded?

### 3. Diagnostic Interpretation
- Are the gam.check/k.check results properly interpreted?
- Were basis dimensions increased where k.check flagged issues?
- Are DHARMa diagnostics clean? If not, was the response appropriate?
- Is autocorrelation adequately addressed?
- Were concurvity checks run? Needed?

### 4. Model Comparison
- Were alternatives fitted as planned?
- Is the comparison method appropriate (AIC, ANOVA, deviance)?
- Is the selected model justified over alternatives?

### 5. Sensitivity Analysis
- Were all planned sensitivity tests executed?
- Are results robust to the tested thresholds?
- Were sensitivity results reported transparently?

### 6. Over/Under-fitting Assessment
- Is the model too complex for the data (overfitting risk)?
- Is the model too simple to capture the biological pattern (underfitting)?
- Is cross-validation or other out-of-sample validation appropriate?

## Output Format

For each focus area, provide:
1. **Rating**: PASS / CONCERN / FAIL
2. **Finding**: What you observed (be specific, reference line numbers or code sections)
3. **Recommendation**: What should be done (if CONCERN or FAIL)
4. **Priority**: MUST FIX / SHOULD FIX / CONSIDER

End with a 2-paragraph overall assessment.
```

---

#### Sub-agent 2: Scientific Interpretation Reviewer

**Prompt template:**

```
You are a scientific interpretation reviewer for a statistical analysis. You have deep expertise in the lab's domain (e.g., small-mammal community ecology, vegetation-climate interactions, camera-trap methods) and in translating statistical results into ecological understanding. Your job is to assess whether the analysis actually answers the underlying scientific question and whether the results are ecologically meaningful.

A domain-specialist sub-agent (lab-specific; see `agents/_domain-specialist.template.md`) plays this role for projects where deep domain coverage matters; the prompt below acts as a generic fallback.

## Analysis Context
- Research question: [from analysis plan]
- Scientific domain: [e.g., small-mammal occupancy along a canopy gradient, vegetation-community response to climate]
- Study system: [e.g., temperate-forest small mammals, alpine meadow plant communities, mixed mark-recapture and camera-trap arrays]
- Expected scientific patterns: [from plan or user description]

## Scripts to Review
[Paste all scripts, clearly labeled by filename]

## Model Outputs
[Paste model summaries, prediction plots descriptions, effect sizes]

## Review Focus Areas

### 1. Question-Analysis Alignment
- Does the model directly address the stated research question?
- Are the response and predictor variables appropriate for the scientific question?
- Could a different framing better address the underlying biology?

### 2. Biological Reasonableness
- Do the predicted relationships make biological sense?
- Are the effect sizes scientifically meaningful (not just statistically significant)?
- Do predictions behave sensibly at the extremes of predictor ranges?
- Are there any predictions that contradict established knowledge in the field?

### 3. Uncertainty Communication
- Are confidence/credible intervals properly computed and reported?
- Is uncertainty appropriately large given the sample size and variability?
- Are predictions reported with uncertainty, or just point estimates?
- Is the distinction between statistical significance and scientific importance made clear?

### 4. Measurement / Detection Bias Concerns
- Could measurement or capture bias confound the observed patterns?
- Are there sampling biases that the analysis doesn't account for?
- Is the temporal/spatial / replicate coverage adequate for the conclusions?
- Are pseudoreplication concerns addressed?

### 5. Contextualization
- Are the results consistent with published literature?
- Where results differ from prior work, is there a plausible mechanistic explanation?
- Are the implications framed appropriately (not over-claiming)?

### 6. Figures & Presentation
- Do the figures clearly communicate the key findings?
- Are axes labeled with units? Are scales appropriate?
- Do prediction plots show uncertainty bands?
- Would a different visualization better communicate the pattern?

## Output Format

For each focus area, provide:
1. **Rating**: PASS / CONCERN / FAIL
2. **Finding**: What you observed
3. **Recommendation**: What should change
4. **Priority**: MUST FIX / SHOULD FIX / CONSIDER

End with a 2-paragraph overall assessment focused on whether the analysis convincingly answers the scientific question.
```

---

#### Sub-agent 3: Reproducibility & Code Quality Reviewer

**Prompt template:**

```
You are a reproducibility and code quality reviewer for an analysis. You have deep expertise in scientific computing best practices, reproducible research, and the specific coding conventions used in this research group. Your job is to assess whether the code is well-structured, reproducible, and follows established conventions.

## Coding Conventions Reference
The following conventions are from `conventions/code-format.template.md` and must be checked:

### Section Headers
- Every major step must have a `# ---- Section Name ----` header
- Headers should be succinct but descriptive
- Four dashes minimum on each side

### Inline Output
- After every major data step, print what happened (nrow, unique IDs, % retained)
- Summaries should be informative when the script is run manually

### Project Structure
- Scripts numbered sequentially: R/01_..., R/02_..., etc.
- Data in data/raw/ and data/processed/
- Outputs in output/figures/, output/tables/, output/models/
- Relative paths only (no absolute paths)

### General Style
- Use the lab's preferred ecosystem (e.g., tidyverse / data.table in R; pandas / polars in Python) consistently
- Pipe / chain operations should be readable (not 20 operations deep)
- Comment non-obvious code decisions
- `sessionInfo()` (R) or pinned dependency record (Python) at the end of analysis scripts

## Scripts to Review
[Paste all scripts, clearly labeled by filename]

## Review Focus Areas

### 1. Convention Compliance
- Do all scripts have proper `# ---- Section Name ----` headers?
- Is inline output present after each major step?
- Are scripts numbered sequentially?
- Is the project directory structure correct?

### 2. Reproducibility
- Are all file paths relative?
- Are random seeds set where needed?
- Is sessionInfo() / pinned dependency record documented?
- Could someone else run this code from scratch and get the same results?
- Are package versions documented?
- Are there any hardcoded values that should be parameters?

### 3. Code Quality
- Are variable names descriptive and consistent?
- Are there magic numbers that should be named constants?
- Are pipe chains readable (< 8 operations per chain)?
- Is error handling present for data loading and model fitting?
- Are there redundant or dead code sections?

### 4. Documentation
- Is each script's purpose clear from its header section?
- Are non-obvious analytical decisions commented?
- Are data transformations explained?
- Is there a clear narrative flow across scripts?

### 5. Efficiency
- Are there obvious performance issues (e.g., row-wise operations on large data)?
- Is `bam()` used instead of `gam()` for large datasets (R) / equivalent chunked-processing used (Python)?
- Are intermediate results cached where appropriate?
- Could any slow operations be parallelized?

### 6. Output Management
- Are all figures saved to the correct output directory?
- Are model objects saved as .rds / .pkl files?
- Are results tables exported in a usable format?
- Are figure dimensions and resolution appropriate for publication?
- **PNG-only**: no `ggsave(..., ".pdf")` calls unless the task explicitly asks for PDF. Flag any PDF export as MUST FIX. (Rule in `conventions/code-format.template.md` Critical Rules block.)
- **No Unicode in plot labels**: any bare degree, superscript, micro, or plus-minus character inside `labs()`, `ggtitle()`, `annotate()` is a MUST FIX, use `expression()` / `bquote()` or plain ASCII. Labels render incorrectly under `Rscript` otherwise. (Rule in `conventions/code-format.template.md` Critical Rules block; failure pattern in `conventions/visual-review-protocol.md`.)

## Output Format

For each focus area, provide:
1. **Rating**: PASS / CONCERN / FAIL
2. **Finding**: Specific issues found (reference script names and line numbers)
3. **Recommendation**: What should change
4. **Priority**: MUST FIX / SHOULD FIX / CONSIDER

End with a 2-paragraph overall assessment of code quality and reproducibility.
```

---

### Merging Sub-agent Results

After all 3 sub-agents complete:

1. **Collect all reviews**: Verify each returned substantive content (not just surface-level passes)
2. **Check for thin reviews**: If any reviewer returned a superficial review (< 3 substantive findings), relaunch that specific agent with a note to go deeper
3. **Identify overlapping findings**: Where multiple reviewers flagged the same issue, note the convergence (strengthens the finding)
4. **Identify unique findings**: Each reviewer should contribute at least 2 to 3 findings the others missed (validates the multi-perspective approach)
5. **Flag contradictions**: Where reviewers disagree (e.g., statistical reviewer says model is fine, scientific reviewer says it misses the point), present both perspectives

### Output
- `[name]_review_statistical.md`: Statistical methods review
- `[name]_review_scientific.md`: Scientific interpretation review
- `[name]_review_code_quality.md`: Code quality review

---

## Phase 3: Synthesis & Priority Ranking

### Objective
Merge all findings (automated + 3 reviewer sub-agents) into a single prioritized report.

### Process

**Step 1: Consolidate**

Combine findings from all sources into a single list, noting the source of each:
- [AUTO]: From automated diagnostic run
- [STAT]: From statistical methods reviewer
- [SCI]: From scientific interpretation reviewer
- [CODE]: From code quality reviewer
- [AUTO+STAT]: Convergence between automated and statistical (stronger finding)

**Step 2: Priority Assignment**

Assign each finding to one of three tiers:

| Priority | Label | Criteria | Expected Action |
|----------|-------|----------|-----------------|
| 1 | **MUST FIX** | Execution errors, diagnostic failures, assumption violations, incorrect model specification, results that are wrong | Fix before any results can be trusted |
| 2 | **SHOULD FIX** | Interpretation gaps, missing diagnostics, reproducibility issues, suboptimal model choices, unclear figures | Fix in current round for a solid analysis |
| 3 | **CONSIDER** | Alternative approaches, additional analyses, style improvements, efficiency gains | Address if time permits or for publication polish |

**Step 3: Organize Report**

```markdown
# Code Review Synthesis: [analysis name]

## Review Round: [N]
## Date: [date]
## Sources: Automated diagnostics + 3 expert reviewers

---

## MUST FIX (Priority 1): [N issues]

### [MF-1] [Short title]
**Source:** [AUTO / STAT / SCI / CODE]
**Finding:** [specific description]
**Impact:** [what goes wrong if not fixed]
**Suggested fix:** [specific recommendation with code if applicable]

### [MF-2] ...

---

## SHOULD FIX (Priority 2): [N issues]

### [SF-1] [Short title]
**Source:** [source]
**Finding:** [description]
**Suggested fix:** [recommendation]

---

## CONSIDER (Priority 3): [N issues]

### [C-1] [Short title]
**Source:** [source]
**Finding:** [description]
**Suggested fix:** [recommendation]

---

## Overall Assessment

[2-paragraph synthesis: Is the analysis fundamentally sound? What are the key improvements needed? Is another review round recommended?]

## Convergence Assessment (for Round 2+)

Round 1: [N] MUST FIX, [N] SHOULD FIX, [N] CONSIDER
Round 2: [N] MUST FIX, [N] SHOULD FIX, [N] CONSIDER
[Trend: improving / plateaued / new issues appearing]
```

### Output
- `[name]_review_synthesis.md`: Priority-ranked findings with code suggestions

---

## Phase 4: Inline Code Suggestions

### Objective
For the highest-priority findings, provide specific code changes that address the issue.

### Process

For each MUST FIX and SHOULD FIX item, provide:

```markdown
### [MF-1] Fix basis dimension for predictor1 smooth

**In:** `R/03_models.R`, Section "Model Fitting"

**Current code:**
```r
m1 <- bam(response ~ s(predictor1, k = 10) + s(subject_id, bs = "re"),
          family = betar(), data = dat_pos, discrete = TRUE)
```

**Suggested replacement:**
```r
m1 <- bam(response ~ s(predictor1, k = 20) + s(subject_id, bs = "re"),
          family = betar(), data = dat_pos, discrete = TRUE)

# Verify basis adequacy after increasing k
k.check(m1)
# If still flagged, try k = 30
```

**Rationale:** k.check flagged this smooth (edf close to k-1). Increasing k allows the smooth to be as wiggly as the data require without forcing it.
```

### Guidelines for Code Suggestions
- Be specific: reference exact script names and section headers
- Show both the current code and the suggested replacement
- Explain why the change helps
- If the fix involves multiple scripts, note the dependencies
- Don't suggest rewrites unless necessary: prefer minimal targeted changes

### Output
Code suggestions are appended to `[name]_review_synthesis.md`

---

## Iteration Model

### Convergence Expectations

| Round | Expected Issues | Interpretation |
|-------|----------------|----------------|
| Round 1 | 5 to 10 issues (mix of MUST/SHOULD/CONSIDER) | Normal first review: model diagnostics, interpretation, code structure |
| Round 2 | 2 to 5 issues (mostly SHOULD/CONSIDER) | Refinement round: initial issues resolved, polish needed |
| Round 3 | 0 to 2 issues (CONSIDER only) | Ready to finalize |
| Round 3+ with 5+ MUST FIX | Fundamental approach problem | Stop iterating. Discuss redesign with user. |

### Between Rounds

After each review round:
1. User reviews the synthesis report
2. User implements fixes (or asks for them via code-writing)
3. User requests another review round
4. New round starts fresh from Phase 0 (re-execute scripts with changes)
5. Synthesis includes convergence tracking (issues from previous rounds)

### USER CHECKPOINT
After each review round, present findings and ask:
- "Fix these and run another review round?"
- "Implement the suggestions and finalize?"
- "Discuss any findings before proceeding?"

---

## File Naming Convention

```
[name]_review_automated.md         Automated diagnostic capture
[name]_review_statistical.md       Statistical methods reviewer
[name]_review_scientific.md        Scientific interpretation reviewer
[name]_review_code_quality.md      Code quality reviewer
[name]_review_synthesis.md         Merged + prioritized (includes code suggestions)
```

For multiple rounds, append round number: `[name]_review_synthesis_r2.md`

---

## Key Principles

1. **Automated first, interpretive second.** The automated run provides an honest baseline. Reviewers can't hand-wave away a diagnostic failure that the automation caught.
2. **Independence.** Each sub-agent reviewer works independently. The merge step reconciles differences rather than forcing consensus during review.
3. **Three-tier priority.** Not all issues are equal. The priority system ensures the user focuses on what matters most. MUST FIX items must be resolved before results can be trusted.
4. **Convergence tracking.** Each round should produce fewer issues. If it doesn't, there's a structural problem that incremental fixes won't solve.
5. **Specific suggestions.** Vague feedback ("improve diagnostics") is unhelpful. Every finding should point to a specific script section and suggest a specific fix.
6. **Plan alignment.** The review explicitly checks whether the implementation matches the analysis plan. Unplanned deviations should be justified or corrected.
7. **Domain awareness.** If a domain extension applies, the reviewers should be briefed on domain-specific concerns (measurement bias, normalization choices, batch effects, spatial autocorrelation).

---

## Troubleshooting

**Q: A script errors during Phase 0 and can't be executed.**
A: Record the error. All downstream scripts that depend on it are also affected. This becomes a MUST FIX in Phase 1. The reviewer sub-agents can still review the code logic even without execution output, but note the limitation.

**Q: One reviewer sub-agent returned a very thin review.**
A: Relaunch that specific agent with an instruction to go deeper. Provide the other two reviews as context (without revealing who wrote them) and ask: "Two other reviewers found N substantive issues. Please ensure your review is at least as thorough."

**Q: The statistical and scientific reviewers fundamentally disagree.**
A: Present both perspectives in the synthesis. This is valuable: it highlights a trade-off between statistical rigor and scientific relevance that the user should resolve.

**Q: The user wants to skip straight to Phase 2 (no automated run).**
A: This is not recommended. The automated run catches issues that reviewers might miss (e.g., silent warnings, execution order dependencies). But if the user insists, launch Phase 2 with a note that automated diagnostics were not captured.

**Q: Round 3+ still shows many issues.**
A: Stop iterating on the same approach. The issue is likely architectural: the model choice, data structure, or question framing may need revision. Recommend going back to analysis-planning.
