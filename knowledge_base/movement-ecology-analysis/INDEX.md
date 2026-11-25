---
topic: movement-ecology-analysis
domain: "Methods: behavioural and spatial inference"
description: Analytical layer for movement-ecology inference: home range and utilisation distributions, state-space models for irregular telemetry, hidden Markov models for behavioural-state segmentation, step-selection analyses, network-based connectivity, and migratory-connectivity metrics. Marine and aquatic taxa focus.
last_updated: 2026-11-25
article_count: 6
ingested_sources: 5
owner: movement-ecology-specialist
co_owners: [acoustic-telemetry-specialist]
---

# Movement ecology analysis

## Topic overview

The analytical layer that translates raw location or detection data into inference about
animal behaviour, space use, and connectivity. Scope covers home-range and
utilisation-distribution estimation (KDE, AKDE, dynamic Brownian bridges), hidden Markov
models for behavioural-state segmentation, state-space models for irregular telemetry,
step-selection analyses, and network-based connectivity. Does not cover detection-history
construction (see `acoustic-telemetry-methods`) or population-scale distribution modelling
(see `species-distribution-modelling`).

## Key concepts

- **Movescape**. The spatial-environmental backdrop over which movement is expressed; an
  organising concept from Lowerre-Barbieri et al. (2021) that helps separate the movement
  process from the environment generating selection.
- **Home range / utilisation distribution**. KDE, AKDE (autocorrelated KDE), dynamic
  Brownian bridges, T-LoCoH, MCPs. Choice of method depends on data autocorrelation
  structure and the question.
- **Behavioural-state segmentation**. Hidden Markov models (HMMs) and state-space models that partition movement into discrete
  states (resident vs transit, foraging vs migrating) and estimate covariates on
  transition probabilities.
- **Step selection**. The probability that an animal selects an available environmental
  state given the realised step length and turning angle. Step-selection functions (SSF)
  and integrated step-selection analysis (iSSA).
- **Migratory connectivity**. Population-level connectivity strength between non-breeding
  and breeding areas; Mantel correlations, MC metric, transition matrices, network
  modularity.
- **Residency vs transit**. Per-individual or per-location classification into resident
  use vs transit; residency indices, area-restricted-search detection.

## Articles in this topic

| Article | Summary |
|---|---|
| [home-range-and-utilisation-distributions](articles/home-range-and-utilisation-distributions.md) | KDE, AKDE, and the autocorrelation pitfalls that govern method choice |
| [resource-selection-functions-with-clogit](articles/resource-selection-functions-with-clogit.md) | Matched case-control resource selection functions fitted with conditional logistic regression, with a cross-validation pattern |
| [migratory-contingents-and-entrainment](articles/migratory-contingents-and-entrainment.md) | Entrainment hypothesis for migratory marine fish; Western Atlantic tarpon contingents, vagrancy and collapse-recovery dynamics |
| [site-fidelity-on-reef-flats](articles/site-fidelity-on-reef-flats.md) | Residency index, dispersal distance, home range and network communities for bonefish on two fringing reef flats in Culebra |
| [sea-turtle-space-use-in-protected-areas](articles/sea-turtle-space-use-in-protected-areas.md) | Home ranges and relative habitat selection of immature green turtles inside a Caribbean marine protected area |
| [predator-prey-spatial-overlap](articles/predator-prey-spatial-overlap.md) | Co-occurrence, nonrandom arrival tests and random forest models of overlap between large sharks and tarpon and permit in the Florida Keys |

## Ingested sources (`raw/`)

| Source | Status | Headline finding |
|---|---|---|
| [Griffin_2025_EntrainmentHypothesis](raw/Griffin_2025_EntrainmentHypothesis.md) | validated | Three Western Atlantic tarpon contingents with mixing areas; vagrant adults far from their contingent; five entrainment hypotheses evaluated |
| [Griffin_2023_BonefishCulebra](raw/Griffin_2023_BonefishCulebra.md) | validated | 43 bonefish; mean residency 0.78, dispersal never beyond 3.52 km, mean MCP 0.65 km², every fish in the network community of its capture area |
| [Griffin_2020_GreenTurtleRSF](raw/Griffin_2020_GreenTurtleRSF.md) | validated | Small, overlapping home ranges below 3 km²; selection highest in shallow water near seagrass, in reef zones by day and night and lagoon zones at night |
| [Griffin_2022_PredatorPreyLandscapes](raw/Griffin_2022_PredatorPreyLandscapes.md) | validated | Potential predation risk heterogeneous in space and time; nonrandom shark arrival and large effect sizes at the Bahia Honda tarpon prespawning aggregation |
| [vanZinnicqBergmann_2024_IntraguildPredatorCommunity](raw/vanZinnicqBergmann_2024_IntraguildPredatorCommunity.md) | draft (abstract only) | Individual-based model with acoustic telemetry on eight elasmobranch species at Bimini; prey favour safety over food |

## Cross-references to other topics

- **acoustic-telemetry-methods**: detection histories are the structural input to most
  movement-ecology analyses.
- **species-distribution-modelling**: movement-derived occupancy or selection patterns can
  be inputs to population-scale habitat models; the two topics share a methodological
  boundary around space-use vs distribution.

## Bibliography pointers

`raw/`: per-source structured summaries with full provenance.

Foundational references:

- **Nathan et al. 2008**, *Proceedings of the National Academy of Sciences* 105: 19052-
  19059. "A movement ecology paradigm for unifying organismal movement research." The
  conceptual founding paper for modern movement ecology.
- **Cooke, Bergman, Twardek, Piczak, Casselberry et al. 2022**, *Journal of Fish Biology*
  101: 532-559. "The movement ecology of fishes." Lab-coauthored synthesis; sets the
  current movement-ecology framing for fishes.
- **Lowerre-Barbieri et al. 2021**, *Fish and Fisheries* 22: 1043-1067. "Movescapes and
  eco-evolutionary movement strategies in marine fish: Assessing a connectivity hotspot."
  Lab-coauthored; introduces and operationalises the movescape framing.
- **Fleming et al. 2015**, *Ecology* 96: 1182-1188. "Rigorous home range estimation with
  movement data: a new autocorrelated kernel density estimator." AKDE foundational.
- **Patterson et al. 2017**, *AStA Advances in Statistical Analysis* 101: 399-438.
  "Statistical modelling of individual animal movement: an overview of key methods and a
  discussion of practical challenges." Methodological synthesis.
- **Michelot et al. 2016**, *Methods in Ecology and Evolution* 7: 1308-1315. "moveHMM:
  an R package for the statistical modelling of animal movement data using hidden Markov
  models." Foundational HMM tool.

## Provenance and source-faithfulness

Standard `conventions/research.md` rules apply.
