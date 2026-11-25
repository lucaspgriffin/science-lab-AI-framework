---
title: "Isoscape foraging assignment"
slug: isoscape-assignment-of-foraging-areas
domain: "Methods: trophic and biochemical inference"
aliases: ["isoscape assignment", "geographic assignment", "foraging area assignment", "resource probabilities", "tarpon isoscapes"]
related: [bayesian-mixing-models-for-marine-diet, migratory-contingents-and-entrainment, home-range-and-utilisation-distributions, integrated-sdm-with-inla-spde, region-misclassification-data-qa]
sources:
  - raw/Griffin_2026_TarponForagingLandscapes.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Isoscape foraging assignment

## Summary

Isoscape assignment estimates where a consumer acquired the resources recorded in its tissues by
comparing the consumer's δ13C and δ15N values with a spatial map of baseline isotope values. Griffin et
al. (2026) applied this approach to Atlantic tarpon (*Megalops atlanticus*) across the southeastern
United States, combining "continental-scale stable isotope assignment modeling (n = 417 individuals) with
five years of electronic tagging (n = 85 individuals)" [Griffin et al. 2026, p. 1]. The baseline was the
inshore lizardfish (*Synodus foetens*), a resident benthic predator, and the isoscapes were fitted as
Bayesian hierarchical spatial models in `R-INLA` [Griffin et al. 2026, p. 3, p. 9]. Telemetry entered the
assignment as a constraint: each fish's search area was limited to the space its contingent occupied
during the months its tissue integrated diet [Griffin et al. 2026, p. 9–10].  Distinct foraging regions
emerged in South Florida, the northern Gulf of Mexico, and the Mid-Atlantic Bight, and the most likely
foraging cell lay a mean 296 ± 188 km from the capture site [Griffin et al. 2026, p. 1].

## Key points

### Cautions

- **Fin correction.** The authors are preparing a correction to the adjustment applied to fin clips
  stored in ethanol. Until the correction notice is published, fin δ13C values, fin assignment distances,
  and the fin versus plasma test statistic reported below should be checked against the public repository
  lucaspgriffin/tarpon_SIA_move_eco, which holds the corrected code and data, before any of them are
  reused.
- **Test mismatch.** The Methods state that "We used a Welch Two Sample t-test" to compare plasma and fin
  assignment distances [Griffin et al. 2026, p. 10]. The reported result, t = −7.4 with df = 29 [Griffin
  et al. 2026, p. 4], matches a paired t-test on the 30 fish sampled for both tissues rather than a Welch
  test, whose degrees of freedom would be estimated from two independent groups. Confirm the test used against the
  repository before citing the statistic.
- **Fork length.** The fork length of the 417 fin-sampled fish is given as 155.9 ± 22.7 cm [Griffin et
  al. 2026, p. 3], 155.77 ± 17.66 cm [Griffin et al. 2026, p. 9], and 155.8 ± 22.7 cm [Griffin et al.
  2026, p. 10]. The standard deviation on p. 9 differs from the other two.

### Baseline consumer

An assignment isoscape needs a baseline organism that records local isotope values and does not move far.
Inshore lizardfish were chosen because, "As resident mid-trophic predators with limited movements, they
integrate local food-web baselines" [Griffin et al. 2026, p. 8]. The baseline dataset held 534 dorsal
muscle samples (25.70 ± 3.90 cm; maturity about 19 cm) compiled from Radabaugh et al. (n = 226), Shipley
et al. (n = 286), and 22 new samples from anglers and the Florida Fish and Wildlife Research Institute's
Fisheries Independent Monitoring Program [Griffin et al. 2026, p. 8]. Lizardfish were collected at a mean
depth of 12.6 ± 25.5 m, which overlaps tarpon depth use of ≤ 10 m for > 80% of their time [Griffin et al.
2026, p. 8].

Lizardfish δ13C ranged from −19.8‰ to −12.8‰ (−17.5 ± 0.9‰) and δ15N from 7.9‰ to 17.0‰ (12.1 ± 1.7‰)
[Griffin et al. 2026, p. 3]. The carbon isoscape was highest in the northern mid-Atlantic and along the
west coast of Florida, and lowest around the Mississippi Delta and along the coasts of Georgia, South
Carolina, and North Carolina. The nitrogen isoscape was highest in the western Gulf of Mexico and the
northern mid-Atlantic, with higher coastal values around the Mississippi Delta and north of Pamlico Sound
[Griffin et al. 2026, p. 3].

### Isoscape model

Two models were fitted, one with δ13C and one with δ15N as the response, each with sea surface
temperature (°C), chlorophyll a (mg/m3), and depth (m) as covariates [Griffin et al. 2026, p. 9]. A
Gaussian Markov random field "explicitly accounted for spatial autocorrelation in the underlying data
structure", and predictions were "constrained to areas within the range of the environmental covariates"
[Griffin et al. 2026, p. 7]. Samples spanned several years, but "temporal effects were not modeled due to
insufficient sample sizes when partitioned by year and location" [Griffin et al. 2026, p. 9]. Prediction
variance was higher where baseline sampling was sparse, including southern and eastern Florida and the
coasts of Georgia and the Carolinas [Griffin et al. 2026, p. 7].

### Assignment model

Assignment used a bivariate normal probability function following Vander Zanden et al. and Trueman et al.
[Griffin et al. 2026, p. 9]. For each raster cell, the likelihood depends on the difference between the
tarpon's corrected δ13C and δ15N values and the cell's predicted mean, scaled by a variance-covariance
matrix built from the δ13C–δ15N correlation across the isoscape and pooled standard deviations
"calculated from the sum of the variances" [Griffin et al. 2026, p. 9]. Cell probabilities (P) were
converted to odds, P / (1 − P), then divided by the maximum odds so that values ran from 0 to 1. The
paper defines these normalised odds as "'resource probabilities'" [Griffin et al. 2026, p. 9]. The output
is a continuous surface rather than a point estimate, and the distance metric reported per fish was the
distance from the capture site to the cell with the highest assignment probability [Griffin et al. 2026,
p. 9–10].

### Telemetry constraints

Telemetry from 85 acoustically tagged tarpon (143.6 ± 17.7 cm fork length) produced 67,557 detections,
with tracking durations of 34 to 2,327 days [Griffin et al. 2026, p. 3, p. 10]. Monthly utilisation
distributions came from dynamic Brownian bridge movement models fitted with the `Actel` and `RSP`
packages [Griffin et al. 2026, p. 10]. Search areas were built in four steps.

1. **Contingent.** Each sampled fish was assigned to the Eastern Gulf of Mexico contingent (236 fish) or
   the Eastern US Seaboard contingent (110 fish) by capture location, and its search area was confined to
   that contingent's satellite-telemetry habitat utilisation maps [Griffin et al. 2026, p. 3, p. 9]. The
   71 fish captured in South Florida, where the contingents overlap, were searched across the full extent
   from South Florida to Louisiana and Virginia [Griffin et al. 2026, p. 3, p. 9].
2. **Month window.** The search area was "constrained to the corresponding monthly 95% probability
   contour and the four months prior (five months in total) for fin tissue samples or two months prior
   (three months in total) for blood plasma samples" [Griffin et al. 2026, p. 10].
3. **Latitude.** A generalised additive mixed model in `mgcv` predicted latitude from ordinal date, with
   individual ID as a random effect and a cyclic cubic regression spline with six knots, checked with
   `gam.check` [Griffin et al. 2026, p. 10]. Plasma used 75% prediction intervals and fin 95% intervals,
   "to reflect the higher temporal precision of this tissue" [Griffin et al. 2026, p. 10]. The model
   explained 46% of deviance and predicted the highest latitudes from July to October (maximum 39.16°N);
   the 95% interval spanned 23.63–33.01°N and the 75% interval 25.26–31.44°N [Griffin et al. 2026, p. 3].
4. **Depth.** Search areas were limited to depths less than 20 m, matching satellite habitat maps and
   tarpon depth use [Griffin et al. 2026, p. 10].

The month window changed the search area by sampling date. Fin samples collected in April (n = 26)
restricted the search to Florida and South Georgia, while fin samples from March to June excluded
Virginia and northward [Griffin et al. 2026, p. 3]. Plasma search areas were narrower for fish captured
in January to March than for those captured in May to December [Griffin et al. 2026, p. 3].

### Tissue turnover

Fin and plasma were assigned separately because they integrate diet over different windows. The paper
defines the incorporation rate as "the isotopic half-life (T50)" and assumed it was no greater than five
months for fin and no greater than three months for plasma [Griffin et al. 2026, p. 9]. Fin clips (about
1 g, 5 mm, from the tip of the anterior dorsal-fin lobe) were taken from 417 fish; 5 mL of whole blood
was taken from 30 fish and centrifuged for 15 min to separate plasma [Griffin et al. 2026, p. 9]. Most
fin clips went into 95% ethanol, with 45 duplicates kept on ice to derive ethanol correction factors
[Griffin et al. 2026, p. 9]; the factors themselves sit in the Supplementary Material and are the subject
of the correction noted above.

Fin δ13C ranged from −21.0 to −11.3‰ (−15.2 ± 1.1‰) and fin δ15N from 5.7 to 17.2‰ (14.2 ± 1.5‰). Plasma
δ13C ranged from −20.0 to −14.8‰ (−17.7 ± 1.3‰) and plasma δ15N from 9.6 to 14.2‰ (12.4 ± 1.0‰) [Griffin
et al. 2026, p. 3]. Plasma assignments were closer to the capture site (158.7 ± 113.7 km) than paired fin
assignments (450.7 ± 205.8 km; t = −7.4, df = 29, p < 0.001) [Griffin et al. 2026, p. 4]..

### Discrimination sensitivity

Tarpon values were adjusted with trophic discrimination factors that accounted for "both trophic position
differences between species and tissue-specific fractionation between Atlantic tarpon tissues (fin,
plasma) and inshore lizardfish muscle" [Griffin et al. 2026, p. 9]. The factor values are not in the main
text. Following advice for Bayesian mixing models, assignment was rerun across 121 discrimination factor
combinations, and the change in assignment distance was plotted against each combination for fish with
paired tissues [Griffin et al. 2026, p. 8, p. 10]. Assignment locations stayed "highly consistent for 20
out of 30 fin tissue samples and 13 out of 30 blood plasma samples" [Griffin et al. 2026, p. 4]..

### Regional foraging

The most likely foraging locations lay 40.8 to 966.5 km (296.2 ± 188.0 km) from the capture site [Griffin
et al. 2026, p. 4]. South Florida (< 26.11°N) was the most consistent foraging region, except for fish
captured in the Mid-Atlantic, which had the highest probabilities between Georgia and North Carolina
(30.74–36.09°N) [Griffin et al. 2026, p. 4]. Fish from East Florida assigned to South Florida and to
northeastern Florida and Georgia (29.31–31.98°N). The northern Gulf of Mexico, including northwest
Florida (28.94–30.13°N), was a highly probable (≥ 25%) foraging area for fish sampled in the northern
Gulf, West Florida, and South Florida [Griffin et al. 2026, p. 4]. The authors recommend "prioritizing
the South Florida, northern Gulf of Mexico, and Mid-Atlantic Bight foraging grounds for habitat
protection and restoration" [Griffin et al. 2026, p. 8].

## Methods and approaches

1. **Baseline.** Choose a resident, mid-trophic baseline species whose depth range overlaps the
   consumer's, and compile muscle δ13C and δ15N across the full candidate range..
2. **Isoscapes.** Fit separate `R-INLA` models for δ13C and δ15N with a Gaussian Markov random field and
   environmental covariates (sea surface temperature, chlorophyll a, depth). Restrict predictions to the
   covariate range of the data and map prediction variance alongside the mean surface.
3. **Consumer correction.** Correct consumer values for preservation and for trophic discrimination
   between consumer tissue and baseline muscle..
4. **Assignment.** Compute bivariate normal likelihoods per cell using pooled variances, convert to odds,
   and normalise by the maximum to obtain resource probabilities.
5. **Telemetry constraint.** Limit each individual's search area by contingent, by the monthly 95%
   contours across the tissue's integration window, by a latitude model with tissue-specific prediction
   intervals, and by a depth cap.
6. **Sensitivity.** Rerun assignment across a grid of discrimination factor combinations and report how
   many individuals keep stable assignments.
7. **Summary.** Report the capture-to-peak distance per individual and tissue, and average surfaces by
   sampling region.

Interpretation carries three limits stated in the source. Tissues integrate diet as fish move, so
assignment surfaces "should therefore be interpreted as integrated foraging landscapes rather than single
points, particularly for the longer-integrating fin tissue" [Griffin et al. 2026, p. 5]. Prey also
migrate, so the surfaces show where prey resources originated as well as where tarpon fed [Griffin et al.
2026, p. 8]. Some tarpon values fell outside the predicted isoscape range, and those individuals "have
inherently lower assignment confidence" [Griffin et al. 2026, p. 8]. Lipid handling, the sum-of-variances
calculation, the mesh and priors, and the discrimination factor values are in the Supplementary Material
and are not reported in the main text.

## Open questions

- The baseline is primarily marine, so low-salinity habitat use by a euryhaline consumer is not fully
  captured; the authors name δ34S as a complementary tracer [Griffin et al. 2026, p. 8].
- Additional lizardfish samples from shallow estuarine habitats would constrain assignment error in
  coastal areas that tarpon use [Griffin et al. 2026, p. 7–8].
- The isoscapes assume temporal stability in regional biogeochemistry over the sampling period [Griffin
  et al. 2026, p. 7].
- Incorporation rates for tarpon fin and plasma carry uncertainty, although the authors argue that
  telemetry constraints limit the influence of the exact window [Griffin et al. 2026, p. 8].

## Connections

- **Related to:** [[bayesian-mixing-models-for-marine-diet]]. Both methods depend on trophic
  discrimination factors, and the sensitivity grid here follows the advice developed for mixing models. A
  mixing model asks which sources fed a consumer; isoscape assignment asks where.
- **Depends on:** [[migratory-contingents-and-entrainment]]. Contingent membership set the first spatial
  constraint on every assignment, and the South Florida overlap zone is where that constraint could not
  be applied.
- **Depends on:** [[home-range-and-utilisation-distributions]]. The monthly 95% contours from dynamic
  Brownian bridge models define the search areas, so choices made in the utilisation distribution carry
  directly into the assignment surfaces.
- **Related to:** [[integrated-sdm-with-inla-spde]]. The isoscapes use the same `R-INLA` machinery with a
  Gaussian Markov random field and environmental covariates, applied to isotope values rather than
  occurrence data.
- **Related to:** [[region-misclassification-data-qa]]. The tagged fish were detected on cooperative
  networks (iTAG, FACT, ACT, and the Ocean Tracking Network) [Griffin et al. 2026, p. 10], so station
  region labels feed into the monthly contours.

## Sources

- **Griffin et al. 2026.** Griffin LP, Shipley ON, Adams AJ, Brownscombe JW, Ceriani SA, Cooke SJ, Dello
  Russo JJ, Newsome SD, Power M, Wilson JK, Danylchuk AJ. "Discrete foraging landscapes support large
  scale migrations of a marine fish." *Movement Ecology* 14: 63. DOI: 10.1186/s40462-026-00677-3.
  Extraction: [Griffin_2026_TarponForagingLandscapes.md](../raw/Griffin_2026_TarponForagingLandscapes.md)
