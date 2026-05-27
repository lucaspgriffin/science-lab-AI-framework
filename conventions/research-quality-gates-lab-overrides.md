---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida
generated: 2026-05-26
---

# Research Quality Gates: Griffin Lab overrides

This file is a delta on `conventions/research-quality-gates.md` (the framework default).
It renames or refines specific gates to match the lab's domain language and adds taxon-
specific criteria. The base file is unchanged; this addendum is consulted alongside it.

---

## Gate 2 rename: "Domain Gate" → "Ecological Gate"

The Griffin Lab uses **Ecological Gate** for the framework's "Domain Gate" across all
project goal-specs. The gate criteria are unchanged in substance; only the label is
relabelled to align with the lab's everyday phrasing.

## Gate 2 (Ecological Gate): added criteria

In addition to the base framework criteria, the Ecological Gate for Griffin Lab work also
evaluates:

- **Detection-process honesty**. For any inference from telemetry data: has detection
  efficiency been characterised or explicitly acknowledged as unmodelled? Naive detection
  histories cannot pass the Ecological Gate without an explicit caveat.
- **Movement-scale alignment**. For any movement, residency, or space-use claim: does the
  analytical scale (temporal window, spatial extent, sample size) match the inferential
  scale (individual, sub-population, population)?
- **Management-context plausibility**. For any management-implication claim: is the
  recommendation framed in the language of the relevant fishery management council /
  agency (SAFMC, GMFMC, ASMFC, FWC, etc.), and does it match the council's data-quality
  bar?
- **Federal-proposal language compliance**. For any output destined for a federal funder
  (NOAA, USGS, DoD, NSF): has the geographic terminology ("Gulf of America" not "Gulf of
  Mexico") and climate language ("environmental change" not "climate change") been
  reviewed per `conventions/voice.md` section 10?
- **Species-vocabulary compliance**. Scientific names italicised everywhere; common name
  + scientific name on first mention; management framing consistent with
  `griffin-writing-style/references/species-vocabulary.md`.

---

## Gate 3 (Visual Gate): added criteria

In addition to the base framework criteria, Visual Gate for Griffin Lab work also
evaluates:

- **Map completeness**. Every spatial figure has a scale bar and (where orientation
  matters) a north arrow.
- **Projection consistency**. The CRS / EPSG used in the figure script matches the CRS
  used in the underlying analysis.
- **Colour palette**. Colourblind-safe palette in use (Okabe-Ito for categorical;
  viridis-family for sequential; RdBu for diverging) per `conventions/figure-format.md`.

---

## Gate 4 (Literature Gate): always applies for manuscripts

The Griffin Lab does not defer literature contextualisation to the manuscript-late phase;
the Literature Gate applies from Phase 3 onwards in `research-iterate`. This is a lab
override of the framework default, which allows the Literature Gate to be deferred.

Justification: the lab's writing voice depends on the
landmark / recent-core / cutting-edge citation balance documented in
`conventions/manuscript-format.md` section 4 and the
`griffin-writing-style/references/reference-quality-protocol.md`. Building citation
balance is easier when done early than retrofitted late.

---

## Gate 5 (Framing Gate): applies for management-leaning outputs

The Framing Gate is enforced for any output where management or policy implications are
load-bearing (proposals, applied-science manuscripts, policy briefs, council documents).
For pure methods papers and synthesis papers without explicit management framing, the
Framing Gate may be waived with written justification per the base framework.

---

## Cross-references

- Base file (unchanged): `conventions/research-quality-gates.md`
- Iteration workflow: `conventions/iteration-workflow.md`
- Visual review protocol: `conventions/visual-review-protocol.md`
- Voice (geographic and climate language): `conventions/voice.md`
- Reference quality:
  `~/github/claude_skills/writing/griffin-writing-style/references/reference-quality-protocol.md`
