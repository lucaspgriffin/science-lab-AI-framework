---
title: "Study design for acoustic-telemetry-based catch-and-release survival estimation"
slug: post-release-survival-design
domain: "Fisheries: physiology and management"
aliases: ["C&R survival", "post-release mortality", "acoustic survival"]
related: [detection-efficiency-and-range-testing, predation-mediated-mortality]
sources:
  - raw/Holder_2020_PermitCRMortality.md
  - raw/Brownscombe_2017_CRBestPractices.md
  - raw/Griffin_2018_TarponCooperative.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Study design for acoustic-telemetry-based catch-and-release survival estimation

> **Stub article.** Replace placeholder text with verbatim extractions from the cited
> sources via `agents/literature-extractor.md`, then verify via `agents/extraction-validator.md`.

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
mortality. The Holder et al. (2020) permit study documented [TODO: extract verbatim
quantitative claim] predation-attributable mortality from VPS-based positional analysis.

### VPS-window detection

Where VPS arrays are deployed, sub-receiver positional records can identify stationary
tags (probable mortalities) within the array footprint, separating mortality from
emigration. This is the strongest single design improvement for the acoustic-survival
approach and is the lab's preferred design where logistics permit.

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

- **Holder et al. 2020.** "Stress, predators, and survival: exploring permit (*Trachinotus
  falcatus*) catch-and-release fishing mortality in the Florida Keys." *Journal of
  Experimental Marine Biology and Ecology* 524: 151283. DOI: 10.1016/j.jembe.2019.151283.
  [TODO: ingest, extract pages.]
- **Brownscombe et al. 2017.** "Best practices for catch-and-release recreational
  fisheries: angling tools and tactics." *Reviews in Fish Biology and Fisheries* 27:
  593-617. DOI: 10.1007/s11160-017-9485-y. [TODO: ingest.]
- **Griffin et al. 2018.** "Keeping up with the Silver King: using cooperative acoustic
  telemetry networks to quantify the movements of Atlantic tarpon." *Fisheries Research*
  205: 65-76. DOI: 10.1016/j.fishres.2018.04.008. [TODO: ingest.]

## Template usage notes

This is a stub; promote to `draft` once verbatim extractions are in place and to
`published` after `extraction-validator` confirms claim-citation alignment.
