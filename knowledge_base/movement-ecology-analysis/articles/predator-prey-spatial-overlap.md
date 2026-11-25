---
title: "Predator-prey spatial overlap from acoustic telemetry"
slug: predator-prey-spatial-overlap
domain: "Methods: behavioural and spatial inference"
aliases: ["predator-prey landscapes", "shark and game fish co-occurrence", "nonrandom arrival test", "shark overlap arrival percentage"]
related: [post-release-survival-design, detection-efficiency-and-range-testing, home-range-and-utilisation-distributions, migratory-contingents-and-entrainment, hurdle-brt-habitat-suitability, bayesian-mixing-models-for-marine-diet]
sources:
  - raw/Griffin_2022_PredatorPreyLandscapes.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---
# Predator-prey overlap

## Summary

Griffin et al. (2022) quantified spatiotemporal overlap between two large sharks, great hammerhead
(*Sphyrna mokarran*) and bull shark (*Carcharhinus leucas*), and two game fishes, Atlantic tarpon
(*Megalops atlanticus*) and permit (*Trachinotus falcatus*), across the Florida Keys using a
cooperative acoustic receiver array. The analysis combined three layers: hourly co-occurrence at
aggregated receiver nodes, a randomisation test of whether sharks arrived at a node when prey were
already present more often than chance, and random forest models of daily overlap against location,
habitat, month, lunar cycle, depth, and water temperature. Potential predation risk was
heterogeneous in space and time, with nonrandom shark arrival and large effect sizes at Bahia Honda,
which the authors describe as "a well-known tarpon prespawning aggregation site" [Griffin et al.
2022, p. 11]. Overlap measures potential predation risk, not observed predation, and two
high-overlap sites are known depredation areas [Griffin et al. 2022, p. 17].

## Key points

### Study system

The study area covers more than 8000 km2 of mangrove islands, seagrass flats shallower than 3 m, the
580-km Florida Reef Tract, and over 1000 known shipwrecks [Griffin et al. 2022, p. 3]. Nearly 300
fixed receivers (VR2W, VR2Tx, and VR2AR) were deployed between 2015 and 2019, spanning roughly 300
km from northern Biscayne Bay to the Marquesas Keys in a point-of-interest arrangement rather than a
grid [Griffin et al. 2022, p. 3–4]. Data were analysed from 1 August 2016 to 25 June 2020, with
Biscayne Bay data extending almost 1 year longer (August 2019 to June 2020) because of mismatched
download periods [Griffin et al. 2022, p. 5].

### Species and tagging

All animals carried internal V13, V13A, or V16 transmitters, except some great hammerheads that
received external V16 tags at the base of the dorsal fin "to reduce handling times" [Griffin et al.
2022, p. 4]. Sharks were tagged in the Florida Keys, Biscayne Bay, and Bimini, The Bahamas; tarpon
were tagged mainly in the Florida Keys with additional sites from Apalachicola to Georgetown, South
Carolina; permit were tagged near the Florida Keys [Griffin et al. 2022, p. 4–5]. The final sample
was 68 tarpon (59 adult, 9 juvenile), 116 permit (105 adult, 11 juvenile), 42 great hammerheads, and
31 bull sharks [Griffin et al. 2022, p. 7].

Table 1 splits great hammerheads into 40 mature and 2 subadult animals, whereas the Results text
reports "42 adult great hammerheads" [Griffin et al. 2022, p. 7].

Sharks entered the analysis only if they exceeded 2 m total length at tagging, a threshold the
authors justify as the length at which sharks "begin incorporating larger prey items" (citing
Lucifora et al. 2009) [Griffin et al. 2022, p. 5]. Three bull sharks of 188–196 cm were retained
because published size-at-maturity estimates classed them as mature, and the cutoffs removed six
sharks (four bull, two great hammerhead) [Griffin et al. 2022, p. 5].

### Seasonal space use

Detections peaked "in the spring for mature tarpon, winter for juvenile tarpon, fall–winter for bull
sharks, late summer–early winter for great hammerhead sharks, and spring–early summer for both
mature and juvenile permit" [Griffin et al. 2022, p. 7]. Tarpon residence was highest in shallow
habitats, with the widest space use from April to June, and permit residence peaked along the reef
tract from March to July [Griffin et al. 2022, p. 7]. Bull sharks used deep natural and artificial
reefs, especially in the Gulf of Mexico north of the Keys from June to August, but also showed high
residence at Bahia Honda (April to June) and North Biscayne (November to February) [Griffin et al.
2022, p. 7–9]. South of Biscayne Bay, great hammerheads used shallow habitats "only between April
and June", and in December their residence was largely restricted to the Miami and Biscayne Bay
areas [Griffin et al. 2022, p. 9].

### Node co-occurrence

Of 48 nodes, tarpon were detected at 33 (69%), permit at 41 (85%), great hammerheads at 41 (85%),
and bull sharks at 42 (88%) [Griffin et al. 2022, p. 9]. Hourly overlap with great hammerheads
occurred at 7 (15%) nodes for tarpon and 11 (23%) for permit, and with bull sharks at 3 (6%) and 16
(33%) nodes, respectively [Griffin et al. 2022, p. 9]. Shark overlap arrival percentages were 7.1%
(56 of 793 arrivals) for great hammerheads and tarpon, 5.6% (154 of 2729) for bull sharks and
tarpon, 9.2% (44 of 476) for great hammerheads and permit, and 4.5% (47 of 1037) for bull sharks and
permit [Griffin et al. 2022, p. 9–10].

### Nonrandom arrival

Pooled across nodes, great hammerheads arrived when tarpon were present "significantly more often
than randomly", whereas bull sharks did not, and neither shark species did so for permit [Griffin et
al. 2022, p. 10]. Node-level tests were significant at four of six nodes for great hammerheads and
tarpon, one of three for bull sharks and tarpon, 5 of 16 for great hammerheads and permit, and 12 of
16 for bull sharks and permit [Griffin et al. 2022, p. 10]. The paper gives 11 overlapping nodes for
great hammerheads and permit on p. 9 and 16 in this sentence on p. 10; both values are printed as
is.

Location mattered as much as the pooled result. Both sharks arrived nonrandomly at Bahia Honda when
tarpon were present, but neither deviated from random use of North Biscayne Bay, "a location with
high individual tarpon residence, but a site not believed to be a prespawning aggregation site"
[Griffin et al. 2022, p. 11]. At Western Dry Rocks, overlap of permit with great hammerheads and
bull sharks was high (24.2% and 18.8%), yet "nonrandom overlap was not detected at this location"
[Griffin et al. 2022, p. 12]. High overlap and nonrandom overlap are therefore separate quantities.

### Daily overlap hotspots

Daily tarpon and great hammerhead overlap was most frequent at Bahia Honda (n = 35), North Biscayne
Bay (n = 21), and Lower Keys Atlantic Flats (n = 18); tarpon and bull shark overlap at North
Biscayne Bay (n = 80), Bahia Honda (n = 78), and Lower Keys Atlantic Flats (n = 12) [Griffin et al.
2022, p. 11]. Permit overlapped with great hammerheads most at Eyeglass Bar (n = 16), Key West
Inside Reef (n = 15), and Western Dry Rocks (n = 15), and with bull sharks at Bahia Honda (n = 17),
Key West Inside Reef (n = 17), and Eyeglass Bar (n = 16) [Griffin et al. 2022, p. 11].

### Environmental drivers

Random forest accuracy ranged from 0.61 to 0.85, highest (0.85) for tarpon and bull sharks [Griffin
et al. 2022, p. 11]. Location, habitat type, and depth were consistently important for all pairings,
and month was important for all except permit and bull sharks [Griffin et al. 2022, p. 11]. Tarpon
and great hammerheads overlapped most in April to June and in November, with Bahia Honda then North
Biscayne highest in May and minimal predicted overlap in August and September [Griffin et al. 2022,
p. 11]. Tarpon and bull sharks had "little to no likelihood of overlap at any depth or any location
in February, July, August, and September", with high values at Bahia Honda and North Biscayne Bay in
spring and late fall to early winter at water temperatures of 22–31 °C [Griffin et al. 2022, p. 11].
Permit overlapped with both sharks more often in spring and summer, at deeper depths, and during the
waning crescent lunar phase, at flats, wreck, and reef nodes [Griffin et al. 2022, p. 11].
Lunar-cycle interactions ranked in the top five for each pairing [Griffin et al. 2022, p. 11].

### Depredation context

The authors report high overlap in "two regions known to have high recreational fishing pressure and
to suffer from depredation and postrelease mortality: Bahia Honda for tarpon ... and Western Dry
Rocks for permit" [Griffin et al. 2022, p. 17]. Values cited from other sources include permit
depredation by bull sharks and great hammerheads exceeding 30%–50% of hooked fish at certain sites
(Holder et al. 2020), and about 15% of tarpon hooked in one spawning aggregation lost to great
hammerheads (G. A. Casselberry, unpublished data) [Griffin et al. 2022, p. 3]. The authors argue
that anglers targeting spawning migrations "likely alter natural predation landscapes by increasing
mortality risk and decreasing antipredator responses" [Griffin et al. 2022, p. 17].

### Management options

The paper lists "spatial, temporal, or species-specific fishing closures, species-specific tackle
requirements (heavier and stronger rods) to reduce fight time, or the application of emerging shark
deterrent technologies" for areas of increased predation risk [Griffin et al. 2022, p. 17]. Most
identified shark foraging grounds lie inside the Florida Keys National Marine Sanctuary, and the
authors state that "these areas should likely be considered in management plans for the sanctuary"
pending further study [Griffin et al. 2022, p. 16].

## Methods and approaches

Receivers were grouped into 48 nodes "based on both receiver geographic position (mean 2.85 ± SD
4.28 km apart) and habitat type" [Griffin et al. 2022, p. 5]. Detection performance was assessed
with reference tags at 9 receivers and environmental noise data from 39 receivers at eight
reef-tract sites [Griffin et al. 2022, p. 4]. Tarpon tracked for fewer than 14 days were removed "in
case postrelease mortality occurred" [Griffin et al. 2022, p. 5].

Detections were filtered in five steps: detections before tag deployment, duplicates (first of the
pair kept), detections within 60 s of each other for an individual, movements faster than 3 m/s, and
singular detections within 24 h [Griffin et al. 2022, p. 5]. Hourly presence was "one or more
detections in a binned hour" per species and node [Griffin et al. 2022, p. 5]. Arrival metrics
(total shark arrival count, shark overlap arrival count, and shark overlap arrival percentage) were
computed only for nodes where overlap occurred, making them "relative rather than absolute" [Griffin
et al. 2022, p. 6].

The null model resampled observed shark arrival counts at each node 100 times and compared the mean
simulated overlap arrival count with the observed count by one-sample t-test (α = 0.05) and Cohen's
D with 95% confidence intervals [Griffin et al. 2022, p. 6]. The test adjusted for availability
because shark tagging was nonrandom in time, leaving 1 shark available at the start and 73 at the
end [Griffin et al. 2022, p. 6]. Random draws used "the proportion of observed shark arrivals (base
probability) multiplied by the proportion of sharks available for detection (adjusted probability)"
[Griffin et al. 2022, p. 6].

For the random forest models, a node-date was present "if at least one individual of a given shark
or prey species was detected at a given node" [Griffin et al. 2022, p. 6]. Dates when neither member
of the pairing was detected anywhere, and nodes with no overlap, were removed to reduce zeros
[Griffin et al. 2022, p. 6]. Predictors were node, habitat type (artificial reef, flats, reef tract,
or seamount), month, lunar cycle, depth, and temperature from more than 50 HOBO loggers and VR2Tx
receivers, with gaps filled from the nearest node of similar depth and habitat [Griffin et al. 2022,
p. 6]. Models used `randomForest` with 8-fold cross-validation and 1000 trees per fold, and lunar
phase came from the `lunar` package [Griffin et al. 2022, p. 6]. Class weights were assigned "by
trial and error until satisfactory accuracies, meaning relatively balanced error rates between
classes, were achieved", with performance reported as accuracy, sensitivity, specificity, kappa, and
F1 score [Griffin et al. 2022, p. 6–7]. Predictor importance was mean decrease accuracy, and two-way
spatiotemporal interactions were screened by the H-statistic in `iml`, excluding correlated pairs
(depth with temperature, depth with habitat, temperature with habitat), and partial dependence plots
for the top five interactions were drawn with `pdp` [Griffin et al. 2022, p. 7].

## Open questions

- The analysis cannot "quantify predation risk directly, nor infer predation events" [Griffin et al.
  2022, p. 17]; co-occurrence is a proxy, and "does not equate to foraging success" [Griffin et al.
  2022, p. 11].
- Model accuracy on nontraining data was "relatively poor", as is common with severely unbalanced
  presence-absence data, and class weighting traded sensitivity against specificity [Griffin et al.
  2022, p. 18].
- Diet studies by stomach content or stable isotopes would show how much sharks rely on game fish
  aggregations seasonally [Griffin et al. 2022, p. 16].
- Finer-scale space-use methods (minimum convex polygons, kernel density estimates, Brownian
  bridges) may be needed to quantify the importance of high-overlap sites [Griffin et al. 2022, p.
  16].

## Connections

- **Informs:** [[post-release-survival-design]]. Nonrandom shark arrival at Bahia Honda and high
  overlap at Western Dry Rocks mark where predation-mediated post-release mortality is most likely,
  which bears on where survival studies are placed and how their results transfer between sites.
- **Depends on:** [[detection-efficiency-and-range-testing]]. Hourly presence and arrival counts
  assume comparable detection across nodes, which range testing checks.
- **Extended by:** [[home-range-and-utilisation-distributions]]. The authors name kernel density and
  Brownian bridge methods as the next step for high-overlap sites.
- **Related to:** [[migratory-contingents-and-entrainment]]. Predictable tarpon spawning
  aggregations are the setting in which nonrandom shark arrival was strongest.
- **Related to:** [[hurdle-brt-habitat-suitability]]. Both fit tree ensembles to zero-heavy
  presence-absence responses.
- **Informs:** [[bayesian-mixing-models-for-marine-diet]]. Isotope diet studies are the authors'
  proposed test of whether overlap translates into consumption of tarpon and permit.

## Sources

- **Griffin, L. P., G. A. Casselberry, S. K. Lowerre-Barbieri, A. Acosta, A. J. Adams, S. J. Cooke,
  A. Filous, C. Friess, T. L. Guttridge, N. Hammerschlag, V. Heim, D. Morley, M. J. Rider, G. B.
  Skomal, M. J. Smukall, A. J. Danylchuk, and J. W. Brownscombe. 2022.** Predator–prey landscapes
  of large sharks and game fishes in the Florida Keys. *Ecological Applications* 32(5): e2584. DOI:
  10.1002/eap.2584. Lucas P. Griffin and Grace A. Casselberry are co-first authors.

Extraction: [Griffin_2022_PredatorPreyLandscapes.md](../raw/Griffin_2022_PredatorPreyLandscapes.md)
