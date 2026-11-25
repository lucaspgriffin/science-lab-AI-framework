---
name: reviewer-reply-planning
description: |
  Parses reviewer comments and a manuscript, classifies every comment by action type, and produces a triage plan with proposed edits and replies. Use this skill whenever the user mentions: addressing reviewer comments, planning a manuscript revision, classifying review feedback, triaging reviewer comments, building a reply plan, or starting the reviewer-reply workflow. Also trigger when users upload a manuscript .docx alongside a reviewer comments .docx and ask what to do with them. This skill produces a structured plan: it does NOT yet draft the final reply or apply edits to the manuscript. Use reviewer-reply-drafting next, or run the full reviewer-reply-pipeline. The planning step front-loads the user's input via AskUserQuestion on comments needing judgement (RESTRUCTURE, NEW-ANALYSIS, JUDGEMENT) so the drafting skill can run without further interruption.
cost: medium
---

# Reviewer Reply: Planning Skill

Phase 0 of the reviewer-reply pipeline. Takes a manuscript and a reviewer comments document, produces a triaged plan with one entry per comment: classification, proposed manuscript edit, proposed reply text, and (for input-required comments) the user's chosen direction.


## Required references: load before triaging

- `conventions/voice.template.md`: base writing voice
- `conventions/reply-format.template.md`: reviewer-response conventions
- `conventions/manuscript-format.template.md`: base voice for proposed edits and reply text
- `conventions/research.md`: citation rules (essential for ADD-CITE/DEFEND comments)

Load these before classifying or triaging comments.

---
## Overview

```
INPUT: manuscript.docx + reviewer_comments.docx
        ↓
Phase 0: Inventory
   - convert manuscript .docx → .md (pandoc)
   - parse comments .docx into structured list
   - assign comment IDs (E-C1, R1-C1, R2-C1, ...)
   - extract manuscript YAML frontmatter for journal context
        ↓
Phase 1: Classification (parallel sub-agents, one per reviewer)
   - tag each comment: TRIVIAL | CLARIFY | ADD-CITE | DEFEND | RESTRUCTURE | NEW-ANALYSIS | JUDGEMENT
   - draft proposed manuscript edit (as ~~/++ markup)
   - draft proposed reply text
        ↓
Phase 2: Triage (USER CHECKPOINT)
   - present full comment list with classifications
   - AskUserQuestion walks through every comment tagged
     RESTRUCTURE / NEW-ANALYSIS / JUDGEMENT
   - the user can also override classifications on auto-actionable comments
        ↓
Phase 3: Analysis bridge (only if the user selected "spawn analysis spec" on a comment)
   - generate spec compatible with skills/simple/analysis-planning
   - reply + edit are stubbed pending the user's analysis output
        ↓
OUTPUT: [title]_reply_plan.md  +  [title]_analysis_specs/[id].md (if any)
```

This skill stays in markdown throughout. The .docx is produced only by `skills/simple/manuscript-builder/SKILL.md` at the end of the drafting skill.

---

## Skills this loads

Read these before classifying:

- `conventions/reply-format.template.md`: comment taxonomy, length conventions, pushback heuristics
- `conventions/manuscript-format.template.md`: base voice for proposed edits and reply text
- `conventions/research.md`: verification rules for any new citation in ADD-CITE or DEFEND

If chained from `skills/workflows/manuscript-pipeline/SKILL.md` (i.e., the manuscript itself was produced by `skills/workflows/paper-research/SKILL.md`), also read the manuscript's YAML frontmatter for `journal_target`, `journal_profile`, and citation tier flags.

---

## Phase 0: Inventory

### Step 0.0: Locate working files (NON-NEGOTIABLE)

Before anything else, lock down the file layout. The drafting skill applies tracked changes directly to a **user-supplied copy** of the original `.docx` so all original formatting (fonts, styles, page setup, tables, embedded figures, references) is preserved byte-for-byte. The planning skill is responsible for confirming that copy exists.

For each input document (manuscript and each appendix), confirm:

| Role | Convention | Example |
|---|---|---|
| Original | `<name>.docx` | `gene_regulatory_dynamics.docx` |
| Working copy (gets tracked changes) | `<name>_revised.docx` | `gene_regulatory_dynamics_revised.docx` |
| Reviewer comments | `reviewer_comments.docx` (or similar) | `reviewer_comments.docx` |

If the `_revised.docx` copies don't exist, ask the user to create them with `cp` (or offer to do it via a shell command), and pause until they confirm. Do not silently render a fresh `.docx` from markdown: that destroys the journal-specific formatting the user has invested in.

Also create a `workflow_intermediates/` subfolder inside the source manuscript directory; **all** intermediate files this workflow produces (`_working.md`, `_comments_parsed.md`, `_reply_plan.md`, `_reply_draft.md`, `_revised_marked.md`, `_appendix_S{X}_revised_marked.md`, `_reply_state.json`, `_analysis_specs/`) live in `workflow_intermediates/`. Only the final deliverables (`<name>_revised.docx` with tracked changes; `<title>_response_to_reviewers_R{N}.docx`) sit at the source-folder top level.

```bash
# If the user hasn't already created the working copies, run e.g.:
cp "<src>/gene_regulatory_dynamics.docx" "<src>/gene_regulatory_dynamics_revised.docx"
cp "<src>/Appendix_S1.docx" "<src>/Appendix_S1_revised.docx"
mkdir -p "<src>/workflow_intermediates"
```

Record both `output_dir` (the source folder, where deliverables land) and `support_dir` (`<output_dir>/workflow_intermediates/`, where intermediates land) in the state JSON metadata.

### Step 0.1: Convert manuscript to markdown (for planning only)

The markdown version is **only used as scratch by the planning + drafting skills** to enumerate edits; it is not the deliverable. Convert the manuscript and any appendix to markdown using pandoc:

```bash
pandoc -f docx -t markdown "<src>/<name>.docx" -o "<src>/workflow_intermediates/<name>_working.md"
pandoc -f docx -t markdown "<src>/<appendix>.docx" -o "<src>/workflow_intermediates/<appendix>_working.md"
```

Preserve tables and figure references. Strip pre-existing tracked changes from the input.

If pandoc is not available, manually extract paragraphs preserving section structure. Heading levels matter: they are used as anchors when proposing edits.

If the manuscript is already `.md` (e.g., chained from `skills/workflows/manuscript-pipeline/SKILL.md`), skip pandoc and use the .md directly, but you still need a `_revised.docx` working copy to apply tracked changes to.

### Step 0.2: Parse the reviewer comments document

Reviewer comments documents vary in structure but typically include:
- An associate editor letter (sometimes just a thank-you, sometimes substantive)
- One block per reviewer, with a header like `Reviewer 1` or `Reviewer #1:`
- Comments either as a continuous prose block, a numbered list, or line-referenced bullet points

Extract into a structured list with these fields per comment:

```yaml
- id: R1-C1
  reviewer: 1
  source_excerpt: "Lines 48 to 67: Some more classical references should be included here."
  manuscript_anchor: "Introduction, P1, lines 48-67"
  raw_section: ""  # if reviewer organized comments under a section heading like "Methods"
```

Comment IDs follow the convention in `conventions/manuscript-format.template.md`:
- `EC-1, EC-2, ...` for editor comments
- `R1-C1, R1-C2, ...` for reviewer 1, in order of appearance
- `R2-C1, R2-C2, ...` for reviewer 2, etc.

If the reviewer wrote a high-level overview paragraph before getting into specifics, treat that as `R1-overview` (or `R2-overview`): many overviews don't require a comment-by-comment reply, but the planning skill still records them in case the reviewer flags an overarching concern.

### Step 0.3: Manuscript context

Extract YAML frontmatter from the .md if present:
- `title`, `journal_target`, `journal_profile`
- `revision_number` (will be incremented when drafting completes)
- citation tier markers (T2+): flag any that are still unresolved, since reviewers may have caught them

If no YAML frontmatter, infer from the manuscript text: title from H1, journal target from the cover letter or surrounding context if present.

### Step 0.4: Inventory output

Save `<src>/workflow_intermediates/[title]_comments_parsed.md` with the structured list of comments, IDs, anchors, and raw text. This is the working document Phases 1 to 3 operate on. All other intermediate outputs from this and downstream phases also save into `workflow_intermediates/`.

---

## Phase 1: Classification (parallel sub-agents, one per reviewer)

### Why sub-agents

Each reviewer has their own framing, register, and priorities. Classifying them independently:
- Prevents Reviewer 2's tone from biasing Reviewer 1's classifications
- Lets each agent dedicate full context to one reviewer's comments + the manuscript
- Runs in parallel: much faster than sequential

### Launching sub-agents

After the inventory is complete, launch one `Agent` (subagent_type: `general-purpose`) per reviewer (and one for the editor, if the editor has substantive comments). All run **in parallel**.

### Sub-agent prompt template

```
You are classifying reviewer comments for a manuscript revision. Your output will
become a plan that another skill drafts replies and manuscript edits from.

## Required reading (do this first)
- conventions/reply-format.template.md: comment taxonomy, length conventions, pushback heuristics
- conventions/manuscript-format.template.md: base voice for proposed edits and reply text
- conventions/research.md: never hallucinate citations

## Manuscript
[Full manuscript .md text]

## Manuscript YAML context (if available)
- Title: [title]
- Target journal: [journal name]
- Revision number: [N]
- Outstanding T2+ citations: [list]

## Your reviewer's comments
Reviewer [N]: [overview text if present]

[Comment list with IDs and raw text from Phase 0 inventory]

## Task

For EVERY comment in your list:

1. Classify into one of seven classes (see conventions/reply-format.template.md for
   definitions and examples):
   - TRIVIAL | CLARIFY | ADD-CITE | DEFEND | RESTRUCTURE | NEW-ANALYSIS | JUDGEMENT

2. Identify the manuscript location to edit (section + paragraph + sentence anchor),
   if the action involves a manuscript change.

3. Draft the proposed edit as inline markup:
   ~~deleted text~~ ++inserted text++ [R{N}-C{N}: brief tag]
   - Use the EXACT existing manuscript text in deletions
   - Inserted text must follow conventions/manuscript-format.template.md voice
   - For ADD-CITE: do NOT invent the citation. If you have a confirmed
     reference (verifiable per conventions/research.md Rule 1), include it.
     Otherwise, mark the citation slot as [CITE: needs verification, topic: X]
   - For DEFEND comments where the reviewer misread something already in the
     manuscript, the proposed edit may be empty (no manuscript change), and
     the reply just points the reviewer to the relevant text.
   - For RESTRUCTURE / NEW-ANALYSIS / JUDGEMENT: leave the proposed edit empty;
     these need the user's input before drafting.

4. Draft the proposed reply text.
   - Length must match the class: see length conventions in conventions/reply-format.template.md
   - For CLARIFY/ADD-CITE that produces new text, quote the new text in the reply
   - For DEFEND, give the actual reasoning, not just "we disagree"
   - For RESTRUCTURE / NEW-ANALYSIS / JUDGEMENT: produce a SHORT (1 to 2 sentence)
     description of the options the user faces, not a draft reply. The triage step
     will surface these for the user to choose between.
   - First-person plural ("We added..."), past tense for changes made,
     no apologies, no filler thanks.

5. Note any flags:
   - "needs_research": comment requires a literature search beyond your context
   - "needs_kb": comment touches a domain topic where you should consult
     the appropriate knowledge base before finalizing
   - "needs_user": classification is RESTRUCTURE / NEW-ANALYSIS / JUDGEMENT
   - "ambiguous_classification": you're not confident which class fits;
     surface in triage for the user to confirm

## Output format (one entry per comment, YAML-style)

```yaml
- id: R1-C1
  classification: TRIVIAL
  classification_confidence: high
  source_excerpt: "Line 72: extra 'a'."
  manuscript_anchor: "Introduction, P1, line 72"
  proposed_edit: |
    ~~a a fundamental~~ ++a fundamental++ [R1-C1: typo]
  proposed_reply: |
    REPLY: removed
  flags: []

- id: R1-C7
  classification: DEFEND
  classification_confidence: high
  source_excerpt: "Line 254: Consider replacing the reference here with a more recent study."
  manuscript_anchor: "Discussion, P3, line 254"
  proposed_edit: ""  # no manuscript change: reviewer misread
  proposed_reply: |
    REPLY: We aren't referring to canopy structure broadly, but its specific
    role in late-summer microhabitat selection, which the current citation addresses directly.
  flags: []

- id: R2-C12
  classification: NEW-ANALYSIS
  classification_confidence: high
  source_excerpt: "Could you compare community-level occupancy patterns between the two survey seasons?"
  manuscript_anchor: "Methods, multi-species occupancy section, P2"
  proposed_edit: ""  # pending the user's input
  proposed_reply: ""  # pending the user's input
  options_for_user:
    - "Run the comparison analysis (community-level occupancy metrics across seasons) and report in the supplement"
    - "Push back: season-specific patterns reflect different detection structures, not pure community differences"
    - "Defer: discuss with co-authors before deciding"
  flags: ["needs_user"]
```

DO NOT skip any comments. Every comment in your list gets an entry.
DO NOT invent reviewer comments not in the source.
DO NOT classify everything as TRIVIAL to save effort: read the taxonomy carefully.
```

### Merging sub-agent results

Combine all sub-agent outputs into a single ordered list, sorted: editor comments first, then R1, R2, etc., each in original order.

Verify:
1. **Coverage**: every comment from Phase 0 has a classification entry. Missing comments cause a relaunch of the sub-agent for that reviewer with the missing IDs flagged.
2. **Classification distribution**: sanity-check the counts. If one reviewer's comments are 100% TRIVIAL or 100% JUDGEMENT, the classifier may have drifted; review and consider relaunching.
3. **No invented references**: scan all `proposed_edit` and `proposed_reply` fields for any citations. Each must be either a verified existing manuscript citation, a `[CITE: ...]` placeholder, or a reference the user can verify.
4. **Manuscript anchors are real**: each anchor should correspond to an actual section/paragraph in the manuscript.

---

## Phase 2: Triage (user checkpoint)

### Step 2.1: Present the plan summary

Show the user a high-level summary first:

```
Comment classification summary:
- Editor: 1 substantive (EC-1)
- Reviewer 1: 14 comments (8 TRIVIAL, 3 CLARIFY, 2 DEFEND, 1 NEW-ANALYSIS)
- Reviewer 2: 19 comments (4 TRIVIAL, 6 CLARIFY, 3 ADD-CITE, 4 DEFEND, 2 RESTRUCTURE)

Comments needing your input: 3
- EC-1 (JUDGEMENT): Editor's question about novelty framing
- R1-C12 (NEW-ANALYSIS): Compare community-level occupancy across survey seasons
- R2-C5 (RESTRUCTURE): Reorder discussion to lead with the cross-stratum comparison

Comments where I'd like to confirm classification: 2
- R1-C8 (could be DEFEND or CLARIFY)
- R2-C14 (could be ADD-CITE or DEFEND)

Auto-actionable comments: 28
```

### Step 2.2: Walk through input-required comments

For each comment flagged `needs_user`, use `AskUserQuestion`. The question shows the reviewer's comment and the options the classifier surfaced; the user picks one or supplies their own direction.

Example invocation:

```
AskUserQuestion(
  questions: [{
    header: "R1-C12",
    question: "R1-C12 (NEW-ANALYSIS): \"Could you compare community-level occupancy
              patterns between the two survey seasons?\" How should we handle this?",
    multiSelect: false,
    options: [
      {
        label: "Run the comparison analysis (Recommended)",
        description: "Spawn an analysis spec for skills/simple/analysis-planning. You run it offline, then the drafting skill plugs in the result."
      },
      {
        label: "Push back: timepoint-specific networks reflect cell composition",
        description: "Defend by noting that topology differences confound with cell-type proportion shifts; the comparison isn't clean."
      },
      {
        label: "Concede: flag as a study limitation",
        description: "Acknowledge in the discussion that the comparison wasn't possible, and note it as a constraint for future work."
      },
      {
        label: "Defer: flag for offline discussion",
        description: "Mark as 'pending' in the plan; resolve with co-authors before continuing."
      }
    ]
  }]
)
```

For comments flagged `ambiguous_classification`, ask the user which class fits before drafting. Same `AskUserQuestion` pattern, options are the candidate classes.

For each user response, update the plan entry:
- If "Run the analysis": flag for Phase 3 (analysis bridge)
- If "Push back" / "Concede" / specific direction: reclassify to DEFEND or CLARIFY and store the user's direction in `user_direction` for the drafter to expand
- If "Defer": mark `status: deferred` and the user gets a list at the end of comments to resolve

### Step 2.3: Optional, spot-check auto-actionable comments

Offer the user a chance to skim the auto-actionable plan entries before drafting:

```
You've cleared the input-required comments. Want to spot-check any of the
auto-actionable comments before I hand off to the drafting skill? You can:
1. Skim the full plan ([title]_reply_plan.md)
2. Override classifications on specific comments
3. Proceed straight to drafting
```

This is optional but recommended for first-time use of the skill on a manuscript: it builds calibration.

---

## Phase 3: Analysis Bridge

For each comment where the user selected "Run the analysis" in Phase 2, generate a specification compatible with `skills/simple/analysis-planning/SKILL.md`.

### Spec format

`[title]_analysis_specs/[comment-id].md`:

```markdown
# Analysis Spec: [comment-id]

## Source comment
**[Reviewer]:** "[full comment text]"

## Manuscript context
- Section: [section]
- Anchor: [paragraph/lines]
- Existing analysis this relates to: [brief summary]

## What's needed
[1 to 2 paragraphs describing the analysis the reviewer is asking for]

## Suggested approach
[Concrete model / test / visualization, drawing on relevant statistical conventions
and any domain-specialist sub-agent (see `agents/_domain-specialist.template.md`) input]

## Inputs required
- Data file(s): [paths or descriptions]
- Variables: [list]
- Existing scripts: [if any from prior analyses on this manuscript]

## Expected output
- [figure/table/test result]
- Where it goes in the manuscript: [section, paragraph, replacing/extending what]

## Reply stub
The reviewer reply will report the analysis result. When the analysis is
complete, return to the drafting skill and provide:
- The figure/table/numerical result
- A 1 to 2 sentence summary of what was found
- The drafter will then produce the manuscript edit and final reply

## Status
- spawned: [timestamp]
- analysis_complete: false
```

### Stub plan entries

For each comment with a spawned analysis spec, the plan entry's `proposed_edit` and `proposed_reply` remain empty. The plan records:

```yaml
- id: R1-C12
  classification: NEW-ANALYSIS
  status: awaiting_analysis
  analysis_spec: "[title]_analysis_specs/R1-C12.md"
  user_direction: "Run topology comparison across timepoints"
```

The drafting skill knows to skip these entries on first pass and ask the user to come back when analyses are complete.

---

## Output: [title]_reply_plan.md

The final plan is a single markdown file with:

```markdown
# Reply Plan: [Manuscript Title]

## Summary
- Manuscript: [path]
- Reviewer comments: [path]
- Total comments: [N]
- Editor: [N]; Reviewer 1: [N]; Reviewer 2: [N]
- Auto-actionable: [N]
- Awaiting analysis: [N]
- Deferred: [N]
- Plan frozen: [timestamp]

## Editor cover letter direction
[If editor has overarching concerns, the user's chosen framing for the cover letter
opening goes here, set in Phase 2]

## Comments

[Full ordered list of plan entries, one per comment, using the YAML format
from Phase 1, with any Phase 2 updates merged in]
```

This file is the input to `skills/simple/reviewer-reply-drafting/SKILL.md`.

---

## File outputs

All planning-skill outputs save to **`<source-folder>/workflow_intermediates/`**, never to the source-folder top level (which is reserved for final deliverables).

```
<source-folder>/workflow_intermediates/[title]_working.md            # Phase 0: manuscript markdown (scratch)
<source-folder>/workflow_intermediates/[title]_appendix_S{X}_working.md   # Per-appendix scratch
<source-folder>/workflow_intermediates/[title]_comments_parsed.md    # Phase 0: raw structured comments
<source-folder>/workflow_intermediates/[title]_reply_plan.md         # Phase 3: final plan, ready for drafting
<source-folder>/workflow_intermediates/[title]_analysis_specs/[id].md  # Phase 3: one per spawned analysis
<source-folder>/workflow_intermediates/[title]_reply_state.json      # State JSON
```

The state JSON's `output_dir` (top-level deliverables) and `support_dir` (`workflow_intermediates/`) record both paths.

---

## Invocation patterns

This skill triggers when the user says:

- "Help me address the reviewer comments on [manuscript]"
- "I got reviews back, plan the revisions"
- "Triage these reviewer comments"
- "Classify the comments and tell me what needs my input"
- "Plan the response to reviewers"
- "Start the reviewer-reply workflow"

If chained from `skills/workflows/reviewer-reply-pipeline/SKILL.md`, this is Phase 0 to 3 of the full pipeline.

---

## Integration

- **Upstream:** `skills/workflows/manuscript-pipeline/SKILL.md` (if the manuscript was produced by `skills/workflows/paper-research/SKILL.md`): read its YAML frontmatter for journal context, citation tiers
- **Downstream:** `skills/simple/reviewer-reply-drafting/SKILL.md`: consumes the frozen plan, produces the reply doc and tracked-changes manuscript
- **Cross-cuts:** `skills/simple/analysis-planning/SKILL.md`: receives analysis specs from Phase 3 when the user chooses to run new analyses

---

## Key principles

1. **Front-load the user's input.** Every comment that needs the user's judgement is surfaced in Phase 2 via `AskUserQuestion`. The drafting skill should not need further interruption for content decisions.
2. **No hallucinated citations.** Any new reference must be verifiable per `conventions/research.md` Rule 1, or marked as a `[CITE: ...]` placeholder for verification.
3. **Length matches class.** TRIVIAL replies are 1 to 4 words. Substantive defenses get paragraphs. The classifier sets the ceiling for the drafter.
4. **Markdown throughout.** No .docx is touched until `skills/simple/manuscript-builder/SKILL.md` runs at the end of the drafting skill.
5. **Plan is frozen before drafting.** Once Phase 2 completes, the plan is the contract for the drafting skill. Re-entering the planning skill produces a new revision of the plan; the drafter never edits the plan itself.
