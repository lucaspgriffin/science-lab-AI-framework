---
topic: marine-traffic-and-anthropogenic-impacts
domain: "Conservation: human-wildlife interaction"
description: AIS-based vessel-traffic exposure modelling, vessel-strike risk for marine megafauna (whales, whale sharks, sea turtles), wildlife-watching tourism compliance, biologger workflows, and behavioural-response analyses to anthropogenic stressors.
last_updated: 2026-05-26
article_count: 1
owner: marine-megafauna-anthropogenic-impacts-specialist
co_owners: []
---

# Topic: Marine traffic and anthropogenic impacts

## Topic overview

A recurring workstream covering the lab's vessel-strike, whale-shark, and
wildlife-watching-compliance projects. Includes vessel-traffic exposure modelling from AIS
data (Maritime Connector, Global Fishing Watch), vessel-strike risk inference (speed-
mortality functions, distance-weighted average speed), tourism-compliance analyses for
provisioning-site whale-shark interactions, and biologger workflows on whale sharks and
related megafauna.

Scope covers the data-processing through interpretation chain for AIS-megafauna
co-occurrence and interaction analyses. Does not cover stock-assessment-style population
mortality estimation for non-megafauna (route to Fisheries Stock & Management
Specialist) or the SDM-style modelling of megafauna habitat distribution at the
population level (route to SDM Specialist).

## Key concepts

- **Exposure × susceptibility × consequence**. The risk-analysis chain: rate of
  encounter (exposure, from AIS-derived vessel density) × probability of injury per
  encounter (susceptibility, from speed-mortality functions) × population-level
  consequence (additive mortality, displacement, reproductive failure).
- **AIS data sources**. Maritime Connector (commercial, gridded), Global Fishing Watch
  (fishing-vessel-specific), exactEarth (gap-filled higher-quality), terrestrial AIS
  (coastal, denser), satellite AIS (offshore coverage). Each has different temporal /
  spatial resolution and class-coverage trade-offs.
- **Vessel-speed metrics**. Mean, median, distance-weighted average speed (DWAS), peak
  speed. The metric materially changes the risk classification; DWAS is the lab's
  preferred metric because vessel-strike mortality scales with the exposure-weighted
  speed distribution, not the average.
- **10-knot threshold**. The operationally relevant cutoff for risk classification in
  most cetacean-strike contexts, derived from the Conn & Silber 2013 and Vanderlaan &
  Taggart 2007 mortality functions.
- **Co-occurrence vs interaction**. Co-occurrence (whales and ships in the same cell) is
  necessary but not sufficient for strike risk; strike-rate inference requires accounting
  for animal occupancy, vessel speed, vessel size, and detection lag.
- **Compliance vs non-impact**. In wildlife-watching contexts, an encounter that follows
  the regulatory guidelines is "compliant"; an encounter where the animal does not
  respond is "non-impactful". These are not the same.
- **Biologger sensor suites**. CATS, OpenTag, accelerometer-magnetometer-depth (IMU)
  combinations; trade-offs in retention duration, sampling rate, and recovery.

## Articles in this topic

| Article | Summary |
|---|---|
| [vessel-strike-risk-from-ais-data](articles/vessel-strike-risk-from-ais-data.md) | Workflow for translating AIS vessel-traffic data into megafauna-strike risk classification |

## Cross-references to other topics

- **movement-ecology-analysis**: behavioural-response inference (HMMs, SSMs) for
  vessel-presence or tourism-presence effects relies on the movement-ecology toolkit.
- **acoustic-telemetry-methods**: paired biologger + acoustic telemetry for the same
  individuals is occasionally used; the acoustic detection layer follows the telemetry
  topic's conventions.

## Bibliography pointers

`raw/`: per-source structured summaries.

Foundational references:

- **Conn and Silber 2013**, *Ecosphere* 4: art43. "Vessel speed restrictions reduce risk
  of collision-related mortality for North Atlantic right whales." Foundational
  speed-mortality function.
- **Vanderlaan and Taggart 2007**, *Marine Mammal Science* 23: 144-156. "Vessel
  collisions with whales: the probability of lethal injury based on vessel speed."
  Earlier speed-mortality function.
- **Halpern et al. 2008**, *Science* 319: 948-952. "A global map of human impact on
  marine ecosystems." Methodological reference for anthropogenic exposure mapping.
- **Pirotta et al. 2018**, *Biological Conservation* 222: 195-208. "Understanding the
  population consequences of disturbance." Framework for translating individual
  behavioural responses into population-level inference (PCAD / PCoD).
- **Womersley et al. 2022**, *Proceedings of the National Academy of Sciences* 119:
  e2117440119. "Global collision-risk hotspots of marine traffic and the world's
  largest fish, the whale shark." Whale-shark vessel-strike risk reference.
- **Cagnacci et al. 2010**, *Philosophical Transactions of the Royal Society B* 365:
  2157-2162. "Animal ecology meets GPS-based radiotelemetry: a perfect storm of
  opportunities and challenges." Biologger / telemetry framing reference.

## Provenance and source-faithfulness

Standard `conventions/research.md` rules apply.
