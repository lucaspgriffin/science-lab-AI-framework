---
citation: "Griffin LP, Shipley ON, Adams AJ, Brownscombe JW, Ceriani SA, Cooke SJ, Dello Russo JJ, Newsome SD, Power M, Wilson JK, Danylchuk AJ. 2026. Discrete foraging landscapes support large scale migrations of a marine fish. Movement Ecology 14:63"
doi: 10.1186/s40462-026-00677-3
journal: Movement Ecology
year: 2026
volume: "14"
pages: "63"
keywords: [atlantic tarpon, marine conservation, movement ecology, resource acquisition, stable isotope analysis]
source_pdf: "/Users/lucasgriffin/Downloads/s40462-026-00677-3.pdf"
extracted_by: literature-extractor (pdftotext, page-marked text)
extracted_on: 2026-11-25
validated_by: extraction-validator
validated_on: 2026-11-25
status: validated
---

# Griffin et al. 2026

## Verbatim abstract

> "Many marine animals migrate thousands of kilometers, yet the spatial extent of dietary resources acquired along these routes remains poorly understood. Identifying foraging areas across a species' annual cycle is critical for understanding habitat connectivity, aligning conservation with locations essential for sustaining populations, and predicting how environmental variability influences resources. We integrated continental-scale stable isotope assignment modeling (n = 417 individuals) with five years of electronic tagging (n = 85 individuals), using movement data to spatially constrain isotope-based foraging assignments, to identify foraging locations along migration routes of Atlantic tarpon (Megalops atlanticus). Distinct foraging regions emerged across the southeastern United States, including South Florida, the northern Gulf of Mexico, and the Mid-Atlantic Bight. Tissue-specific isotope incorporation rates indicated temporal variation in habitat use, with foraging activity often hundreds of kilometers from capture sites (mean distance to peak probability = 296 ± 188 km). These findings provide a framework for managing foraging habitats essential for highly migratory marine species." (Abstract, p. 1 (PDF p. 1))

## Study system and design

- Species: "Atlantic tarpon (Megalops atlanticus)" (Abstract, p. 1 (PDF p. 1)); baseline species "inshore lizardfish (Synodus foetens), a ubiquitous but resident species that inhabits benthic ecosystems along the continental shelf throughout much of the southern and eastern US" (Introduction, p. 3 (PDF p. 3)).
- Region: "across the southeastern United States, including South Florida, the northern Gulf of Mexico, and the Mid-Atlantic Bight" (Abstract, p. 1 (PDF p. 1)).
- Tarpon tissues: "δ13C and δ15N values from multiple tarpon tissues (fin clips and blood plasma)" (Introduction, p. 3 (PDF p. 3)).
- Isotope sample size: "stable isotope assignment modeling (n = 417 individuals)" (Abstract, p. 1 (PDF p. 1)); plasma subset "n = 30" (Results, p. 3 (PDF p. 3)).
- Telemetry sample size: "five years of electronic tagging (n = 85 individuals)" (Abstract, p. 1 (PDF p. 1)); "five years of tarpon acoustic tracking data [37]" (Introduction, p. 3 (PDF p. 3)).
- Baseline sample size: "A total of 534 inshore lizardfish δ13C and δ15N values were used to develop isoscapes" (Results, p. 3 (PDF p. 3)).
- Baseline data sources: "from two published sources (Radabaugh et al. [40], n = 226 and Shipley et al. [33], n = 286), and collected additional samples (n = 22) from anglers and the Florida Fish and Wildlife Research Institute's Fisheries Independent Monitoring Program" (Materials and methods, p. 8 to 9 (PDF p. 8 to 9)).
- Isoscape model: "Bayesian hierarchical spatial models with integrated nested Laplace approximation via the 'R-INLA' package" (Materials and methods, p. 9 (PDF p. 9)).
- Isoscape covariates: "sea surface temperature (SST °C), chlorophyll a (mg/m3), and depth (m) as independent variables" (Materials and methods, p. 9 (PDF p. 9)).
- Movement model: "monthly utilization distributions from dynamic Brownian bridge movement models [92, 93] using the 'Actel' [94] and the 'RSP' [95] packages" (Materials and methods, p. 10 (PDF p. 10)).
- Latitude model: "Using the 'mgcv' package [96], we constructed and validated a generalized additive mixed effects model with latitude as the dependent variable" (Materials and methods, p. 10 (PDF p. 10)).
- Assignment model: "A bivariate normal probability function defined the most likely probable foraging spaces of Atlantic tarpon." (Materials and methods, p. 9 (PDF p. 9)).
- Paired-tissue test: "We used a Welch Two Sample t-test to test if the distance from the sampling location from blood plasma was significantly different than that from fin tissue." (Materials and methods, p. 10 (PDF p. 10)).
- Ethics: "Handling procedures were conducted in accordance with the American Association for Laboratory Animal Science (IACUC protocol 2016-0049, University of Massachusetts)." (Declarations, p. 10 (PDF p. 10)).
- Funding: "Bonefish & Tarpon Trust." (Funding, p. 10 (PDF p. 10)).
- Data: "All data are available in the supplementary materials." (Data availability, p. 10 (PDF p. 10)).
- Dates: "Received: 1 March 2026 / Accepted: 29 June 2026" (p. 11 (PDF p. 11)).
- Telemetry networks acknowledged: "integrated Tracking of Animals in the Gulf (iTAG), FACT network, Atlantic Cooperative Telemetry (ACT) network, and the Ocean Tracking Network (OTN)" (Acknowledgements, p. 10 (PDF p. 10)).

## Quantitative claims

### Headline results

- 296 ± 188 km: "with foraging activity often hundreds of kilometers from capture sites (mean distance to peak probability = 296 ± 188 km)" (Abstract, p. 1 (PDF p. 1)).
- 40.8 to 966.5 km, 296.2 ± 188.0 km SD: "with the most likely foraging locations ranging from 40.8 to 966.5 km (296.2 ± 188.0 km SD) away from the initial capture location (see Fig. S11 and Highest probability origin in SM)" (Results, p. 4 (PDF p. 4)).
- 158.7 ± 113.7 km SD (plasma) versus 450.7 ± 205.8 km SD (fin): "Assignment probabilities for blood plasma (158.7 ± 113.7 km SD) were more spatially constrained relative to those from paired fin tissue samples (450.7 ± 205.8 km SD) (Fig. 4)" (Results, p. 4 (PDF p. 4)).
- t = -7.4, df = 29, p < 0.001: "and the most probable foraging locations were, on average, closer than those derived from fin (t = -7.4, df = 29, p < 0.001)" (Results, p. 4 (PDF p. 4)).
- 20 of 30 fin, 13 of 30 plasma stable under TDF sensitivity: "Regardless of the TDF, the assignment locations remained highly consistent for 20 out of 30 fin tissue samples and 13 out of 30 blood plasma samples (see Isotopic discrimination and sensitivity in SM)." (Results, p. 4 (PDF p. 4)).
- 121 TDF combinations: "Our sensitivity analysis across 121 TDF combinations (Figs. S13-S15) showed that assignment locations remained stable for most individuals, with consistent regional patterns across tissue types." (Methodological considerations, p. 8 (PDF p. 8)).

### Lizardfish isoscapes

- n = 534: "A total of 534 inshore lizardfish δ13C and δ15N values were used to develop isoscapes (Shipley et al. 2024) across the southeastern US using Bayesian hierarchical spatial models with integrated nested Laplace approximations." (Results, p. 3 (PDF p. 3)).
- Lizardfish δ13C range and mean: "δ13C values ranged from − 19.8‰ to -12.8‰ (mean ± SD = -17.5 ± 0.9‰)" (Results, p. 3 (PDF p. 3)).
- Lizardfish δ15N range and mean: "δ15N values ranged from 7.9‰ to 17.0‰ (12.1 ± 1.7‰)" (Results, p. 3 (PDF p. 3)).
- Carbon isoscape pattern: "The reference carbon isoscape indicated the highest δ13C values in the northern mid-Atlantic region and along the west coast of Florida. In contrast, the lowest δ13C values were observed around the Mississippi Delta and the mid-Atlantic coast, particularly along the coasts of Georgia, South Carolina, and North Carolina" (Results, p. 3 (PDF p. 3)).
- Nitrogen isoscape pattern: "The reference nitrogen isoscape highlighted the highest δ15N values within the western GOM and the northern mid-Atlantic, with generally higher values along the coast, especially around the Mississippi Delta and north of Pamlico Sound." (Results, p. 3 (PDF p. 3)).
- Lizardfish depth: "Inshore lizardfish were collected from continental shelf habitats (mean ± SD depth: 12.6 ± 25.5 m) that overlap with Atlantic tarpon depth use (> 80% of their time in ≤ 10 m) [88]." (Materials and methods, p. 8 (PDF p. 8)).
- Lizardfish size: "We constructed δ13C and δ15N isoscapes using 534 (25.70 ± 3.90 cm; maturity ~ 19 cm) inshore lizardfish samples collected across the GOM and Eastern US." (Materials and methods, p. 8 (PDF p. 8)).
- Source split: "from two published sources (Radabaugh et al. [40], n = 226 and Shipley et al. [33], n = 286), and collected additional samples (n = 22)" (Materials and methods, p. 8 (PDF p. 8)).

### Tarpon isotope values

- Fin n and fork length: "δ13C and δ15N values of Atlantic tarpon fin tissue (n = 417, fork length: 155.9 ± 22.7 cm)" (Results, p. 3 (PDF p. 3)).
- Fin δ13C: "ranged from − 21.0 to -11.3‰ (-15.2 ± 1.1‰)" (Results, p. 3 (PDF p. 3)).
- Fin δ15N: "from 5.7 to 17.2‰ (14.2 ± 1.5‰), respectively" (Results, p. 3 (PDF p. 3)).
- Plasma n and δ13C: "Blood plasma (n = 30) δ13C and δ15N values ranged from − 20.0 to -14.8‰ (-17.7 ± 1.3‰)" (Results, p. 3 (PDF p. 3)).
- Plasma δ15N: "and 9.6 to 14.2‰ (12.4 ± 1.0‰), respectively" (Results, p. 3 (PDF p. 3)).

### Sample sizes

- Contingent counts: "a total of 236 Atlantic tarpon sampled for stable isotope analysis were assigned to the Eastern GOM contingent (Fig. 1)" (Results, p. 3 (PDF p. 3)).
- "In contrast, 110 individuals were assigned to the Eastern US Seaboard contingent, with their initial search area along the coast from South Florida to Virginia." (Results, p. 3 (PDF p. 3)).
- "Additionally, 71 individuals were captured in South Florida, and their search area for geo-assignment encompassed the entire southeastern US." (Results, p. 3 (PDF p. 3)).
- Fin samples by month: "fin samples (set to five-month composites) collected in April (n = 26)"; "if fin tissue samples were collected in March (n = 2), April, May (n = 72), or June (n = 116)" (Results, p. 3 (PDF p. 3)).
- Plasma samples by month: "all blood samples were taken in April (n = 12), May (n = 10), June (n = 6), and July (n = 2)" (Results, p. 3 (PDF p. 3)).
- Ethanol duplicate subset: "Most samples were placed in 95% ethanol with a subset of duplicate samples (n = 45) placed on ice to derive ethanol correction factors" (Materials and methods, p. 9 (PDF p. 9)).
- Fin tissue amount: "Approximately 1 g of fin tissue (5 mm) was collected from the tip of the anterior lobe of the dorsal fin of each tarpon (n = 417; 155.77 ± 17.66 cm)." (Materials and methods, p. 9 (PDF p. 9)).
- Blood volume: "we collected 5 mL of whole blood and extracted blood plasma via centrifugation for 15 min from a subset (n = 30) of Atlantic tarpon" (Materials and methods, p. 9 (PDF p. 9)).
- Sizes of isotope and tagged fish: "Both isotope-sampled (155.8 ± 22.7 cm, n = 417, range: 111.8–208.3 cm) and acoustically tagged (143.6 ± 17.7 cm, n = 85, range: 112–183 cm) Atlantic tarpon were above or near maturity (~ 117.5 cm for males, 128.5 cm for females)." (Materials and methods, p. 10 (PDF p. 10)).
- Fork length of the 417 fin-sampled fish is given three ways in the paper: 155.9 ± 22.7 cm (Results, p. 3 (PDF p. 3)), 155.77 ± 17.66 cm (Materials and methods, p. 9 (PDF p. 9)) and 155.8 ± 22.7 cm (Materials and methods, p. 10 (PDF p. 10)). The SD differs between the p. 9 value and the other two.

### Telemetry results

- Detections and durations: "Monthly utilization distributions were estimated using dynamic Brownian bridge movement models from 85 acoustically tagged Atlantic tarpon, resulting in 67,557 detections (6,404.4 ± 6,705.0 per individual; median 3,692) with tracking durations from 34 to 2,327 days (1,280.6 ± 609.5 days, median 1,449) (Fig. 1)." (Results, p. 3 (PDF p. 3)).
- Tagged fish size: "data for 85 tagged fish with an mean (± SD) fork length of 143.6 ± 17.7 cm (see Griffin et al. [37] for tagging and monitoring details; SM, Table S1)" (Materials and methods, p. 10 (PDF p. 10)).

### Search area constraints

- Incorporation windows: "After accounting for typical isotopic incorporation rates of fish fin (~ five months) and blood plasma (~ < three months) [41–44], composite monthly 95% probability contours largely encompassed coastal areas from Louisiana to Delaware." (Results, p. 3 (PDF p. 3)).
- April fin restriction: "composite 95% probability estimates associated with fin samples (set to five-month composites) collected in April (n = 26) led to a restriction in the search area to Florida and South Georgia" (Results, p. 3 (PDF p. 3)).
- March to June fin restriction: "composite 95% probability estimates led to search areas excluding coastal areas of Virginia and northward. Only fin samples collected in March and May led to the exclusion of Louisiana." (Results, p. 3 (PDF p. 3)).
- Plasma restriction: "Due to a faster incorporation rate associated with blood plasma (set to three-month composites), 95% probability estimates were more restrictive based on the month of sampling, with individuals captured in January-March having restricted search areas, compared to that of May-December" (Results, p. 3 (PDF p. 3)).

### Latitude model

- Model fit: "A generalized additive model with ordinal date as the independent variable predicted the latitude for Atlantic tarpon (F = 1,150,103.2, p < 0.001, deviance explained = 46%), with high variation observed across different individuals (F = 648.3, p < 0.001, (Fig. 1)." (Results, p. 3 (PDF p. 3)).
- Peak latitude: "The model predicted that Atlantic tarpon would be at higher latitudes during the months of July to October (max latitude: 39.16°N)." (Results, p. 3 (PDF p. 3)).
- Prediction intervals: "the 95% confidence intervals (CI) for the predicted latitude ranged from 23.63 to 33.01°N, while the 75% CI ranged from 25.26 to 31.44°N" (Results, p. 3 (PDF p. 3)).

### Regional assignments

- South Florida: "South Florida (< 26.11°N) was more consistently assigned as the most probable foraging region for Atlantic tarpon, except for those captured in the Mid-Atlantic (> 29.40 °N, > -81.50°) (Fig. 2)." (Results, p. 4 (PDF p. 4)).
- Mid-Atlantic fish: "Individuals sampled from this area had the highest assignment probabilities between Georgia and North Carolina (30.74–36.09°N)." (Results, p. 4 (PDF p. 4)).
- East Florida fish: "Fish sampled from East Florida (26.0–30.73° N, > −81.40°) had the highest assignment probabilities in South Florida as well as in northeastern Florida and Georgia (29.31–31.98 °N)." (Results, p. 4 (PDF p. 4)).
- Northern GOM: "The Northern GOM (> 29.00° N, < −83.30°), including northwest Florida (28.94–30.13°N), was assigned as a highly probable (≥ 25%) foraging location for fish sampled in the Northern GOM, West Florida (26.11–30.73° N, < −81.79°), and South Florida (Fig. 2)." (Results, p. 4 (PDF p. 4)).

### Cited comparison values

- Trueman et al. [24], North Sea scallops: "Trueman et al. [24] used jellyfish (Cyanea capillata) δ13C and δ15N isoscapes in the North Sea to determine queen scallop origin (Chlamys opercularis) with 90% accuracy achieved within 40% of the isoscape area." (Introduction, p. 2 (PDF p. 2)).
- Luo and Ault [88], tarpon depth use: "depth use of ≤ 10 m for > 80% of their time [88]" (Materials and methods, p. 10 (PDF p. 10)).
- Griffin et al. [37], residence in northern areas: "Each year, individuals remain in these northern foraging areas for up to four months [37]" (Discussion, p. 6 (PDF p. 6)).

## Methods worth reusing

### Tissues and storage

- "Approximately 1 g of fin tissue (5 mm) was collected from the tip of the anterior lobe of the dorsal fin of each tarpon" (Materials and methods, p. 9 (PDF p. 9)).
- "Most samples were placed in 95% ethanol with a subset of duplicate samples (n = 45) placed on ice to derive ethanol correction factors (see Tissue collection and processing collection in SM)." (Materials and methods, p. 9 (PDF p. 9)). The correction factor values are not given in the main text.
- "Given its faster rate of isotopic incorporation [41], we collected 5 mL of whole blood and extracted blood plasma via centrifugation for 15 min from a subset (n = 30) of Atlantic tarpon" (Materials and methods, p. 9 (PDF p. 9)).
- Lizardfish tissue: "We compiled inshore lizardfish dorsal muscle δ13C and δ15N values (see Inshore lizardfish processing in SM and the complete dataset in SM Data S1)" (Materials and methods, p. 8 (PDF p. 8)).
- Lipid handling: no lipid extraction or lipid normalisation statement appears in the main text; the main text refers to "Tissue collection and processing in SM" and "Inshore lizardfish processing in SM" (Materials and methods, p. 8 to 9 (PDF p. 8 to 9)).

### Trophic discrimination

- "Both inshore lizardfish and Atlantic tarpon are opportunistic foragers (largely piscivores) within coastal ecosystems, and trophic discrimination factors account for differences in trophic position between species and tissue-specific fractionation between Atlantic tarpon tissues (fin, plasma) and inshore lizardfish(see Isotopic discrimination and sensitivity in SM)." (Materials and methods, p. 8 (PDF p. 8)).
- "Isotopic values were adjusted using trophic discrimination factors that accounted for both trophic position differences between species and tissue-specific fractionation between Atlantic tarpon tissues (fin, plasma) and inshore lizardfish muscle (see Isotopic discrimination and sensitivity in SM)." (Materials and methods, p. 9 (PDF p. 9)). The TDF values themselves are not given in the main text.
- "Lastly, we tested the sensitivity of geographic assignment to variable TDFs as recommended for Bayesian isotope mixing models [97] (see Isotopic discrimination and sensitivity in SM). To assess the stability of assignment for individuals with paired fin and blood plasma samples, we plotted the change in assignment distance as a function of the discrimination value combination." (Materials and methods, p. 10 (PDF p. 10)).

### Isoscape construction

- Baseline rationale: "As resident mid-trophic predators with limited movements, they integrate local food-web baselines and serve as a proxy for spatial biogeochemical variation, making them well-suited for constructing isoscapes relevant to higher trophic consumers such as Atlantic tarpon [33]." (Materials and methods, p. 8 (PDF p. 8)).
- "To account for spatial autocorrelation and to incorporate uncertainty across the study area, isoscapes were constructed from Bayesian hierarchical spatial models with integrated nested Laplace approximation via the 'R-INLA' package (http://www.r-inla.org) [89] (see Bayesian hierarchical spatial modeling framework in SM)." (Materials and methods, p. 9 (PDF p. 9)).
- "With δ13C and δ15N values as the dependent variables, we constructed two models with sea surface temperature (SST °C), chlorophyll a (mg/m3), and depth (m) as independent variables (see Environmental and depth data aggregation in SM)." (Materials and methods, p. 9 (PDF p. 9)).
- "Samples were collected over multiple years, but temporal effects were not modeled due to insufficient sample sizes when partitioned by year and location." (Materials and methods, p. 9 (PDF p. 9)).
- "Our Gaussian Markov random field approach (Fig. S3) explicitly accounted for spatial autocorrelation in the underlying data structure, predictions were constrained to areas within the range of the environmental covariates [84]" (Methodological considerations, p. 7 (PDF p. 7)).

### Assignment model

- "Our assignment approach calculated the likelihood that Atlantic tarpon obtained dietary resources from each grid cell within movement-constrained search areas, generating continuous probability distributions across space rather than single-point assignments." (Materials and methods, p. 9 (PDF p. 9)).
- "Assignments were made by estimating the likelihood that Atlantic tarpon δ13C and δ15N values fall within a given raster cell and are derived from the isotopic difference between the sample and cell value relative to the total variance in the isoscape. Following that of Vander Zanden et al. [90] and Truemen et al. (2017), the bivariate normal probability function (Eq. 1)" (Materials and methods, p. 9 (PDF p. 9)).
- Terms: "The mean isotopic values for cell i are represented by µ i , while Σ is the variance-covariance matrix. The correlation between δ13C and δ15N values across the isoscape is denoted by ρ . The pooled standard deviations for δ13C and δ15N, σ x and σ y , are calculated from the sum of the variances (see Sum of Variances in SM)." (Materials and methods, p. 9 (PDF p. 9)).
- Odds transform: "We then extracted the probability estimates for each cell (P) and converted these probabilities into odds ratios using (Eq. 2): Odds = P / (1 − P)" (Materials and methods, p. 9 (PDF p. 9)).
- Normalisation: "We then calculated the maximum odds value and normalized the odds ratios by dividing each by this maximum, enabling a standardized comparison across different cells." "We refer to these normalized odds ratios, which range from 0 to 1, as 'resource probabilities' hereafter." (Materials and methods, p. 9 (PDF p. 9)).

### Search area rules

- Incorporation assumptions: "the incorporation rate defined here as the isotopic half-life (T50) for fin tissue was assumed to be no greater than five months. Therefore, the search window encompassed the previous five months of movement data. Conversely, the incorporation rate for blood plasma was assumed to be no greater than three months (see Search area in SM)." (Materials and methods, p. 9 (PDF p. 9)).
- Contingents: "one along the west coast of Florida and northward towards Louisiana, known as the Eastern GOM contingent, and the other along the east coast of Florida and northward towards Virginia, known as the Eastern US Seaboard contingent [37, 38]" (Materials and methods, p. 9 (PDF p. 9)).
- "Then, dependent on contingent membership, we confined our search areas for each sampled fish to corresponding habitat utilization maps derived from Atlantic tarpon satellite telemetry [36]." (Materials and methods, p. 9 (PDF p. 9)).
- South Florida overlap: "If the sample came from an individual captured in South Florida, where the contingents overlap [37, 38, 91], we could not assign a contingent and extended the search area to the entire extent of the habitat utilization maps from South Florida to Louisiana and Virginia." (Materials and methods, p. 9 (PDF p. 9)).
- Monthly contour rule: "Dependent on the month of capture, the search area was then constrained to the corresponding monthly 95% probability contour and the four months prior (five months in total) for fin tissue samples or two months prior (three months in total) for blood plasma samples." (Materials and methods, p. 10 (PDF p. 10)).
- Latitude GAMM: "a generalized additive mixed effects model with latitude as the dependent variable, derived from interpolated tracks using the 'RSP' package [95], ordinal date as the independent variable, and individual ID as a random effect. Ordinal date was modeled with a cyclic cubic regression spline smooth with six knots. Model diagnostics were assessed using the gam.check function" (Materials and methods, p. 10 (PDF p. 10)).
- Tissue-specific intervals: "we used narrower prediction intervals for plasma (75%) to reflect the higher temporal precision of this tissue, while retaining broader 95% intervals for fin, which integrates diet over a longer window" (Materials and methods, p. 10 (PDF p. 10)).
- Depth cap: "Lastly, we also restricted the search window to areas less than 20 m in depth, corresponding to Atlantic tarpon satellite telemetry data habitat utilization maps [36] and depth use of ≤ 10 m for > 80% of their time [88]." (Materials and methods, p. 10 (PDF p. 10)).
- Regional averaging: "the most likely origin of Atlantic tarpon prey resources was generated for each individual by tissue type and averaged across each sampling region (Northern GOM, West, South, and East Florida, and Mid-Atlantic)" (Materials and methods, p. 10 (PDF p. 10)).
- Distance metric: "we calculated the distance from each capture site to the grid cell with the highest assignment probability" (Materials and methods, p. 10 (PDF p. 10)).

## Management statements

- "Given their high reliance on this area, conservation efforts should focus on protecting coastal habitats and mitigating the impacts of altered freshwater flows, which can affect the composition and abundance of forage species in estuarine creeks and adjacent wetlands [62, 63]." (Discussion, p. 6 (PDF p. 6)).
- "there is growing concern over the management of menhaden stocks [80–82] underscoring the need to explicitly integrate foraging hotspots into ecosystem-based fisheries management frameworks [3]" (Discussion, p. 7 (PDF p. 7)).
- "This includes prioritizing the South Florida, northern Gulf of Mexico, and Mid-Atlantic Bight foraging grounds for habitat protection and restoration, coordinating management across the jurisdictions these migrations cross, and integrating these foraging hotspots, and the prey that sustain them, into ecosystem-based fisheries management." (Conclusions and future directions, p. 8 (PDF p. 8)).
- "In this context, resolving where Atlantic tarpon forage enables place-based protection that jurisdictionally bounded management often misses." (Conclusions and future directions, p. 8 (PDF p. 8)).
- "Protecting and improving these spatially discrete grounds is essential, as degradation of even a single key site may compromise broader migratory success, individual fitness, and by extension long-term population viability." (Discussion, p. 5 to 6 (PDF p. 5 to 6)).

## Stated limitations

- "First, this approach assumed relative temporal stability in regional biogeochemical patterns over the sampling period." (Methodological considerations, p. 7 (PDF p. 7)).
- "Second, isoscape prediction variance varied spatially, with higher uncertainty in sparsely sampled regions (Fig. S5)." (Methodological considerations, p. 7 (PDF p. 7)).
- "Baseline sampling was comparatively sparse across portions of southern and eastern Florida and the southeastern Atlantic coast (Georgia and the Carolinas), so assignments in these regions carry greater uncertainty" (Methodological considerations, p. 7 (PDF p. 7)).
- "Third, although our kriging approach extended predictions across our study area, additional inshore lizardfish samples in shallower coastal estuarine habitats would have further constrained errors associated with the assignment probabilities." (Methodological considerations, p. 7 to 8 (PDF p. 7 to 8)).
- "because Atlantic tarpon are euryhaline and our baseline is primarily marine, low-salinity habitat use is not fully captured here; sulfur isotopes (δ34S) would offer a complementary tracer for distinguishing these sources in future work" (Methodological considerations, p. 8 (PDF p. 8)).
- "Fourth, some Atlantic tarpon isotope values fell outside predicted isoscape ranges (Fig. S12), likely reflecting trophic position differences, use of very shallow estuarine habitats not well-represented in our inshore lizardfish sampling, or temporal mismatches between tissue integration periods. These individuals have inherently lower assignment confidence." (Methodological considerations, p. 8 (PDF p. 8)).
- "Reported tissue incorporation rates also carry uncertainty; however, because each individual's search area was independently constrained by telemetry, the exact incorporation window may have only limited influence on the assignments." (Methodological considerations, p. 8 (PDF p. 8)).
- "assignment probability distributions reflect potential foraging locations and areas where prey originated, as prey species often migrate themselves" (Methodological considerations, p. 8 (PDF p. 8)).
- "because tissues integrate diet continuously as individuals move, isotopic values likely represent a spatial average of resources acquired across more than one foraging area; assignment probabilities should therefore be interpreted as integrated foraging landscapes rather than single points, particularly for the longer-integrating fin tissue" (Discussion, p. 5 (PDF p. 5)).

## Lab references cited

- Griffin et al. 2023 Mar Policy, angler and guide perceptions of the tarpon fishery (ref 34)
- Griffin et al. 2023 Mar Biol, individual variation and repeatability of tarpon migrations (ref 37)
- Griffin et al. 2025 Fish Fish, entrainment hypothesis and tarpon life cycles (ref 38)
- Griffin et al. 2022 Mar Ecol Prog Ser, seasonal phenology of tarpon in the Florida Keys (ref 91)
- Griffin et al. 2025 Fisheries, habitat management and restoration in flats conservation (ref 59)
- Danylchuk et al. 2023 Environ Biol Fish, cascading effects of climate change on flats fishes (ref 58)
- Adams et al. 2009 Estuaries Coasts, freshwater flow alteration and juvenile snook trophic ecology (ref 62)
- Adams et al. 2019, IUCN Red List assessment for Megalops atlanticus (ref 35)
- Lennox et al. 2016 Conserv Physiol, conservation physiology of animal migration (Cooke coauthor, ref 50)
- Matley et al. 2022 Trends Ecol Evol, global trends in acoustic telemetry (Cooke coauthor, ref 87)

## Correction in progress

A correction to the ethanol-stored fin clip adjustment is being prepared by the authors. The code and data as corrected are in the public repository lucaspgriffin/tarpon_SIA_move_eco. Until the notice is published, the fin δ13C values, the fin assignment distances and the paired fin versus plasma test statistic above should be checked against that repository before reuse.

## Provenance

Text was obtained by pdftotext from the open-access PDF and read in full as page-marked text, PDF pages 1 to 13, which match the journal pagination (Page n of 13). All main-text sections were read: Abstract, Introduction, Results, Discussion, Methodological considerations, Conclusions and future directions, Materials and methods, declarations and references. Equation 1 was not transcribed because the text layer scrambles its layout; its description in prose is quoted instead. The supplementary material (Figs. S1 to S15, Table S1, Data S1 and S2) was not available, so the ethanol correction factors, lipid handling, trophic discrimination factor values, the 121 TDF combinations, the sum-of-variances calculation, the INLA mesh and priors, and the environmental data aggregation are referenced here only by their SM section names. Figures 1 to 4 were not used to read values; every number above comes from the text.
