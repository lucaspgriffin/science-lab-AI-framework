---
title: "Hurdle BRT models for fish habitat suitability (two-stage prevalence + intensity)"
slug: hurdle-brt-habitat-suitability
domain: "Methods: spatial inference"
aliases: ["hurdle BRT", "two-stage BRT", "zero-inflated BRT", "delta model"]
related: [integrated-sdm-with-inla-spde]
sources:
  - raw/Potts_Elith_2006_BRT_HabitatSuitability.md
  - raw/Elith_2008_WorkingGuide_BRT.md
status: stub
origin: manual
last_invoked: 2026-05-26
---

# Hurdle BRT models for fish habitat suitability (two-stage prevalence + intensity)

> **Stub article.** Replace placeholder text with verbatim extractions via
> `agents/literature-extractor.md`; verify via `agents/extraction-validator.md`. The
> empirical observations below derive from the lab's FIM_TB / Tampa Bay habitat
> suitability project and should be substantiated with published-literature equivalents
> where possible.

## Summary

A hurdle (or delta) BRT model decomposes a zero-inflated species-abundance response into
two stages: a Bernoulli classification of presence vs absence (the "prevalence" or
"hurdle" stage) and a positive-count regression conditional on presence (the "intensity"
stage). The two stages are fitted independently and combined at prediction time. The
approach is well-suited to fishery-independent monitoring (FIM) data, which is
characteristically zero-inflated at the haul or station level.

## Key points

### Why two stages

A standard BRT on a zero-inflated count response is dominated by the zero-vs-positive
boundary, with the result that the regression curve at positive abundance is poorly
estimated. The hurdle decomposition separates the two processes:

- **Stage 1 (prevalence)**: Bernoulli BRT on presence-absence; identifies environmental
  drivers of where the species occurs.
- **Stage 2 (intensity)**: Gaussian / log-normal / Poisson / negative-binomial BRT on
  positive counts only; identifies drivers of abundance where the species is present.

The combined prediction multiplies the two: E[count] = P(presence) × E[count | presence].

### Implementation in R

The lab uses `gbm` with `gbm.step` for parameter selection, separately for each stage.
Standard pipeline:

```r
# Stage 1: prevalence
prev_brt <- gbm.step(
  data = train_df,
  gbm.x = covariate_indices,
  gbm.y = which(names(train_df) == "presence"),
  family = "bernoulli",
  tree.complexity = 5,
  learning.rate = 0.005,
  bag.fraction = 0.75
)

# Stage 2: intensity (subset to positive observations)
pos_df <- train_df[train_df$count > 0, ]
intens_brt <- gbm.step(
  data = pos_df,
  gbm.x = covariate_indices,
  gbm.y = which(names(pos_df) == "count"),
  family = "gaussian",   # or "poisson" / "negbin" depending on intensity distribution
  tree.complexity = 5,
  learning.rate = 0.005,
  bag.fraction = 0.75
)

# Combine at predict time
prev_pred <- predict(prev_brt, newdata = pred_df, n.trees = prev_brt$gbm.call$best.trees,
                     type = "response")
intens_pred <- predict(intens_brt, newdata = pred_df, n.trees = intens_brt$gbm.call$best.trees,
                       type = "response")
combined_pred <- prev_pred * intens_pred
```

### Evaluation

- **Stage 1**: AUC, sensitivity-specificity, deviance reduction.
- **Stage 2**: predicted-vs-observed plots, residual diagnostics, cross-validated R².
- **Combined**: spatial cross-validation (block CV) on the combined prediction, plus
  qualitative checks against known high-density areas.

### Common pitfalls

- Treating the two stages as independent at the interpretation level when the underlying
  ecological process couples them (e.g., environmental gradients that affect both
  presence and intensity but at different scales).
- Pooling all haul-level observations as if independent when the sampling design has
  station-level clustering; use block CV.
- Reading a poorly-fit Stage 2 as "no abundance signal" when the issue is small
  sample size of positive observations.
- Using a Gaussian intensity model on a heavy-tailed catch-count distribution; the
  Gaussian assumption is often violated in fish CPUE data, and a log-transformation or
  negative-binomial alternative is appropriate.

### Empirical observations (Griffin Lab FIM_TB Tampa Bay project)

[TODO: replace with published-paper claims when FIM_TB results are in press.]

- Two-stage hurdle BRT outperformed single-stage zero-inflated BRT on Tampa Bay
  fishery-independent data for three game-fish species (snook, redfish, spotted
  seatrout).
- AUC for the prevalence stage was 0.78–0.85 across species; predicted-vs-observed
  R² for the intensity stage was 0.25–0.40.
- Coastline data quality matters: `coastline.gpkg` had NaN artefacts that propagated
  into prediction grids; the working substitute was a bathymetry raster clipped to the
  > -0.5 m contour.

## Methods and approaches

The lab's default sequence:

1. Split data into haul-level / station-level observations with paired environmental
   covariates.
2. Define presence (count > 0) and intensity (count, conditional on presence).
3. Fit Stage 1 (Bernoulli BRT) with `gbm.step()` parameter selection.
4. Fit Stage 2 (Gaussian / Poisson / negative-binomial BRT) on positives only.
5. Evaluate each stage independently; evaluate the combined prediction with spatial
   block CV.
6. Report variable importance from both stages; compare to identify whether prevalence
   and intensity respond to similar or different environmental gradients.

## Open questions

- Best-practice integration of hurdle BRT predictions with iSDM-style inference (does
  combining BRT-derived prevalence with INLA-derived intensity make sense?).
- The choice of intensity family (Gaussian vs Poisson vs negative-binomial) is often
  data-driven; published guidance for fish-CPUE distributions is sparse.
- Spatial-block CV partition design (cell size, number of folds) and its effect on
  combined-prediction performance metrics.

## Connections

- **Related to**: [[integrated-sdm-with-inla-spde]] (alternative SDM framework).
- **Depends on**: clean coastline / land-mask raster; reliable environmental covariates;
  station-level (not pooled) observation data.
- **Informs**: management-relevant habitat suitability maps; cross-species
  comparison of habitat drivers.

## Sources

- **Potts and Elith 2006.** "Comparing species abundance models." *Ecological Modelling*
  199: 153-163. DOI: 10.1016/j.ecolmodel.2006.05.025. [TODO: ingest.]
- **Elith et al. 2008.** "A working guide to boosted regression trees." *Journal of
  Animal Ecology* 77: 802-813. DOI: 10.1111/j.1365-2656.2008.01390.x. [TODO: ingest.]

## Template usage notes

Stub article. Promote to `draft` after verbatim extractions and FIM_TB-paper-derived
empirical claims; to `published` after `extraction-validator` confirms claim-citation
alignment.
