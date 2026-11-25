---
name: topic-writing
description: >
  Research a topic and write about it: syntheses, literature reviews, perspectives, policy briefs, technical reports, blog posts, or background documents. Triggers: "write a synthesis on", "research and summarize", "write a perspective piece", "draft a policy brief", "write a blog post about", "put together a review of", "what does the literature say about". Not for journal manuscripts from analysis findings (use paper-research) or manuscript review (use expert-review).
cost: light
---

# Topic Writing: Research Synthesis & General Science Writing

A structured skill for researching topics and producing polished written documents across formats. Covers everything from quick blog posts to comprehensive literature syntheses.

---

## Required references: load before drafting

- `conventions/voice.template.md`: core writing voice
- `conventions/topic-format.template.md`: synthesis/perspective/policy/blog format conventions
- `conventions/research.md`: source-faithfulness contract
- `conventions/supporting/sentence-patterns.md`: sentence-level construction patterns (if available)

Load these before any drafting. Topic writing inherits the manuscript voice with format-specific deltas.

---
## Overview

Four phases, scaled to the task:

1. **Scoping**: Define topic, audience, format, depth
2. **Research**: Systematic literature search, evaluation, synthesis
3. **Drafting**: Write in the chosen format following the lab's voice
4. **Review & Polish**: Self-review, refine, deliver

Simple tasks (blog post on a familiar topic) compress phases. Complex tasks (20-page synthesis) expand them.

---

## Phase 1: Scoping

Establish before writing:

**Topic definition:**
- Specific question or topic being addressed
- Scope boundaries (geographic, taxonomic, temporal, methodological)
- Particular angles or framings requested

**Format selection: identify early, it shapes everything:**

| Format | Length | Audience | Citations | Tone |
|--------|--------|----------|-----------|------|
| Research synthesis | 5 to 20 pp | Scientists, managers | High | Formal, evidence-based |
| Perspective/commentary | 2 to 5 pp | Scientific community | Moderate | Measured, opinionated but balanced |
| Policy brief | 2 to 4 pp | Decision-makers | Low (key refs) | Clear, action-oriented |
| Technical report | 5 to 30+ pp | Mixed technical | Moderate to high | Detailed, methodical |
| Blog post / outreach | 500 to 1500 words | General public | Minimal (links) | Accessible, conversational |
| Background document | Variable | Internal | High | Working document |

**Depth calibration:**
- Quick overview: 1 to 2 pages, main points, limited search
- Standard synthesis: 5 to 10 pages, systematic coverage, 20 to 40 references
- Comprehensive review: 10 to 20+ pages, exhaustive search, 50+ references

Ask the user if format/depth aren't obvious from context.

---

## Phase 2: Research

Follow the principles in `conventions/research.md` for all literature work. Core rules: never hallucinate references, verify claim-citation alignment, prioritize relevance over prestige.

### Research Strategy by Citation Density

**High density (syntheses, reports):**
1. Break topic into 3 to 6 narrative themes needing literature support
2. Search systematically: PubMed, Google Scholar. Specific terms, not broad ones.
3. Forward/backward citation chaining from key papers
4. Verify every citation: authors, year, title, journal, volume/pages. Flag anything unverifiable.
5. Evaluate quality: peer-reviewed empirical work for facts, reviews for framing, government or agency reports for regulatory context
6. Balance eras: foundational papers + recent work (last 5 to 10 years)
7. Document contradictions: mixed evidence is valuable information

**Moderate density (perspectives, commentaries):**
- Curate the most relevant and impactful references
- A few well-chosen citations beat exhaustive lists
- Include references that illustrate the argument

**Low density (policy briefs, blog posts):**
- 5 to 10 most important sources
- Prioritize synthesis papers, meta-analyses, authoritative reports
- Open-access sources are more useful for general audiences

### Organize Before Writing
For high-citation documents, organize research by theme: key claims with supporting citations, confidence levels, contradictions, and connections to the broader narrative.

---

## Phase 3: Drafting

### Voice

Read `conventions/voice.template.md` for the full voice profile. Core fingerprint applies across all formats:

- **Measured confidence.** Facts decisively; interpretations hedged.
- **Practical framing.** Gaps are practical problems. Connect to applications.
- **No superlatives.** Never "unprecedented," "revolutionary," "groundbreaking."
- **Precision.** Actual values and specifics where possible.
- **Active voice.** ~95% across all formats.
- **Uncertainty woven in.** Limitations and alternatives throughout, not afterthoughts.
- **Concrete verbs.** "examine," "characterize," "quantify," "estimate," "explore," "assess."

### Format-Specific Structure

#### Research Synthesis
Thematic, not chronological. Organize around ideas, not papers.
- Open: scope and significance
- Body: themes, each building on the last (established to advances to gaps to implications)
- Conclude: synthesis across themes, key takeaways, specific research needs
- If systematic search: brief methods note (databases, date range, criteria)

#### Perspective / Commentary
Argument-driven. Take a position, build the case.
- Clear thesis up front
- Evidence curated to support the argument
- Acknowledge counterarguments
- Suggest specific actions or paradigm shifts
- Measured but more direct than a synthesis

#### Policy Brief
Problem to Evidence to Recommendations
- Executive summary (2 to 3 sentences)
- The problem in plain language
- Key evidence distilled to practical meaning
- Specific, actionable recommendations
- Short reference list with links
- 4 pages max. Clear language, no hedge words in recommendations.

#### Technical Report
Like a synthesis but with more methodological detail.
- Detailed methodology for any original analysis
- Subsections, figures/tables, clear headings
- Appendices for supplementary material
- Follows agency or institutional formatting when applicable

#### Blog Post / Outreach
Hook to Story to Takeaway
- Engaging opening (finding, question, scene)
- Short paragraphs, conversational but accurate
- Translate without dumbing down
- "We found" / "Our research shows": personal connection
- Hyperlink sources, no formal citations
- Target: college-educated, non-specialist audience

#### Background Document
Whatever serves the purpose.
- Rough notes, open questions, tentative ideas all fine
- Flag uncertainties explicitly
- Thinking tool, not deliverable

### Citation Integration by Format
- **Formal** (synthesis, report, perspective): Author-date in-text, reference list at end
- **Policy brief**: Numbered footnotes/endnotes or inline hyperlinks
- **Blog post**: Hyperlinks, no formal format
- **Background**: Whatever's fastest
- In all cases: every reference connects to an argument. No orphan citations.

---

## Phase 4: Review & Polish

### Self-Review Checklist

**Content:**
- [ ] Scope covered adequately for chosen depth
- [ ] Key claims supported by evidence
- [ ] Alternative viewpoints acknowledged
- [ ] Practical implications explicit
- [ ] No hallucinated references

**Voice:**
- [ ] Active voice (~95%)
- [ ] No superlatives
- [ ] Measured confidence: facts direct, interpretations hedged
- [ ] Concrete verbs and specific language
- [ ] Accessible to target audience

**Structure:**
- [ ] Logical section flow
- [ ] Transitions connect ideas
- [ ] Conclusion synthesizes, doesn't just summarize
- [ ] Length appropriate for format

**For formal documents:**
- [ ] Citation density appropriate
- [ ] Mix of foundational and recent literature
- [ ] Reference list complete and accurate

---

## Output

Default: markdown (.md). For formal deliverables, ask whether user wants markdown, .docx, or .pdf.

Name files: `[topic]_[format].md` (e.g., `regulatory_logic_synthesis.md`)

---

## Relationship to Other Skills

```
Conversation -> topic-writing -> paper-research -> expert-review -> manuscript-builder
                    ^
                 THIS SKILL

  "Tell me about X"     "Research and write      "Turn these findings
   -> conversation       about X for me"          into a paper"
                         -> this skill            -> manuscript pipeline
```

A topic-writing output can feed into the manuscript pipeline later: the synthesis or background document provides a head start on Phase 1 (theme extraction) of paper-research.
