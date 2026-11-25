---
title: "Seasonal presence from cooperative receiver networks"
slug: seasonal-presence-from-cooperative-networks
domain: "Methods: detection and survey"
aliases: ["tarpon phenology", "arrival and departure timing", "daily occupancy from telemetry", "seasonal residency"]
related: [detection-efficiency-and-range-testing, region-misclassification-data-qa, migratory-contingents-and-entrainment, post-release-survival-design, home-range-and-utilisation-distributions, hurdle-brt-habitat-suitability]
sources:
  - raw/Griffin_2022_TarponPhenology.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---
 # Seasonal presence modelling

## Summary

Detections pooled from a local receiver array and from cooperative telemetry networks can be reduced to arrival
events, departure events, residence periods, and daily counts of tagged individuals, which together describe the
phenology of a migratory species at a focal site. Griffin et al. (2022) applied this sequence to Atlantic
tarpon, *Megalops atlanticus*, in the Florida Keys, combining over 200 local receivers with networks of "1000+
acoustic receivers spanning the GOM and coastal southeastern USA" [Griffin et al. 2022, p. 136]. After
false-detection filtering and grouping of stations into arrays and habitat nodes, time-to-event models, linear
mixed models, and random forests described arrival, departure, residence, repeatability, and their temperature
cues. All 47 adult detection profiles were seasonal residents, with a mean residence period of 51 d across years
and most adults arriving in April and departing in June [Griffin et al. 2022, p. 133].

## Key points

### Data sources

Tarpon were captured from May 2016 to August 2019 on recreational fishing gear across six sampling locations
from the Florida Keys to central South Carolina, and fitted with V16 69 kHz transmitters (min and max delay
times 60–120 s, estimated battery life 1910 d) inserted into the coelomic cavity [Griffin et al. 2022, p. 135].
Within the Florida Keys, "over 200 autonomous fixed acoustic receivers (VR2RW and VR2Tx models; Amirix)" were
deployed in a "point-of-interest arrangement rather than a grid formation" [Griffin et al. 2022, p. 136].
Detections outside the Keys came from the integrated Tracking of Animals in the Gulf, Florida Atlantic Coast
Telemetry, and Atlantic Cooperative Telemetry networks, with the Ocean Tracking Network providing receiver loans
and data-sharing support [Griffin et al. 2022, p. 136]. Receiver performance was assessed with reference tags at
9 receivers and with environmental noise data from 39 receivers at 8 sites on the Florida Reef Tract [Griffin et
al. 2022, p. 136].

### Detection filtering

False detections from code mutations or collisions were removed with three criteria, quoted here because the
thresholds are reusable:

> "(1) consecutive detections that occurred within a time period less than the minimum tag delay (defined here
> as 60 s), (2) unrealistic detections (movements) at >10 m s−1 (a higher rate was chosen when considering
> variable detection ranges), and (3) singular detections occurring within a specific time frame (defined here
> as 120 min)." [Griffin et al. 2022, p. 136]

A post-release inclusion rule followed: "only M. atlanticus with detections >1 station and detected over 14 d
after tagging were used for data analysis and visualization" [Griffin et al. 2022, p. 136]. After filtering, the
analysis retained 58 633 detections from 57 tarpon across 34 receiver nodes between May 2016 and August 2020,
with tracking durations of 20–1500 d (633 ± 407 d [SD]) [Griffin et al. 2022, p. 139].

### Array grouping

Every station with a tarpon detection was assigned to one of two array types, inside or outside the Florida
Keys. Stations within about 20 km of the Keys, including nearby shipwrecks and reefs, counted as inside [Griffin
et al. 2022, p. 136]. Florida Bay, the Everglades, Biscayne Bay, and the Dry Tortugas were assigned outside "due
to the limited detection coverage, spatial extent, and generalized habitat differences" [Griffin et al. 2022, p.
136]. Within the Keys, stations "within similar habitat types and relatively close together were grouped into
the same node", with habitat classes such as flats and channels, the Florida Reef Tract, and shipwrecks [Griffin
et al. 2022, p. 136]. The array boundary therefore defines what counts as an arrival or a departure, and the
node defines the spatial unit for residence time and distance travelled.

### Life-stage classification

Fish ≥ 128.5 cm FL were classed as adults, following Florida maturity estimates of 117.5 cm FL for males and
128.5 cm FL for females [Griffin et al. 2022, p. 136]. Smaller fish were reclassified as "potential adults" if
they were >100 cm and "exhibited distinct migratory behaviors with north−south seasonal movements" [Griffin et
al. 2022, p. 137]. At tagging, 42 fish were mature and 15 immature; 4 large subadults were reclassified as
potential adults and 1 fish (107 cm FL at tagging) shifted to a migratory pattern after its first monitored
year, giving 47 adult detection profiles [Griffin et al. 2022, p. 139].

### Adult phenology

All adult detection profiles were seasonal residents, and only 4 of 47 adults were detected exclusively in the
Florida Keys array [Griffin et al. 2022, p. 141]. Twenty-seven of the 47 adults were detected at least once in
the Keys between December and February [Griffin et al. 2022, p. 141]. Mean arrival was 25 April (95% CI 19
April–1 May) and mean departure 6 June (95% CI 1–12 June) [Griffin et al. 2022, p. 142]. Time-to-event estimates
by year follow [Griffin et al. 2022, pp. 142, 144].

| Year | Median arrival (95% CI) | Median departure (95% CI) | Median duration |
|---|---|---|---|
| 2017 | 28 April (not reported) | 31 May (not reported) | 40 d |
| 2018 | 14 April (14 March–7 May) | 7 June (29 May–22 June) | 60 d (40–114 d) |
| 2019 | 17 April (12–27 April) | 31 May (29 May–9 June) | 48 d (41–67 d) |
| 2020 | 15 April (11–21 April) | 5 June (29 May–14 June) | 56 d (44–73 d) |

The average median duration across years was 51 d [Griffin et al. 2022, p. 142]. Detections had a mean sea
surface temperature of 26.9°C in spring, 30.4°C in summer, 27.1°C in fall, and 23.6°C in winter [Griffin et al.
2022, p. 142]. Highest adult space use occurred in shallow water on the Atlantic side of the Keys [Griffin et
al. 2022, pp. 141–142].

### Subadult patterns

Of the 11 subadults, 7 were detected only within the Florida Keys, 3 made far-ranging movements to Tampa Bay,
Charlotte Harbor, the Everglades, and Florida Bay, and 1 appeared to undergo an ontogenetic shift [Griffin et
al. 2022, pp. 143–144]. Individual mean subadult residence time was greatest between November and February, and
subadults travelled their greatest distances within the Keys between March and May [Griffin et al. 2022, p.
141].

### Individual repeatability

Repeatability ranged from 0.16 to 0.55 for individuals with more than 1 year of observations and from 0.11 to
0.88 for those with more than 2 years [Griffin et al. 2022, p. 142]. In the full dataset, R was 0.48 for arrival
date, 0.43 for departure date, 0.36 for departure temperature, and 0.55 for spring–summer duration, all with p <
0.001; arrival temperature had R = 0.16 (95% CI 0.00–0.44) and was not significant [Griffin et al. 2022, p.
145]. In the subset with more than 2 years, arrival-date repeatability reached 0.88 (95% CI 0.68–0.95) while
arrival temperature stayed at 0.11 [Griffin et al. 2022, p. 145]. The abstract reads this contrast as evidence
"that photoperiod may be an important migratory cue" [Griffin et al. 2022, p. 133].

### Environmental cues

Arrival probabilities "began to increase during April when SSTs reach 26°C and continued into May and June
when SSTs are less than 28°C" [Griffin et al. 2022, p. 143]. In December, arrival events were likely across all
observed temperatures (22–25°C) [Griffin et al. 2022, p. 143]. Departure probability rose in April once
temperatures reached 27°C and peaked in May and June at 27–29°C [Griffin et al. 2022, p. 143]. Expected daily
occurrence was greatest in May at 26–28°C and lowest between August and October [Griffin et al. 2022, p. 143].
Lunar cycle "had little to no effect" on arrival, departure, or daily occupancy in any of the three models
[Griffin et al. 2022, p. 143].

### Classification performance

Both classification models had accuracy of 0.87 and precision of 0.44 [Griffin et al. 2022, p. 143]. The arrival
model had sensitivity 0.88, specificity 0.87, fall-out 0.13, and miss rate 0.12; the departure model had
sensitivity 0.87, specificity 0.87, fall-out 0.13, and miss rate 0.13 [Griffin et al. 2022, p. 146]. These
values come from strongly unbalanced data: 131 arrival presences against 1131 absences, and 147 departure
presences against 1290 absences [Griffin et al. 2022, pp. 142–143]. With a rare positive class, balanced
sensitivity and specificity still yield low precision, and the authors state that the models "were biased in
predicting the majority class (absences)" [Griffin et al. 2022, p. 139]. The daily occupancy regression had a
mean absolute error of 0.76, root mean squared error of 1.14, mean squared error of 1.31, and R2 of 0.77
[Griffin et al. 2022, p. 146].

## Methods and approaches

**Residence events.** Detections were summarised into events with the `events` function in `glatos`, using nodes
as the location and a 60 min threshold, and the residence period was the time between an event's first and last
detection [Griffin et al. 2022, p. 137].

**Arrival and departure.** Array-level events were defined "when consecutive M. atlanticus detections from an
individual indicated that an M. atlanticus entered or left the Florida Keys or when 30 d passed with no new
detections" [Griffin et al. 2022, p. 137]. To limit tagging bias, arrivals within 30 d of the tagging date and
departures within 14 d of it were removed [Griffin et al. 2022, p. 137]. Seasons were fixed as spring–summer (1
March to 31 August) and fall–winter (1 September to 28 February), and December–February arrivals and departures
were examined to separate visiting from overwintering fish [Griffin et al. 2022, p. 137].

**Temperature covariate.** Daily sea surface temperature came from the NOAA ERDDAP server (dataset
`jplMURSST41`) through `rerddap`, `xtractomatic`, and `rerddapXtracto`, averaged over a box spanning all Keys
stations (latitude 24.43° to 25.07°, longitude −82.23° to −80.31°) [Griffin et al. 2022, p. 137].

**Time-to-event models.** Survival analysis was restricted to adults in the spring–summer season, with 1
September as the benchmark date so that each event was the number of days since 1 September [Griffin et al.
2022, pp. 137–138]. Duration was the number of days between first arrival and last departure, which includes
temporary absences from the array [Griffin et al. 2022, p. 138]. Models used `survival` and `survminer`, and
95% CIs were not reported for 2017 because of limited data [Griffin et al. 2022, p. 138].

**Repeatability.** Five linear mixed models were fitted, one each for arrival ordinal date, arrival temperature,
departure ordinal date, departure temperature, and duration, "with each metric as a response variable and
individual ID as the random effect alone" [Griffin et al. 2022, p. 138]. Repeatability and likelihood ratio
tests used `lme4` and `rptR`, with 95% CIs from 1000 parametric bootstraps, run separately on fish with more
than 1 and more than 2 years of data [Griffin et al. 2022, p. 138]. Sample sizes differ between sources within
the paper: the text gives n = 13, 11, 13, and 12, whereas Table 2 lists ID counts of 25 and 32 for the full
dataset and 12 and 18 for the subset [Griffin et al. 2022, pp. 142, 145].

**Random forests.** Three datasets were built, for arrivals, departures, and daily occupancy, each with month,
sea surface temperature, lunar cycle (from the `lunar` package), and year as predictors [Griffin et al. 2022, p.
138]. Daily counts were limited to 2017–2020 because tagging began in 2016; the occupancy inputs comprised 569
days with no tarpon, 376 days with 1, 124 days with 2, and 254 days with ≥ 3 (maximum 17) [Griffin et al. 2022,
pp. 139, 143]. Models used `mlr` and `ranger` with 1000 trees, tuned by 5-fold cross-validation over 50
hyperparameter combinations (250 models), and were interpreted with `iml` and partial dependence plots from
`pdp` [Griffin et al. 2022, p. 139]. Class weights were set "by trial and error until sensitivity (true positive
rate; accurately predicted presences) and specificity (true negative rate; accurately predicted absences)
performance metrics were similar" [Griffin et al. 2022, p. 139], and year was a control only.

**Reuse notes.** The array boundary, the 30 d gap rule, and the tagging trims jointly determine every arrival
and departure date, so they should be reported together and tested for sensitivity in any new application. Daily
occupancy predictions are "constrained to the observed data set and provides a relative measure of abundance
rather than an absolute measure" [Griffin et al. 2022, p. 139].

## Open questions

- Departures may be difficult to capture "if M. atlanticus spawn twice or display more indiscriminate
  'wandering' tendencies" [Griffin et al. 2022, p. 150]; the gap rule cannot separate a departure from an
  undetected stay in poorly covered habitat.
- Offshore spawning movements fall outside the array, and the authors call for "increased receiver coverage" to
  examine fine-scale spawning-related movements [Griffin et al. 2022, p. 150].
- Precision of 0.44 leaves open how well the classification models would predict individual event dates, as
  opposed to the seasonal shape of the response.
- The occupancy model does not adjust daily counts for detection probability or for changes in receiver effort
  across 2017–2020; no such adjustment is described in the Methods.

## Connections

- **Depends on:** [[detection-efficiency-and-range-testing]]. Arrival and departure dates are inferred from the
  first and last detections, so variation in detection range across habitats can shift those dates; this array
  was range tested with reference tags and noise data [Griffin et al. 2022, p. 136].
- **Depends on:** [[region-misclassification-data-qa]]. The inside and outside array assignment is a regional
  classification of cooperative-network stations, and it is only as accurate as the station coordinates behind
  it.
- **Informs:** [[migratory-contingents-and-entrainment]]. High repeatability in arrival date and duration
  indicates that the same adults return to the Keys each year, which is the individual-level pattern that
  contingent structure and socially transmitted routes would produce.
- **Informs:** [[post-release-survival-design]]. Because "this fishery relies on the same adult individuals each
  year" [Griffin et al. 2022, p. 150], post-release mortality during the April–June aggregation removes repeat
  spawners, which raises the stakes of C&R survival estimates for this season.
- **Related to:** [[home-range-and-utilisation-distributions]]. Node-level residence time and distance travelled
  are coarse space-use summaries; utilisation distributions are the finer alternative where positional data
  allow.
- **Related to:** [[hurdle-brt-habitat-suitability]]. Both fit tree ensembles to unbalanced presence data, where
  class weighting decides the trade between sensitivity and specificity.

## Sources

- **Griffin LP, Brownscombe JW, Adams AJ, Holder PE, Filous A, Casselberry GA, Wilson JK, Boucek RE,
  Lowerre-Barbieri SK, Acosta A, Morley D, Cooke SJ, Danylchuk AJ (2022).** Seasonal variation in the phenology
  of Atlantic tarpon in the Florida Keys: migration, occupancy, repeatability, and management implications.
  *Marine Ecology Progress Series* 684: 133–155. DOI: 10.3354/meps13972.
  Extraction: [Griffin_2022_TarponPhenology.md](../raw/Griffin_2022_TarponPhenology.md)