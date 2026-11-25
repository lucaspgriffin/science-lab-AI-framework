---
topic: catch-and-release-survival
domain: "Fisheries: physiology and management"
description: Catch-and-release survival in recreational marine fisheries, focused on the lab's primary taxa (Atlantic tarpon, permit, bonefish, cobia, snook, sharks). Acoustic-detection and VPS-based post-release survival estimation, handling and air-exposure effects, predation-vs-stress mortality, recovery physiology, and management implications.
last_updated: 2026-11-25
article_count: 6
ingested_sources: 7
owner: fisheries-stock-management-specialist
co_owners: [acoustic-telemetry-specialist]
---

# Catch-and-release survival

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
| [post-release-survival-design](articles/post-release-survival-design.md) | Study design for estimating post-release survival and predation from acoustic detections and float tracking, with Seychelles bonefish and Bahia Honda tarpon as worked cases |
| [reflex-impairment-and-handling](articles/reflex-impairment-and-handling.md) | Fight time, air exposure and hooking effects on reflex impairment and post-release activity of giant trevally, with the reflex battery and accelerometer design |
| [cooperative-fishery-monitoring](articles/cooperative-fishery-monitoring.md) | A guide-kept catch log at the Alphonse Group turned into a spatially explicit monitoring programme for five flats species |
| [angling-pressure-and-catchability](articles/angling-pressure-and-catchability.md) | Whether repeated angler-fish interactions change giant trevally space use, residency and catchability, tested with telemetry, mark-recapture and catch logs |
| [angler-knowledge-and-fishery-status](articles/angler-knowledge-and-fishery-status.md) | Angler and guide survey of local ecological knowledge on Atlantic tarpon fishing quality, threats, shark depredation and conservation support |
| [flats-habitat-management](articles/flats-habitat-management.md) | Ten principles for bringing habitat management and restoration into conservation of bonefish, permit and tarpon flats fisheries |

## Ingested sources (`raw/`)

| Source | Status | Headline finding |
|---|---|---|
| [Griffin_2025_BonefishPRP_Seychelles](raw/Griffin_2025_BonefishPRP_Seychelles.md) | validated | Overall post-release predation 13%; 75% of events at one site, where predation was 15 times more likely; the abstract (17%) and Results (4 of 12, 33%) disagree on how many events followed a sighted predator |
| [Griffin_2022_GiantTrevallyCR](raw/Griffin_2022_GiantTrevallyCR.md) | validated | Neither fight time nor air exposure had a detectable effect on giant trevally reflex impairment or post-release body acceleration (n = 50) |
| [Griffin_2021_AlphonseMonitoring](raw/Griffin_2021_AlphonseMonitoring.md) | validated | Three seasons of guide catch logs at Alphonse; catch areas fairly consistent across seasons; body size declines in two species flagged for monitoring |
| [Griffin_2024_BeyondTheHook](raw/Griffin_2024_BeyondTheHook.md) | validated | Habituated giant trevally at a floating dock held home ranges about half the size of non-habituated adults; the COVID-19 fishing closure produced no clear change |
| [Griffin_2023_AnglerPerceptions](raw/Griffin_2023_AnglerPerceptions.md) | validated | 918 completed surveys; long-time respondents reported tarpon fishing quality declining from good to fair; water and habitat quality ranked the top threats |
| [Griffin_2025_FlatsHabitat](raw/Griffin_2025_FlatsHabitat.md) | validated | Synthesis with no new data; habitat loss and degradation limit what catch-and-release practice alone can achieve for flats fisheries |
| [Casselberry_2024_HammerheadTarpon_BahiaHonda](raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md) | draft | Combined depredation and immediate post-release predation of 15.3% for tarpon fought longer than 5 min; risk peaks 5 to 12 min into the fight on the outgoing current |

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
