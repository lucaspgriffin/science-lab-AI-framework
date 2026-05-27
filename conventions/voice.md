---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida (Department of Integrative Biology)
generated: 2026-05-26
source: ported from griffin-writing-style skill (manuscript-and-grant calibration across 21+ peer-reviewed papers and 25+ proposals, 2017-2025)
---

# Voice: Griffin Lab writing conventions

The Griffin Lab works in marine ecology, fisheries science, and movement ecology. The voice
below is the same voice used in the lab's manuscripts and proposals, calibrated across a corpus
of 21+ peer-reviewed publications (2017-2025) and 25+ proposals across NOAA, USGS, DoD, NSF,
Gulf Research Program, Bonefish & Tarpon Trust, Sloan, and state foundations. The
`griffin-writing-style` skill ships the full voice surface; this file is the framework-native
mirror for cross-skill consumption.

---

## 1. Register

Formal but not stiff. The prose reads like a knowledgeable colleague speaking precisely and
confidently to peers, not reading from a textbook. Technical and citation-dense. Comfortable
with mixed-model notation, occupancy / N-mixture parameters, SDM components (1D and 2D SPDE,
INLA, BRT), telemetry concepts (detection probability, residency, range testing), and
quantitative summaries in main text without scaffolding for a general audience. Audience
assumption is fisheries scientists, movement ecologists, and quantitative marine ecologists
submitting to *Fish and Fisheries*, *Ecological Applications*, *Methods in Ecology and
Evolution*, *ICES Journal of Marine Science*, *Marine Ecology Progress Series*, *Fisheries
Research*, *Animal Biotelemetry*, *Movement Ecology*, *Marine Biology*, *Canadian Journal of
Fisheries and Aquatic Sciences*, or comparable venues. No contractions in body text. No
colloquialisms.

---

## 2. Hedging calibration

Hedging is calibrated to evidence strength, not reflexive. Over-hedging reads as early-career
uncertainty and weakens the case in both manuscripts and proposals.

- **Established facts and widely accepted findings**: state directly, no hedge.
  "Atlantic tarpon support an economically important recreational fishery."
- **Supported findings from the study's own data**: confident attribution.
  "Our results demonstrated that ..." or "We found that ..."
- **Mechanistic interpretation of own data**: moderate hedge.
  "This pattern likely reflects ..." or "This may be driven by ..."
- **Speculation or extrapolation beyond the data**: clear hedge.
  "Future research may reveal whether ..." or "It is possible that ..."
- **Methodological advantages**: avoid absolute language. A design choice "avoids" or "greatly
  reduces" a confound; it does not "eliminate" the confound. Reserve "eliminates" for cases
  where something is literally removed from the design (e.g., "eliminates the need for surgical
  implantation" is fine because surgery is literally not performed).

Do not apply "may," "potentially," or "suggest" to every claim. If the data supports a
statement, say so directly.

---

## 3. Punctuation rules

**Em-dashes are banned**, period. No `—`, no `--`, no spaced ` - `. The em-dash is the single
most recognisable LLM tell; banning it outright breaks the cadence drift that makes AI-written
prose recognisable.

Replacements:

| If you would have written | Use instead |
|---|---|
| `label — explanation` | `label: explanation` |
| `clause — aside — clause` | `clause, aside, clause` or `clause (aside) clause` |
| `clause — pivot` | `clause; pivot` or two sentences |
| `noun — qualifier` | `noun, qualifier` or restructure |
| `phrase — emphatic clause` | period and new sentence |

Other punctuation:
- Oxford comma used.
- Hyphens for compound modifiers (catch-and-release, mark-recapture, acoustic-telemetry,
  mixed-effects, state-space).
- En-dashes for numeric ranges (10–15 words, 25–35 words, 2007–2019).
- No contractions in body text.
- Scientific names italicised everywhere they appear: *Megalops atlanticus*, *Rachycentron
  canadum*, *Caretta caretta*, *Albula vulpes*.

---

## 4. Sentence rhythm

Vary sentence length deliberately. Short declarative sentences (10–15 words) create emphasis.
Longer compound-complex sentences (25–35 words) build context and integrate multiple ideas. A
well-placed short sentence after a sequence of longer ones lands as a punch.

Active voice dominates (~80% of sentences). Passive voice is reserved for cases where the agent
is unimportant, unknown, or where section convention requires it (occasional Methods sentences).
First-person plural throughout: "we examined," "we found," "our results suggest," "we propose,"
"our approach."

Prefer implicit logical flow over explicit transitional phrases. When explicit connectors are
needed: *However*, *Despite*, *Although*, *In contrast*, *As such*, *In turn*, *Ultimately*,
*Critically*. Avoid *Furthermore*, *In addition*, *Moreover*; these signal cataloging rather
than argument.

---

## 5. Words to use

Vocabulary anchors that recur naturally across the lab's published work. Use where they fit,
not where they have to be forced in.

- *spatiotemporal* (preferred over "spatial and temporal")
- *space use* (core concept, often paired with *habitat selection*)
- *site fidelity*
- *movement ecology* / *movement patterns* / *movescape*
- *implications for management and conservation*
- *critical to* / *essential to*
- *ecological role*
- *recreational fishery* / *catch-and-release (C&R)*
- *acoustic telemetry*
- *local ecological knowledge (LEK)*
- *knowledge co-production* (proposals especially)
- *actionable* / *management-actionable* (proposals)
- *fishery-dependent* / *fishery-independent* (data source classification)

Opening / framing constructions:
- "To assess whether [X], we ..."
- "We reasoned that ..."
- "Consistent with [prior finding], ..."
- "Our results demonstrated that ..."
- "These patterns suggest that ..."
- "One plausible mechanism is ..."
- "Critically, ..."

---

## 6. Words to avoid

The signature anti-patterns. LLM defaults skew toward these.

- **Superlatives**: *groundbreaking, unprecedented, revolutionary, transformative*, and *novel*
  when overused.
- **Empty intensifiers**: *significantly* without a number, *markedly* increased, *highly*
  diverse without a metric.
- **Reflexive hedging on facts**: "It may be possible that the data suggest ..."
- **Causation language for correlational findings**: *demonstrates, proves, establishes* unless
  the evidence is mechanistic (not just correlational).
- **Absolute methodological claims**: *eliminates* (for confound reduction), unless the design
  literally removes the source.
- **Em-dashes** (per section 3).
- **Passive-voice narrative citations**: *described by, reported by, shown by, noted by*.
  Narrative citations place the author as the active subject: "Secor (1999) proposed ...",
  "Griffin et al. (2023) demonstrated ..."
- **Catalog connectors**: *Furthermore, In addition, Moreover*.
- **Performative filler**: "Letters of support are included," "We will coordinate with
  partners," repeated "see CV" after every PI bio.
- **Boilerplate revision openers**: "We thank the reviewers for their careful reading of the
  manuscript" (use substantive openers instead, per `reply-format.md`).
- **Quantitative placeholders**: never `[X]`, `[QUANTIFY]`, or `(N)`. Either the real number is
  there or the sentence reads qualitatively.

---

## 7. Authoring vs editing

When the model is **authoring** fresh prose (drafting from notes, expanding bullets, generating
an abstract from scratch), this voice file applies fully.

When the model is **editing** Lucas's existing prose, the voice file applies narrowly:
- **Fair game**: typos, grammar errors that change meaning, factual errors, citation errors,
  explicit voice violations from sections 3 (em-dashes), 5, and 6.
- **Off-limits**: paragraph restructuring, reordering arguments, softening strongly-stated
  claims, substituting verbs for stylistic preference, "improving" sentence rhythm.

When asked to "tighten" or "polish", ask which scope is meant before editing.

---

## 8. Writing evolution

The lab's voice has been stable since roughly 2020. Earlier papers (pre-2018) carry slightly
heavier passive constructions and longer Methods exposition; the current voice moves toward
active Results narration and Methods sections that defer architectural detail to a
supplementary protocol. When using pre-2018 papers as voice exemplars, weight the more recent
ones more heavily.

---

## 9. Voice exemplars

First-author papers that exemplify the current voice. The model should re-read these
when uncertain about tone for a specific document type. Recent papers (2023+) are weighted
more heavily; older papers are reference points for the foundational lab voice but may
read more conservatively than current writing.

**Primary exemplars (re-read first):**

- **Griffin et al. 2025**, *Fish and Fisheries*: "Synthesising Support for the Entrainment
  Hypothesis Through Spatially Explicit Life Cycles, Vagrancy and Collapse of Atlantic
  Tarpon." The current flagship first-author paper for synthesis writing in a top-tier
  fisheries venue. Reference patterns: the funnel-structure Introduction, the
  spatially-explicit life-cycle framing, the conservation closer.
- **Griffin et al. 2025**, *Fisheries*: "Habitat management and restoration as missing
  pieces in flats ecosystems conservation and the fishes and fisheries that they support."
  Management-framed voice for an applied audience. Reference patterns: the
  problem-and-stakes opening, the gap-naming penultimate Introduction paragraph, the
  actionable management implications closer.
- **Griffin et al. 2023**, *Environmental Biology of Fishes*: "There's no place like home:
  high site fidelity and small home range of bonefish inhabiting fringing reef flats in
  Culebra, Puerto Rico." Movement-ecology / residency voice. Reference patterns: the
  Results subsection openers, the mechanistic interpretation in the Discussion, the
  scoped-to-system implications.

**Secondary exemplars (also worth pulling for specific document types):**

- **Griffin et al. 2025**, *Fisheries Research*: "Site-specific post-release predation of
  bonefish in a catch-and-release recreational fishery: informing voluntary actions and
  management strategies." C&R-survival voice; pairs analytic results to voluntary-action
  recommendations without overclaiming. Reference for the catch-and-release-survival
  workstream.
- **Griffin et al. 2024**, *Canadian Journal of Fisheries and Aquatic Sciences*: "Beyond
  the hook: do angler-fish interactions in a catch-and-release recreational fishery modify
  fish space use and catchability?" Methodological-question framing combined with
  management-relevant inference; recent telemetry voice.
- **Griffin et al. 2023**, *Marine Policy*: "Angler and guide perceptions provide insights
  into the status and threats of the Atlantic tarpon fishery." Stakeholder-engagement
  voice; uses local ecological knowledge framing throughout. Reference for any LEK or
  knowledge-co-production-framed manuscript or proposal.
- **Griffin et al. 2023**, *Environmental Biology of Fishes*: "Assessing the potential for
  red tide algal bloom impacts on Atlantic tarpon along the southwestern coast of Florida."
  Multi-stressor / environmental-stressor voice; useful reference for federal-proposal
  framing where "environmental change" language is required.
- **Griffin et al. 2022**, *Ecological Applications*: "Predator-prey landscapes of large
  sharks and game fishes in the Florida Keys." Predator-prey / depredation voice; reference
  for any shark-depredation or large-pelagic interaction framing.
- **Griffin et al. 2022**, *Marine Ecology Progress Series*: "Seasonal variation in the
  phenology of Atlantic tarpon in the Florida Keys." Phenology / spatiotemporal voice.

**Foundational exemplar (older but still load-bearing):**

- **Griffin et al. 2018**, *Fisheries Research*: "Keeping up with the Silver King: using
  cooperative acoustic telemetry networks to quantify the movements of Atlantic tarpon."
  The foundational lab paper for cooperative-network telemetry framing. Slightly more
  conservative voice than current work but the cooperative-network framing is still the
  lab's reference pattern.

**Adjacent co-author exemplars (use when section style is specific):**

- **Brownscombe, Griffin et al. 2020**, *Methods in Ecology and Evolution*: "A practical
  method to account for variation in detection range in acoustic telemetry arrays." For
  methods-paper voice.
- **Cooke, Bergman, Twardek et al. 2022**, *Journal of Fish Biology*: "The movement
  ecology of fishes." For synthesis-paper structure.
- **Lowerre-Barbieri, Friess, Griffin et al. 2021**, *Fish and Fisheries*: "Movescapes and
  eco-evolutionary movement strategies in marine fish." For movescape-framing language.
- **Danylchuk, Griffin et al. 2023**, *Environmental Biology of Fishes*: "Cascading effects
  of climate change on recreational marine flats fishes and fisheries." For multi-stressor
  conservation framing.

The full publication list is on the lab's Google Scholar page:
https://scholar.google.com/citations?user=scPoGrkAAAAJ&hl=en

---

## 10. Geographic and climate terminology (context-dependent)

The Gulf-region name depends on document type:

- **Federal proposals** (NOAA, USGS, DoD, NSF, any federal agency): use **"Gulf of America"**
  at first mention (current official federal designation), then **"the Gulf"** thereafter.
- **Manuscripts, state proposals, non-federal writing**: use **"Gulf of Mexico"** at first
  mention, then **"the Gulf"** thereafter.

Never use abbreviations GOA or GOM in prose. Never use "Gulf of Mexico" in a federal proposal;
never use "Gulf of America" in a manuscript.

Climate language:
- **Federal proposals**: avoid the phrase *climate change*. Use *environmental change*,
  *environmental stressors*, or *environmental trends*.
- **Manuscripts and non-federal writing**: *climate change* is fine.

---

## 11. Species name convention

At first mention: common name followed by scientific name in parentheses: "Atlantic tarpon
(*Megalops atlanticus*)." After first mention: use common name or abbreviated binomial
consistently within the section. Both forms at first mention in titles and abstracts.
Scientific names italicised everywhere they appear, including headings, captions, and tables.

See `griffin-writing-style/references/species-vocabulary.md` for primary study taxa management
framing and preferred phrasing.

---

## 12. Word document formatting defaults

When a written deliverable lands in Word (manuscripts, proposals, LOIs):

- **Font**: Times New Roman, 12 pt throughout.
- **Colour**: black for all body text, headings, captions, and reference list entries.
- **In-text citation hyperlinks**: standard blue hyperlink colour is acceptable (these are the
  only blue text in the document, signalling clickable DOI links).
- **All other hyperlinks** (DOI links in the reference list, URLs in text): formatted in black.
- **Paragraph spacing**: manual blank lines only. No Space Before / Space After settings.
- **No running page headers, no footnotes**. Section headings within the body are normal and
  expected.

If the RFP specifies a different font or colour scheme, follow the RFP.

---

## Cross-references

- Manuscript section architecture and citation conventions: `conventions/manuscript-format.md`
- Reviewer reply tone and structure: `conventions/reply-format.md`
- Figure and table render conventions: `conventions/figure-format.md`
- Source-faithfulness and citation verification: `conventions/research.md`
- Full griffin-writing-style skill (manuscript + proposal mode, journal/funder profiles,
  reference-quality protocol): `~/github/claude_skills/writing/griffin-writing-style/SKILL.md`
