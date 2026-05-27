---
topic: movement-ecology-analysis
domain: "Methods: behavioural and spatial inference"
description: Analytical layer for movement-ecology inference: home range and utilisation distributions, state-space models for irregular telemetry, hidden Markov models for behavioural-state segmentation, step-selection analyses, network-based connectivity, and migratory-connectivity metrics. Marine and aquatic taxa focus.
last_updated: 2026-05-26
article_count: 2
owner: movement-ecology-specialist
co_owners: [acoustic-telemetry-specialist]
---

# Topic: Movement ecology analysis

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
- **Behavioural-state segmentation**. HMMs and SSMs that partition movement into discrete
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
| [resource-selection-functions-with-clogit](articles/resource-selection-functions-with-clogit.md) | Matched case-control RSFs via `survival::clogit(method = "efron")`; cross-validation pattern with manual covariate prediction |

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
