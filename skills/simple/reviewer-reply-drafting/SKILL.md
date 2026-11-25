---
name: reviewer-reply-drafting
description: |
  Drafts the final reviewer reply document and applies tracked-change edits to the manuscript, given a frozen plan from reviewer-reply-planning. Use this skill whenever the user mentions: drafting the reply to reviewers, building the response document, applying tracked changes from the reply plan, finalizing the reviewer response, or rendering the revised manuscript with tracked changes. Also trigger when users say "draft the reply now", "build the response doc", or "apply the planned edits to the manuscript". Requires a [title]_reply_plan.md as input: if no plan exists, route to reviewer-reply-planning first. Produces two .docx outputs (reply doc + revised manuscript with tracked changes) via manuscript-builder. Supports targeted re-entry on individual comments without redrafting the whole reply.
cost: medium
---

# Reviewer Reply: Drafting Skill

Phase 4 of the reviewer-reply pipeline. Consumes a frozen plan from `skills/simple/reviewer-reply-planning/SKILL.md`, produces the reviewer reply markdown and the manuscript markup, then renders both as .docx via `skills/simple/manuscript-builder/SKILL.md`.


## Required references: load before drafting

- `conventions/voice.template.md`: base writing voice
- `conventions/reply-format.template.md`: reviewer-response conventions
- `conventions/manuscript-format.template.md`: for any manuscript inserts/edits
- `conventions/research.md`: source-faithfulness contract for any cite work

Load these before drafting any reply text or manuscript edit.

---
## Overview

```
INPUT: [title]_reply_plan.md  (from reviewer-reply-planning)
       [title]_working.md     (manuscript in markdown)
        ↓
Phase 1: Per-reviewer reply drafting (parallel sub-agents)
   - one agent per reviewer; each loads conventions/reply-format.template.md
   - drafts cover letter to editor (orchestrator does this in main context)
   - drafts comment-by-comment replies
        ↓
Phase 2: Manuscript markup application
   - apply all confirmed edits as ~~/++ markup, end-to-beginning
   - tag every edit with [R{N}-C{N}: ...]
        ↓
Phase 3: Render (USER CHECKPOINT, mode confirmation)
   - reply doc → manuscript-builder (clean mode) → [title]_response_to_reviewers.docx
   - manuscript → manuscript-builder (tracked mode) → [title]_revised_tracked.docx
        ↓
Phase 4: Iteration (USER CHECKPOINT)
   - the user reviews the .docx pair
   - targeted re-entry on individual comments via state JSON
        ↓
OUTPUT: [title]_response_to_reviewers.docx
        [title]_revised_tracked.docx
        [title]_reply_draft.md          (markdown source for reply doc)
        [title]_revised_marked.md       (manuscript .md with markup)
```

---

## Skills this loads

- `conventions/reply-format.template.md`: voice, length conventions, quote-the-insertion pattern
- `conventions/manuscript-format.template.md`: base writing voice for `++inserted text++` blocks
- `conventions/research.md`: for any citations being added in inserts or replies
- `skills/simple/manuscript-builder/SKILL.md`: for final .docx rendering

---

## Phase 0: Plan Validation

Before drafting, verify the plan is ready:

1. **Plan file exists**: `[title]_reply_plan.md` from `skills/simple/reviewer-reply-planning/SKILL.md`
2. **All input-required comments have direction**: no comments still tagged `needs_user` without `user_direction` set
3. **Awaiting-analysis comments are flagged**: for any comment with `status: awaiting_analysis`, check if the user has provided the analysis result. If not, list those comments and ask the user whether to draft around them (skipping for now) or pause until results are in.
4. **Manuscript .md exists**: `[title]_working.md` (or whatever the planning skill saved). If not, regenerate via pandoc from the original .docx.

If validation fails, surface the issue and route back to `skills/simple/reviewer-reply-planning/SKILL.md` for the missing pieces. Do not proceed.

---

## Phase 1: Per-Reviewer Reply Drafting

### Cover letter (main context, not a sub-agent)

The cover letter is short and the orchestrator drafts it directly. Read the editor's comment block from the plan:

- **No substantive editor concerns**: use the standard cover letter template from `conventions/reply-format.template.md`
- **Substantive editor concerns**: draft the executive-summary opening described in the same convention, drawing on `user_direction` from Phase 2 of planning if the user set the framing during triage

The cover letter goes at the top of `[title]_reply_draft.md`, before the editor-comment block.

### Per-reviewer sub-agents (parallel)

Launch one `Agent` (subagent_type: `general-purpose`) per reviewer. Editor comments are handled in main context (usually short, and the editor block sits above the reviewer blocks anyway).

### Sub-agent prompt template

```
You are drafting reply text for one reviewer's comments on a manuscript revision.
A frozen plan with proposed replies and edits has already been produced. Your
job is to expand those into the final reply text in the lab's voice.

## Required reading (do this first, in order)
- conventions/reply-format.template.md: voice, length conventions, quote-the-insertion
- conventions/manuscript-format.template.md: base writing voice
- conventions/research.md: never hallucinate citations (only relevant if your
  comments include ADD-CITE or DEFEND with literature)

## Your reviewer
Reviewer [N]

## Plan entries for this reviewer
[Filter [title]_reply_plan.md to entries where reviewer == N. Pass the full
plan entries: id, classification, source_excerpt, manuscript_anchor,
proposed_edit, proposed_reply, user_direction, flags]

## Manuscript context
[Full manuscript .md text: the inserted text in your replies must match
this voice exactly]

## Task

For each plan entry in your list, produce the final reply block:

1. Start with the comment header line:
   - `R{N}-C{N}:` followed by the reviewer's actual comment text (paraphrased
     if very long, but verbatim is preferred: quote the source_excerpt from
     the plan)

2. Follow with a `REPLY:` block. Length and content must match the
   classification: see length conventions in conventions/reply-format.template.md:

   - TRIVIAL: 1 to 4 words ("done", "corrected", "removed", "added")
   - CLARIFY: 1 sentence; if new manuscript text was added, QUOTE that text
   - ADD-CITE: 1 sentence; if a specific citation was added, name it briefly
   - DEFEND (concise): 1 to 3 sentences explaining the misread or alt framing
   - DEFEND (substantive): 1 to 3 paragraphs with reasoning, evidence, and any
     related improvements made; cite literature when relevant
   - RESTRUCTURE / NEW-ANALYSIS / JUDGEMENT: expand user_direction into a
     full reply in the lab's voice: the substance is the user's, you tighten and
     match voice

3. Voice rules (from conventions/reply-format.template.md):
   - First-person plural ("We added...")
   - Past tense for changes already made
   - No filler thanks unless the reviewer's input was substantive
   - No apologies for the original manuscript
   - No "We will...", only "We have..."
   - Quote inserted manuscript text when CLARIFY produced new text

4. Cross-references: if a comment was already addressed in an earlier reply
   in your list, use cross-reference phrasing rather than repeating
   ("Please see our response to R{N}-C{N} above"). The orchestrator will
   resolve these references across reviewers if needed.

5. Citations: if you reference a paper in the reply, it must be either:
   - A citation already in the manuscript (verify by searching the manuscript text)
   - A new citation that the planning skill verified (look at the proposed_edit
     to see if a new ref was already added there)
   - If you need a citation that wasn't pre-verified, flag with [CITE: needs
     verification, topic: X] and DO NOT invent the reference

## Output format

For each comment, produce the formatted block:

```
R{N}-C{N}: [comment text]

REPLY: [reply text]

```

Stack them in order of comment ID. Do NOT include the ## Reviewer header: the
orchestrator adds that. Do NOT include the cover letter: orchestrator handles
that too.

## Quality bar
- Every comment in your input list has a corresponding reply
- Length matches class: no over-replying to typos, no under-replying to
  substantive concerns
- Voice is consistent with conventions/manuscript-format.template.md throughout
- Cross-references resolve within your reviewer's list
- No hallucinated citations
```

### Merging sub-agent results

Combine the cover letter + editor block + reviewer 1 block + reviewer 2 block (and so on) into a single document with the structure from `conventions/reply-format.template.md`:

```markdown
# Response to Reviewers: [Manuscript Title]

[Cover letter to editor]

---

## Editor Comments

EC-1: [comment]
REPLY: [reply]

---

## Reviewer 1

[Reviewer 1's overview reply if warranted]

R1-C1: [comment]
REPLY: [reply]

R1-C2: [comment]
REPLY: [reply]

[... etc ...]

---

## Reviewer 2

[etc.]
```

Verify before saving:
1. **Coverage**: every plan entry produced a reply block
2. **Length variance**: TRIVIAL replies are short; substantive defenses are paragraphs
3. **Cross-references resolve**: every "see above" points to an actual prior reply
4. **No bare `[CITE: ...]` placeholders** unless explicitly accepted by the user: surface any unresolved ones
5. **Voice consistency**: read 3 to 5 random reply blocks; do they sound like the example replies in `conventions/reply-format.template.md`?

Save as `[title]_reply_draft.md`.

---

## Phase 2: Manuscript Markup Application

### The markup convention

Same as `skills/workflows/expert-review/SKILL.md` and `skills/simple/manuscript-builder/SKILL.md`:
- `~~deleted text~~`
- `++inserted text++`
- `[R{N}-C{N}: brief tag]`

The `[R{N}-C{N}: ...]` marker links the manuscript edit back to the comment that motivated it. This is what makes the tracked-changes .docx and the reply doc stay in lockstep.

### Application order

Apply all edits **end-to-beginning** through the manuscript .md. This avoids character-offset drift that would invalidate later edits.

### Process

1. Load `[title]_working.md` (manuscript markdown)
2. Collect all `proposed_edit` strings from the plan, sorted by manuscript anchor in reverse order (last paragraph first)
3. For each edit:
   - Locate the target text in the manuscript (the deletion portion of the markup must match existing text exactly)
   - Replace with the markup string
   - If the target text doesn't match exactly, flag the edit for the user's review (the planning skill should have caught this, but the manuscript may have been edited between planning and drafting)

4. Output: `[title]_revised_marked.md`

### Edits that don't change manuscript text

Some plan entries (especially DEFEND where the reviewer misread something already in the manuscript, or comments that resulted in only a reply with no manuscript change) have an empty `proposed_edit`. Skip these in Phase 2: they only contribute to the reply doc.

### Preserve YAML frontmatter

The original frontmatter in `[title]_working.md` is preserved verbatim, except:
- `revision_number`: increment by 1
- `workflow_state`: set to `revised_r{N}` (where N is the new revision_number)
- `last_modified`: current timestamp

The frontmatter is what `skills/simple/manuscript-builder/SKILL.md` reads for journal target, citation style, etc. Do not modify those fields here: they came from the original manuscript and reflect the journal's requirements.

---

## Phase 3: Render to .docx

### Render conventions (NON-NEGOTIABLE DEFAULTS)

The drafting skill produces three .docx deliverables, all under the same conventions:

1. **Manuscript and each appendix (preserve original formatting):** the user provides byte-identical copies of the originals named `<original>_revised.docx`. The drafting skill applies `<w:ins>` / `<w:del>` revision marks and `<w:comment>` entries **directly into those copies**: every other byte of the file is left untouched. This preserves journal-specific fonts, styles, page setup, embedded images, table layouts, citation formatting, and figure references that would be lost if rendered fresh from markdown. **Never overwrite the originals; never render the manuscript or appendix from markdown.**
2. **Comment markers:** `[R{N}-C{N}: ...]` and `[EC-{N}: ...]` tags become **native Word comments** anchored at the edit (`<w:commentRangeStart>`, `<w:commentRangeEnd>`, `<w:commentReference>`, with the comment text in `word/comments.xml`).
3. **Author attribution:** all `<w:ins>` / `<w:del>` / `<w:comment>` elements are attributed to the corresponding author's full name (from `state.metadata.track_change_author`, which defaults to the corresponding author from the manuscript YAML / author list).
4. **Reply doc (rendered fresh, no original):** `<title>_response_to_reviewers_R{N}.docx` is built from `<title>_reply_draft.md`. Apply Times New Roman 11pt, black text everywhere (including headings: Python-docx heading styles default to Calibri / Word-blue and must be overridden), no other markup. This file has no original to preserve, so the renderer of record is `tools/tracked-changes/render_tracked_docx.py` in `clean` mode.

The two scripts shipped with this skill:

| Script | Purpose | Used for |
|---|---|---|
| `tools/tracked-changes/apply_tracked_changes.py` | Surgically inserts `<w:ins>` / `<w:del>` / `<w:comment>` into a user-supplied `<original>_revised.docx`, preserving all other formatting | Manuscript and each appendix |
| `tools/tracked-changes/render_tracked_docx.py` | Renders a markdown file to a fresh `.docx` (TNR-black, comments-pane-aware) | Reply doc only |

Both validate their output and fail the build if anything goes wrong.

### Output location (NON-NEGOTIABLE)

- **Final deliverables** (`<original>_revised.docx` with tracked changes; `<title>_response_to_reviewers_R{N}.docx`) save to **the source manuscript's directory**: the same folder as the original `.docx`.
- **Intermediate / supporting files** (everything from planning + drafting that isn't a final deliverable: `_working.md`, `_comments_parsed.md`, `_reply_plan.md`, `_reply_draft.md`, `_revised_marked.md`, `_appendix_S{X}_revised_marked.md`, `_reply_state.json`, `_analysis_specs/`) save to **`<source-folder>/workflow_intermediates/`**, which the planning skill creates if it doesn't exist.
- Never create a new top-level subfolder for the revision.

If the source manuscript path is unknown, ask the user where the deliverables should go (and confirm the `<original>_revised.docx` working copies exist) before rendering.

### User checkpoint: render mode

Skip the question entirely if the state JSON already has `render_mode: "tracked"` (the default after the planning skill runs).

Otherwise, and only when the user has signalled they want something other than the default, ask:

```
AskUserQuestion(
  questions: [{
    header: "Render mode",
    question: "How should the revised manuscript be rendered? Tracked changes is the standard for journal submission and is the default.",
    multiSelect: false,
    options: [
      {
        label: "Tracked changes (default)",
        description: "Native Word tracked changes (<w:ins>/<w:del>) attributed to the corresponding author, with [R#-C#: ...] markers as native Word comments. Times New Roman, black text throughout. This is what most journals expect on resubmission."
      },
      {
        label: "Tracked + clean (resubmission pair)",
        description: "Render both versions. Use when the journal requires a clean revised version alongside the tracked-changes version."
      },
      {
        label: "Highlight mode (visual review only)",
        description: "Red-strikethrough deletions and yellow-highlighted insertions, comment tags as inline bracketed text. Useful for offline visual review; do NOT submit this version to a journal."
      },
      {
        label: "Clean only",
        description: "Strip all markup. Use only when no tracked-changes version is needed (rare for revisions)."
      }
    ]
  }]
)
```

### Invoke the renderers

Three render calls (one per deliverable):

**1. Apply tracked changes to the manuscript copy**
```bash
python tools/tracked-changes/apply_tracked_changes.py \
    --revised <src>/<original>_revised.docx \
    --markup  <src>/workflow_intermediates/<title>_revised_marked.md \
    --author  "<corresponding author full name>" \
    --report  <src>/workflow_intermediates/<title>_apply_report.md
```

The script:
- Opens the user's `<original>_revised.docx` (left byte-identical by the user / Phase 0).
- Parses every `~~deletion~~`, `++insertion++`, `[R#-C#: tag]` from the markup file along with surrounding context (~50 chars).
- For each edit, locates the anchor in the docx body (concatenating run text per paragraph), splits the run(s) at the right offsets, wraps the deletion in `<w:del><w:r><w:delText>...</w:delText></w:r></w:del>` (inheriting the run's `<w:rPr>`), inserts `<w:ins>` containing a new run with the inserted text and matching formatting.
- Adds `<w:commentRangeStart>` / `<w:commentRangeEnd>` / `<w:commentReference>` markers and registers the comment text in `word/comments.xml`.
- Writes the result back to the same path (the user's working copy gains the tracked changes).
- Emits an `_apply_report.md` listing every edit applied, every edit deferred (anchor ambiguous), and every edit failed (anchor not found).

**2. Apply tracked changes to each appendix copy**

Same invocation, with `<src>/<appendix>_revised.docx` and the appendix markdown:

```bash
python tools/tracked-changes/apply_tracked_changes.py \
    --revised <src>/<appendix>_revised.docx \
    --markup  <src>/workflow_intermediates/<title>_appendix_S{X}_revised_marked.md \
    --author  "<corresponding author full name>"
```

**3. Render the reply doc fresh**
```bash
python tools/tracked-changes/render_tracked_docx.py \
    <src>/workflow_intermediates/<title>_reply_draft.md \
    <src>/<title>_response_to_reviewers_R{N}.docx \
    --mode clean \
    --author "<corresponding author full name>" \
    --title "Response to Reviewers"
```

The reply doc has no original to preserve, so it's rendered fresh in Times New Roman 11pt black.

### Render quality checks

Run after every render. The scripts emit warnings; the orchestrator must surface them.

1. **Native tracked changes present**: unzip the manuscript / appendix `.docx` and confirm `<w:ins>` and `<w:del>` elements exist in `word/document.xml`. A render with zero revision marks for a manuscript that has edits in the markup is a failed render.
2. **Comment markers landed as Word comments**: `word/comments.xml` contains one `<w:comment>` per `[R#-C#: ...]` / `[EC-N: ...]` marker in the source.
3. **No anchor mismatches**: review `_apply_report.md`. Every edit should land. Surface unresolved edits to the user with surrounding context.
4. **Original formatting preserved**: for the manuscript / appendix .docx: byte size and structure should be very close to the original (typically +5 to 15% from the inserted XML); section count, page setup, and styles unchanged. The applier validator checks this.
5. **Reply doc: TNR-black**: every `<w:rFonts>` is Times New Roman; every `<w:color>` is `000000` or `auto`.
6. **Files written to correct locations**: manuscript & appendix `_revised.docx` files at the source-folder top level; reply doc also at top level; intermediates and reports in `workflow_intermediates/`.
7. **Post-render QA scan clean**: `tools/tracked-changes/apply_tracked_changes.py` runs an automated scan after every render and reports findings to stderr and to `_apply_report.md`. The scan catches issues that have shipped in past runs: doubled adjacent letters at insertion boundaries (`OO`, `FF`, `CC`), stranded lowercase letters before insertions, missing spaces between word-and-paren or word-and-capital, repeated tokens, and font drift on `<w:ins>` runs. **Any QA finding must be resolved before declaring the render complete**: these are usually localized renderer artefacts that surgical XML edits can fix, but they need a human pass to confirm the fix matches the source markdown's intent.

---

## Phase 4: Iteration

### User checkpoint: review the .docx pair

Present the outputs to the user:

```
Reply draft is ready. Two outputs:
- [title]_response_to_reviewers.docx: the reply letter
- [title]_revised_tracked.docx: manuscript with tracked changes

Review both and let me know:
- Comments where the reply text needs adjustment
- Manuscript edits that need refinement
- Comments where you want to escalate the response (e.g., turn a CLARIFY into a DEFEND, or add more substance to a defense)
- Anything missing
```

### Targeted re-entry

The user can request changes to specific comments without redrafting the whole reply. The state JSON tracks per-comment status (`auto_proposed | confirmed | drafted | finalized | needs_revision`). On re-entry:

1. The user names the comments to revise (e.g., "Redo R1-C12 and R2-C5; the rest is good")
2. Drafting skill reads those plan entries, optionally re-classifies if the user provides new direction, and re-runs Phase 1 only for those comments
3. Phase 2 re-applies the new markup for those comments (rolling back the old markup if it was already in `_revised_marked.md`)
4. Phase 3 re-renders the .docx pair

This avoids redoing the whole reply when only a few comments need adjustment.

### Convergence

Most reply drafts converge in 1 to 2 iterations. If iteration 3+ is still surfacing major changes, route back to `skills/simple/reviewer-reply-planning/SKILL.md`: the underlying issue is probably classification, not drafting.

---

## File outputs

| File | Location | Purpose |
|---|---|---|
| `<original>_revised.docx` | source folder (top level) | Manuscript with native tracked changes, applied onto the user's working copy |
| `<appendix>_revised.docx` | source folder (top level) | Each appendix with native tracked changes |
| `<title>_response_to_reviewers_R{N}.docx` | source folder (top level) | Reply letter, rendered fresh from markdown |
| `<title>_reply_draft.md` | `workflow_intermediates/` | Markdown source for the reply doc |
| `<title>_revised_marked.md` | `workflow_intermediates/` | Manuscript markdown with inline markup (drives the applier) |
| `<title>_appendix_S{X}_revised_marked.md` | `workflow_intermediates/` | Per-appendix markup |
| `<title>_apply_report.md` | `workflow_intermediates/` | Per-edit application status from `tools/tracked-changes/apply_tracked_changes.py` |
| `<title>_reply_state.json` | `workflow_intermediates/` | State JSON |

`R{N}` is the revision round number (1, 2, ...). For first revision, omit `R{N}` only if the user explicitly asks for unversioned filenames.

The source folder stays clean: only the user's existing files (originals, reviewer comments) plus the three final deliverables. Everything else lives in `workflow_intermediates/`.

---

## Invocation patterns

This skill triggers when the user says:

- "Draft the reply now"
- "Apply the planned edits to the manuscript"
- "Build the response document"
- "Render the revised manuscript with tracked changes"
- "Finalize the reviewer response"
- "Build the final reply docx"

If chained from `skills/workflows/reviewer-reply-pipeline/SKILL.md`, this is the second-stage skill that runs after `skills/simple/reviewer-reply-planning/SKILL.md` and produces the final outputs.

---

## Integration

- **Upstream:** `skills/simple/reviewer-reply-planning/SKILL.md`: consumes the frozen `[title]_reply_plan.md`
- **Downstream:** `skills/simple/manuscript-builder/SKILL.md`: for both .docx renders
- **Cross-cuts:** None, this skill is self-contained once the plan is in place

---

## Key principles

1. **Plan-driven.** The plan is the contract. The drafter expands plan entries into final text, but does not make new content decisions.
2. **Voice fidelity.** Every reply and every manuscript insert must read like the lab. Sub-agents load the voice guides; the orchestrator spot-checks the merged output.
3. **Tracked changes applied to the user's working copy of the original.** Manuscript and appendix `.docx` files are user-supplied byte-identical copies of the originals (`<original>_revised.docx`); the drafting skill surgically inserts `<w:ins>` / `<w:del>` / `<w:comment>` markers into them. The originals are never overwritten and the manuscript is never re-rendered from markdown: that destroys the journal-specific formatting.
4. **Native Word comments for tags.** `[R{N}-C{N}: ...]` and `[EC-N: ...]` markers render in the comments pane, not as inline body text.
5. **Times New Roman, black text** in the reply doc (which is rendered fresh): every paragraph, every heading, every run. The manuscript & appendix inherit the original's formatting (also typically Times New Roman black, but the script doesn't override the source).
6. **Outputs split between source folder and `workflow_intermediates/`.** Final deliverables (the `*_revised.docx` files and the reply doc) at the source-folder top level. Everything intermediate (markdown sources, plan, state JSON, apply reports, analysis specs) in `<source-folder>/workflow_intermediates/`. Never a new top-level subfolder.
7. **Lockstep reply ↔ manuscript.** Every `[R{N}-C{N}: ...]` in the manuscript markup corresponds to a comment ID in the reply doc.
8. **Targeted iteration.** Re-entry on individual comments without redoing the whole draft. State JSON tracks per-comment status.
9. **No hallucinated citations.** Every reference in either the reply or the manuscript edit was verified at planning time, or marked as a placeholder for verification.
