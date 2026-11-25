---
name: analysis-pipeline
description: |
  Orchestrates the end-to-end analysis workflow from planning through implementation and review to finalized results. Chains analysis-planning, code-writing, and code-review skills in sequence with state tracking and user checkpoints. Use this skill when the user wants to run the full analysis workflow, resume from a checkpoint, check pipeline status, or coordinate between planning, coding, and review phases. Trigger phrases include: "run the full analysis workflow", "where are we in the analysis", "review this code", "run another review round", "finalize the analysis", or "resume the analysis from where we left off". The orchestrator manages state, tracks completion, and coordinates handoffs between skills. Each component skill remains independently usable.
cost: heavy
---

# Analysis Pipeline Orchestrator

Lightweight workflow coordinator for the end-to-end analysis lifecycle. Chains three primary skills in a managed sequence while keeping each independently usable.


## Required references: load before any work

For code structure and figure/table conventions:
- `conventions/code-format.template.md`
- `conventions/figure-format.template.md` (when producing figures or tables)

For any literature research, citations, or source handling:
- `conventions/research.md`

These are non-negotiable. Load them before substantive work.

---
## Overview

The pipeline coordinates three skills:

1. **analysis-planning** (Phases 0 to 5) -> Outputs `.md` analysis plan with YAML frontmatter
2. **code-writing** (Phases 0 to 8) -> Outputs numbered scripts + models + figures
3. **code-review** (Phases 0 to 4, iterative) -> Outputs priority-ranked review synthesis

```
analysis-planning -> analysis_plan.md + methods_evidence.md + diagnostics_checklist.md
        v
code-writing -> scripts + models + figures + code_summary.md
        v
code-review (round 1) -> review_synthesis_r1.md
        v  (user reviews, implements fixes)
code-review (round 2) -> review_synthesis_r2.md
        v  (user finalizes)
Final outputs: publication-ready figures + results + scripts
```

The orchestrator does not duplicate skill logic: it manages checkpoints, state transitions, and user-driven iteration.

---

## State Management

The orchestrator tracks the analysis lifecycle in a JSON state file saved alongside the analysis files.

```json
{
  "analysis_id": "occupancy-canopy-gam",
  "title": "Small-mammal occupancy along a canopy-cover gradient",
  "created": "2026-03-10T14:00:00Z",
  "current_phase": "review_r1",
  "files": {
    "analysis_plan": "occupancy_canopy_analysis_plan.md",
    "methods_evidence": "occupancy_canopy_methods_evidence.md",
    "diagnostics_checklist": "occupancy_canopy_diagnostics_checklist.md",
    "scripts": ["R/01_data_cleaning.R", "R/02_exploration.R", "R/03_models.R", "R/04_predictions_figures.R", "R/05_sensitivity.R"],
    "code_summary": "occupancy_canopy_code_summary.md",
    "review_r1": "occupancy_canopy_review_synthesis_r1.md",
    "review_r2": null,
    "final_outputs": null
  },
  "checkpoints": [
    {"phase": "planning_complete", "timestamp": "2026-03-10T15:00:00Z", "notes": "Multi-species occupancy GAM selected, Journal of Animal Ecology targeted"},
    {"phase": "implementation_complete", "timestamp": "2026-03-10T17:30:00Z", "notes": "5 scripts, 84 stations, 41% deviance explained"},
    {"phase": "review_r1", "timestamp": "2026-03-10T19:00:00Z", "notes": "3 MUST FIX, 4 SHOULD FIX, 2 CONSIDER"}
  ],
  "review_history": [
    {
      "round": 1,
      "must_fix": 3,
      "should_fix": 4,
      "consider": 2,
      "key_issues": ["k.check flagged canopy smooth", "missing residual spatial autocorrelation check", "hardcoded date range"]
    }
  ],
  "metadata": {
    "primary_model": "Multi-species occupancy GAM (logit-link)",
    "sample_size": 84,
    "domain_extension": "wildlife-ecology",
    "revision_number": 1
  }
}
```

**State file location:** Saved in the project directory, named `[analysis_id]_pipeline_state.json`.

**State file creation:** Automatically created after the first phase completes. Updated after each major phase.

---

## Entry Points

### 1. Run Full Pipeline from Start

**User says:** "Run the full analysis workflow for my paper on [topic]" or "Help me plan and code the analysis for [question]"

**Actions:**
1. Read `skills/simple/analysis-planning/SKILL.md`
2. Trigger analysis-planning Phase 0 (question clarification)
3. Pause for user confirmation on question framing
4. Continue through Phases 1 to 5 -> Output `[name]_analysis_plan.md` + supporting docs
5. Create state file with `current_phase: "planning_complete"`
6. Ask: "Analysis plan is ready. Would you like to proceed to implementation?"
7. If yes, read `skills/simple/code-writing/SKILL.md`
8. Trigger code-writing Phases 0 to 8
9. Update state: `current_phase: "implementation_complete"`
10. Ask: "Code is written and outputs generated. Would you like to run a code review?"

### 2. Start from Planning Only

**User says:** "Plan the analysis for [question]" or "Help me design a statistical approach"

**Actions:**
1. Read `skills/simple/analysis-planning/SKILL.md`
2. Run Phases 0 to 5
3. Create state with `current_phase: "planning_complete"`
4. Present plan and ask if user wants to proceed to implementation

### 3. Start from Implementation (Plan Already Exists)

**User says:** "Implement the analysis plan" or "Write the code for this plan"

**Actions:**
1. Locate the analysis plan (from state file or user-specified path)
2. Read `skills/simple/code-writing/SKILL.md`
3. Read the analysis plan's YAML frontmatter for model specifications
4. Run Phases 0 to 8
5. Update state: `current_phase: "implementation_complete"`
6. Present outputs and ask if user wants code review

### 4. Start Code Review

**User says:** "Review this analysis" or "Run a code review on these scripts"

**Actions:**
1. Locate the scripts and outputs (from state file or user-specified paths)
2. Read `skills/simple/code-review/SKILL.md`
3. Read the analysis plan (if available) for plan-execution alignment checking
4. Run Phases 0 to 4 -> Output `[name]_review_synthesis_r[N].md`
5. Update state: `current_phase: "review_r[N]"`, record issue counts in review_history
6. Present: "Review round [N] complete. [N] MUST FIX, [N] SHOULD FIX, [N] CONSIDER. Review the synthesis and let me know when you're ready for another round or to finalize."

### 5. Run Another Review Round

**User says:** "Run another review round" or "Re-review after my changes"

**Actions:**
1. Load the current scripts (user's version after implementing fixes)
2. Detect revision number from state file
3. Trigger code-review Phases 0 to 4 with fresh execution
4. Output `[name]_review_synthesis_r[N].md`
5. Update state: increment revision_number, append to review_history
6. If Round 3+, check convergence:
   - If MUST FIX count decreased: "Good progress. [N] issues remaining."
   - If MUST FIX count same or increased: "WARN: Issues are not converging. Consider revisiting the analysis approach rather than patching individual issues."

### 6. Finalize the Analysis

**User says:** "Finalize the analysis" or "I'm done with reviews"

**Actions:**
1. Verify no unresolved MUST FIX items from the latest review (warn if any remain)
2. Confirm all planned outputs exist: scripts, figures, model objects, results summary
3. Verify `[name]_code_summary.md` is up to date with final results
4. Update state: `current_phase: "final"`
5. Present final summary:
   - Number of scripts, total lines of code
   - Key results (from code_summary.md)
   - Review history (rounds, convergence)
   - List of all output files

### 7. Check Status

**User says:** "Where are we?" or "What's the status of the analysis?"

**Actions:**
1. Read state file
2. Display: current phase, last checkpoint, files generated, review history
3. Offer options based on current phase:
   - `planning_complete`: "Ready to implement. Proceed?"
   - `implementation_complete`: "Ready for review. Run code review?"
   - `review_r[N]`: "Last review had [N] MUST FIX. Run another round or finalize?"
   - `final`: "Analysis is finalized. All outputs available."

---

## Handoff Protocol

When passing control from one skill to the next:

1. **Verify output exists**: confirm the output files from the previous skill were saved
2. **Read YAML frontmatter**: extract model specifications, metadata
3. **Update state file**: record completion timestamp and notes
4. **Read next skill**: load the SKILL.md for the next phase
5. **Pass context**: provide the next skill with file paths and key metadata

### State Updates at Each Transition

| Transition | current_phase | revision_number |
|-----------|---------------|-----------------|
| Planning complete | `planning_complete` | 0 |
| Implementation complete | `implementation_complete` | 0 |
| Review R1 complete | `review_r1` | 1 |
| Review R2 complete | `review_r2` | 2 |
| Finalized | `final` | unchanged |

---

## Iteration Model

The pipeline supports user-driven iteration between review and implementation:

```
analysis_plan.md -> code-writing -> scripts + outputs
                                          v
                                   code-review R1 -> synthesis_r1.md
                                          v
                                   user reviews findings
                                   implements fixes
                                          v
                                   code-review R2 -> synthesis_r2.md
                                          v
                                   user reviews findings
                                          v
                                   ... (repeat as needed)
                                          v
                                   finalize -> all outputs ready
```

**Convergence signal:** Each round should produce fewer issues than the previous. If Round 3+ still has 5+ MUST FIX items, the issue is likely structural: recommend revisiting the analysis plan rather than continuing incremental fixes.

**Version tracking:** All review syntheses are preserved with round suffixes. The user always has access to every intermediate version.

---

## File Naming Convention

```
[name]_analysis_plan.md              Planning output: structured plan
[name]_methods_evidence.md           Planning output: literature + fundamentals
[name]_diagnostics_checklist.md      Planning output: per-model diagnostics
R/01_data_cleaning.R                 Implementation: data loading + QC
R/02_exploration.R                   Implementation: exploratory plots
R/03_models.R                        Implementation: models + diagnostics
R/04_predictions_figures.R           Implementation: predictions + figures
R/05_sensitivity.R                   Implementation: robustness tests
[name]_code_summary.md               Implementation: results narrative
[name]_review_automated.md           Review: automated diagnostic capture
[name]_review_statistical.md         Review: statistical methods reviewer
[name]_review_scientific.md          Review: scientific interpretation reviewer
[name]_review_code_quality.md        Review: code quality reviewer
[name]_review_synthesis_r[N].md      Review: merged findings (per round)
[name]_pipeline_state.json           Auto-generated, updated at each checkpoint
```

All files saved to the user's project directory.

---

## Design Principles

1. **Skills remain independent.** Each skill can be invoked directly without the orchestrator. The orchestrator adds coordination, not new logic.
2. **User drives iteration.** No automatic progression between phases. The user decides when to move forward, run another round, or finalize.
3. **Clear state tracking.** The user always knows where they are in the pipeline and what the next step is.
4. **Non-destructive versioning.** Every intermediate file is preserved. Nothing is overwritten.
5. **Convergence monitoring.** The orchestrator tracks review issue counts across rounds and flags when iteration isn't converging.
6. **Domain-aware.** Domain extensions detected during planning carry through to implementation and review automatically.

---

## Invocation Patterns

This skill should trigger when the user says things like:

- "Run the full analysis workflow for [topic]"
- "Plan and code the analysis for [question]"
- "Where are we in the analysis?" / "What's the status?"
- "Implement the analysis plan"
- "Run a code review"
- "Run another review round"
- "Finalize the analysis"
- "Resume the analysis from where we left off"

---

## Integration

This skill orchestrates:
- `skills/simple/analysis-planning`: for Phases 0 to 5 (research + plan)
- `skills/simple/code-writing`: for Phases 0 to 8 (scripts + outputs)
- `skills/simple/code-review`: for Phases 0 to 4 (automated + expert review)

It reads the `SKILL.md` of each component skill as needed to understand phase requirements and outputs.

It also references:
- `conventions/code-format.template.md`: for code conventions (passed through to implementation and review)
- `conventions/figure-format.template.md`: for figure conventions
- `conventions/research.md`: for source-handling conventions
