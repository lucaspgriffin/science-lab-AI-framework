---
topic: acoustic-telemetry-methods
domain: Methods: detection and survey
description: Passive acoustic telemetry for marine and estuarine fish (tarpon, cobia, bonefish, permit, snook, sharks) and sea turtles. Receiver array design, VPS positioning, detection-efficiency modelling, tag specification, deployment logistics, cooperative networks (FACT, iTAG, OTN, ACT, MATOS), and detection-history construction.
last_updated: 2026-05-26
article_count: 2
owner: acoustic-telemetry-specialist
co_owners: []
---

# Topic: Acoustic telemetry methods

## Topic overview

The methodological foundation of the Griffin Lab's research programme. This topic covers the
deployment, characterisation, and analytical preparation of passive acoustic telemetry data
in marine and estuarine systems. Scope includes: receiver array design (gates, grids, VPS
deployments), detection-efficiency modelling and range testing, tag specification and
retention, detection-history construction from raw events, false-detection filtering, and
integration with environmental covariates. Does not cover downstream behavioural inference
(see `movement-ecology-analysis`) or population-scale habitat modelling (see
`species-distribution-modelling`).

## Key concepts

- **Detection probability**. The per-survey, per-receiver probability that a tagged animal
  is detected when in range, conditional on detection-window, transmitter output,
  environmental noise, and biofouling state.
- **Detection range and range testing**. Stationary and drift-test characterisation of the
  per-receiver detection envelope under varying environmental conditions; the
  Brownscombe et al. (2020) detection-range-adjusted spatial-ecology approach.
- **VPS positioning**. Multi-receiver synchronous detection geometry that yields
  sub-receiver positional estimates from time-difference-of-arrival; sync-tag placement,
  geometric dilution of precision, positional accuracy validation.
- **Independent-detection thresholding**. Setting the minimum interval (typically 30 or 60
  minutes) between consecutive detections of the same tag at the same receiver to avoid
  pseudoreplication of behaviour at the receiver.
- **Tag retention and shedding**. External (towed, dart) vs intramuscular vs intracoelomic
  surgical tag attachment; retention rates and bias on long-term residency estimates.
- **Effort accounting**. Deployment-day vs detection-day denominators; receiver downtime
  (storms, battery exhaustion, biofouling); pooling across heterogeneous tag specifications.
- **Cooperative networks**. FACT (Florida Atlantic Coast Telemetry), iTAG (integrated
  Tagging and Tracking of Atlantic Goliath grouper and others, NOAA SEFSC), OTN (Ocean
  Tracking Network), ACT (Atlantic Cooperative Telemetry), MATOS. Data sharing
  conventions, Movebank deposits, cross-network calibration.

## Articles in this topic

| Article | Summary |
|---|---|
| [detection-efficiency-and-range-testing](articles/detection-efficiency-and-range-testing.md) | Stationary and drift-test approaches to detection-efficiency characterisation; integration into spatial-ecology inference |
| [region-misclassification-data-qa](articles/region-misclassification-data-qa.md) | Empirical data-QA pattern for cooperative-network telemetry feeds; upstream region labels do not always match station coordinates |

## Cross-references to other topics

- **movement-ecology-analysis**: detection-history is the structural input to all
  movement-pattern inference. See bridge in `GLOBAL-CONCEPTS.md`.
- **catch-and-release-survival**: post-release acoustic detection (or non-detection) is the
  primary evidence stream for C&R survival in the lab's tarpon, cobia, and permit work.
- **species-distribution-modelling**: telemetry-derived occupancy or detection points are one
  data stream into integrated SDMs alongside mark-recapture and fishery data.

## Bibliography pointers

`raw/` (this directory): per-source structured summaries with full provenance (DOI, page
numbers, key claims). One Markdown file per ingested source.

Foundational references to ingest first:

- **Brownscombe et al. 2020**, *Methods in Ecology and Evolution* 11: 82-94. "A practical
  method to account for variation in detection range in acoustic telemetry arrays to
  accurately quantify the spatial ecology of aquatic animals." The lab's methodological
  reference for detection-range-adjusted spatial ecology.
  DOI: 10.1111/2041-210X.13322.
- **Heupel et al. 2006**, *Marine and Freshwater Research* 57: 1-13. "Automated acoustic
  tracking of aquatic animals: scope, design and deployment of listening station arrays."
  Foundational deployment-design reference.
- **Kessel et al. 2014**, *Reviews in Fish Biology and Fisheries* 24: 199-218. "A review of
  detection range testing in aquatic passive acoustic telemetry studies." Range-testing
  protocol synthesis.
- **Pincock 2012**, "False detection rates in acoustic telemetry." Vemco Application Note
  AN-005. False-detection probability and the `glatos::false_detections()` filter rationale.
- **Hussey et al. 2015**, *Science* 348: 1255642. "Aquatic animal telemetry: a panoramic
  window into the underwater world." High-level field synthesis.

## Provenance and source-faithfulness

All claims in articles under this topic trace to one of the entries in the bibliography.
Per `conventions/research.md`, every quantitative statement is verifiable from the cited
page; the `extraction-validator` agent confirms claim-citation alignment before an article
moves from `draft` to `published`. Ingestion of new sources uses `agents/literature-extractor.md`.
