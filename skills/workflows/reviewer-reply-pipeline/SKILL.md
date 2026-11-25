---
name: reviewer-reply-pipeline
description: |
  Orchestrates the end-to-end reviewer-reply workflow from raw reviewer comments to a submission-ready response document and tracked-changes manuscript. Chains reviewer-reply-planning and reviewer-reply-drafting in sequence, manages state, and coordinates handoffs. Use this skill whenever the user wants to run the full reply workflow, resume from a checkpoint, redraft individual comments, or check status. Trigger phrases include "address the reviewer comments", "respond to the reviewers", "where are we on the reply", "redraft my reply to R2-C3", "build the final reply docx", or "resume the reply workflow". The orchestrator manages a JSON state file alongside the manuscript and supports targeted re-entry on individual comments without redrafting the whole reply.
cost: heavy
---

# Reviewer Reply Pipeline: Orchestrator

Lightweight workflow coordinator for the end-to-end reviewer-reply lifecycle. Chains two primary skills while keeping each independently usable.


## Required references: load before orchestrating

- `conventions/voice.template.md`: base writing voice
- `conventions/reply-format.template.md`: reviewer-response conventions

The pipeline orchestrator should propagate these to each phase skill it dispatches.

---
## Overview

The pipeline coordinates two skills:

1. **reviewer-reply-planning** (Phases 0 to 3) → Outputs `[title]_reply_plan.md`
2. **reviewer-reply-drafting** (Phases 1 to 4) → Outputs `[title]_response_to_reviewers.docx` + `[title]_revised_tracked.docx`

```
INPUT: manuscript.docx + reviewer_comments.docx
        ↓
reviewer-reply-planning → [title]_reply_plan.md
        ↓  (user's input on RESTRUCTURE/NEW-ANALYSIS/JUDGEMENT comments)
        ↓
reviewer-reply-drafting → [title]_reply_draft.md
                       → [title]_revised_marked.md
                       ↓
                       → [title]_response_to_reviewers.docx
                       → [title]_revised_tracked.docx
        ↓  (user reviews .docx pair, may request targeted edits)
        ↓
[finalized for submission]
```

The orchestrator does not duplicate skill logic: it manages checkpoints, state transitions, analysis hand-offs, and targeted re-entry.

---

## State Management

The orchestrator tracks the reply lifecycle in a JSON state file saved alongside the manuscript.

```json
{
  "manuscript_id": "small-mammal-canopy-occupancy",
  "title": "Small-mammal occupancy along a canopy-cover gradient",
  "created": "2026-04-28T15:00:00Z",
  "current_phase": "drafting",
  "revision_round": 1,
  "files": {
    "manuscript_original": "small_mammal_canopy_v1.docx",
    "manuscript_working_md": "small_mammal_canopy_working.md",
    "comments_source": "Reviewer_replies_final.docx",
    "comments_parsed": "small_mammal_canopy_comments_parsed.md",
    "reply_plan": "small_mammal_canopy_reply_plan.md",
    "reply_draft": "small_mammal_canopy_reply_draft.md",
    "revised_marked": "small_mammal_canopy_revised_marked.md",
    "response_docx": null,
    "revised_tracked_docx": null,
    "analysis_specs_dir": "small_mammal_canopy_analysis_specs/"
  },
  "comments": [
    {
      "id": "EC-1",
      "classification": "JUDGEMENT",
      "status": "drafted",
      "user_direction": "Defend novelty via the integrated multi-species occupancy and the canopy-gradient framing"
    },
    {
      "id": "R1-C1",
      "classification": "TRIVIAL",
      "status": "drafted"
    },
    {
      "id": "R1-C12",
      "classification": "NEW-ANALYSIS",
      "status": "awaiting_analysis",
      "analysis_spec": "small_mammal_canopy_analysis_specs/R1-C12.md"
    }
  ],
  "checkpoints": [
    {"phase": "planning_complete", "timestamp": "2026-04-28T15:30:00Z", "notes": "33 comments, 3 awaiting user input"},
    {"phase": "triage_complete", "timestamp": "2026-04-28T16:00:00Z", "notes": "1 analysis spec spawned"},
    {"phase": "drafting_complete", "timestamp": "2026-04-28T17:30:00Z", "notes": "All non-analysis comments drafted"}
  ],
  "metadata": {
    "journal_target": "Journal of Animal Ecology",
    "n_reviewers": 2,
    "n_comments": 33,
    "render_mode": "tracked",
    "track_change_author": "Corresponding Author Name",
    "output_dir": "/Users/.../paper/versions/JAnimEcol/revised/",
    "support_dir": "/Users/.../paper/versions/JAnimEcol/revised/workflow_intermediates/",
    "manuscript_original": "/Users/.../revised/manuscript.docx",
    "manuscript_revised_copy": "/Users/.../revised/manuscript_revised.docx",
    "appendices": [
      {"original": "/Users/.../revised/appendix_S1.docx", "revised_copy": "/Users/.../revised/appendix_S1_revised.docx"}
    ]
  }
}
```

`render_mode` defaults to `"tracked"` (native Word `<w:ins>`/`<w:del>`). `track_change_author` defaults to the corresponding author's full name from the manuscript YAML / author list.

`output_dir` is the directory the source manuscript .docx came from: final deliverables (the `*_revised.docx` files with tracked changes; the reply doc) save there. `support_dir` is `<output_dir>/workflow_intermediates/`: every intermediate file (markdown sources, plan, state JSON, apply reports, analysis specs) saves there. Never a new top-level subfolder.

`manuscript_revised_copy` and each `appendices[].revised_copy` point at the user-supplied byte-identical copies that the drafting skill applies tracked changes to. The planning skill confirms these exist during Phase 0.

**State file location:** `<support_dir>[manuscript_id]_reply_state.json`.

**State file creation:** Created at the end of the planning skill's Phase 3. Updated after each major phase and at every targeted re-entry.

### Per-comment status values

- `auto_proposed`: classifier set proposed_edit and proposed_reply, awaiting the user's spot-check (or auto-confirmed)
- `awaiting_input`: needs the user's `AskUserQuestion` response before drafting
- `awaiting_analysis`: analysis spec spawned; reply pending the user's analysis output
- `confirmed`: the user's input received; ready for drafting
- `drafted`: drafting skill produced final reply text and manuscript markup
- `needs_revision`: the user flagged for re-drafting after reviewing the .docx
- `finalized`: included in the rendered .docx, no further changes pending
- `deferred`: the user set aside for offline resolution

---

## Entry Points

### 1. Run Full Pipeline from Start

**User says:** "Address the reviewer comments on [manuscript]" / "Respond to the reviewers"

**Actions:**
1. Identify inputs: manuscript .docx + reviewer comments .docx (ask if not clear)
2. Trigger `skills/simple/reviewer-reply-planning/SKILL.md` Phase 0 (inventory)
3. Run Phases 1 to 3 (classification, triage, analysis bridge)
4. Pause at the end of planning: "Plan is frozen. Ready to draft replies and apply manuscript edits, or want to review the plan first?"
5. On confirmation, trigger `skills/simple/reviewer-reply-drafting/SKILL.md` Phases 1 to 3
6. Pause for the user to review the .docx pair: "Reply draft + revised manuscript are ready. Review both and let me know if any comments need adjustment."

### 2. Resume / Check Status

**User says:** "Where are we on the reply?" / "Status of the [manuscript] reply"

**Actions:**
1. Read state file
2. Display: current phase, comment status counts, files generated, any awaiting-analysis comments, next recommended action

Example status display:

```
Reply pipeline: small_mammal_canopy

Current phase: drafting_complete
Revision round: 1
Total comments: 33
  - 28 finalized
  - 1 awaiting analysis (R1-C12: network topology comparison across timepoints)
  - 4 needs_revision (per your last review of the .docx pair)

Outputs:
  - small_mammal_canopy_response_to_reviewers.docx
  - small_mammal_canopy_revised_tracked.docx

Next: address R1-C12 (provide analysis result), then redraft the 4 flagged comments.
```

### 3. Targeted Redraft

**User says:** "Redraft my reply to R2-C3" / "Redo R1-C12 and R2-C5"

**Actions:**
1. Load state file
2. Identify the named comments
3. If the user has new direction, update `user_direction` field on those plan entries (rerun the relevant `AskUserQuestion` if needed)
4. Trigger `skills/simple/reviewer-reply-drafting/SKILL.md` Phase 1 only on those comments
5. Trigger `skills/simple/reviewer-reply-drafting/SKILL.md` Phase 2 to re-apply markup for those comments (roll back old markup first)
6. Trigger `skills/simple/reviewer-reply-drafting/SKILL.md` Phase 3 to re-render the .docx pair
7. Update state: those comments move to `drafted`; checkpoint logged

### 4. Resume After Analysis

**User says:** "I ran the analysis for R1-C12, here are the results: [result]" / "Analysis for [comment] is done"

**Actions:**
1. Load the analysis spec at `[manuscript]_analysis_specs/[comment-id].md`
2. Update `status: analysis_complete: true` on the spec
3. Treat the comment like a CLARIFY or NEW-ANALYSIS-resolved entry: the drafter generates the manuscript edit and reply incorporating the result
4. Re-render the .docx pair with the new comment included

### 5. Build Final Output

**User says:** "Build the final reply docx" / "Finalize the reviewer response"

**Actions:**
1. Verify all comments are `drafted` or `deferred` (no `awaiting_input`, `awaiting_analysis`, or `needs_revision`)
2. If any comments are still in non-final states, list them and confirm with the user whether to proceed without them
3. Trigger `skills/simple/reviewer-reply-drafting/SKILL.md` Phase 3 (render) one more time for clean output
4. Update state: `current_phase: "finalized"`, all included comments → `finalized`
5. Present file paths and a summary

---

## Handoff Protocol

When passing control between skills:

1. **Verify output exists**: confirm the previous skill's output file was saved
2. **Read state file**: extract current_phase, comment statuses, file paths
3. **Validate plan structure**: for the planning → drafting handoff, ensure the plan has all comments classified and no `awaiting_input` entries
4. **Update state**: log a checkpoint with timestamp and notes
5. **Invoke next skill**: pass paths to plan, manuscript .md, and state file

### Phase transitions

| Transition | current_phase | Triggers |
|---|---|---|
| Planning Phase 0 done | `inventory_complete` | comments parsed, manuscript converted |
| Planning Phase 1 done | `classification_complete` | all comments classified by sub-agents |
| Planning Phase 2 done | `triage_complete` | user's input collected on flagged comments |
| Planning Phase 3 done | `planning_complete` | analysis specs spawned (if any), plan frozen |
| Drafting Phase 1 done | `replies_drafted` | reply markdown produced |
| Drafting Phase 2 done | `markup_applied` | manuscript markup applied |
| Drafting Phase 3 done | `drafting_complete` | .docx pair rendered |
| All comments finalized | `finalized` | ready for submission |

---

## Iteration Model

The pipeline supports two kinds of iteration:

### Targeted re-entry (within the same revision round)

The user reviews the .docx pair, flags specific comments needing adjustment. The drafting skill redrafts only those comments. State stays at `revision_round: 1`.

```
draft (round 1) → review .docx → "Redo R1-C12 and R2-C5" → re-draft those two
                                                          → re-render .docx pair
```

### New revision round (full rerun)

If reviewers send a second round of comments after the journal returns the revised manuscript, run the pipeline again:

1. New reviewer comments .docx → `skills/simple/reviewer-reply-planning/SKILL.md` Phase 0 with `revision_round: 2`
2. Plan + draft as usual
3. State file appends round 2 comments alongside round 1 (which are kept for reference)

---

## Analysis Hand-off

When a comment is classified `NEW-ANALYSIS` and the user selects "Run the analysis" during triage, the planning skill spawns an analysis spec at `[manuscript]_analysis_specs/[comment-id].md`. The state file records `status: awaiting_analysis` on that comment.

### Workflow

1. Planning skill spawns the spec, drafting proceeds without the awaiting-analysis comments
2. The user runs the analysis offline using `skills/simple/analysis-planning/SKILL.md` (or however they prefer)
3. When the analysis is done, the user says "I ran the analysis for R1-C12, [result summary]"
4. Orchestrator routes to entry point #4 above: the drafter integrates the result and re-renders

The pipeline does **not** automatically run analyses. Analysis specs are spawned and the user decides how to handle them.

---

## File Naming Convention

Files split between `output_dir` (top-level deliverables, where the originals live) and `support_dir` (`<output_dir>/workflow_intermediates/`, where intermediates live):

**`output_dir/` (top-level):**
```
<original>.docx                                        # User's original (untouched)
<original>_revised.docx                                # User's working copy + applied tracked changes (DELIVERABLE)
<appendix>.docx                                        # User's original appendix (untouched)
<appendix>_revised.docx                                # Appendix working copy + applied tracked changes (DELIVERABLE)
<short-title>_response_to_reviewers_R{N}.docx         # Reply doc (DELIVERABLE)
reviewer_comments.docx                                 # User-supplied
```

**`output_dir/workflow_intermediates/` (intermediates):**
```
<short-title>_working.md                               # Phase 0 manuscript markdown (scratch)
<short-title>_appendix_S{X}_working.md                 # Per-appendix scratch
<short-title>_comments_parsed.md                       # Phase 0 raw structured comments
<short-title>_reply_plan.md                            # Phase 3 of planning
<short-title>_analysis_specs/[id].md                   # Per-comment analysis specs
<short-title>_reply_draft.md                           # Phase 1 of drafting (markdown)
<short-title>_revised_marked.md                        # Phase 2 of drafting (markdown with markup)
<short-title>_appendix_S{X}_revised_marked.md          # Per-appendix markup
<short-title>_apply_report.md                          # Per-edit application status
<short-title>_reply_state.json                         # State tracking
```

`R{N}` is the revision round number (1, 2, ...). The state JSON's `output_dir` and `support_dir` fields are authoritative.

---

## Design Principles

1. **Skills remain independent.** Each skill can be invoked directly. The orchestrator adds coordination, not new logic.

2. **Front-load the user's input.** All `AskUserQuestion` prompts happen during planning Phase 2. Drafting runs without interruption.

3. **Markdown throughout.** All creative work stays in `.md`. The `.docx` is produced only at the end of drafting.

4. **Tracked changes onto the user's working copy.** Manuscript and appendix `.docx` files are user-supplied byte-identical copies of the originals (`<original>_revised.docx`); the drafting skill applies `<w:ins>` / `<w:del>` / `<w:comment>` markers in place via OOXML manipulation. Originals are never overwritten; the manuscript is never re-rendered from markdown.

5. **Native Word comments for tags.** `[R{N}-C{N}: ...]` and `[EC-N: ...]` markers render in the comments pane, not as inline body text.

6. **Reply doc rendered fresh in TNR-black.** The reply doc has no original, so it's rendered from markdown with Times New Roman 11pt and black text on every run.

7. **Outputs split: deliverables top-level, intermediates in `workflow_intermediates/`.** The state JSON's `output_dir` (deliverables) and `support_dir` (`<output_dir>/workflow_intermediates/`) are authoritative. No new top-level subfolder.

8. **State is the source of truth.** Per-comment status drives orchestration decisions. Targeted re-entry is possible because state knows what's drafted and what isn't.

9. **Non-destructive versioning.** Every intermediate file is preserved. The plan, the markdown reply, and the manuscript markup are all kept; the .docx pair can be re-rendered any time. Each revision round increments `R{N}` in the filename.

---

## Invocation Patterns

This skill triggers when the user says things like:

- "Address the reviewer comments on [manuscript]"
- "Respond to the reviewers"
- "Run the reviewer-reply pipeline"
- "Where are we on the reply?" / "Status of the [paper] reply"
- "Redraft my reply to R{N}-C{N}"
- "I ran the analysis for [comment-id], here are the results"
- "Resume the reply workflow"
- "Build the final reply docx"
- "Finalize the reviewer response"

---

## Integration

This skill orchestrates:
- `skills/simple/reviewer-reply-planning/SKILL.md`: for inventory, classification, triage, analysis bridge
- `skills/simple/reviewer-reply-drafting/SKILL.md`: for reply drafting, markup application, .docx rendering

It also coordinates with:
- `skills/simple/manuscript-builder/SKILL.md`: invoked by the drafting skill for .docx rendering
- `skills/simple/analysis-planning/SKILL.md`: receives analysis specs from the planning skill when the user selects "Run the analysis"
- `skills/workflows/manuscript-pipeline/SKILL.md`: if the manuscript was originally produced by `skills/workflows/paper-research/SKILL.md`, the YAML frontmatter is read for journal context

It reads the `SKILL.md` of each component skill as needed.

---

## Quality Gates

Before declaring `current_phase: "finalized"`:

1. **All comments accounted for.** No comments in `auto_proposed`, `awaiting_input`, `awaiting_analysis`, or `needs_revision`. Deferred comments are listed at the top of the reply doc as a note (or surfaced separately for the user to handle).
2. **Reply doc renders cleanly.** No raw `~~`, `++`, or `[CITE: ...]` placeholders.
3. **Manuscript & appendix .docx render cleanly.** Native `<w:ins>` / `<w:del>` revision marks are present in `word/document.xml`; native `<w:comment>` entries in `word/comments.xml` for every `[R#-C#: ...]` / `[EC-N: ...]` marker in the source markup.
4. **Original formatting preserved.** Manuscript & appendix `*_revised.docx` retain the original's section count, page setup, styles, fonts, embedded images, and reference list formatting. The applier validator checks structural fingerprints against the original.
5. **Reply doc TNR-black.** Validator confirms every `<w:rFonts>` is Times New Roman and every `<w:color>` value is `000000` or `auto`. No exceptions for headings, hyperlinks, or comments.
6. **All edits accounted for.** `_apply_report.md` shows zero failed edits (or any failures have been hand-applied and acknowledged).
7. **Outputs in the right places.** Final `.docx` deliverables sit at `state.metadata.output_dir` (top level); intermediates at `state.metadata.support_dir` (`workflow_intermediates/`). Never a new top-level subfolder.
8. **Cover letter is appropriate.** If the editor had substantive concerns, the cover letter has the executive-summary opening; otherwise the standard short letter is used.
9. **Journal target consistency.** The reply doc and the manuscript both reflect the same `journal_target` from the original YAML frontmatter.
