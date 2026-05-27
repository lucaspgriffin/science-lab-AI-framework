---
title: "Vessel-strike risk from AIS data: exposure, susceptibility, consequence"
slug: vessel-strike-risk-from-ais-data
domain: "Conservation: human-wildlife interaction"
aliases: ["AIS vessel strike", "ship strike risk", "vessel mortality"]
related: [biologger-workflows, tourism-compliance-protocols]
sources:
  - raw/Conn_Silber_2013_SpeedRestrictions.md
  - raw/Vanderlaan_Taggart_2007_VesselCollisions.md
  - raw/Womersley_2022_WhalesharkCollisionHotspots.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Vessel-strike risk from AIS data: exposure, susceptibility, consequence

> **Stub article.** Replace with verbatim extractions via `agents/literature-extractor.md`;
> verify via `agents/extraction-validator.md`.

## Summary

Vessel-strike risk for marine megafauna is the product of three terms: per-cell exposure
(vessel-traffic density and speed distribution from AIS data), per-encounter
susceptibility (probability of lethal injury given a strike, a function of vessel speed
and species), and population-level consequence (additive mortality and its demographic
implications). AIS data plus a peer-reviewed speed-mortality function provides a defensible
risk-classification framework; co-occurrence alone does not.

## Key points

### AIS data sources

- **Maritime Connector** (commercial-grade, gridded): widely used, good coverage of
  large commercial vessels.
- **Global Fishing Watch (GFW)**: fishing-vessel-specific, with derived activity-state
  (fishing vs transit) classification.
- **exactEarth**: gap-filled, higher-quality satellite + terrestrial AIS.
- **Terrestrial AIS**: dense coastal coverage, sparse offshore.
- **Satellite AIS**: offshore coverage at coarser temporal resolution.

The lab's working default is Maritime Connector at 0.1° / ~10 km grid cells, matching
NOAA standards for cetacean-risk reporting.

### Datetime and CRS pitfalls

- Maritime Connector and GFW use different datetime formats; standardise to UTC
  ISO 8601 before any temporal join.
- EEZ and management-boundary shapefiles often come in WGS84 (EPSG:4326); always
  reproject to an equal-area CRS (e.g., Albers Equal Area for US waters) before area /
  density computation.
- Grid-aggregation cells should match the management or analysis scale; 0.1° in the
  Gulf of Mexico is ~10 km north-south but ~9 km east-west at 25°N — close enough to
  treat as square for risk classification but worth flagging for high-precision work.

### Speed metrics

- **Mean speed** in a cell is the unweighted average across all AIS pings; biased low
  when vessels slow down repeatedly in the cell (e.g., near pilots, ports).
- **Median speed** is more robust to extreme pings but less directly linked to
  strike-mortality.
- **Distance-weighted average speed (DWAS)**: time- and distance-weighted average of the
  speed an animal would encounter if randomly placed in the cell. The lab's preferred
  metric because strike mortality scales with the speed distribution at which the
  animal is exposed, not the vessel's overall average.
- **Peak speed** in a cell: useful for identifying high-risk transit corridors.

### Speed-mortality functions

- **Conn and Silber 2013** (cetaceans): probability of lethal injury as a function of
  vessel speed, with the inflection around 10 knots that drives the
  speed-restriction zone policy for North Atlantic right whales.
- **Vanderlaan and Taggart 2007** (large whales): earlier formulation of the speed-
  mortality function.
- **Womersley et al. 2022** (whale sharks): vessel-strike risk hotspot analysis using
  AIS + telemetry.

For non-cetacean / non-whale-shark species, the lab uses Conn & Silber as a starting
point with explicit caveats about cross-species transferability.

### Co-occurrence vs interaction

A vessel-density map alone does not establish strike risk. Required additional steps:

1. **Animal occupancy layer**: where is the species present, at what intensity?
   Telemetry, sightings, SDM outputs all contribute.
2. **Animal availability layer**: surface vs sub-surface time budget, behavioural
   state, group size.
3. **Detection-lag layer**: how much time elapses between visual detection (if any) and
   evasive action by the vessel?
4. **Encounter-rate model**: probability of an encounter given co-occurrence, treating
   vessels and animals as objects in continuous space with realistic encounter
   geometries.

### Common pitfalls

- Reading a co-occurrence hotspot as a strike risk without animal-occupancy weighting.
- Using mean vessel speed when DWAS would change the risk classification.
- Pooling vessel classes (cargo, fishing, recreational, military) without acknowledging
  the strike-risk and behavioural-response differences across classes.
- Reporting risk maps without communicating the temporal scope (year-round vs seasonal
  vs migration-window) of the AIS data used.
- Forgetting that satellite AIS undersamples short transit and slow speeds.

## Methods and approaches

The lab's default sequence for a vessel-strike risk analysis (per `vsm-gom/`):

1. Ingest AIS data (Maritime Connector or GFW); standardise datetime, CRS, vessel class.
2. Filter to study area and study period.
3. Grid to 0.1° cells (or finer for tight management contexts); compute per-cell
   vessel-traffic intensity, DWAS, peak speed, vessel-class composition.
4. Overlay animal occupancy (telemetry residency, SDM output, sightings).
5. Apply the appropriate speed-mortality function to per-encounter risk.
6. Aggregate to per-cell risk classification (e.g., "high risk" = DWAS > 10 knots AND
   animal-occupancy > 75th percentile).
7. Report uncertainty: AIS coverage gaps, vessel-class assumptions, mortality-function
   transferability.

## Open questions

- Encounter-geometry modelling for AIS + telemetry pairs is still a maturing area;
  current standard practice over-simplifies animal-availability.
- Cross-species transferability of cetacean-derived speed-mortality functions to
  elasmobranchs (especially whale sharks) and sea turtles is poorly characterised.
- AIS gap-filling and undersampling for slow-moving recreational vessels is a known
  weakness for coastal-bay risk assessments.

## Connections

- **Related to**: [[biologger-workflows]], [[tourism-compliance-protocols]].
- **Depends on**: well-characterised animal-occupancy layer (telemetry or SDM).
- **Informs**: management recommendations for speed restrictions, vessel-routing
  changes, time-area closures.

## Sources

- **Conn and Silber 2013.** "Vessel speed restrictions reduce risk of collision-related
  mortality for North Atlantic right whales." *Ecosphere* 4: art43.
  DOI: 10.1890/ES13-00004.1. [TODO: ingest.]
- **Vanderlaan and Taggart 2007.** "Vessel collisions with whales: the probability of
  lethal injury based on vessel speed." *Marine Mammal Science* 23: 144-156.
  DOI: 10.1111/j.1748-7692.2006.00098.x. [TODO: ingest.]
- **Womersley et al. 2022.** "Global collision-risk hotspots of marine traffic and the
  world's largest fish, the whale shark." *Proceedings of the National Academy of
  Sciences* 119: e2117440119. DOI: 10.1073/pnas.2117440119. [TODO: ingest.]

## Template usage notes

Stub article; promote to `draft` after verbatim extractions; to `published` after
`extraction-validator` confirms claim-citation alignment.
