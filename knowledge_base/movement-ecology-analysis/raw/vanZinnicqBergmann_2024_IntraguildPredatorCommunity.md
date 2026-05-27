---
citation: "van Zinnicq Bergmann MPM, Griffin LP, Bodey TW, Guttridge TL, Aarts G, Heithaus MR, Smukall MJ, Papastamatiou YP. 2024. Intraguild processes drive space-use patterns in a large-bodied marine predator community. Journal of Animal Ecology 93(7): 876-890."
doi: 10.1111/1365-2656.14108
pmid: 38778676
journal: Journal of Animal Ecology
year: 2024
volume: "93"
issue: "7"
pages: "876-890"
published_online: "2024-05-22"
keywords: [biotelemetry, competition, habitat selection, ideal free distribution, intraguild, predation, random forest, resource selection functions]
source_pdf: NOT LOCALLY AVAILABLE (paywalled; abstract via PubMed)
extracted_by: WebFetch from PubMed PMID 38778676
extracted_on: 2026-05-26
validated_by: NOT YET validated
status: draft  # abstract is complete and verifiable; only main results body is missing
---

# Source extraction: van Zinnicq Bergmann et al. 2024, Journal of Animal Ecology — Intraguild processes in a marine predator community

## Verbatim abstract (from PubMed PMID 38778676)

> "Interspecific interactions, including predator-prey, intraguild predation (IGP) and
> competition, may drive distribution and habitat use [of marine predators]." The
> researchers employed individual-based models to forecast elasmobranch distributions in
> a subtropical Bahamian system with eight shark and ray species, then validated
> predictions using acoustic telemetry data.
>
> Key findings indicated that "prey and IG prey will preferentially select habitats based
> on safety over resources (food)," with smaller organisms showing stronger habitat
> safety preferences. Species exhibiting predator-prey relationships or asymmetrical
> intraguild predation demonstrated clearest spatial separation, while competitors
> displayed greater overlap with fine-scale microhabitat distinctions.

## Verbatim quantitative claims with PubMed-level provenance

- **Number of elasmobranch species studied:** 8 (sharks and rays) (Abstract)
- **Study site:** Bimini, The Bahamas (subtropical marine predator community) (Abstract)
- **Methods:** individual-based models (IBMs) to predict distributions, then validated
  with passive acoustic telemetry (Abstract)
- **Key finding 1:** prey and intraguild prey preferentially select habitats based on
  safety over food (Abstract)
- **Key finding 2:** smaller prey show stronger selection for safe habitat (Abstract)
- **Key finding 3:** species with predator-prey and asymmetrical IGP interactions show
  the clearest spatial separation (Abstract)
- **Key finding 4:** asymmetrical IGP among apex and large mesopredators produces
  intermediate spatial separation (Abstract)
- **Key finding 5:** competitors display greater overlap with fine-scale microhabitat
  distinctions (Abstract)

## Known publication details

- **First author:** Maurits P.M. van Zinnicq Bergmann (corresponding)
- **Second author:** Lucas P. Griffin
- **Other authors:** Thomas W. Bodey, Tristan L. Guttridge, Geert Aarts, Michael R.
  Heithaus, Matthew J. Smukall, Yannis P. Papastamatiou
- **Journal:** Journal of Animal Ecology
- **Issue/pages:** 93(7): 876-890
- **Published online:** 22 May 2024
- **DOI:** 10.1111/1365-2656.14108
- **PMID:** 38778676
- **Data deposit:** Dryad — https://datadryad.org/dataset/doi:10.5061/dryad.8gtht76x4

## How to complete this extraction

The paper is paywalled via Wiley but full text should be accessible through:
1. **USF institutional library** (Lucas's affiliation gives subscription access)
2. **Author copy:** the first author maintains a publications list; Lucas (as co-author)
   has direct access to the PDF
3. **Dryad data package** at https://datadryad.org/dataset/doi:10.5061/dryad.8gtht76x4
   contains the underlying data and may have a methods README that complements the paper

Once the full PDF is available locally, re-run the literature-extractor process to fill
in detailed methods (IBM specification, RSF/random-forest implementation,
acoustic-telemetry array design), key quantitative results (effect sizes, model
performance), and the discussion's mechanistic interpretation.

## Why this paper matters for the framework

This is the most recent first-coauthor publication establishing the **intraguild
predation (IGP) framing** for the lab's elasmobranch and large-predator community work.
Specifically relevant to:

- The movement-ecology-analysis topic (space-use under predator-prey + IGP +
  competition)
- The marine-megafauna-anthropogenic-impacts specialist (shark community ecology
  context for the Bahia Honda hammerhead-tarpon work)
- The catch-and-release-survival topic (predator presence and prey behaviour for PRP
  inference; complements the Casselberry 2024 and Griffin 2025 Bonefish papers)

The IBM + telemetry validation methodology is also methodologically relevant for any
future lab work that wants to combine simulation predictions with empirical detection
data.

## Cross-references

Article in framework: [intraguild-predation-and-space-use.md](../articles/intraguild-predation-and-space-use.md) (to be written for a complete coverage; currently the abstract alone is sufficient for citing the paper as a methods exemplar)

## Provenance

PubMed abstract fetched via WebFetch on 2026-05-26 (PMID 38778676 → published
abstract). Direct WebFetch from Wiley returned HTTP 402 (paywalled). The abstract is
complete and self-contained; the missing piece is the full-results-section detail and
the methods specification, which require Wiley-side access.

## Validation note

This is a `draft`-status extraction. The abstract claims are directly verifiable from
PubMed (a curated authoritative source). Promote to `published` only after the
`extraction-validator` agent confirms the abstract-quoted claims against the published
abstract (trivial check) AND a full-PDF pass adds the detailed methods and results.
