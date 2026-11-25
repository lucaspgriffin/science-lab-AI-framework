---
name: manuscript-pipeline
description: |
  Orchestrates the end-to-end manuscript workflow from research through review to submission-ready .docx. Chains paper-research, expert-review, and manuscript-builder skills in sequence. Use this skill when the user wants to run the full pipeline, resume from a checkpoint, or coordinate between research, review, and formatting phases. Trigger phrases include: "run the full manuscript workflow", "where are we in the pipeline", "start manuscript review", "run another review round", "build the final docx", or "finalize the manuscript". The orchestrator manages state, tracks completion, and coordinates handoffs between skills. Each component skill remains independently usable.
cost: heavy
---

# Manuscript Pipeline Orchestrator

Lightweight workflow coordinator for the end-to-end manuscript lifecycle. Chains three primary skills in a managed sequence while keeping each independently usable.


## Required references: load before orchestrating

Load from `conventions/`:
- `conventions/voice.template.md`: base writing voice
- `conventions/manuscript-format.template.md`: manuscript document structure
- `conventions/research.md`: citation and source rules

The pipeline orchestrator should propagate these to each phase skill it dispatches.

---
## Overview

The pipeline coordinates three skills:

1. **paper-research** (Phases 0 to 7): outputs `.md` manuscript draft with YAML frontmatter
2. **expert-review** (Phases 1 to 4, iterative): outputs `.md` with inline markup edits
3. **manuscript-builder**: outputs final `.docx` for journal submission

```
paper-research -> manuscript_draft.md
        |
        v
expert-review (round 1) -> manuscript_reviewed_r1.md
        |  (user reviews, accepts/rejects changes)
        v
expert-review (round 2) -> manuscript_reviewed_r2.md
        |  (user finalizes)
        v
manuscript-builder -> manuscript_submission.docx
```

The orchestrator does not duplicate skill logic: it manages checkpoints, state transitions, and user-driven iteration.

---

## State Management

The orchestrator tracks the manuscript lifecycle in a JSON state file saved alongside the manuscript.

```json
{
  "manuscript_id": "small-mammal-canopy-occupancy",
  "title": "Small-mammal occupancy along a canopy-cover gradient",
  "created": "2026-03-08T14:00:00Z",
  "current_phase": "review_r1",
  "files": {
    "reference_doc": "canopy_occupancy_reference_doc.md",
    "draft": "canopy_occupancy_draft.md",
    "review_r1": "canopy_occupancy_reviewed_r1.md",
    "review_r1_edits": "canopy_occupancy_review_r1_edits.md",
    "final_docx": null
  },
  "checkpoints": [
    {"phase": "research_complete", "timestamp": "2026-03-08T15:00:00Z", "notes": "Journal of Animal Ecology targeted"},
    {"phase": "draft_complete", "timestamp": "2026-03-08T16:30:00Z", "notes": "6850 words"},
    {"phase": "review_r1", "timestamp": "2026-03-08T18:00:00Z", "notes": "15 edits applied"}
  ],
  "metadata": {
    "journal_target": "Journal of Animal Ecology",
    "revision_number": 1,
    "word_count": 6850
  }
}
```

**State file location:** Saved in the same directory as the manuscript, named `[manuscript_id]_pipeline_state.json`.

**State file creation:** Automatically created after the first phase completes. Updated after each major phase.

---

## Entry Points

### 1. Run Full Pipeline from Start

**User says:** "Run the full manuscript workflow for my paper on [topic]"

**Actions:**
1. Trigger `paper-research` Phase 0 (journal targeting)
2. Pause for user confirmation on journal profile and paper plan
3. Continue through Phases 1 to 7, outputting `[title]_draft.md`
4. Create state file with `current_phase: "draft_complete"`
5. Ask: "Manuscript draft is ready. Would you like to send it for expert review?"

### 2. Start Expert Review

**User says:** "Review this manuscript" or "Run expert-review on the manuscript"

**Actions:**
1. Locate the latest .md manuscript (from state file or user-specified path)
2. Read YAML frontmatter for context (journal profile, paper plan)
3. Trigger `expert-review` Phase 1 (panel assembly)
4. Continue through Phases 2 to 4, outputting `[title]_reviewed_r1.md` plus edit summary
5. Update state: `current_phase: "review_r1"`, increment `revision_number`
6. Present: "Review round 1 complete. [N] edits applied. Review the inline markup and let me know when you're ready for another round or to finalize."

### 3. Run Another Review Round

**User says:** "Run another review round" or "Second round of reviews"

**Actions:**
1. Load the current manuscript (user's version after accepting/rejecting changes)
2. Detect revision number from frontmatter or state file
3. Trigger `expert-review` Phases 1 to 4 with fresh reviewer panel (or same panel if user prefers)
4. Output `[title]_reviewed_r[N].md`
5. Update state: increment phase counter
6. If Round 3+, note: "This is round [N]. If major issues persist, there may be structural concerns that individual edits cannot address."

### 4. Build Final Manuscript

**User says:** "Convert to Word" or "Build the final docx" or "Finalize the manuscript"

**Actions:**
1. Load the latest .md manuscript
2. Verify no unresolved `[CITE:]` or `[SOURCE NEEDED]` placeholders remain
3. Ask user: "Should I render this with inline markup visible (as highlights) or as a clean submission version?"
4. Trigger `manuscript-builder` with chosen mode
5. Output `[title]_[journal]_submission.docx`
6. Update state: `current_phase: "final"`
7. Present word count, citation count, and compliance summary

### 5. Check Status

**User says:** "Where are we?" or "What's the status of the manuscript?"

**Actions:**
1. Read state file
2. Display: current phase, last checkpoint, files generated, next recommended action
3. Offer options based on current phase

---

## Handoff Protocol

When passing control from one skill to the next:

1. **Verify output exists**: confirm the output file from the previous skill was saved successfully
2. **Validate .md structure**: check that YAML frontmatter is present and parseable
3. **Read frontmatter**: extract workflow_state, revision_number, journal_target
4. **Update frontmatter**: increment revision_number, update workflow_state and last_modified
5. **Invoke next skill**: pass the file path and any extracted context

### Frontmatter Updates at Each Transition

| Transition | workflow_state | revision_number |
|-----------|---------------|-----------------|
| Phase 7 complete | `draft` | 0 |
| Expert review R1 complete | `review_r1` | 1 |
| Expert review R2 complete | `review_r2` | 2 |
| Final docx built | `final` | unchanged |

---

## Iteration Model

The pipeline supports user-driven iteration between expert-review rounds:

```
draft.md -> expert-review R1 -> reviewed_r1.md
                                    |
                                    v
                          user reviews markup
                          accepts/rejects changes
                                    |
                                    v
                          edited_r1.md (clean version)
                                    |
                                    v
                          expert-review R2 -> reviewed_r2.md
                                    |
                                    v
                          user reviews markup
                                    |
                                    v
                          ... (repeat as needed)
                                    |
                                    v
                          manuscript-builder -> submission.docx
```

**Convergence signal:** Each round should produce fewer edits than the previous round. If Round 3+ still generates 10+ edits, flag to the user that structural revision may be needed rather than incremental edits.

**Version tracking:** All versions are preserved with revision suffixes. The user always has access to every intermediate version.

---

## File Naming Convention

```
[short-title]_draft.md                    # Phase 7 output
[short-title]_reviewed_r1.md              # Expert review round 1
[short-title]_review_r1_edits.md          # Edit summary for round 1
[short-title]_reviewed_r2.md              # Expert review round 2
[short-title]_[journal]_submission.docx   # Final manuscript
[short-title]_pipeline_state.json         # State tracking file
```

All files saved to the user's workspace folder.

---

## Design Principles

1. **Skills remain independent.** Each skill can be invoked directly without the orchestrator. The orchestrator adds coordination, not new logic.

2. **User drives iteration.** No automatic progression between phases. The user decides when to move forward, run another round, or finalize.

3. **Markdown throughout.** All creative work stays in .md format. The .docx is produced only at the end for submission.

4. **Clear state tracking.** The user always knows where they are in the pipeline and what the next step is.

5. **Non-destructive versioning.** Every intermediate file is preserved. Nothing is overwritten.

---

## Invocation Patterns

This skill should trigger when the user says things like:

- "Run the full manuscript workflow"
- "Start the manuscript pipeline for my paper on [topic]"
- "Where are we in the pipeline?" / "What's the status?"
- "Send this for expert review"
- "Run another review round"
- "Build the final docx" / "Finalize the manuscript"
- "Convert the manuscript to Word for submission"
- "Resume the workflow from where we left off"

---

## Integration

This skill orchestrates:
- `skills/workflows/paper-research/SKILL.md`: for Phases 0 to 7 (literature research through manuscript drafting)
- `skills/workflows/expert-review/SKILL.md`: for simulated peer review and inline markup revision
- `skills/simple/manuscript-builder/SKILL.md`: for final .md to .docx conversion

It reads the `SKILL.md` of each component skill as needed to understand phase requirements and outputs.
