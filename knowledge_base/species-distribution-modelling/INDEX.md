---
topic: species-distribution-modelling
domain: "Methods: spatial inference"
description: Species distribution modelling and integrated SDM (iSDM) for marine fishes, with emphasis on INLA-SPDE / inlabru frameworks, boosted regression trees (BRT), and the integration of telemetry, mark-recapture, and fishery-dependent data with marine environmental covariates. Includes climate-projection workflows and extrapolation diagnostics.
last_updated: 2026-05-26
article_count: 1
owner: species-distribution-modelling-specialist
co_owners: []
---

# Topic: Species distribution modelling

## Topic overview

Habitat- and distribution-modelling methods for marine fishes, with the Griffin Lab's
working preference for INLA-SPDE / inlabru integrated SDMs (Farchadi-style) that combine
multiple data streams with shared latent ecological fields and dataset-specific intercepts.
Scope covers iSDM and single-dataset SDM workflows, model evaluation and comparison,
projection and climate-scenario inference, and the operational handling of marine
environmental covariates. Does not cover environmental data acquisition itself (see
`geospatial-environmental-data-specialist`), telemetry detection-history construction (see
`acoustic-telemetry-methods`), or stock-assessment integration (see
`fisheries-stock-management-specialist`).

## Key concepts

- **Integrated SDM (iSDM)**. A modelling approach that fits multiple data streams jointly
  with a shared spatial random field and dataset-specific intercepts. Allows borrowing
  strength across heterogeneous data (telemetry, mark-recapture, fishery surveys) while
  respecting their different sampling biases.
- **INLA-SPDE**. Integrated nested Laplace approximation with stochastic partial
  differential equation representation of Gaussian Markov random fields; the lab's
  computational substrate for spatial-field SDMs via the `INLA` and `inlabru` packages.
- **1D SPDE Matérn smoothers**. Non-linear covariate-effect representation via
  one-dimensional SPDE basis expansions; replaces manual polynomial terms in iSDM
  workflows and is the lab's current default (Farchadi 2025 approach).
- **Penalised complexity (PC) priors**. Prior class that shrinks toward simpler models;
  used throughout the lab's INLA workflow for both spatial fields and covariate
  smoothers.
- **Boosted regression trees (BRT)**. Tree-based machine-learning alternative used
  alongside iSDM for cross-validation and variable-importance perspectives; `gbm`,
  `dismo::gbm.step`.
- **Niche–environment–data triangle**. The interpretive frame: a fitted distribution is
  the realised niche conditional on the observed environmental gradient and the sampling
  design.
- **Extrapolation diagnostics**. Visual and quantitative tools (MESS, environmental-
  envelope plots) that flag regions of prediction where covariate values lie outside the
  training envelope; load-bearing for any climate-projection inference.

## Articles in this topic

| Article | Summary |
|---|---|
| [integrated-sdm-with-inla-spde](articles/integrated-sdm-with-inla-spde.md) | Farchadi-style iSDM workflow with shared 2D SPDE, 1D SPDE covariate smoothers, and dataset-specific intercepts |

## Cross-references to other topics

- **acoustic-telemetry-methods**: detection or occurrence data from telemetry is one input
  stream to iSDMs.
- **movement-ecology-analysis**: movement-derived selection patterns provide complementary
  inference at the individual scale.
- Environmental-covariate workflows are owned by the
  `geospatial-environmental-data-specialist` agent (no dedicated KB topic yet; may be
  added if workflows accumulate).

## Bibliography pointers

`raw/`: per-source structured summaries.

Foundational references:

- **Farchadi et al. 2025**, "[TODO: full citation]". The blue-shark iSDM framework the
  lab's cobia SDM is built on. Reference implementation:
  `~/github/BlueShark_ISDM/`.
- **Krainski, Gomez-Rubio, Bakka, Lenzi, Castro-Camilo, Simpson, Lindgren, Rue 2019.**
  *Advanced Spatial Modeling with Stochastic Partial Differential Equations Using R and
  INLA.* Chapman & Hall. The INLA-SPDE textbook reference.
- **Bakka, Rue, Fuglstad, Riebler, Bolin, Illian, Krainski, Simpson, Lindgren 2018**,
  *WIREs Computational Statistics* 10: e1443. "Spatial modeling with R-INLA: A review."
  Methodological synthesis.
- **Lindgren, Rue, Lindström 2011**, *Journal of the Royal Statistical Society B* 73:
  423-498. "An explicit link between Gaussian fields and Gaussian Markov random fields:
  the stochastic partial differential equation approach." Foundational SPDE paper.
- **Elith, Leathwick 2009**, *Annual Review of Ecology, Evolution, and Systematics* 40:
  677-697. "Species distribution models: ecological explanation and prediction across
  space and time." General SDM synthesis.
- **Elith et al. 2008**, *Journal of Animal Ecology* 77: 802-813. "A working guide to
  boosted regression trees." Foundational BRT reference.
- **Bauder et al. 2018** *Ecography* 41: 1947-1957. "A guide to interpreting and applying
  niche models." Niche-model interpretation guidance.

## Provenance and source-faithfulness

Standard `conventions/research.md` rules apply.
