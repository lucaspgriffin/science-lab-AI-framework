---
title: "Resource selection functions with clogit: matched case-control RSFs for coastal telemetry"
slug: resource-selection-functions-with-clogit
domain: "Methods: behavioural and spatial inference"
aliases: ["RSF", "clogit RSF", "matched case-control RSF", "step-selection vs RSF"]
related: [home-range-and-utilisation-distributions, hidden-markov-models]
sources:
  - raw/Manly_2002_RSF_textbook.md
  - raw/Boyce_2002_RSF.md
  - raw/Therneau_survival_package.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Resource selection functions with clogit: matched case-control RSFs for coastal telemetry

> **Stub article.** Replace placeholder text with verbatim extractions via
> `agents/literature-extractor.md`; verify via `agents/extraction-validator.md`. The
> empirical observations below derive from the lab's DBT-Visual-Survey terrapin
> resource-selection project.

## Summary

Resource selection functions (RSFs) estimate the probability of habitat use as a function
of environmental covariates, conditional on availability. Matched case-control RSFs
implemented with conditional logistic regression (`clogit()` in the `survival` package)
provide a flexible framework for telemetry data where used and available locations are
paired by individual or by time step. The `clogit` framework supports a `strata()` term
that pairs used and available locations within each individual or session, controlling for
unmeasured individual-level heterogeneity.

## Key points

### Why matched case-control RSF

Standard logistic-regression RSFs treat used and available locations as exchangeable;
matched designs (used and available paired within a `strata` group) control for
individual-level differences in availability, sampling effort, and unmeasured covariates.
This is particularly useful for telemetry data where:

- Individuals have different home-range extents (different availability domains).
- Tracking durations differ across individuals.
- Habitat composition varies across the study area.

The `clogit()` function in the `survival` package implements conditional logistic
regression and is the lab's working default for matched-design RSFs on coastal telemetry
data.

### Implementation

```r
library(survival)

# Construct matched used / available pairs per individual
# data must have: used (1/0), strata_id (individual or session), covariates
fit <- clogit(
  used ~ veg_class + dist_to_water + tide_state +
         strata(strata_id),
  data = paired_df,
  method = "efron"   # NOT "exact" — see pitfalls below
)
```

### method = "efron" vs "exact"

For RSF use, **always use `method = "efron"`**, not `"exact"`. The `"exact"` method
becomes computationally infeasible for typical telemetry datasets (thousands of pairs)
and provides no inferential advantage for the RSF use case (where ties in continuous
covariates are not meaningfully informative). The lab's DBT-Visual-Survey terrapin
project documented an explicit lesson on this: `method = "exact"` failed to converge on
a typical telemetry dataset; switching to `"efron"` gave a stable fit with no loss of
inferential validity.

### k-fold cross-validation with manual covariate prediction

Cross-validation for `clogit` RSFs requires manual prediction. The `clogit` object does
not provide a straightforward `predict.newdata()` method; the standard pattern is:

```r
# Extract coefficients from training fit
coefs <- coef(fit)

# Manually compute linear predictor on test data
test_lp <- as.matrix(test_df[, names(coefs)]) %*% coefs

# Per-stratum standardisation: subtract the max LP in each test stratum
# to keep predictions on a comparable scale across strata
test_df$lp_std <- test_lp - ave(test_lp, test_df$strata_id, FUN = max)

# Evaluate with AUC or Boyce index, NOT on the raw linear predictor pooled across strata
```

The lab's DBT-Visual-Survey workflow uses the Boyce index for evaluation because AUC
behaves poorly with the matched case-control structure (where the "absence" set is not
true absence but designed availability).

### Avoiding zero-pixel issues

For NLCD or other coarse-resolution raster covariates, extracting values at telemetry
points sometimes yields zero or missing pixels at coastline edges. Guards:

- Use `terra::extract(method = "bilinear")` for continuous covariates.
- For categorical covariates, use `method = "simple"` but check the proportion of NA
  extractions before fitting; > 5% NA suggests a coastline-buffer issue that needs
  manual adjustment of the availability domain.
- Apply a focal-mean fill (`terra::focal(w = 5, fun = "mean", na.rm = TRUE,
  na.policy = "only")`) to derived covariates before extraction.

### Seasonal KDE and multi-route comparisons

For comparing RSFs across seasons or behavioural states, the lab's workflow fits separate
`clogit` models per stratum (season or state) and compares coefficients and ranked-route
performance. Pooling across seasons with a season-dummy interaction is an alternative but
loses interpretability when many covariates have seasonal modulation.

### Common pitfalls

- Using `method = "exact"` on a typical telemetry dataset; switch to `"efron"`.
- Pooling individuals with very different tracking durations as if they contributed
  equivalent matched pairs.
- Reporting predictions on the raw linear predictor pooled across strata (the LP scale
  is not comparable across strata in `clogit`).
- Evaluating with AUC pooled across strata; use Boyce index or per-stratum AUC.
- Using AIC for model selection on `clogit` fits; AIC behaves poorly for conditional
  likelihood. Use likelihood-ratio tests or k-fold CV.

## Methods and approaches

The lab's default sequence (per `DBT-Visual-Survey/`):

1. Define the availability domain per individual (typically a home-range buffer or a
   movement-step pool).
2. Sample available points within the domain at a 5:1 or 10:1 ratio to used points.
3. Construct `strata_id` per individual (or per session for short tracks).
4. Extract environmental covariates at used and available points.
5. Fit `clogit(used ~ covariates + strata(strata_id), method = "efron")`.
6. Cross-validate via k-fold split on individuals (not on points), with manual
   linear-predictor prediction and Boyce-index evaluation.
7. Report coefficients with 95% CIs and ranked-route plots.

## Open questions

- Integrated step-selection analysis (iSSA, via `amt`) is increasingly the
  recommended successor to matched case-control RSFs; the lab's experience with iSSA
  on coastal-bay telemetry data is limited.
- Choice of availability-domain definition (home-range buffer vs movement-step pool vs
  full study area) materially affects coefficient interpretation; the published
  guidance is mixed.
- Spatial autocorrelation residuals in `clogit` RSFs are difficult to diagnose; the
  lab currently does not formally test for residual autocorrelation.

## Connections

- **Related to**: [[home-range-and-utilisation-distributions]] (defines the availability
  domain).
- **Depends on**: well-characterised availability set; reliable environmental covariate
  rasters.
- **Informs**: habitat-suitability inference, MPA design, channel and microhabitat
  characterisation.

## Sources

- **Manly et al. 2002.** *Resource Selection by Animals: Statistical Design and Analysis
  for Field Studies* (2nd edition). Kluwer Academic Publishers. [TODO: ingest.]
- **Boyce et al. 2002.** "Evaluating resource selection functions." *Ecological
  Modelling* 157: 281-300. DOI: 10.1016/S0304-3800(02)00200-4. [TODO: ingest.]
- **Therneau and Grambsch 2000.** *Modeling Survival Data: Extending the Cox Model.*
  Springer. (Reference for `survival::clogit` implementation.) [TODO: ingest.]

## Template usage notes

Stub article. Promote to `draft` after verbatim extractions and DBT-Visual-Survey
empirical claims; to `published` after `extraction-validator` confirms claim-citation
alignment.
