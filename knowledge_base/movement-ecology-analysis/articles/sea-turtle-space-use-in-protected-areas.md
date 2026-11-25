---
title: "Green turtle space use"
slug: sea-turtle-space-use-in-protected-areas
domain: "Methods: behavioural and spatial inference"
aliases: ["green turtle home range", "immature green turtle habitat selection", "Buck Island green turtles", "marine protected area space use", "binomial GLMM RSF"]
related: [home-range-and-utilisation-distributions, resource-selection-functions-with-clogit, detection-efficiency-and-range-testing, integrated-sdm-with-inla-spde]
sources:
  - raw/Griffin_2020_GreenTurtleRSF.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Green turtle space use

## Summary

Griffin et al. (2020) combined conventional acoustic-telemetry space-use metrics with a resource selection function
(RSF) to describe how immature green turtles (*Chelonia mydas*) use and select habitat inside Buck Island Reef
National Monument (BIRNM), St. Croix, United States Virgin Islands. Detections were converted to centres of activity
(COAs), summarised as minimum convex polygons (MCPs) and 99%, 95%, and 50% kernel density estimates (KDEs), and then
modelled as presence against random background points in a binomial generalized linear mixed model (GLMM) with depth,
distance to seagrass, zone type, and diel period as covariates. Turtles held small, overlapping home ranges, with mean
space use below 3 km² for every category [Griffin et al. 2020, p. 1]. Relative selection was highest at shallow
depths, close to seagrass, and in reef zones by day and night and lagoon zones at night [Griffin et al. 2020, p. 1].
The authors concluded that the reserve "is providing sufficient protection for immature green turtles", while
recommending that finer-scale habitat protection target both areas of high space use and areas of high predicted
selection [Griffin et al. 2020, p. 1]. The study is the lab's worked example of pairing home-range estimation with a
used-versus-available habitat model on a fixed receiver array.

## Key points

### Study system

The reserve is "a 73.4-km2 no-take marine reserve with small restricted anchoring zone", managed by the United States
National Park Service, established in 1961 and expanded in 2001 [Griffin et al. 2020, p. 8]. Buck Island itself is 0.7
km² and lies 2.5 km northeast of St. Croix; the surrounding reef system encloses a 50- to 150-m-wide lagoon, and
seagrass beds are composed of *Thalassia* sp., *Syringodium* sp., and *Halophila* sp. [Griffin et al. 2020, p. 8]. The
passive array grew from six to 141 Vemco VR2W receivers between 2011 and 2018, most deployed in less than 15 m, with
downloads and maintenance twice a year [Griffin et al. 2020, p. 8].

Turtles were captured by hand while freediving or by the "turtle jumping" rodeo method and fitted with V16-4L or
V13-1L transmitters (both on a 30–90 s delay) attached by coated wire through a marginal scute and epoxy [Griffin et
al. 2020, pp. 8–9]. Detection logs were examined for 58 immature green turtles carrying 68 transmitters (because of
retagging), deployed in 2012 (n = 38) and 2013 (n = 30) [Griffin et al. 2020, p. 3]. Straight carapace length (nuchal)
ranged from 33.8 to 65.5 cm (46.9 ± 7.0 cm) [Griffin et al. 2020, p. 3].

### Tracking duration

Days at liberty ranged from 1 to 505 days (146.3 ± 100.1 days), and residency, defined as detection days divided by
days at liberty, ranged from 0.6 to 1 (0.8 ± 0.3) [Griffin et al. 2020, p. 3]. Only four transmitters were still
active 10 detection months after release, which the authors attributed to "tear-outs from attachment holes failing
and/or tags moving towards the edge of their scutes from growth" [Griffin et al. 2020, p. 3]. After logs with fewer
than 100 COAs were dropped (n = 10), 97,065 COAs from 52 turtles (58 transmitters) across 2012, 2013, and 2014 were
used for space use [Griffin et al. 2020, p. 3].

### Home-range estimates

Full MCPs ranged from 0.0 to 4.2 km² (0.9 ± 0.9 km²) [Griffin et al. 2020, p. 3]. Kernel estimates were as follows
[Griffin et al. 2020, p. 3]:

| Isopleth | Range (km²) | Mean ± spread (km²) | Mean overlap (%) |
|---|---|---|---|
| 99% KDE | 1.2–5.9 | 2.3 ± 0.8 | 67.7 ± 19.3 |
| 95% KDE | 0.7–3.7 | 1.4 ± 0.5 | 64.5 ± 21.25 |
| 50% KDE | 0.1–0.6 | 0.3 ± 0.0 | 41.9 ± 33.6 |

The 95% and 50% KDEs lay largely on the southern side of Buck Island, although some individual 95% KDEs extended to
the northeast and northwest of the island [Griffin et al. 2020, p. 3]. These values sit close to the cited estimates
for immature green turtles elsewhere: home ranges below 3 km² in Hawaii and of 3 km² in Florida, and core areas of 0.5
± 0.4 km² (Makowski et al. 2006) and 0.2 ± 0.3 km² (Chambault et al. 2020) [Griffin et al. 2020, p. 6].

### Sampling sufficiency

Cumulative monthly MCPs began to stabilise around six detection months, and their proportions to full MCPs around
three detection months after release [Griffin et al. 2020, p. 3]. The authors read this as evidence that "3 to 6
months of tracking for turtles may provide sufficient amount of data for inferences" [Griffin et al. 2020, pp. 3–5].
Only four transmitters remained active 10 detection months after release [Griffin et al. 2020, p. 3].

### Model selection

Variance inflation factors showed that reef type and zone type were highly correlated, so reef type was removed
[Griffin et al. 2020, p. 3]. The top model, fitted to a random 60% subset, was the full model, and the year random
effect was dropped because its variance component was zero [Griffin et al. 2020, p. 3]. Model coefficients are not
reported in the main text; the model-selection table and accuracy-by-level table are in Additional file 1.

### Model performance

Overall accuracy on the 40% holdout was 77.3%, with presences (1 s) predicted at 72.2% and background points (0 s) at
85.2% [Griffin et al. 2020, p. 3]. Accuracy across the levels of the categorical variables ranged from 71.7 to 100%
(77.1 ± 11.3) [Griffin et al. 2020, p. 3].

### Selection by habitat

Relative selection was high within 200 m of seagrass by both day and night [Griffin et al. 2020, p. 3]. For zone type,
the three highest relative selection probabilities were in reef zones by day, reef zones at night, and lagoon zones at
night [Griffin et al. 2020, p. 3].

### Depth and diel period

Depths shallower than 10 m had higher relative selection probabilities by day and night, with higher values by day
[Griffin et al. 2020, p. 3]. Mapped across the reserve, the greatest relative selection probabilities lay at shallow
depths near Buck Island and generally declined with distance from the island and with depth [Griffin et al. 2020, p.
3]. The authors linked this pattern to predation risk: acoustically tagged tiger sharks in the reserve were more
likely to use depths greater than 10 m, where relative habitat selection by turtles was very low (below 0.25) [Griffin
et al. 2020, p. 6].

### Protected-area design

The authors judged that the reserve protects the developmental ground well, because turtles both use and most strongly
select habitat near Buck Island [Griffin et al. 2020, p. 7]. Their recommendation for finer-scale management was
explicit: "detailed habitat protection (e.g., no anchor, motor and idle only zones, invasive seagrass control) could
be focused in areas of space use and in locations with high relative selection probabilities, as indicated by the RSF
model" [Griffin et al. 2020, p. 8]. They also stated that "it is critical that acoustic arrays are designed to
initially capture the representative habitats to reduce biases" [Griffin et al. 2020, p. 8]. Turtles at neighbouring
Culebra Island, Puerto Rico (less than 100 km away) also remained in well-defined areas (Griffin et al. 2019) [Griffin
et al. 2020, pp. 6–7].

### Stated limitations

- Space use did not fully match predicted selection over the wider study area, probably because tagging effort was
  concentrated south of the island, where green turtle abundance was highest [Griffin et al. 2020, p. 7].
- The model omitted covariates such as fetch, wave energy, total seagrass area, density dependence, predator landscape
  metrics, and foraging strategy [Griffin et al. 2020, p. 7].
- The authors described RSFs as "inherently phenomenological and not mechanistic": the predictions describe observed
  habitat selection and ignore movement processes such as home ranging [Griffin et al. 2020, p. 8].
- Aggregation to raster cells assigns the dominant habitat to each cell, so "important animal space use-habitat
  relationships may be lost if cell sizes are set too large" [Griffin et al. 2020, p. 8].
- The analysis estimates relative selection, not probability of occurrence; integrated step selection functions were
  named as one route to better interpolation [Griffin et al. 2020, p. 8].
- V16-4L tags are more powerful than V13-1L tags and can, in theory, be detected at greater distances, so detection
  range differed between tag types [Griffin et al. 2020, p. 9].

## Methods and approaches

The workflow below is reusable for any benthic or site-attached species tracked on a fixed receiver array. All
analyses were run in R with glatos, VTRACK, adehabitatHR, raster, sp, maptools, glmmTMB, MuMIn, and sjPlot [Griffin et
al. 2020, pp. 9–10].

**Detection filtering.** Background detections were removed with the glatos `background_detections` function using a
2700 s time threshold [Griffin et al. 2020, p. 9]. Detections were also removed when the implied rate of movement
exceeded 10 m/s or fell within 30 s of the previous detection [Griffin et al. 2020, p. 9]. To trim post-shedding
detections, the glatos `detection_events` function identified the last event in each log, where a new event was
defined by consecutive detections on two different receivers; the function was modified to also flag events when
turtles exceeded 400 m [Griffin et al. 2020, p. 9].

**Centres of activity.** Filtered detections were converted to COAs with the mean position algorithm in 60-min bins
using VTRACK [Griffin et al. 2020, p. 9]. Following Selby et al., any transmitter dataset with fewer than 100 COAs was
excluded [Griffin et al. 2020, p. 9].

**Space-use metrics.** Monthly MCPs were added cumulatively, so the last cumulative monthly value equals the full MCP;
"detection months after release" counts only months in which the individual was detected, skipping gaps [Griffin et
al. 2020, p. 9]. Kernel utilisation distributions were estimated in adehabitatHR with a 200 m smoothing parameter, and
pairwise overlap was "the proportion of individual is KDE that is overlapped by individual js KDE" [Griffin et al.
2020, p. 9]. The fixed bandwidth on COAs does not model autocorrelation; see
[[home-range-and-utilisation-distributions]] for that trade-off.

**Availability.** Available area was a 400-m buffer around each receiver deployed in a given year (2012, 2013, 2014),
chosen from earlier range testing of the array and to retain more COAs [Griffin et al. 2020, p. 10]. Background points
were drawn within that area in equal number to each individual's COAs, matched to the observed diel periods and to the
observed points per year [Griffin et al. 2020, p. 10].

**Covariates.** Presences and background points were collapsed into 200 × 200 m raster cells with habitat and depth
[Griffin et al. 2020, p. 10]. Habitat covariates were distance to seagrass (seagrass defined as greater than 50%
cover), reef type (no reef, patch reef, continuous reef), and zone type (lagoon, bank/shelf, reef, other) [Griffin et
al. 2020, p. 10]. Depth cells without data took the mean of adjacent cells, and diel period was assigned from civil
dawn and civil dusk with maptools [Griffin et al. 2020, p. 10].

**Model structure.** The response was COA presence (1) versus background (0), fitted as a binomial GLMM following
Selby et al. [Griffin et al. 2020, pp. 9–10]. The full model was:

```
presence ~ diel * depth + diel * dist_seagrass + diel * zone_type
           + (1 | individual) + (1 | year)        # binomial, glmmTMB
```

Continuous covariates were z-standardised, and datasets from retagged individuals were grouped under one individual
[Griffin et al. 2020, p. 10]. All subsets were run with MuMIn and ranked by AIC [Griffin et al. 2020, p. 10]. The
variable names above are illustrative; the paper gives the terms in prose. This unconditional, random-intercept design
differs from the matched case-control form in [[resource-selection-functions-with-clogit]].

**Validation.** Models were fitted to a random 60% of the data and tested on the remaining 40%, with accuracy "defined
as the top model's ability to correctly predict the probability of 1 s and 0 s" in the holdout [Griffin et al. 2020,
p. 10]. The probability cut-off used to classify predictions is not stated in the main text.

**Effects and prediction.** Marginal effects were plotted with sjPlot, holding depth and distance to seagrass at their
means and factors at their proportional levels rather than their reference levels [Griffin et al. 2020, p. 10]. The
top model was then applied to the aggregated raster layers to map relative selection across the study area by day and
by night [Griffin et al. 2020, p. 10].

## Open questions

- The 400-m availability buffer rests on range testing of the array; whether selection estimates shift under
  tag-specific buffers, given the stronger V16-4L signal, is untested in the paper.
- Predicted high-selection areas outside the tagged area were not validated with tracking, so the gap between space
  use and predicted selection may reflect tagging location rather than habitat.
- Integrated step selection functions, named by the authors as an alternative, would join the movement and selection
  processes that the RSF treats separately; predator landscape metrics were proposed but not modelled.

## Connections

- **Builds on:** [[home-range-and-utilisation-distributions]]. This study uses fixed-bandwidth KDEs and MCPs on
  hourly COAs, the conventional approach that the home-range article contrasts with autocorrelated estimators.
- **Contrasts with:** [[resource-selection-functions-with-clogit]]. Availability here is drawn per individual within
  year-specific receiver buffers and handled with a random intercept, rather than through conditional strata.
- **Depends on:** [[detection-efficiency-and-range-testing]]. The 400-m availability buffer and the difference in tag
  power both depend on how detection range was measured on the array.
- **Informs:** [[integrated-sdm-with-inla-spde]]. The paper's distinction between relative selection and probability
  of occurrence marks the boundary between an RSF and a population-scale distribution model.
- **Related to:** green turtle space use at Culebra, Puerto Rico (Griffin et al. 2019), and tiger shark depth use at
  the reserve (Casselberry et al. 2020), both cited as comparisons; no articles yet.

## Sources

- **Griffin LP, Smith BJ, Cherkiss MS, Crowder AG, Pollock CG, Hillis-Starr Z, Danylchuk AJ, Hart KM. 2020.** "Space
  use and relative habitat selection for immature green turtles within a Caribbean marine protected area." *Animal
  Biotelemetry* 8: 22. DOI: 10.1186/s40317-020-00209-9.
  Extraction: [Griffin_2020_GreenTurtleRSF.md](../raw/Griffin_2020_GreenTurtleRSF.md)
