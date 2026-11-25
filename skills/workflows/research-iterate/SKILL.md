---
name: research-iterate
description: |
  Iteratively refines a research analysis through multi-specialist critique and quality gates until it reaches publication-ready quality. Use this skill when the user says: "iterate the analysis", "refine until publication-ready", "run through quality gates", "bring this to publication quality", or asks for a defensible, multi-round refinement of existing outputs. The skill orchestrates the Lab Director + specialist agents through a six-phase loop (readiness assessment, planning, implementation, parallel critique, arbitration, and self-update) until the project's concrete goal spec is met, escalating to the user only on structural decisions. Wraps `analysis-pipeline` as a sub-workflow for code-heavy rounds; adds cross-domain critique, render-and-read visualization review, and self-improvement feedback into the framework itself.
cost: heavy
---

# Research Iterate Skill

A structured, multi-round orchestration loop that takes a research analysis from "first cut" to "publication ready" by running it through parallel specialist critique, explicit quality gates, and self-improvement feedback cycles.

This skill is the operational implementation of `conventions/iteration-workflow.md`. The Lab Director is the orchestrator; the skill is the sequence of steps the Lab Director follows.


## Required references: load before any work

For code structure and figure/table conventions:
- `conventions/code-format.template.md`
- `conventions/figure-format.template.md` (when producing figures or tables)

For any literature research, citations, or source handling:
- `conventions/research.md`

These are non-negotiable. Load them before substantive work.

---
## Overview

Six-phase process, runs once for Phase 0 then loops Phases 1 to 5 until convergence:

0. **Readiness & Goal-Setting** (once): establish what "done" means and confirm system has the expertise
1. **Plan**: Lab Director plans the round based on goal-spec progress and open issues
2. **Implement**: specialists execute the plan (may invoke `analysis-pipeline` as sub-workflow)
3. **Refine**: parallel critics (Quantitative Scientist + domain specialists + Science Writer) review outputs
4. **Arbitrate**: Lab Director reconciles critiques, updates issue queue, evaluates quality gates
5. **Self-Update**: triage system-improvement suggestions (mechanical auto-apply; structural escalate)

Loop exits when all goal-spec acceptance criteria pass AND zero open HIGH-priority issues, OR max rounds reached, OR user halts.

---

## Before You Begin

**Core documents (read all six):**
- `conventions/iteration-workflow.md`: the canonical phase spec this skill implements
- `conventions/research-quality-gates.md`: gate criteria evaluated in Phase 4
- `conventions/readiness-assessment.md`: Phase 0 expertise-coverage check
- `conventions/goal-spec.template.md`: Phase 0 endpoint template
- `conventions/visual-review-protocol.md`: Phase 3 render-and-read protocol
- `conventions/system-improvement-protocol.md`: Phase 5 self-update triage rules

**Supporting references:**
- `agents/lab-director.md`: dispatch patterns A to D (used in Phase 2) + Iteration Mode section (used throughout)
- `agents/quantitative-scientist.md`: Visualization Review protocol (Phase 3)
- `skills/workflows/analysis-pipeline/SKILL.md`: sub-workflow invoked in Phase 2 for code-heavy rounds
- `skills/simple/code-review/SKILL.md`: sub-workflow invoked in Phase 3 for code-specific critique

**Domain extensions** (lab-specific; load per goal statement if the lab maintains them): for example, a camera-trap-methods extension, an occupancy-modelling extension, or a vegetation-transects extension. A domain-specialist sub-agent (lab-specific; see `agents/_domain-specialist.template.md`) plays the domain-expert critic role in Phase 3.

---

## Phase 0: Readiness & Goal-Setting

### Objective
Establish concrete, testable endpoints for the project AND confirm the system has the expertise required. Gaps block the loop until resolved.

### Process

**Step 1: Parse the goal statement and inspect the project.**

Lab Director reads the user's goal statement and the project directory. Identifies required analytical techniques, focal system (with relevant biological traits), covariates, and statistical frameworks. This is the input to the readiness assessment.

**Step 2: Run readiness assessment.**

Per `conventions/readiness-assessment.md`:
1. Lab Director lists all required expertise.
2. Consults each specialist whose domain is implicated to confirm coverage classification.
3. Queries any knowledge-base indices for each requirement.
4. Classifies coverage as **present** / **partial** / **gap**.
5. For each gap, proposes a response: mechanical fill (auto-apply before loop), structural fill (escalate), or proceed-with-caveat.
6. Writes `.iterate/readiness-assessment.md` with the coverage table and gap-fill plan.

**Step 3: Draft the goal spec.**

Per `conventions/goal-spec.template.md`:
1. List concrete deliverables (files, figures, tables, text sections).
2. List testable acceptance criteria, each tied to a specific gate from `conventions/research-quality-gates.md`.
3. Select applicable vs waived gates, with justifications for any waivers.
4. Declare out-of-scope items.
5. Set round budget and project-specific escalation triggers.
6. Enumerate escalation-requiring decisions.
7. Write `.iterate/project-goal-spec.md`.

**Step 4: Run pre-loop mechanical fills.**

Any items in `.iterate/improvement-queue.md` marked `mechanical-auto` from the readiness assessment are processed in a blocking pass BEFORE Phase 1. Usually Science Writer is dispatched to write missing stubs or knowledge-base articles; Quantitative Scientist to tighten existing skill steps. Log outcomes in `.iterate/decision-log.md` under "Pre-loop self-update".

**Step 5: Resolve structural gaps.**

Any `structural-pending` entries in `.iterate/system-change-proposals.md` block the loop. USER CHECKPOINT.

### Output
- `.iterate/readiness-assessment.md`
- `.iterate/project-goal-spec.md`
- `.iterate/improvement-queue.md` (possibly populated)
- `.iterate/system-change-proposals.md` (possibly populated)
- Initial `.iterate/iteration-state.json` (round=0, all gates pending)
- Initial `.iterate/decision-log.md` (Phase 0 entry)

### USER CHECKPOINT
Present goal-spec and readiness assessment. User approves both before entering the loop. If structural gaps exist, user decides build-now / defer / reduce scope. Loop does not enter Phase 1 until user confirms.

---

## Phase 1: Plan

### Objective
Plan the round: decide what to work on, who does it, what outputs are expected.

### Process

Lab Director:
1. Reads `.iterate/iteration-state.json` (round number, open issue counts, gate status, goal-spec progress).
2. Reads `.iterate/issue-queue.md` (open HIGH/MEDIUM issues from prior rounds).
3. Reads `.iterate/project-goal-spec.md` (unmet acceptance criteria).
4. Writes `.iterate/round-N-plan.md` with:
   - Round objectives: which acceptance criteria and open issues will be addressed this round.
   - Dispatch plan: which specialists, which sub-skills, which output files expected.
   - Expected critics for Phase 3.
   - Known risks / dependencies.

### Output
- `.iterate/round-N-plan.md`
- Updated `.iterate/iteration-state.json` (round number increments, phase = "implement")

---

## Phase 2: Implement

### Objective
Execute the plan. Specialists do the domain work; critics do not act in this phase.

### Process

Lab Director dispatches per Pattern A/B in `agents/lab-director.md`:
- Analytical / code work: relevant domain specialist + Quantitative Scientist; invoke `skills/workflows/analysis-pipeline/SKILL.md` as sub-workflow when appropriate.
- Writing / framing work: Science Writer with domain specialist consultation.
- Pure knowledge-base / theory work: relevant domain specialist reading the knowledge base.

Each dispatched specialist:
1. Executes their portion of the plan.
2. Writes outputs to the project directory (code, figures, tables, text).
3. Appends a self-critique request to their deliverable: specific questions they want the critics in Phase 3 to examine (e.g., "the regulator-X coefficient is null in this stratum; is this a real finding or a sample-size artifact?").

### Output
- Project deliverables per plan (code changes, new figures, text drafts)
- Specialist self-critique requests logged in the deliverable files

### USER CHECKPOINT (lightweight)
Not mandatory; available if implementation surfaces a question needing user input.

---

## Phase 3: Refine

### Objective
Parallel critique of the round's outputs. Critics act independently; Lab Director does not yet arbitrate.

### Process

Lab Director dispatches the following critics in parallel:

**Quantitative Scientist (always)**
- Statistical critique: are diagnostics run? are assumptions tested? are coefficients interpretable? are sensitivity analyses done where consequential?
- Visualization critique: per `conventions/visual-review-protocol.md`, render-and-read each full-tier figure, score the four tests, revise and re-render as needed.
- Writes `.iterate/round-N-critique-quantitative.md` with prioritized issues (HIGH / MEDIUM / LOW), evidence, suggested fixes, gate-blocking flags.

**Relevant domain specialist(s)**
- Scientific plausibility: do findings match established mechanisms? Are counterintuitive findings explained mechanistically? Are literature-discordant results engaged?
- Writes `.iterate/round-N-critique-<domain>.md` with same prioritized structure.
- Multiple domain specialists may critique in parallel if the project spans domains.

**Science Writer (rounds >= 2, or earlier if framing matters)**
- Framing review: is the narrative coherent? Are claims cited? Does the figure-to-claim map exist?
- Writes `.iterate/round-N-critique-writer.md`.

All critics follow the same file structure:
```
# Round N Critique: <agent>

## HIGH priority
### <issue title>
- Evidence: <specific file / figure / coefficient>
- Suggested fix: <concrete action>
- Blocks gate: <gate name or "none">

## MEDIUM priority
...

## LOW priority
...
```

### Output
- One `.iterate/round-N-critique-<agent>.md` per critic

---

## Phase 4: Arbitrate

### Objective
Reconcile critiques, decide what gets worked on next, evaluate quality gates against the goal spec, decide whether to continue the loop.

### Process

Lab Director:

**Step 1: Read all critique files.**

Consolidate issues by priority. Flag conflicts (e.g., one critic says X, another says not-X) for explicit resolution.

**Step 2: Update issue queue.**

For each critique item, mark one of:
- **accept**: queued for the next round; add to `.iterate/issue-queue.md`.
- **defer**: log to issue queue with a re-check condition and round.
- **reject**: log with justification (e.g., "out of current project scope; not generalizable").

**Step 3: Evaluate quality gates.**

For each gate listed as applicable in `.iterate/project-goal-spec.md`, check all criteria per `conventions/research-quality-gates.md`. Write evaluation to `.iterate/round-N-decision.md`. Every passed gate requires written justification citing specific evidence (file paths, coefficient CIs, figure filenames); ticking a box is not a pass.

**Step 4: Append to decision log.**

`.iterate/decision-log.md` gets a new round-N section: round summary, gate status changes, key decisions and tradeoffs, next-round focus. Preserve history; never overwrite.

**Step 5: Decide.**

One of:
- **Done**: all applicable goal-spec acceptance criteria pass AND zero open HIGH-priority issues. Loop terminates. Write final `.iterate/decision-log.md` "CONVERGED" section.
- **Continue**: proceed to Phase 5 then Phase 1 of round N+1.
- **Escalate**: the same gate has failed two consecutive rounds, OR a structural question has emerged. USER CHECKPOINT.

### Output
- `.iterate/round-N-decision.md`
- Updated `.iterate/issue-queue.md`
- Updated `.iterate/iteration-state.json` (gate status, goal-spec progress, phase = "self-update")
- Appended `.iterate/decision-log.md`

### USER CHECKPOINT (lightweight)
After each round: "continue, pause, or redirect?" Provide a 3 to 5 sentence summary of round decisions.

### USER CHECKPOINT (mandatory)
On escalation: present the specific decision needing user input with options.

---

## Phase 5: Self-Update

### Objective
Channel system-improvement suggestions discovered during the round into the system, either as auto-applied mechanical changes or escalated structural proposals.

### Process

Lab Director:
1. Read `.iterate/improvement-queue.md` entries added this round.
2. Per `conventions/system-improvement-protocol.md`, classify each as mechanical or structural.
3. Move entries to `.iterate/system-change-proposals.md` with appropriate status:
   - **mechanical-auto**: dispatch implementation (Science Writer for knowledge-base article; Quantitative Scientist or relevant specialist for skill-step tightening).
   - **structural-pending**: included in round's escalation set; not applied until user approves.
4. Mechanical changes applied before Phase 1 of round N+1; dashboard picks them up on next `tools/refresh-dashboard.sh` run.
5. Log all triage decisions in `.iterate/decision-log.md` under "Round N Self-Update".

### Output
- Updated `.iterate/system-change-proposals.md`
- Possibly modified system files (knowledge-base articles, skill steps)
- Appended `.iterate/decision-log.md`

### USER CHECKPOINT
Triggered only by structural changes queued this round. Skip if only mechanical updates.

---

## Loop Termination

Three termination conditions (per Phase 4 decision):

1. **Converged**: all applicable goal-spec acceptance criteria pass AND zero open HIGH-priority issues.
   - Write final summary to `.iterate/decision-log.md`.
   - Produce a deliverables-manifest listing every goal-spec deliverable and its location.
   - Report to user with key findings summary, gate-pass justifications, and any deferred items.

2. **Max rounds reached** (default 5): write an escalation report to `.iterate/decision-log.md` describing what converged, what didn't, why the remaining work is blocked, and recommended next steps (extend budget, reduce scope, try alternative approach). USER CHECKPOINT.

3. **User halt**: write a graceful termination summary to `.iterate/decision-log.md` at the current phase. Preserve state for potential resumption.

---

## State Directory Layout

The skill creates and maintains `.iterate/` inside the project directory:

```
<project>/
  .iterate/
    config.yaml                     (optional override of max-rounds, gates, etc.)
    project-goal-spec.md            (Phase 0)
    readiness-assessment.md         (Phase 0)
    iteration-state.json            (round, gate status, goal-spec progress)
    round-1-plan.md ... round-N-plan.md
    round-1-critique-quantitative.md ... round-N-critique-<agent>.md
    round-1-decision.md ... round-N-decision.md
    issue-queue.md                  (rolling, appended)
    improvement-queue.md            (rolling, appended)
    system-change-proposals.md      (rolling, appended)
    decision-log.md                 (permanent, human-readable, appended each round)
```

---

## Sub-Workflow Integration

### `skills/workflows/analysis-pipeline/SKILL.md`
Invoked in Phase 2 when a round involves substantial code / analytical work. The analysis-pipeline's own phase structure nests inside Phase 2; its state file (`*_pipeline_state.json`) coexists with `iteration-state.json`.

### `skills/simple/code-review/SKILL.md`
Invoked in Phase 3 when the round produced code changes. Quantitative Scientist runs code-review as Statistical Methods Reviewer AND Reproducibility Reviewer per the existing convention.

### Skill-file updates (Phase 5)
When a mechanical system change requires skill-file modification (e.g., adding a step to an existing workflow skill, updating a task-skill reference), apply the edit directly to the SKILL.md file. Knowledge-base article edits do not require any tooling; agents edit the files directly.

---

## Configuration Overrides

Per-project overrides via `.iterate/config.yaml` (optional):

```yaml
max_rounds: 7                     # default: 5
escalation_after_gate_failures: 2 # default: 2 consecutive
applicable_gates:                 # default: all 5
  - Analytic
  - Domain            # field-neutral; see conventions/research-quality-gates.md §2
  - Visual
  - Literature
  # Framing waived via goal spec
viz_tier:
  default: lightweight            # default for in-analysis diagnostics
  main_figures: full              # default for convergence-gate figures
```

---

## Common Pitfalls

- **Skipping Phase 0.** The temptation is to start implementing immediately. Without a concrete goal spec, the loop has no exit condition other than user halt. Always run Phase 0.
- **Ticking gates without justification.** `decision-log.md` entries must cite specific evidence. "Diagnostics look fine" is not a pass.
- **Code-only viz review.** Phase 3 visualization review MUST include the render-and-read protocol. Use the Read tool on rendered PNGs, not the code.
- **Auto-applying structural changes.** Never. Structural changes always escalate to the user.
- **Forgetting to invoke sub-workflows.** `analysis-pipeline` in Phase 2 for code-heavy rounds; `code-review` in Phase 3 for code-change critique. Don't reinvent these.
- **Overwriting decision-log.** The log is permanent: append only. Preserves audit trail across rounds.

---

## Related Skills

- `skills/workflows/analysis-pipeline/SKILL.md`: the code-side loop; sub-workflow in Phase 2
- `skills/simple/analysis-planning/SKILL.md`: standalone analysis plan; often invoked inside analysis-pipeline
- `skills/simple/code-writing/SKILL.md`: code writing; invoked inside analysis-pipeline
- `skills/simple/code-review/SKILL.md`: code review; invoked in Phase 3 by Quantitative Scientist

---

## References

- `conventions/iteration-workflow.md`: canonical phase specification
- `conventions/research-quality-gates.md`: gate criteria
- `conventions/readiness-assessment.md`: Phase 0 expertise check
- `conventions/goal-spec.template.md`: goal spec template
- `conventions/visual-review-protocol.md`: render-and-read protocol
- `conventions/system-improvement-protocol.md`: self-update triage
- `agents/lab-director.md`: orchestrator with Iteration Mode section
- `agents/quantitative-scientist.md`: critic with Visualization Review protocol
