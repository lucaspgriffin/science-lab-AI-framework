---
title: "Detection-region misclassification: a data-QA pattern for cooperative telemetry networks"
slug: region-misclassification-data-qa
domain: "Methods: detection and survey"
aliases: ["region misclassification", "telemetry data QA", "upstream label drift"]
related: [detection-efficiency-and-range-testing]
sources: []
status: stub
origin: manual
last_updated: 2026-05-26
---

# Detection-region misclassification: a data-QA pattern for cooperative telemetry networks

> **Stub article documenting a recurring data-QA pattern observed in the Griffin Lab's
> use of cooperative telemetry network data feeds.** This article is empirical and
> Griffin-Lab-specific; promote to `published` only after the pattern is corroborated
> across multiple projects and (where possible) reported in a methods paper.

## Summary

Cooperative telemetry network data feeds (FACT, iTAG, OTN, ACT) propagate
station-level geographic region labels alongside the raw detection events. These labels
are convenient but not authoritative: in the Griffin Lab's experience, region labels do
not always match the station coordinates, sometimes by substantial fractions. Any
analysis that aggregates by region must validate the region label against the station's
actual coordinates before drawing inference. The fix is straightforward (compute regions
from coordinates locally) but the bias is silent and high-magnitude if missed.

## Key points

### What the bias looks like

The Griffin Lab discovered this pattern while building the tarpon dashboard
(`~/github/tarpon_dashboard/`). Comparison of upstream-assigned region labels against
locally-computed regions (from station coordinates) revealed:

- **Tampa Bay region**: 88.8% of stations labelled "Tampa Bay" were on the Atlantic
  coast.
- **Northeast Florida / Georgia region**: 69.6% of stations labelled "NE FL/GA" were on
  the Gulf side.

These are large-magnitude misclassifications. Any regional residency or
connectivity inference using the upstream labels would have been substantially biased.

### Why it happens

Cooperative networks aggregate from many contributing labs and projects, each with their
own region-naming conventions. Region labels are often inherited from the contributing
project's internal organisation and may not match the geographic conventions a downstream
user assumes. Updates to region definitions in the upstream data product are not always
flagged or backfilled.

### Mitigation

The lab's standard QA pattern for any cooperative-network data ingest:

1. Always pull station coordinates alongside region labels.
2. Compute regions locally from coordinates using a defensible spatial join (e.g.,
   NOAA management zone polygons, state-water boundaries, or a custom Voronoi
   partition).
3. Cross-tabulate locally-computed regions against upstream labels; flag mismatches.
4. **Use the locally-computed regions for all downstream analysis.**
5. Document the mismatch rate in the methods section (it is a quantitative measure of
   data-product quality and reviewers may ask).

For long-running projects, this QA step should be re-run on every data refresh.
Region definitions in upstream products do drift, and a fix today does not guarantee a
fix next quarter.

### Adjacent data-QA patterns

The region-misclassification pattern is one instance of a broader class of "upstream
label drift" issues common in cooperative or aggregated data products:

- **Species ID drift**: cooperative-network species labels may not match the
  contributing project's current species assignment after taxonomic revision.
- **Tag-deployment-date drift**: the deployment date in the network record may not
  match the contributing project's authoritative deployment log.
- **Receiver-deployment-window drift**: the network's claim of when a receiver was
  active may not match the contributing project's recovery log.

For any analysis where the inference depends on these fields, the lab's pattern is to
**re-derive locally from the contributing project's authoritative records where
possible**, and to fall back to the network-provided field only when local records are
unavailable.

## Methods and approaches

The lab's standard data-QA preamble for cooperative-network data:

```r
# 1. Pull detections with station coordinates
detections <- read_csv(network_feed)

# 2. Compute locally-derived region
detections <- detections %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326) %>%
  st_join(noaa_management_zones)   # or whatever the analysis-relevant polygon set is

# 3. Cross-tab and flag
qa_table <- detections %>%
  st_drop_geometry() %>%
  count(network_region, computed_region) %>%
  mutate(mismatch = network_region != computed_region)

print(qa_table %>% filter(mismatch))

# 4. Use computed_region downstream
detections <- detections %>%
  select(-network_region) %>%
  rename(region = computed_region)
```

## Open questions

- The frequency of upstream-label drift across cooperative networks is not formally
  characterised; a multi-network audit would be a useful methods contribution.
- Best practice for documenting derived-vs-supplied fields in shared data deposits
  (Movebank, OBIS) is currently inconsistent.

## Connections

- **Related to**: [[detection-efficiency-and-range-testing]] (the other foundational
  data-QA step for telemetry).
- **Depends on**: authoritative locally-held station-coordinate and deployment-log
  records.
- **Informs**: any analysis that aggregates by region; any manuscript that uses
  cooperative-network data and reports residency, transit, or connectivity patterns.

## Sources

This article documents a Griffin Lab empirical pattern; published literature on
cooperative-network data-QA at this specific level of detail is limited. When publishing
work that depends on this QA step, cite the pattern as a methods note or supplementary
description rather than as a citation to existing literature.

## Template usage notes

Stub article. The pattern is empirical and confirmed in at least one project
(`tarpon_dashboard`). Promote to `draft` after the pattern is confirmed in a second
project; to `published` after a methods note describes it in the published literature.
