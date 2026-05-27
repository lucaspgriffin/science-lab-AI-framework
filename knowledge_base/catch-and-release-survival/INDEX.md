---
topic: catch-and-release-survival
domain: "Fisheries: physiology and management"
description: Catch-and-release survival in recreational marine fisheries, focused on the lab's primary taxa (Atlantic tarpon, permit, bonefish, cobia, snook, sharks). Acoustic-detection and VPS-based post-release survival estimation, handling and air-exposure effects, predation-vs-stress mortality, recovery physiology, and management implications.
last_updated: 2026-05-26
article_count: 1
ingested_sources: 2
owner: fisheries-stock-management-specialist
co_owners: [acoustic-telemetry-specialist]
---

# Topic: Catch-and-release survival

## Topic overview

A central applied focus of the Griffin Lab: estimating post-release survival of recreational
catch-and-release (C&R) fish using acoustic telemetry, physiological assays, and behavioural
observation. Scope covers post-release mortality estimation (including the distinction
between acute and chronic mortality), the contribution of handling time, air exposure, and
hook injury to mortality risk, the role of predation in apparent C&R mortality, and the
translation of survival estimates into management-relevant total mortality components. Does
not cover stock-assessment integration (see `fisheries-stock-management-specialist`) or the
acoustic detection process itself (see `acoustic-telemetry-methods`).

## Key concepts

- **Acute vs chronic mortality**. Acoustic-window mortality (typically hours to days
  post-release, within the array's detection horizon) vs longer-term mortality (months,
  often requires alternative methods).
- **Stress proxies**. Lactate, glucose, cortisol, reflex impairment; their relationships to
  subsequent survival.
- **Handling time and air exposure**. The dose-response between fight duration, air
  exposure, and survival.
- **Predation-mediated mortality**. The contribution of predators (sharks, dolphins,
  goliath grouper) to apparent post-release mortality in vulnerable species; depredation
  studies and the difficulty of separating predation from non-predation mortality.
- **VPS-window mortality detection**. Sub-receiver positional records that allow
  identification of stationary tags (mortalities) within the array footprint.
- **Total mortality decomposition**. The integration of C&R survival estimates into
  fishery mortality budgets (recreational removals = harvest + post-release mortality).

## Articles in this topic

| Article | Summary |
|---|---|
| [post-release-survival-design](articles/post-release-survival-design.md) | Study-design considerations for acoustic-detection-based C&R survival estimation. **Draft status** with verbatim extractions from Griffin et al. 2025 (Seychelles bonefish) and Casselberry et al. 2024 (Bahia Honda hammerhead-tarpon) |

## Ingested sources (`raw/`)

| Source | Status | Headline finding |
|---|---|---|
| [Griffin_2025_BonefishPRP_Seychelles](raw/Griffin_2025_BonefishPRP_Seychelles.md) | draft | Overall PRP 13%; 75% of events at one site; 15× site effect; cryptic predation in 83% of events |
| [Casselberry_2024_HammerheadTarpon_BahiaHonda](raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md) | draft | Combined depredation + immediate PRP 15.3% for tarpon fought > 5 min; risk peaks 5-12 min into fight, outgoing current |

## Cross-references to other topics

- **acoustic-telemetry-methods**: post-release detection is the primary evidence stream;
  detection-efficiency modelling is required before survival inference.
- **movement-ecology-analysis**: behavioural response to release (recovery movements,
  return to capture site) is a movement-ecology question that informs the survival
  estimate.

## Bibliography pointers

`raw/` (this directory): per-source structured summaries with full provenance.

Foundational references to ingest first:

- **Cooke et al. 2013**, *Conservation Physiology* 1: cot001. "What is conservation
  physiology? Perspectives on an increasingly integrated and essential science."
  Conceptual frame for the physiological component.
- **Griffin et al. 2018**, *Fisheries Research* 205: 65-76. "Keeping up with the Silver
  King: using cooperative acoustic telemetry networks to quantify the movements of
  Atlantic tarpon." Lab-foundational tarpon C&R / telemetry framing.
- **Holder et al. 2020**, *Journal of Experimental Marine Biology and Ecology* 524: 151283.
  "Stress, predators, and survival: exploring permit (*Trachinotus falcatus*)
  catch-and-release fishing mortality in the Florida Keys." Foundational lab paper on
  predation-mediated C&R mortality.
- **Brownscombe et al. 2017**, *Reviews in Fish Biology and Fisheries* 27: 593-617.
  "Best practices for catch-and-release recreational fisheries: angling tools and
  tactics." The standard practice synthesis.
- **Cooke and Schramm 2007**, *Fisheries Management and Ecology* 14: 73-79.
  "Catch-and-release science and its application to conservation and management of
  recreational fisheries." Conceptual reference.

## Provenance and source-faithfulness

All article claims trace to bibliography entries. The `extraction-validator` agent verifies
claim-citation alignment before any article moves from `draft` to `published`.
