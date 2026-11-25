---
name: reply-writing
description: |
  Lightweight entry point for ad-hoc reviewer reply writing: drafting, refining, or editing reply text and manuscript inserts without running the full pipeline. Use whenever the user wants to draft a reply to a single reviewer comment, refine an existing reply, improve tone or push-back wording, check voice on a reply, write a manuscript insert prompted by a comment, or apply the lab's reply conventions. Trigger phrases: "draft a reply to this comment", "help me respond to R1-C3", "refine this reply", "check the voice on this reply", "edit my reviewer response", "tighten this reply". Lightweight counterpart to reviewer-reply-planning/drafting (multi-comment pipeline with parallel sub-agents and tracked-changes rendering). Route to reviewer-reply-planning for full triage, or reviewer-reply-drafting for end-to-end tracked-changes render.
cost: light
---

# Reviewer Reply Writing: Daily Entry Point

A lightweight skill for ad-hoc reply drafting, refinement, and editing. Loads the lab's voice, reply-format, manuscript-format, research-integrity, and sentence conventions, then helps draft or edit reply text and matching manuscript inserts in markdown.

This is the daily working skill for reply prose. It is the counterpart to `reviewer-reply-planning` and `reviewer-reply-drafting` (which run the full pipeline with parallel triage sub-agents, frozen plan, tracked-changes manuscript render). Use this skill when refining individual replies, drafting a single comment, or doing voice work on existing reply text.

## Required references: load before any work

- `conventions/voice.template.md`: base writing voice (measured confidence, no superlatives, sentence-length variation)
- `conventions/reply-format.template.md`: reviewer-response conventions (7-class taxonomy, length conventions, push-back heuristics, cover letter structure)
- `conventions/manuscript-format.template.md`: for any manuscript inserts paired with the reply
- `conventions/research.md`: source-faithfulness contract; mandatory for ADD-CITE / DEFEND-with-literature comments

Loading these before responding is mandatory. They define the lab's reply voice and integrity rules.

---

## When to Use

Use this skill for any of:

- **Drafting a reply to a single comment**: "draft a reply to R1-C3", "respond to this comment about batch correction", "write a DEFEND reply for this push-back"
- **Refining existing reply text**: "tighten this reply", "this reads defensively, fix the tone", "make this reply shorter for a TRIVIAL comment"
- **Voice and length calibration**: "this is a TRIVIAL comment but the reply is two paragraphs, cut it down", "this DEFEND reply needs more substance, expand with literature support"
- **Manuscript insert paired with reply**: "write the inserted text for this CLARIFY comment", "draft the new paragraph requested by R2-C5", "refine this `++insert++` to match the lab's voice"
- **Quote-the-insertion pattern**: "format this reply with the inserted text quoted", "show what was added in the manuscript for this comment"
- **Push-back framing**: "help me push back on this comment without sounding adversarial", "frame this as a DEFEND with literature support"
- **Cover letter help**: "draft the cover letter to the editor", "write the executive summary for the response document"

## When NOT to Use (route elsewhere)

- **Full reviewer set triage** with classification of all comments and AskUserQuestion-driven planning: `skills/simple/reviewer-reply-planning/SKILL.md`
- **End-to-end response document and tracked-changes manuscript render** with parallel sub-agents per reviewer: `skills/simple/reviewer-reply-drafting/SKILL.md`
- **Multi-paper literature synthesis** for substantive defenses requiring 5+ new citations: `skills/workflows/paper-research/SKILL.md` (then return to this skill for the reply itself)

---

## How It Works

Lightweight by design. No phase structure, no required frozen plan, no state files. The skill just:

1. Loads the required references above
2. Reads or accepts the reply text (and any paired manuscript insert) the user wants help with
3. Applies conventions to draft, refine, or edit
4. Hands the result back as markdown

Output stays in markdown. For final tracked-changes rendering, route to `skills/simple/reviewer-reply-drafting/SKILL.md` or `skills/simple/manuscript-builder/SKILL.md` when ready.

### Common patterns

**Pattern 1: Classify and draft a single comment.**
User pastes a reviewer comment. Classify per the 7-class taxonomy in `conventions/reply-format.template.md` (TRIVIAL, CLARIFY, ADD-CITE, DEFEND, RESTRUCTURE, NEW-ANALYSIS, JUDGEMENT). Pick the right reply length and pattern. For TRIVIAL: 1 to 4 words. For CLARIFY: 1 sentence with quoted insert. For DEFEND substantive: 1 to 3 paragraphs with literature support. Apply voice + reply-format throughout.

**Pattern 2: Refine an existing reply.**
User points at a reply and asks for improvement. Diagnostic checks: length matches class? Tone non-adversarial on DEFEND? Quoted insert present on CLARIFY? Cross-reference resolved? First-person plural? No filler thanks on trivial replies? No apology? Apply targeted edits.

**Pattern 3: Add literature support to a DEFEND.**
User wants to strengthen a substantive defense with a citation. Apply `conventions/research.md` rules: verify existence, check claim alignment, no hallucinations. Insert the citation naturally per the DEFEND substantive pattern. If multiple citations needed or full literature synthesis required, hand off to `skills/workflows/paper-research/SKILL.md`.

**Pattern 4: Manuscript insert paired with a reply.**
User has a CLARIFY or ADD-CITE comment that needs new manuscript text. Draft the insert in markdown using the `~~delete~~ ++insert++ [R#-C#: tag]` markup convention. Apply manuscript-format voice (passive in Methods, etc.). Quote the insert in the reply per `conventions/reply-format.template.md` "Quote What You Inserted" pattern.

**Pattern 5: Push-back framing.**
User wants to DEFEND but the original draft sounds adversarial or thin. Apply `conventions/reply-format.template.md` "Tone for substantive defenses": acknowledge the concern first, ground in data or literature, note what *did* change, frame disagreement as interpretation rather than calling the reviewer wrong.

**Pattern 6: Cover letter.**
User needs the editor letter at the top of the reply doc. Use the standard or executive-summary pattern from `conventions/reply-format.template.md` depending on whether the editor flagged overarching concerns.

---

## Hand-offs

This skill handles individual comments and ad-hoc edits. Hand off when the task gets bigger:

| If the user wants... | Route to... |
|---|---|
| Triage and classify ALL comments from a reviewer set with structured planning | `skills/simple/reviewer-reply-planning/SKILL.md` |
| Build the full response document and rendered tracked-changes manuscript | `skills/simple/reviewer-reply-drafting/SKILL.md` |
| Multi-paper literature synthesis for a complex DEFEND | `skills/workflows/paper-research/SKILL.md` |
| Final `.docx` rendering of the reply or revised manuscript | `skills/simple/manuscript-builder/SKILL.md` (with `inline_markup_mode: "tracked"` for the manuscript) |

When handing off, surface the existing markdown so the next skill picks up where this left off.

---

## Output Conventions

- Default output is markdown
- Replies use the `R#-C#: ... / REPLY: ...` block format from `conventions/reply-format.template.md`
- Manuscript inserts use `~~delete~~ ++insert++ [R#-C#: tag]` markup so they can be rendered as tracked changes later
- Always cite specific conventions when explaining edits (e.g., "shortened per reply-format TRIVIAL length convention", "added literature support per DEFEND substantive pattern")
- For ADD-CITE or DEFEND with literature, surface verification status: "citation verified against [source]" or "citation needs verification"

---

## Quality Checks Before Handing Back

Before returning a reply to the user:

1. **Class-length match**: TRIVIAL is 1 to 4 words. CLARIFY is 1 sentence with quoted insert. DEFEND substantive is 1 to 3 paragraphs. Mismatches feel off.
2. **No filler thanks** on TRIVIAL replies. "We thank the reviewer for this comment" only when actually warranted.
3. **No apology** for the original manuscript.
4. **No defensiveness** in tone, even on JUDGEMENT comments.
5. **First-person plural** throughout ("We added...", never "I" or "the authors").
6. **Past tense for completed changes** ("We have added..." not "We will add...").
7. **Citations verified** per `conventions/research.md`. Flag any unverified.
8. **Manuscript inserts on-voice** per `conventions/manuscript-format.template.md` (passive in Methods, hedging calibration on interpretations).
9. **Sentence length varied** per `conventions/voice.template.md`.

If a check fails, fix it before returning. Reply voice slips compound across a long response document, so catching them at the single-reply level matters.
