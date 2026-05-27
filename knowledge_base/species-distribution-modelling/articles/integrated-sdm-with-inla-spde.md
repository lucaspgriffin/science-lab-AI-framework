---
title: "Integrated species distribution modelling with INLA-SPDE (Farchadi-style iSDM)"
slug: integrated-sdm-with-inla-spde
domain: "Methods: spatial inference"
aliases: ["iSDM", "INLA iSDM", "Farchadi iSDM", "shared spatial field model"]
related: [boosted-regression-trees, climate-projection-sdms, detection-efficiency-and-range-testing]
sources:
  - raw/Farchadi_2025_BlueShark_iSDM.md
  - raw/Lindgren_Rue_2011_SPDE.md
  - raw/Krainski_2019_INLA-SPDE_textbook.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Integrated species distribution modelling with INLA-SPDE (Farchadi-style iSDM)

> **Stub article.** Replace placeholder text with verbatim extractions via
> `agents/literature-extractor.md`; verify via `agents/extraction-validator.md`.

## Summary

An integrated species distribution model (iSDM) jointly fits multiple data streams (e.g.,
telemetry, mark-recapture, fishery-independent surveys) under a shared latent ecological
field, with dataset-specific intercepts that absorb sampling-design differences. The
Farchadi-style formulation uses an INLA-SPDE representation of the shared field together
with 1D SPDE Matérn smoothers for covariate effects. The approach trades the
implementational simplicity of single-dataset SDMs for the ability to borrow strength
across heterogeneous data while respecting their distinct biases.

## Key points

### Structure of a Farchadi-style iSDM

- **Shared 2D SPDE spatial field**: a Gaussian Markov random field defined on a finite-
  element mesh covering the study extent, representing unmodelled spatial structure
  common across data streams. Penalised-complexity (PC) priors control range and sigma.
- **Dataset-specific intercepts**: each data stream gets its own intercept, absorbing
  per-dataset detection / encounter probability and unmodelled per-dataset bias.
- **Copy effect**: secondary data streams' spatial structure is parameterised as a
  `copy` of the primary 2D SPDE with `fixed = FALSE`, allowing a scaling parameter to
  modulate the borrowing strength.
- **1D SPDE Matérn smoothers** for covariate effects: each covariate enters as a
  one-dimensional SPDE basis with PC priors, replacing manual polynomial or B-spline
  terms.
- **Optional seasonal AR1 cyclic SPDE**: a cyclic temporal random field for seasonal
  structure, enabled when seasonal variation in the target is substantive.

### Component syntax (`inlabru`)

Each covariate is registered as a component:

```r
sst(sst, model = sst_spde1d)
salinity(salinity, model = salinity_spde1d)
bathymetry(bathymetry, model = bath_spde1d)
```

The component name appears in both the fit formula and the prediction formula. **Critical
operational point**: the 1D SPDE objects must be `assign()`'d into the calling environment
for `inlabru` to find them, or wrapped in a `local()` block.

### Model fit calls

```r
fit <- bru(components = ~ sst(sst, model = sst_spde1d) +
                          salinity(salinity, model = salinity_spde1d) +
                          shared_field(coords, model = shared_spde) +
                          tel_intercept(1) + mr_intercept(1),
           tel_likelihood,
           mr_likelihood,
           options = list(safe = TRUE, inla.mode = "classic"))
```

`inla.mode = "classic"` is required for downstream `inla.posterior.sample()` compatibility;
`compact` mode breaks this.

### Mesh design

The mesh is the discretisation of the spatial domain on which the SPDE field is defined.
For marine extents:

- Use `inla.mesh.2d()` with an ocean-only boundary (clip the convex hull to coastline).
- Simplify coastline with `st_simplify(dTolerance = 0.1)` before passing to
  `inla.sp2segment()`.
- `sf_use_s2(FALSE)` before boundary operations.
- Target 200-500 vertices for a regional extent; more produces uncertainty-honeycomb
  artefacts and long fit times.

### Prediction and posterior summaries

- Per-covariate response curves: `predict(fit, pred_sf, formula = ~ sst)` isolates the
  single-covariate partial effect.
- Spatial-field posterior median: use `inlabru::spde.posterior()` rather than reading
  `$summary.random$<field>$median` directly. Wrap in `tryCatch()` because the return
  object's `$median` slot is not always populated as expected.
- Climate-projection surfaces: predict on future-covariate rasters; pair every
  projection with an extrapolation diagnostic showing where future covariate space lies
  outside the training envelope.

### Model comparison and evaluation

- **Within iSDM**: DIC, WAIC.
- **Across model families** (iSDM vs BRT vs MaxEnt): spatial cross-validation (k-fold
  spatial block) on a holdout set; AUC, TSS, Boyce index. Do not compare iSDM and BRT on
  the same dataset using the same in-sample DIC.

## Methods and approaches

The lab's standard sequence for an iSDM analysis (per `cobia_sdm_explore/`):
`00_config.R` → `01_data_preparation.R` → `02_env_*.R` (covariate extraction) →
`03a_inla_isdm.R` (iSDM fit, constant and seasonal) → `03b_brt_models.R` (BRT comparison)
→ `04_projections.R` → `05_model_comparison.R` (spatial CV).

## Open questions

- How best to handle non-Gaussian observation likelihoods in the iSDM framework when
  one dataset is presence-only and another is count.
- Optimal mesh-density vs computational-cost trade-off for large marine extents.
- Best practice for propagating tag-detection-probability uncertainty from telemetry
  into iSDM likelihood weighting.

## Connections

- **Related to**: [[boosted-regression-trees]], [[climate-projection-sdms]].
- **Depends on**: clean environmental rasters from the
  `geospatial-environmental-data-specialist` workflow; clean detection histories from
  [[detection-efficiency-and-range-testing]].
- **Informs**: spatial-management planning, stock-structure inference (with
  `fisheries-stock-management-specialist`).

## Sources

- **Farchadi et al. 2025.** "[TODO: full citation when ingested]." Blue-shark integrated
  SDM framework. Reference code: `~/github/BlueShark_ISDM/`. [TODO: ingest.]
- **Lindgren, Rue, Lindström 2011.** "An explicit link between Gaussian fields and
  Gaussian Markov random fields: the stochastic partial differential equation approach."
  *Journal of the Royal Statistical Society B* 73: 423-498. DOI: 10.1111/j.1467-9868.2011.00777.x.
  [TODO: ingest.]
- **Krainski et al. 2019.** *Advanced Spatial Modeling with Stochastic Partial
  Differential Equations Using R and INLA.* Chapman & Hall. [TODO: ingest.]

## Template usage notes

Stub article. Promote to `draft` after verbatim extractions; to `published` after
`extraction-validator` confirms claim-citation alignment.
