---
name: manuscript-writing
description: |
  Lightweight entry point for ad-hoc manuscript writing: drafting, refining, or editing journal manuscript text without running a full pipeline. Use whenever the user wants to draft a paragraph, refine an introduction, improve a sentence, write methods, expand a discussion, edit for voice, or apply the lab's writing conventions to existing prose. Trigger phrases: "help me draft this paragraph", "refine my introduction", "improve this sentence", "write the methods section", "edit for voice", "polish this paragraph", "tighten this writing", "fix the hedging in this sentence". Lightweight counterpart to the paper-research workflow (multi-phase pipeline). Route to paper-research when literature search is needed, expert-review for peer-review simulation, or manuscript-builder for final .docx rendering.
cost: light
---

# Manuscript Writing: Daily Entry Point

A lightweight skill for ad-hoc manuscript writing. Loads the lab's voice, format, and research-integrity conventions, then helps draft, refine, or edit manuscript text in markdown.

This is the daily working skill for manuscript prose. It is the counterpart to `skills/workflows/paper-research/SKILL.md` (heavy, multi-phase, designed for "I have analysis results and want a paper from scratch"). Use this skill when you are already in the middle of writing and want help with a paragraph, a section, or a voice pass.

## Required references: load before any work

Load from `conventions/`:
- `conventions/voice.template.md`: core writing voice (measured confidence, no superlatives, em-dash rules, sentence-length variation, sentence patterns)
- `conventions/manuscript-format.template.md`: section structure, citation density, headings, paper-type variations
- `conventions/research.md`: source-faithfulness contract; mandatory whenever a citation is added or verified

Loading all three before responding is mandatory. They define the lab's voice and integrity rules.

---

## When to Use

Use this skill for any of:

- **Drafting new text**: "write the introduction paragraph about X", "draft the methods for the camera-trap occupancy analysis", "write a discussion paragraph that ties findings to small-mammal microhabitat selection"
- **Refining existing text**: "make this paragraph sound more like the lab voice", "tighten this sentence", "improve the hedging here", "vary the sentence rhythm in this paragraph"
- **Editing for voice**: "edit for voice", "this reads too AI-generated, fix it", "remove the superlatives", "kill the em-dashes"
- **Section-level help**: "write the methods opening rationale", "draft the Results paragraph for Fig 2", "help me write the implications paragraph"
- **Citation work** (single citations or quick checks): "add a citation here for [claim]", "verify this citation supports the claim", "is this paper the right one to cite for X"
- **Self-review**: "review this paragraph against the voice convention", "run the checklist on this section"

## When NOT to Use (route elsewhere)

- **Full literature synthesis or background research** with multiple new citations and theme extraction: `skills/workflows/paper-research/SKILL.md`
- **Comprehensive peer review** with simulated reviewer panels: `skills/workflows/expert-review/SKILL.md`
- **Final .docx rendering** for journal submission: `skills/simple/manuscript-builder/SKILL.md`
- **Synthesis, perspective, policy brief, blog post** (non-manuscript): `skills/simple/topic-writing/SKILL.md`

---

## How It Works

This is intentionally lightweight. No phase structure, no required inputs, no state files. The skill just:

1. Loads the three required references above
2. Reads or accepts the manuscript text the user wants help with
3. Applies the conventions to draft, refine, or edit
4. Hands the result back as markdown

Output stays in markdown by default. The user can ask for a `.docx` render via `manuscript-builder` when ready.

### Common patterns

**Pattern 1: Draft a paragraph from scratch.**
User describes what the paragraph needs to do (the argument, the context, the citations to include). Apply the voice and manuscript-format conventions for the relevant section (Discussion paragraphs follow the topic-sentence, then interpretation, then literature comparison, then alternative acknowledgment, then transition pattern from the voice convention).

**Pattern 2: Refine an existing paragraph.**
User pastes or points at a paragraph. Run a voice diagnostic and apply targeted edits: cut superlatives, fix hedging calibration, vary sentence length, minimize em-dashes, replace "We did X. We did Y." with rationale-first or passive constructions per the voice convention.

**Pattern 3: Section-level voice pass.**
User points at a Methods, Results, or Discussion section. Apply the section-by-section checklist from the manuscript-format convention. Methods get passive voice plus rationale-first openings. Results get statistical reporting precision. Discussion gets woven uncertainty and high citation density.

**Pattern 4: Citation help.**
User wants to add or verify a citation. Apply the research-integrity rules: verify existence, check claim alignment, prioritize relevance over prestige, no hallucinations. If multiple citations are needed or systematic literature search is required, hand off to `paper-research`.

**Pattern 5: Self-review.**
User has a draft and wants a quality pass. Run the section-appropriate checks. Flag superlatives, vague results, orphan citations, missing hedging on interpretations, em-dash overuse, monotonous sentence rhythm.

---

## Hand-offs

This skill is a working bench, not a complete pipeline. Hand off when the task gets bigger:

| If the user wants... | Route to... |
|---|---|
| Multi-paper literature synthesis with theme extraction | `skills/workflows/paper-research/SKILL.md` |
| Reviewer-panel simulation and structured review | `skills/workflows/expert-review/SKILL.md` |
| Final journal-ready `.docx` with tracked changes or formatting | `skills/simple/manuscript-builder/SKILL.md` |
| Non-manuscript writing (synthesis, brief, blog) | `skills/simple/topic-writing/SKILL.md` |

When handing off, surface the existing markdown so the next skill picks up where this left off.

---

## Output Conventions

- Default output is markdown
- For inline edits, use the `~~deletion~~` / `++insertion++` markup convention so the user can see what changed
- For full rewrites, present the new text and a brief change summary noting what voice/structure rules were applied
- Always cite specific conventions (for example, "per voice.template.md hedging calibration") so the user can verify the reasoning

---

## Quality Checks Before Handing Back

Before returning text to the user:

1. **Voice diagnostic**: run the section-appropriate checks from the voice and manuscript-format conventions mentally. Flag any failures.
2. **Em-dash count**: no more than one em-dash per paragraph. Rewrite if higher.
3. **Sentence length variation**: scan for monotonous rhythm. Mix lengths.
4. **Citation integrity**: every citation traces to a real source per the research convention. Flag any unverified.
5. **Section-appropriate voice**: passive in Methods, active elsewhere. No interpretation in Results.
6. **No superlatives**: scan for "unprecedented", "revolutionary", "groundbreaking", "novel" (when used as a stale superlative).

If a check fails, fix it before returning. Do not ship voice violations.
