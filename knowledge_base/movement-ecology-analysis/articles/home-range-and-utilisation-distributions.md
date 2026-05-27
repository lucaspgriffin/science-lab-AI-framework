---
title: "Home range and utilisation distributions in marine telemetry"
slug: home-range-and-utilisation-distributions
domain: "Methods: behavioural and spatial inference"
aliases: ["KDE", "AKDE", "Brownian bridge", "utilisation distribution"]
related: [hidden-markov-models, residency-classification]
sources:
  - raw/Fleming_2015_AKDE.md
  - raw/Calabrese_2016_ctmm.md
  - raw/Lowerre-Barbieri_2021_Movescapes.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Home range and utilisation distributions in marine telemetry

> **Stub article.** Replace placeholder text with verbatim extractions from the cited
> sources via `agents/literature-extractor.md`, then verify via `agents/extraction-validator.md`.

## Summary

A utilisation distribution (UD) is the probability density that an animal is found at a
given location during a defined time window. Home range is the area enclosing some
quantile of the UD, conventionally 95% (or 50% for the core area). Kernel density estimation
(KDE) is the historical default; autocorrelated KDE (AKDE) is the current best practice for
telemetry data with non-trivial autocorrelation, which is most marine telemetry data.
Minimum convex polygons (MCPs) are not quantitative UDs and are appropriate only as crude
extent summaries.

## Key points

### Method selection

- **KDE** assumes independent location samples. Marine telemetry rarely satisfies this:
  detections at adjacent times are correlated by the animal's movement rate and the
  receiver geometry. Naive KDE on autocorrelated data over-smooths the UD and
  under-estimates the home range.
- **AKDE** (Fleming et al. 2015, `ctmm` package) explicitly models the autocorrelation
  structure via a fitted continuous-time movement model (OUF, IOU, OU) and uses the
  variogram fit to choose a movement model before estimating the UD. This is the lab's
  default for non-sparse marine telemetry datasets.
- **Dynamic Brownian bridges** (BBMM, dBBMM) work well for GPS-tracked taxa with
  high-frequency relocations along a track; less well suited to acoustic detection data,
  which is presence-at-receiver rather than continuous location.
- **T-LoCoH** (time-local convex hull) builds UDs from time-aware nearest-neighbour
  clusters; useful for fine-scale behavioural inference but data-hungry.
- **MCPs** are extent summaries; report alongside, do not use as UDs.

### Workflow for AKDE

1. Project location data into an equal-area CRS appropriate for the study extent.
2. Plot the variogram (`ctmm::variogram()`); if the variogram does not asymptote within the
   sampling duration, the dataset cannot support a full home-range estimate.
3. Fit candidate continuous-time movement models (`ctmm.fit()` on IID, OU, OUF starting
   conditions).
4. Select the best-supported model via AIC.
5. Compute AKDE (`akde()`) with the selected model.
6. Report the home range with explicit confidence intervals and the effective sample size
   (which can be substantially less than the raw detection count).

### Sample-size and tracking-duration constraints

Home range estimates degrade rapidly below an effective sample size of ~50 (per Fleming et
al. 2015 simulations); short-duration tracks may not capture full range use even with many
detections. The effective sample size from AKDE is the most honest quality indicator.

### Pitfalls in acoustic telemetry

- Receiver placement biases the UD toward the array footprint; a UD that ends at a
  receiver edge is an array artefact.
- Per-receiver detection probability variation produces apparent spatial intensity
  differences that are not behavioural.
- Pooling individuals with different tracking durations produces a population-level UD
  weighted by tracking effort, not by space use.

## Methods and approaches

The lab's default for acoustic telemetry home-range estimation: AKDE on the detection-
positioned data (median receiver positions weighted by detection counts, or VPS positions
where available), with the variogram inspected to confirm asymptote, with sensitivity
analyses across alternative time windows (seasonal, annual) and tag specifications, and
with explicit reporting of effective sample size.

## Open questions

- AKDE handling of acoustic-detection data (presence at receivers rather than continuous
  GPS locations) is less standardised than for GPS telemetry; the lab has emerging
  internal workflow but the published guidance is sparse.
- Multi-scale home-range characterisation (core vs total vs seasonal) often produces
  inconsistent results across methods; method-comparison studies are limited in the marine
  literature.

## Connections

- **Related to**: [[hidden-markov-models]], [[residency-classification]].
- **Depends on**: [[detection-efficiency-and-range-testing]] (for detection-corrected
  effort).
- **Informs**: spatial-management boundary delineation, MPA design,
  habitat-suitability mapping.

## Sources

- **Fleming et al. 2015.** "Rigorous home range estimation with movement data: a new
  autocorrelated kernel density estimator." *Ecology* 96: 1182-1188.
  DOI: 10.1890/14-2010.1. [TODO: ingest.]
- **Calabrese, Fleming, and Gurarie 2016.** "ctmm: an R package for analyzing animal
  relocation data as a continuous-time stochastic process." *Methods in Ecology and
  Evolution* 7: 1124-1132. DOI: 10.1111/2041-210X.12559. [TODO: ingest.]
- **Lowerre-Barbieri, Friess, Morley, Skomal et al. 2021.** "Movescapes and
  eco-evolutionary movement strategies in marine fish: Assessing a connectivity hotspot."
  *Fish and Fisheries* 22: 1043-1067. DOI: 10.1111/faf.12569. [TODO: ingest.]

## Template usage notes

Stub article; promote to `draft` after verbatim extractions, to `published` after
`extraction-validator` confirmation.
