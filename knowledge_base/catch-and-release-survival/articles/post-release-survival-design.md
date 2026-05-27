---
title: "Study design for acoustic-telemetry-based catch-and-release survival estimation"
slug: post-release-survival-design
domain: "Fisheries: physiology and management"
aliases: ["C&R survival", "post-release mortality", "acoustic survival"]
related: [detection-efficiency-and-range-testing, predation-mediated-mortality]
sources:
  - raw/Griffin_2025_BonefishPRP_Seychelles.md
  - raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md
  - raw/Holder_2020_PermitCRMortality.md
  - raw/Brownscombe_2017_CRBestPractices.md
  - raw/Griffin_2018_TarponCooperative.md
status: draft
origin: literature-extractor (manual via pdftotext; full text available for Griffin 2025 and Casselberry 2024)
last_updated: 2026-05-26
---

# Study design for acoustic-telemetry-based catch-and-release survival estimation

> **Draft article** with verbatim extractions from Griffin et al. 2025
> ([raw/Griffin_2025_BonefishPRP_Seychelles.md](../raw/Griffin_2025_BonefishPRP_Seychelles.md))
> and Casselberry et al. 2024
> ([raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md](../raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md)).
> Older referenced sources (Holder 2020, Brownscombe 2017, Griffin 2018) are still to be
> ingested. Promote to `published` after the `extraction-validator` agent (or Lucas)
> confirms claim-citation alignment.

## Summary

Acoustic-telemetry-based catch-and-release (C&R) survival estimation infers post-release
fate from the pattern of detections (or non-detections) of tagged released fish in a
receiver array. The approach is powerful when array detection efficiency is well
characterised but breaks in known ways when (1) the array does not span the post-release
movement envelope, (2) detection efficiency is unmeasured, (3) predation produces stationary
"dead" detections that cannot be distinguished from genuine residency by detection pattern
alone, or (4) the study cannot distinguish between mortality and tag failure or shedding.

## Key points

### Design components

- **Tag selection**: external (towed) tags avoid surgical confounds but introduce shedding;
  intramuscular and intracoelomic surgical tags offer better retention at the cost of a
  surgical handling event. The Griffin Lab's tarpon and permit work has used both
  depending on the question.
- **Sample size**: minimum useful sample for survival estimation is typically n ≥ 30
  tagged fish per stratum (gear, species, season, body-size class) to detect mortality
  differences of ecological magnitude.
- **Array geometry**: ideally fish are released into a known array footprint where
  detection-efficiency has been characterised; releases at array boundaries produce
  censored data.
- **Control comparisons**: where ethically and operationally feasible, paired comparisons
  (e.g., short vs long air exposure, surgical vs external tag) strengthen causal
  interpretation.

### Mortality vs disappearance

Acoustic non-detection has multiple causes: mortality, tag failure, tag shedding,
emigration beyond the array, or detection efficiency below the per-receiver threshold.
The four hypotheses cannot be separated by detection pattern alone, and the relative
plausibility depends on:

- the array spatial extent and detection envelope;
- the tag battery life and the time window for inference;
- the species' known movement scale (a tarpon may transit out of an array in days; a
  resident reef fish should not);
- whether the study has independent evidence of tag failure rates and shedding from
  laboratory or contemporaneous field studies.

### Predation-mediated mortality

For vulnerable species (permit, bonefish, snook, juvenile tarpon), predation by sharks,
goliath grouper, dolphins, or other predators is a substantial fraction of apparent C&R
mortality. Three Griffin Lab papers establish the headline quantitative magnitudes:

**Casselberry et al. 2024** (great hammerheads on tarpon at Bahia Honda, Florida Keys):
"During the visual survey, 394 Tarpon were hooked. The combined observed shark
depredation and immediate postrelease predation rate was 15.3% for Tarpon that were
fought longer than 5 min. Survival analysis and decision trees showed that depredation
risk was highest in the first 5-12 min of the fight and on the outgoing current." With
51 acoustically-tagged tarpon and 14 great hammerheads tracked simultaneously, "Great
Hammerheads shifted their space use in Bahia Honda to overlap with Tarpon core use
areas. Great Hammerheads restricted their space use on the outgoing current when
compared to the incoming current, which could drive increased shark-angler
interactions." [Abstract, Casselberry et al. 2024]

**Griffin et al. 2025** (bonefish post-release predation in the Seychelles): "Bonefish
(Albula glossodonta) in the Alphonse Group of islands ... overall PRP = 13%. Notably,
PRP was highly site-specific, with 75% of predation events occurring at a single
location where bonefish were 15 times more likely to be predated compared to other
sites. Cryptic predation was prevalent, as only 17% of predation events were preceded
by observing potential predators. Sicklefin lemon sharks (Negaprion acutidens) were
responsible for most PRP, often tracking and preying on bonefish within an average of
9 minutes after release (30-1080 seconds; 545 ± 315 seconds)." [Abstract, Griffin et al.
2025]

Critically, in the Griffin et al. 2025 study, "air exposure, among other angling event
characteristics, did not affect PRP", yet air exposure DID affect reflex impairment.
This decouples the standard handling-impairment metric from realised predation risk in
predator-dense environments.

For broader cross-system comparisons, Griffin et al. 2025 also synthesises:
- **Danylchuk et al. 2007c (Bahamas):** "bonefish that lost equilibrium following
  capture were six times more likely to be predated within the first 20 minutes
  post-release." [Griffin et al. 2025, §1, p. 2]
- **Lennox et al. 2017 (Anaa Atoll, French Polynesia, blackfin reef shark *Carcharhinus
  melanopterus*-dense):** "bonefish released without air exposure experienced PRP of
  33%, while those exposed to air had PRP > 60%." [Griffin et al. 2025, §1, p. 2]
- **Moxham et al. 2019 (Seychelles, surgically tagged):** "rather high PRP (at least
  43%) but those fish were surgically implanted with transmitters (average hooking to
  release time of approximately 11 minutes) which confounds findings when applied to a
  C&R context." [Griffin et al. 2025, §1, p. 2]

The Holder et al. (2020) permit study at the Florida Keys established the lab's
operational framework for VPS-based positional analysis of post-release predation; that
extraction is still TODO and would refine the methodological detail in this article
when ingested.

### Floats and visual tracking as an alternative to VPS

Where a VPS array is logistically infeasible (open flats, large reef expanses, lack of
HR2 infrastructure), the lab has used **visual-track-with-float** designs to monitor PRP
in real time. The Griffin et al. (2025) Seychelles bonefish design is the current
reference:

> "Each fish was visually tracked by attaching a small, brightly colored fishing float
> via a small hook carefully inserted into the dorsal musculature just behind the dorsal
> fin. The float was connected to the line above the fish (~10 m) on 5.4 kg test
> fluorocarbon, which was tethered to a spinning rod with the bail left open to ensure
> minimal resistance on the fish during tracking. While wading on the flats, we tracked
> each fish for up to 20 minutes following release, which is the time period predation
> is most likely to occur for bonefish (Danylchuk et al., 2007c). The predator species,
> behavior, and time (seconds) to predation were recorded in attempted or successful
> predation events." [Griffin et al. 2025, §2.2, p. 3]

The 20-minute tracking window is the operative inference horizon: predation events
outside that window are right-censored. The Griffin 2025 design also documented "cryptic
predation": 83% of predation events were NOT preceded by an observed predator, meaning
visual-observer-based predator-presence covariates substantially underestimate true
predator density.

### VPS-window detection

Where VPS arrays are deployed, sub-receiver positional records can identify stationary
tags (probable mortalities) within the array footprint, separating mortality from
emigration. This is the strongest single design improvement for the acoustic-survival
approach and is the lab's preferred design where logistics permit, particularly for
species with longer tracking horizons than the 20-minute float-tracking window can
support.

## Methods and approaches

The lab's default sequence for a new acoustic-survival study: (1) confirm array detection
efficiency via stationary range tests and sentinel tags; (2) compute the per-individual
detection horizon (median time to last detection for known-mortality controls vs known-
survival controls); (3) fit a known-fate or Cormack-Jolly-Seber framework with detection
covariates; (4) report survival estimates with explicit acoustic-window scope (e.g., "30-day
post-release survival"); (5) decompose chronic mortality where possible via paired studies
or long-life-tag deployments.

## Open questions

- The contribution of sub-lethal stress to delayed mortality beyond the acoustic detection
  window is poorly characterised across the lab's primary taxa.
- Behavioural response (acute movement away from the capture site, recovery duration)
  varies by species, gear, and environmental conditions; the interaction is under-studied.
- Integration of physiological assays (lactate, glucose) with downstream survival in
  field-realistic time-to-recapture frameworks remains limited.

## Connections

- **Related to**: [[predation-mediated-mortality]].
- **Depends on**: [[detection-efficiency-and-range-testing]].
- **Informs**: total-mortality budgets for recreational fishery assessments (route to
  `fisheries-stock-management-specialist`).

## Sources

**Ingested (verbatim extractions in `raw/`):**

- **Griffin et al. 2025.** "Site-specific post-release predation of bonefish (Albula
  glossodonta) in a catch-and-release recreational fishery: informing voluntary actions
  and management strategies for a Blue Economy." *Fisheries Research* 286: 107387.
  DOI: 10.1016/j.fishres.2025.107387.
  Extraction: [Griffin_2025_BonefishPRP_Seychelles.md](../raw/Griffin_2025_BonefishPRP_Seychelles.md).
- **Casselberry et al. 2024.** "Depredation rates and spatial overlap between Great
  Hammerheads and Tarpon in a recreational fishing hot spot." *Marine and Coastal
  Fisheries* 16: e10277. DOI: 10.1002/mcf2.10277.
  Extraction: [Casselberry_2024_HammerheadTarpon_BahiaHonda.md](../raw/Casselberry_2024_HammerheadTarpon_BahiaHonda.md).

**Cited in the article above but not yet ingested:**

- **Holder et al. 2020.** "Stress, predators, and survival: exploring permit (*Trachinotus
  falcatus*) catch-and-release fishing mortality in the Florida Keys." *Journal of
  Experimental Marine Biology and Ecology* 524: 151283. DOI: 10.1016/j.jembe.2019.151283.
- **Brownscombe et al. 2017.** "Best practices for catch-and-release recreational
  fisheries: angling tools and tactics." *Reviews in Fish Biology and Fisheries* 27:
  593-617. DOI: 10.1007/s11160-017-9485-y.
- **Griffin et al. 2018.** "Keeping up with the Silver King: using cooperative acoustic
  telemetry networks to quantify the movements of Atlantic tarpon." *Fisheries Research*
  205: 65-76. DOI: 10.1016/j.fishres.2018.04.008.
- **Danylchuk et al. 2007c.** Cited via Griffin et al. 2025 for the equilibrium-loss
  6× predation finding.
- **Lennox et al. 2017.** Cited via Griffin et al. 2025 for the Anna Atoll air-exposure
  PRP comparison.
- **Moxham et al. 2019.** Cited via Griffin et al. 2025 for the Seychelles
  surgically-tagged baseline.

## Template usage notes

This is a `draft` article: verbatim extractions for the headline 2024-2025 papers are in
place. Promote to `published` after `extraction-validator` confirms claim-citation
alignment for the ingested sources AND after Holder 2020, Brownscombe 2017, and Griffin
2018 are also ingested with `raw/` source files.
