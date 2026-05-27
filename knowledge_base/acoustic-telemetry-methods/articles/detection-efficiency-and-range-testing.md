---
title: "Detection efficiency and range testing in passive acoustic telemetry"
slug: detection-efficiency-and-range-testing
domain: "Methods: detection and survey"
aliases: ["detection probability", "range testing", "detection-range adjustment"]
related: [vps-positioning, independent-detection-thresholds, occupancy-modelling]
sources:
  - raw/Brownscombe_2020_DetectionRangeAccounting.md
  - raw/Kessel_2014_RangeTestingReview.md
  - raw/Pincock_2012_FalseDetections.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Detection efficiency and range testing in passive acoustic telemetry

> **Stub article.** Replace the placeholder text with verbatim extractions from the cited
> sources (use `agents/literature-extractor.md` to ingest, then `agents/extraction-validator.md`
> to verify). The structure below mirrors the Griffin Lab's preferred article format.

## Summary

Detection probability is the per-survey, per-receiver probability that a tagged animal is
recorded when in the array, given that it is present. Treating raw detection counts or
binary detection histories as proxies for animal presence biases inference in known
directions, with the magnitude of bias depending on the per-receiver detection range
distribution and the deployment geometry. Range testing characterises the detection
envelope and feeds detection-efficiency models that partition the observation process from
the ecological process.

## Key points

### Why detection efficiency matters

In passive acoustic telemetry, a 1/0 detection record is the product of (1) the animal
being in the array, (2) the tag transmitting in the receiver's detection window, (3) the
acoustic signal propagating without occlusion by environmental noise, biofouling, or
sympatric tag collisions, and (4) the receiver decoding the signal. Each step has a
non-trivial failure probability, and the joint failure probability varies across
receivers, seasons, and tag specifications. Ignoring this structure produces apparent
spatial patterns that reflect the array, not the animal.

### Range testing approaches

- **Stationary range tests**: tag at known fixed positions, receivers at known positions,
  detection rate computed as a function of inter-station distance. Cheap; misses
  environmental variation.
- **Drift tests**: tag towed along transects across receiver positions; detection
  probability modelled as a function of distance with environmental covariates.
  Better captures real-world detection envelope.
- **Sentinel tags**: low-power sentinel tags installed at known positions inside the
  array, transmitting throughout the deployment; per-receiver detection rate becomes a
  continuous quality-control signal.

### Brownscombe et al. (2020) approach

The lab's working reference uses range-test data to fit a detection-probability surface
across the array, then adjusts subsequent spatial-ecology inference (residency, space use)
for the per-receiver detection-probability gradient. [TODO: extract verbatim claims and
worked-example numbers from Brownscombe et al. 2020 using literature-extractor.]

### Practical recommendations

[TODO: replace with verbatim claims from Kessel et al. 2014 range-testing review.]

## Methods and approaches

For new deployments the lab's default sequence is: (1) deploy range-test tags at three
distances within the expected detection envelope during deployment, (2) collect
range-test detections monthly to characterise seasonal variation, (3) fit a
detection-probability-by-distance model with environmental covariates, (4) propagate the
detection-probability surface into downstream residency and space-use estimates.

## Open questions

- The interaction between AI-assisted false-detection filtering and the Pincock false-rate
  framework is under-explored in published literature.
- Cross-network comparability of detection efficiency (FACT vs OTN vs iTAG) when array
  geometries and tag specifications differ.

## Connections

- **Related to**: [[independent-detection-thresholds]], [[vps-positioning]].
- **Depends on**: nothing within the topic; this is the foundational concept.
- **Informs**: [[occupancy-modelling]], all downstream movement-ecology inference.
- **Pattern**: imperfect detection is the shared challenge across acoustic, camera-trap,
  mark-recapture, and acoustic-survey work.

## Sources

All claims trace to one of the entries below.

- **Brownscombe et al. 2020.** "A practical method to account for variation in detection
  range in acoustic telemetry arrays to accurately quantify the spatial ecology of
  aquatic animals." *Methods in Ecology and Evolution* 11: 82-94. DOI: 10.1111/2041-210X.13322.
  [TODO: ingest and extract pages.]
- **Kessel et al. 2014.** "A review of detection range testing in aquatic passive acoustic
  telemetry studies." *Reviews in Fish Biology and Fisheries* 24: 199-218.
  DOI: 10.1007/s11160-013-9328-4. [TODO: ingest.]
- **Pincock 2012.** "False detection rates in acoustic telemetry." Vemco Application Note
  AN-005. [TODO: ingest.]

## Template usage notes

- Status `stub` means this article is a placeholder; do not cite from it until elevated to
  `draft` (verbatim extractions in place) or `published` (extraction-validator confirmed).
- Each TODO marker indicates a verbatim extraction needed before the article advances.
- Use `agents/literature-extractor.md` to populate; use `agents/extraction-validator.md` to
  verify.
