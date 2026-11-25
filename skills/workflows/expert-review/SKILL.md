---
name: expert-review
description: |
  Simulates a panel of expert peer reviewers for academic manuscripts, technical reports, grant proposals, and white papers, then generates targeted edits addressing key criticisms. Use this skill whenever the user mentions: peer review, reviewing a manuscript, getting feedback on a paper, simulating reviewers, expert critique, manuscript revision, addressing reviewer comments, editorial feedback, or iterating on a draft. Also trigger when users upload a manuscript (.docx or .md) and ask for feedback, critique, improvement suggestions, or quality assessment. This skill works standalone or as a follow-up to paper-research. It supports iterative review-edit cycles where each round builds on the previous. Edits are applied as inline markup (~~deletions~~ and ++insertions++) in markdown, keeping the manuscript in a plain-text format until final .docx conversion via manuscript-builder.
cost: heavy
---

# Expert Review Skill

A comprehensive peer review simulation and manuscript revision system that applies expert feedback through inline markdown markup.


## Required references: load before any review

Load from `conventions/`:
- `conventions/voice.template.md`: voice the manuscript should match
- `conventions/manuscript-format.template.md`: document structure rules
- `conventions/research.md`: citation accuracy and source-faithfulness rules

Load these before reviewing any manuscript. They define what counts as on-voice, well-structured, and properly cited.

---
## Overview

This skill orchestrates a structured four-phase review process:
1. **Phase 1**: Reviewer panel selection and briefing
2. **Phase 2**: Independent expert reviews (parallel sub-agents)
3. **Phase 3**: Synthesis and thematic analysis
4. **Phase 4**: Targeted revision with inline markup

The output is a markdown manuscript with all edits tracked via inline syntax, maintaining transparency about every change and its justification.

---

## Phase 1: Reviewer Panel Selection and Briefing

### Objective
Assemble a diverse panel of 4 expert reviewers matched to the manuscript's scope and identify key evaluation criteria.

### Process

**Step 1: Document Analysis**
- Read the manuscript (or excerpt if >5,000 words)
- Extract: title, field/discipline, research question, methodology, and intended audience
- Note any YAML frontmatter (journal profile, target audience, manuscript guidelines)

**Step 2: Propose Reviewer Expertise Options**

Based on the document analysis, propose **6 to 8 candidate expertise areas** tailored to the manuscript's specific content. These should be concrete, domain-specific specializations, not generic roles like "methodologist" or "critical evaluator."

For example, a manuscript on small-mammal microhabitat selection across a canopy-cover gradient might generate:
- Camera-trap methods and detection-probability modelling
- Multi-species occupancy and community ecology
- Small-mammal microhabitat and behavioural ecology
- Vegetation-community ecology and habitat structure
- Mixed-models and hierarchical inference
- Field-survey design and effort accounting
- Climate-covariate integration and predictive distribution modelling
- Reproducibility and open-data standards in ecology

Each proposed expertise should include a 1-sentence description of what that reviewer would focus on.

**Step 3: User Selects Reviewers**

Present the candidate expertise areas to the user (use a multi-select prompt). Recommend 4 selections but allow the user to pick 3 to 5.

Example prompt: "Based on the manuscript, here are expertise areas that would give useful review coverage. Which ones would you like on the panel?"

If the user picks fewer than 3 or more than 5, that is fine: adjust the panel size accordingly. If the user suggests a custom expertise not in the list, add it.

**Step 4: Build Reviewer Personas**

For each selected expertise area, construct a full reviewer persona:
- **A descriptive role title** capturing their angle (e.g., "Camera-trap methods & detection-probability specialist")
- **Expertise profile**: 2 to 3 sentences on their background, what they focus on in reviews, and what they push back on
- **Review lens**: The specific aspects of the document they will scrutinize
- **Evaluation criteria**: 3 to 5 specific things they will assess

For manuscripts tied to paper-research, use journal profile and submission guidelines from YAML frontmatter to further refine personas.

**Step 5: Confirm Panel**

Present the full panel with personas and evaluation criteria. Ask the user to confirm or adjust before proceeding to reviews.

---

## Phase 2: Independent Expert Reviews (Subagent Architecture)

### Objective
Generate 4 independent, detailed reviews from each persona's perspective.

### Why subagents

Each reviewer operates independently with their own persona, lens, and evaluation criteria: they should not see or be influenced by other reviewers' assessments. By giving each reviewer their own agent, we get:
- **True independence**: no cross-contamination between reviewer perspectives
- **Deeper analysis**: each agent dedicates its full context to one reviewer's thorough assessment
- **Parallel execution**: all 4 reviews run simultaneously
- **Persona fidelity**: each agent stays fully in character without drifting between roles

### Launching subagents

After Phase 1 panel is confirmed, launch one sub-agent per reviewer. All reviewer agents run **in parallel** since they are independent.

**Subagent prompt template:**

```
You are an expert peer reviewer for an academic manuscript. You are reviewing from a specific expert perspective and must stay fully in character throughout.

## Your Reviewer Persona
Role: [Reviewer role title from Phase 1]
Expertise profile: [2 to 3 sentence background from Phase 1]
Review lens: [What you focus on]
Evaluation criteria: [3 to 5 specific criteria from Phase 1]

## Manuscript Context
- Title: [title]
- Target journal: [journal name]
- Journal scope: [from YAML frontmatter, if available]
- Paper type: [empirical / review / methods / etc.]

## The Manuscript
[Full manuscript text: include all sections through References, Tables, and Figures]

## Citation Context (if chained from paper-research)
[Citation validation log excerpt, if available: T2+ flagged citations]

## Review Instructions

Generate a thorough, independent review following this EXACT format:

### 1. Summary (2 to 3 sentences)
Overall assessment and your primary concern from your expertise angle.

### 2. Strengths (3 to 4 bullet points)
What the manuscript does well, especially in areas relevant to your expertise.

### 3. Major Concerns (3 to 5 bullet points)
Significant issues requiring revision. Each should include:
- The specific problem
- Why it matters
- A concrete suggestion for how to address it

### 4. Minor Issues (3 to 5 bullet points)
Smaller problems: wording, clarity, formatting, missing details. Include checks for:
- **Methods voice**: Flag excessive first-person active voice ("We did X, We did Y") in methods sections; methods should use passive voice with rationale-first paragraph openings
- **Paragraph thematic coherence**: Flag discussion paragraphs that lack a clear organizing theme or have weak internal flow between sentences
- **Limitations distribution**: Flag if limitations/caveats are concentrated in a single dedicated paragraph or section rather than woven throughout the discussion
- **Domain-specific data processing**: Flag if methods are missing standard processing steps for the data type in question (e.g., for camera-trap data: independent-detection thresholding, species-ID confidence handling, observer-effect covariates; for vegetation transects: cover-class consistency checks, observer-effect handling)

### 5. Questions for Author (2 to 3 questions)
Direct questions the author should address in revision.

### 6. Actionable Comments
Specific revision suggestions with section/paragraph references where possible. These should be precise enough to map to inline edits later.

### 7. Citation Spot-Check
Check 3 to 5 citations for:
- Does the cited paper exist?
- Does the claim attributed to it seem accurate based on the citation context?
- Are any citations missing that a reviewer in your field would expect?
If chained from paper-research, flag any T2+ citations still requiring resolution.

### 8. Figure & Table Assessment
For each figure and table referenced in the manuscript:
- Completeness: present in Tables/Figures sections? Referenced in body text?
- Caption quality: standalone, complete descriptions?
- Text consistency: does body text match what figures/tables show?
- Appropriateness: effective visualization for the data?
- Redundancy: any that overlap or could be combined/moved to supplementary?
- Missing: any results that need a figure/table that is not included?
- Numbering: sequential and in order of appearance?

### 9. Overall Recommendation
One of: Accept / Minor Revisions / Major Revisions / Reject
Include 2 to 3 sentence justification.

## Tone Guidelines
- Professional but honest: identify real problems, not superficial criticism
- Constructive: frame critiques with suggestions or reasoning
- Stay in character: your background should drive your focus areas
- Be specific: cite sections, provide examples, avoid vague comments
- Be fair: acknowledge what the manuscript does well
```

### Merging subagent results

Once all reviewer agents return, collect the 4 reviews into a single document. Verify:

1. **Each review is clearly labeled** by reviewer number and role
2. **Reviews are substantively different**: reflecting distinct expertise angles, not generic feedback repeated four times
3. **No persona drift**: each reviewer stayed within their stated expertise lens
4. **Required sections present**: all 9 sections (Summary through Recommendation) appear in each review
5. **Citation spot-checks completed**: each reviewer checked 3 to 5 citations
6. **Figure/table assessment completed**: each reviewer evaluated the visual elements

**Quality gate:** If any review is thin (fewer than 3 major concerns, missing sections, or generic rather than persona-specific feedback), relaunch that single reviewer agent with a more targeted prompt emphasizing their specific expertise angle and evaluation criteria. Do not relaunch reviewers that produced strong reviews.

### Review Format for Each Reviewer

Each review includes:
1. **Summary (2-3 sentences)**: Overall assessment and primary concern
2. **Strengths (3-4 bullet points)**: What the manuscript does well
3. **Major Concerns (3-5 bullet points)**: Significant issues requiring revision
4. **Minor Issues (3-5 bullet points)**: Smaller problems, wording, clarity
5. **Questions for Author**: 2-3 direct questions the author should address
6. **Actionable Comments**: Specific suggestions for revision, with line references when possible
7. **Overall Recommendation**: Accept / Minor Revisions / Major Revisions / Reject (with justification)

### Tone and Style
- Professional but honest; identify real problems, not superficial criticism
- Constructive: frame critiques with suggestion or reasoning
- Persona-consistent: each reviewer's background influences their focus
- Specific: cite sections, provide examples, avoid vague comments
- Fair: acknowledge what the manuscript does well

### Citation Validation (if applicable)
- If the manuscript contains citations, reviewers spot-check 3-5 for accuracy and relevance
- If chained from paper-research, use the citation validation log from Phase 3 of that skill
- Flag any T2+ (Tier 2+) citations still requiring resolution
- Recommend adding specific missing references where relevant

### Figure & Table Assessment
The manuscript includes `# Tables` and `# Figures` sections after `# References`. Reviewers should assess:

- **Completeness**: Are all figures and tables referenced in the body text present in the Tables/Figures sections? Are there any orphaned figures/tables not referenced in the text?
- **Caption quality**: Are captions complete, standalone descriptions? Can a reader understand the figure/table from the caption alone?
- **Figure-text consistency**: Does the body text accurately describe what the figures show? Are the key patterns/results highlighted in both the text and the caption?
- **Appropriateness**: Are the chosen figure types effective for the data being presented? Would a different visualization be clearer?
- **Redundancy**: Do any figures/tables show essentially the same information? Could any be combined or moved to supplementary material?
- **Missing visualizations**: Are there results described in the text that would benefit from a figure or table that is not included?
- **Numbering and ordering**: Are figures and tables numbered sequentially and referenced in the order they appear in the body text?

Reviewers should include figure/table-specific comments in their **Actionable Comments** section, referencing specific figures/tables by number.

### Output: Four Separate Reviews
Present each review as a standalone section, clearly labeled by reviewer number and role.

---

## Phase 3: Synthesis and Thematic Analysis

### Objective
Identify patterns, consensus points, and cross-cutting themes across the four reviews.

### Synthesis Steps

**Step 1: Extract Key Themes**
For each major category (strengths, weaknesses, clarity issues, technical gaps, etc.), identify themes that appear in 2+ reviews. Example:

> **Theme: Sample Size Justification**
> - Reviewer 1 (Methods): "No power analysis provided; unclear how N=45 was determined"
> - Reviewer 4 (Critical): "Sample size seems small for the claimed generalizability"
> - Consensus: Author must provide statistical justification for sample size

**Step 2: Consensus vs. Outlier Assessment**
- Note items flagged by all 4 reviewers (highest priority for revision)
- Note 2-3 reviewer consensus (moderate priority)
- Flag outlier comments (lower priority; consider but do not over-prioritize single perspectives)

**Step 3: Actionability Filter**
For each theme, determine:
- Is this actionable by the author? (Can they revise and resolve it?)
- How critical is it? (Affects core claims? Clarity? Minor concern?)
- What concrete revision would address it?

**Step 4: Create Review Synthesis Document**
Produce a markdown document listing all themes, consensus level, priority, and suggested revision direction.

### Output Files
- `[title]_synthesis.md`: Thematic synthesis document with all themes and consensus assessment
- `[title]_review_r1.md`: Reviewer 1 full review
- `[title]_review_r2.md`: Reviewer 2 full review
- `[title]_review_r3.md`: Reviewer 3 full review
- `[title]_review_r4.md`: Reviewer 4 full review

All files saved as markdown (.md). Include all four individual reviews as separate .md files.

---

## Phase 4: Targeted Revision via Inline Markup

### Objective
Apply 10-20 targeted, high-impact edits to the manuscript using inline markdown syntax, linking every change back to the review synthesis.

### Input
- Markdown manuscript (.md) with optional YAML frontmatter
- For .docx input: extract text to markdown first (using pandoc or manual extraction), then apply markup to the .md version
- Completed review synthesis from Phase 3

### Inline Markup Syntax

**Deletion (Strikethrough)**
```
~~text to delete~~
```

**Insertion (Double-Plus)**
```
++new text to insert++
```

**Replacement (Delete then Insert)**
```
~~old text~~ ++new text++
```
When using replacements, place deletion and insertion adjacent with no space between `~~` and `++`.

**Comment Marker**
```
[R{number}-C{number}: Brief explanation]
```
- Format: `[R1-C3: explanation]` links to Reviewer 1, Comment 3
- Appears immediately after the markup (no space)
- Always include: this links every edit back to the review that motivated it
- For edits addressing multiple reviewer comments: `[R1-C3, R2-C5: shared explanation]`

### Rules for Applying Markup

1. **Edit Order**: Apply edits from end of document to beginning. This avoids character offset shifts that would invalidate subsequent edit positions.

2. **No Nesting**: Never nest markup. Invalid:
   ```
   ~~text with ++nested++ markup~~  X
   ```

3. **No Overlapping**: Edits must not overlap in the same region:
   ```
   ~~old~~ ++new~~ ~~text~~ ++content++  X
   ```

4. **Paragraph-Level Rewrites**: For substantial rewrites affecting an entire paragraph:
   - Strikethrough the entire original paragraph
   - Insert the complete revised paragraph on the next line
   ```
   ~~The original paragraph about the methodology was too vague and lacked necessary detail about sample selection criteria.~~
   ++Our methodology employed a stratified random sampling approach, with participants selected from three distinct geographic regions (n=15 per region). Inclusion criteria required participants to have 5+ years of relevant experience.++ [R1-C2: Added sample selection detail]
   ```

5. **Preserve Exact Original Text**: All non-edited text must remain exactly as-is. Correct spelling/grammar separately if needed.

6. **One Comment Marker Per Edit**: Each edit (deletion, insertion, or replacement) receives exactly one `[R#-C#: ...]` marker.

7. **Preserve Formatting**: Maintain markdown formatting within edited text (bold, italics, links, etc.):
   ```
   Original: The **primary concern** was validity.
   Edit: The ~~primary concern~~ ++fundamental limitation++ [R2-C1: Reframed as limitation] was validity.
   ```

### Prose audit (pre-edit pass)

Before selecting edits from the reviewer synthesis, run a one-pass prose audit of each major section (Introduction, Methods, Results, Discussion). This is a structural editorial pass that complements the substantive reviewer critique: it targets prose that is doing no analytical work, not prose that is wrong. The point is to make the writing earn its length (per `conventions/voice.template.md`) with a per-sentence audit rather than a blanket length-cut target.

For each section, produce two short lists:

**Load-bearing sentences**: the sentences actually doing the argumentative work: claims that connect evidence to conclusions, transitions that carry the logic, the specific framings that define the contribution. Name 2 to 4 per section, with a one-line note on what each one does. These get protected during the edit pass: do not cut, rewrite, or weaken them unless a reviewer comment specifically requires it.

**Candidate cuts**: sentences that are restating an earlier point, hedging redundantly, padding with throat-clearing, or filling space without adding to the argument. For each, give the location and a one-line reason. Example tags: `restates Intro P1`, `hedges a claim already qualified two sentences earlier`, `closing sentence of paragraph adds no new content`, `throat-clearing before the actual argument starts`.

This is not a blanket length-cut target. A section that is already tight may produce zero candidate cuts; a Discussion that is spinning may produce many. Cuts are flagged per-sentence with reasons; the next step decides which to act on.

**Output format:**

```
## Prose audit

### Introduction
Load-bearing (protect):
- "[Sentence]": defines the knowledge gap the paper closes
- "[Sentence]": frames the contribution at the right scale of generality
- ...

Candidate cuts:
- P2 sentence 3: "[Sentence]": restates the claim made in P1 sentence 2
- P3 closing: "[Sentence]": throat-clearing transition; adds no content
- ...

### Methods
[same structure]

### Results
[same structure]

### Discussion
[same structure]
```

The audit feeds the targeted-edit step that follows: load-bearing sentences are off-limits; candidate cuts become optional deletions when they overlap with reviewer-flagged issues (e.g., a reviewer flags "Discussion is too long": take candidate cuts from this audit as the starting set for the corresponding edits).

---

### Edit Selection and Confirmation

**Step 1: Identify Candidate Edits**
From the review synthesis, select 10-20 targeted edits that:
- Address cross-cutting themes (prioritize items flagged by 2+ reviewers)
- Are genuinely actionable (author can reasonably implement them)
- Preserve author voice and core argument
- Avoid over-editing (do not fix every minor issue)

**Step 2: Create Edit Plan**
For each proposed edit, document:
- **Location**: Section and approximate line reference
- **Type**: Deletion / Insertion / Replacement / Paragraph rewrite
- **Reviewer(s)**: Which review(s) motivated this edit
- **Change**: Exactly what will be deleted/inserted
- **Rationale**: Why this change improves the manuscript

Example plan entry:
```
Edit 5: Methods Section, Sample Description
Type: Replacement
Reviewer(s): R1-C2, R4-C3
Current text: "The study included 45 participants."
Proposed text: "The study included 45 participants (M_age = 34.2 years, SD = 8.6; 28 female, 17 male), recruited from three geographic regions (n=15 per region)."
Rationale: Adds demographic and sampling detail flagged by methodological reviewer; addresses concerns about sample description completeness.
```

**Step 3: Present Plan to User**
Show the complete edit plan and ask: "Proceed with applying these edits?"

**Step 4: Apply Edits**
Once confirmed, apply all edits in end-to-beginning order using the inline markup syntax.

### Output Files

**Revised Manuscript**
- `[title]_reviewed_r[N].md`: The full manuscript with inline markup applied
  - Preserves YAML frontmatter if present
  - All edits visible as strikethrough/insertion pairs with comment markers
  - Ready for author review and iteration

**Edit Summary**
- `[title]_review_r[N]_edits.md`: Edit summary table for reference

```markdown
# Review Round [N] Edit Summary

Total edits: [N]

| # | Section | Type | Reviewers | Change Description |
|---|---------|------|-----------|-------------------|
| 1 | Intro P2 | Replace | R1-C3, R3-C1 | Expanded knowledge gap framing with recent citations |
| 2 | Methods | Insert | R2-C4 | Added sample size justification and power analysis reference |
| 3 | Methods | Replace | R1-C2 | Enhanced participant demographic description |
| 4 | Results P1 | Replace | R3-C5 | Clarified statistical notation and interpretation |
| ... | ... | ... | ... | ... |
```

### Example: Complete Edit Sequence

**Original Manuscript Excerpt:**
```markdown
## Methods

The study profiled small-mammal occupancy across early-season survey windows.
Stations were sampled across three vegetation strata. Our sample included 84 stations.

Data collection involved camera traps on standard mounts. All cameras were configured with default settings. We used standard QC to analyze the data.
```

**After Edits Applied:**
```markdown
## Methods

The study profiled small-mammal occupancy across ~~early-season survey windows~~ ++three closely spaced late-summer survey windows (1 to 14 August, 15 to 28 August, 29 August to 11 September)++ [R1-C3: Specified survey windows].
Stations were sampled across ~~three vegetation strata~~ ++three vegetation strata with 28 stations per stratum, stratified by canopy openness++ [R2-C4, R4-C1: Clarified stratification] with stratum assignment confirmed by point-quadrat canopy estimates.
Our sample included ~~84 stations~~ ++84 stations (28 per stratum; spaced at a minimum of 200 m to reduce non-independence)++ [R1-C2: Added spacing detail required for replication].

Data collection involved camera traps on standard mounts using ~~standard~~ ++Bushnell Trophy Cam HD model 119876 with manufacturer-default++ [R3-C2: Specified camera model and configuration] settings.
All cameras were ~~configured with default settings~~ ++configured for 1-second trigger interval and 3-image bursts on motion detection++ [R2-C5: Specified trigger configuration].
We used ~~standard QC~~ ++independent-detection thresholding of 30 minutes between consecutive same-species detections, following O'Brien et al. (2003), with species ID confidence scoring per Burton et al. (2015)++ [R3-C1: Added methodological framework reference] to analyze the data.
```

**Corresponding Edit Summary:**
```markdown
# Review Round 1 Edit Summary

Total edits: 5

| # | Section | Type | Reviewers | Change Description |
|---|---------|------|-----------|-------------------|
| 1 | Methods P1 | Replace | R1-C3 | Specified survey windows (1 Aug to 11 Sept, three intervals) |
| 2 | Methods P2 | Replace | R2-C4, R4-C1 | Clarified stratification within canopy-cover gradient |
| 3 | Methods P3 | Replace | R1-C2 | Added station-spacing detail required for replicability |
| 4 | Methods P4 | Replace | R3-C2 | Specified camera model and configuration |
| 5 | Methods P5 | Replace | R2-C5, R3-C1 | Added trigger configuration and methodological framework references |
```

### Editing Figure Captions and Table Content

The same inline markup syntax applies to the Tables and Figures sections:

- **Caption edits**: Use `~~old caption text~~ ++new caption text++ [R#-C#: explanation]` within caption lines
- **Table cell edits**: For markdown tables, apply edits within individual cells. If an entire table needs restructuring, strikethrough the full table and insert the revised version
- **Figure suggestions**: If a reviewer recommends a different figure type, additional panel, or visual change, add a comment marker: `[R#-C#: Suggest replacing with X / adding panel showing Y]` (since the image file itself cannot be edited via inline markup)
- **New figures/tables**: If reviewers recommend adding a new figure or table, insert a placeholder in the appropriate section with a comment marker explaining what is needed

### What NOT to Edit

Apply the revision philosophy conservatively:

- **Author's voice and argument**: Preserve the author's unique perspective, argumentation style, and conclusions
- **Substantive disagreement with reviewers**: If the author's position is defensible, preserve it (reviewers are not always right)
- **Stylistic preferences**: Minor wording choices, tone, or structure that do not impede clarity
- **Unactionable feedback**: Comments about the research itself (e.g., "I wish you'd studied different species") rather than presentation
- **Isolated outlier concerns**: Single-reviewer comments that do not align with broader consensus and are not clearly important

**Rationale**: The goal is improving presentation and addressing genuine clarity/rigor gaps, not rewriting the manuscript to please every reviewer.

---

## Iteration: Multiple Review Rounds

### Multi-Round Review Process

After applying Phase 4 edits and presenting the marked-up manuscript to the user:

**User Review and Feedback**
- User reads the manuscript with inline edits
- User accepts, rejects, or modifies specific edits
- User may request new edits or clarifications

**Round 2+ Execution**
- Start with the user's accepted version (incorporating confirmed edits)
- Run another complete review cycle (Phases 1 to 4) on the updated .md
- Increment `revision_number` in YAML frontmatter if present
- Each successive round typically yields fewer, more focused edits

**Convergence Criteria**
- Round 1: 10 to 20 edits expected (major themes)
- Round 2: 5 to 10 edits (emerging patterns, residual clarity issues)
- Round 3+: 2 to 5 edits (refinement and polish)

**Flagging Structural Issues**
If Round 3 or later still generates major comments (>10 edits) addressing similar themes, stop and flag that the manuscript may have underlying structural issues (e.g., missing section, incoherent argument flow) that require more substantial revision than iterative polish.

---

## Integration with paper-research

### Workflow Chain

```
paper-research              expert-review              manuscript-builder
─────────────────────────   ──────────────────         ─────────────────
Phase 0-6: Research
Phase 7: .md manuscript ->  Phase 1: Reviewer panel
                            Phase 2: Reviews (4 parallel sub-agents)
                            Phase 3: Synthesis
                            Phase 4: Inline markup ->
                            (iterate as needed)        .md -> .docx
                                                       -> Submit
```

### When Chaining from paper-research

- **Read YAML frontmatter** from the .md manuscript output (Phase 7) for journal profile, submission guidelines, target audience, and citation standards
- **Use citation validation log** from Phase 3 of paper-research when expert-review Phase 2 checks references
- **Cross-reference** any T2+ (Tier 2+) citations flagged in paper-research that still require resolution
- Reviewers note any new T2+ citations introduced in the manuscript that need handling

### When Used Standalone

- Works with any .md or .docx file (extracts .docx to markdown first)
- Reviewer personas inferred from document content and stated target audience
- Citation checking is spot-check only (3 to 5 references) rather than comprehensive validation
- No journal profile context, so reviewers assess general scholarly standards

---

## Invocation Patterns

Use this skill when users mention any of:

- "Can you review this manuscript / paper / report?"
- "Simulate peer reviewers for my paper"
- "Review this markdown manuscript"
- "Run a review cycle on this document"
- "Apply edits from the reviews"
- "Run another round of review"
- "Give me feedback on this draft"
- "What would peer reviewers say about this?"

Also trigger when users upload a manuscript (.docx or .md) and ask for feedback, critique, improvement suggestions, or quality assessment.

---

## Notes on Tool Use

### File Handling
- **Input formats**: .md (preferred) or .docx (converted to .md)
- **Output formats**: All outputs as markdown (.md) files by default
- **File naming**: Use the original manuscript title, append `_reviewed_r1`, `_review_r1`, `_synthesis`, etc.
- **Save location**: User workspace folder (typically `/Downloads` or user-specified directory)

### .docx to Markdown Conversion
- Use `pandoc -f docx -t markdown input.docx -o output.md` if available
- If pandoc unavailable, manually extract text and convert to markdown structure
- Preserve tables, figure references, and citation formatting during conversion
- Remove track changes formatting (expert-review will apply its own markup)

### Markdown Formatting Preservation
- Maintain bold, italic, links, code blocks, lists, and tables from original
- Edits may span across formatting markers but should not break them
- Example: `The ~~**important**~~ ++**critical**++ [R1-C1: Word choice] insight` is valid

### Style Guide Integration
- If a writing style reference exists (e.g., from paper-research), load `conventions/manuscript-format.template.md` and `conventions/voice.template.md`
- Reviewers should assess against those conventions when evaluating clarity, tone, and format
- Suggest edits that align the manuscript with established style guidelines

### Final Conversion
- After iterative review cycles are complete, advise user to use **manuscript-builder** skill for final .docx conversion
- Do not generate .docx files within expert-review; keep all outputs in markdown until final conversion
- This preserves editability and allows seamless integration with manuscript-builder's formatting pipeline

### Tools and Dependencies
- **Markdown editors**: VS Code, Obsidian, or other markdown-aware editor for user review
- **Pandoc**: Optional, for converting legacy .docx files to markdown (if unavailable, manual conversion works)
- **Citation tools**: If integrating with paper-research, cross-reference citation validation logs

---

## Key Principles

1. **Transparency**: Every edit links back to a specific reviewer comment via `[R#-C#: ...]` markers
2. **Preservation**: Author voice, argument, and conclusions remain intact unless substantively wrong
3. **Actionability**: All edits address real clarity/rigor gaps, not stylistic preferences
4. **Iterability**: The system supports multiple rounds of review, with each round more focused than the last
5. **Traceability**: The edit summary table provides a quick reference for what changed and why
6. **Plain-text durability**: Markdown format avoids vendor lock-in and enables easy integration with other tools
7. **Independence**: Parallel sub-agents ensure each reviewer's perspective is uncontaminated by others

---

## Troubleshooting

**Q: What if the manuscript is in .docx format?**
A: Convert it to markdown using pandoc or manual extraction. The expert-review skill works exclusively with .md format to enable inline markup. After review is complete, use manuscript-builder for final .docx conversion.

**Q: Can I edit the inline markup manually before showing it to the author?**
A: Yes. If you want to combine, split, or refine any edit, maintain the comment marker structure and ensure all `~~` and `++` markers remain balanced.

**Q: What if an edit spans multiple paragraphs?**
A: For large rewrites, strikethrough each affected paragraph separately, then insert the revised version(s). Avoid nesting or overlapping markup across non-contiguous text.

**Q: How do I handle edits containing special characters (tildes, plus signs)?**
A: Escape with backslash: `\~` and `\+` within the edited text if those characters appear literally.

**Q: Should I include reviewer criticism that I disagree with?**
A: Yes, if it is a legitimate perspective from the assigned reviewer persona. The author can accept or reject it later. Preserve diverse viewpoints.

**Q: What if two edits are adjacent in the same sentence?**
A: Apply them in sequence with no space between: `text~~delete1~~ ++insert1++ [R1-C2] text ~~delete2~~ ++insert2++ [R2-C1] more text`. Each edit has its own marker.

**Q: What if a reviewer sub-agent produces a thin or generic review?**
A: Relaunch just that one agent with a more specific prompt emphasizing their unique expertise angle and evaluation criteria. Do not relaunch reviewers that produced strong reviews.

---

## Summary

The expert-review skill provides a structured, transparent, and iterative peer review and revision workflow. Phase 2 uses parallel sub-agents (one per reviewer) to ensure truly independent assessments with full persona fidelity. Using inline markdown markup (`~~`, `++`, and comment markers), it generates actionable, traceable edits that preserve author voice while addressing cross-cutting themes from expert feedback. The system integrates with paper-research for content sourcing and manuscript-builder for final formatting.
