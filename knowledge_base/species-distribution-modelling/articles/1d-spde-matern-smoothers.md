---
title: "1D SPDE Matérn smoothers for non-linear covariate effects (Farchadi approach)"
slug: 1d-spde-matern-smoothers
domain: "Methods: spatial inference"
aliases: ["1D SPDE", "SPDE smoothers", "Farchadi 1D smoothers"]
related: [integrated-sdm-with-inla-spde, oisst-vs-glorys-for-sst-covariates]
sources:
  - raw/Farchadi_2025_BlueShark_iSDM.md
  - raw/Krainski_2019_INLA-SPDE_textbook.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# 1D SPDE Matérn smoothers for non-linear covariate effects (Farchadi approach)

> **Stub article.** Replace placeholder text with verbatim extractions via
> `agents/literature-extractor.md`; verify via `agents/extraction-validator.md`. The
> empirical observations below derive from the lab's cobia iSDM project
> (`~/github/cobia_sdm_explore/`) and should be replaced or substantiated with
> published-literature equivalents where possible.

## Summary

1D SPDE Matérn smoothers, introduced operationally in the Farchadi-style integrated SDM,
replace manual polynomial or quadratic covariate terms with flexible non-linear basis
expansions learned from the data. In the Griffin Lab's cobia iSDM, switching from manual
linear + quadratic covariate terms to 1D SPDE smoothers cut DIC by approximately 58% and
revealed substantially different SST optima (~26.3°C vs ~29.2°C). 1D SPDE smoothers are
the lab's current default for any covariate that is expected to have non-monotonic
ecological response.

## Key points

### Why 1D SPDE smoothers

Marine fish-environment relationships are rarely monotonic: optima exist for SST,
salinity, depth, and chlorophyll. The classical SDM approach uses polynomial (often
quadratic) terms in a GLM / GLMM framework; this captures unimodal responses but
constrains shape and is sensitive to outlier covariate values that pull the polynomial
into implausible shapes. 1D SPDE smoothers replace the polynomial with a one-dimensional
stochastic-partial-differential-equation representation of a Gaussian random field, with
PC priors that control smoothness. The shape is learned from the data; outliers do not
distort the fit.

### Construction

```r
# 1D mesh covering the observed range of the covariate
sst_mesh1d <- inla.mesh.1d(
  seq(min(data$sst, na.rm = TRUE),
      max(data$sst, na.rm = TRUE),
      length.out = 20),
  boundary = "free",
  degree = 1
)

# SPDE on the 1D mesh
sst_spde1d <- inla.spde2.matern(sst_mesh1d)

# CRITICAL: assign to calling environment so inlabru can find it
assign("sst_spde1d", sst_spde1d, envir = .GlobalEnv)
```

20 knots is the lab's working default; sensitivity analyses across 10, 20, and 30 knots
should confirm the result is not knot-count-dependent.

### Component syntax (`inlabru`)

```r
components <- ~ sst(sst, model = sst_spde1d) +
                salinity(salinity, model = salinity_spde1d) +
                bathymetry(bathymetry, model = bath_spde1d) +
                shared_field(coords, model = shared_spde) +
                tel_intercept(1) + mr_intercept(1)
```

The component name (e.g., `sst`) appears in both the fit formula and the prediction
formula. **Critical**: the 1D SPDE objects must be `assign()`'d into the calling
environment for `inlabru` to find them at predict() time.

### Response-curve prediction

```r
# Construct a prediction frame across the covariate range
pred_sst <- data.frame(sst = seq(15, 32, by = 0.25))

# Use the component name as the formula
sst_response <- predict(fit, pred_sst, formula = ~ sst)

# Truncate to observed data range before plotting
sst_response <- sst_response[sst_response$sst >=
                             quantile(observed_sst, 0.01) &
                             sst_response$sst <=
                             quantile(observed_sst, 0.99), ]
```

### Empirical observations (Griffin Lab cobia iSDM, 2025)

[TODO: replace these with published-paper claims once cobia iSDM is in press; for now
they are documented empirical findings from the project memory.]

- Switching from manual linear + quadratic SST and salinity terms to 1D SPDE smoothers
  cut model DIC by approximately 58% (DIC dropped from ~27,383 to ~11,463 on the iSDM
  Constant model).
- Estimated SST optimum shifted: ~26.3°C with 1D SPDE smoothers vs ~29.2°C with manual
  quadratic terms. The 1D SPDE shape is bell-shaped with sharper roll-off above the
  optimum, consistent with thermal stress.
- Bathymetry effect remained weak in the INLA fit (95% CI bracketing zero) even with
  1D SPDE smoothing because the 2D shared spatial field absorbed the shelf-edge signal.
  The BRT ensemble confirmed bathymetry as the single highest-importance covariate
  (75.9% variable importance), with a sharp shelf-edge threshold near 0 m.

### Common pitfalls

- Not `assign()`'ing 1D SPDE objects into the calling environment, leading to
  `inlabru` errors at the predict() step.
- Choosing knot counts without sensitivity analysis: 10 knots oversmooths complex
  responses, 30+ knots overfits and inflates posterior uncertainty.
- Treating an apparently weak covariate effect as biologically weak when the 2D shared
  spatial field is absorbing the covariate's spatial structure. Always check this with a
  no-SPDE fit before reporting a covariate as ecologically unimportant.
- Comparing 1D-SPDE iSDM with manual-quadratic iSDM on different mesh or different CV
  folds; the 58% DIC improvement noted above was on identical mesh and identical
  data; cross-comparisons require controlled conditions.

## Methods and approaches

The lab's standard sequence:

1. Build 20-knot 1D SPDE for each non-linear covariate.
2. Set PC priors (default: `range = 1/0.05, sigma = 2/0.05`); confirm posterior
   sensitivity is acceptable.
3. Fit iSDM with `bru(safe = TRUE, inla.mode = "classic")`.
4. Generate response curves with `predict(fit, pred_frame, formula = ~ covariate_name)`.
5. Truncate to observed data range before plotting (avoid extrapolation in figures).
6. Report 95% credible interval on every response curve.

## Open questions

- Best-practice knot count for variable observed-range coverage (small N at one tail of
  the covariate range).
- The interaction between 1D SPDE smoothers and the shared 2D spatial field; when does
  the 2D field absorb a covariate signal and what diagnostics best surface it.
- Knot-placement strategies: equally-spaced (the lab default) vs quantile-based vs
  data-driven via adaptive meshing.

## Connections

- **Related to**: [[integrated-sdm-with-inla-spde]] (parent workflow).
- **Depends on**: well-characterised covariate range; reliable mesh; PC prior tuning.
- **Informs**: response-curve interpretation; sensitivity analyses to alternative
  covariate parameterisations.

## Sources

- **Farchadi et al. 2025.** "[TODO: full citation when published / ingested]."
  BlueShark integrated SDM framework with 1D SPDE smoothers.
  Reference code: `~/github/BlueShark_ISDM/`. [TODO: ingest.]
- **Krainski et al. 2019.** *Advanced Spatial Modeling with Stochastic Partial
  Differential Equations Using R and INLA.* Chapman & Hall. [TODO: ingest, especially
  Chapter on 1D SPDEs for non-linear smoothing.]

## Template usage notes

Stub article. Promote to `draft` after verbatim Farchadi extractions; to `published`
after `extraction-validator` confirms claim-citation alignment.
