---
title: "Forage fish dynamics"
slug: "forage-fish-dynamics"
domain: "Methods: detection and survey"
aliases: ["pinfish dynamics", "forage fish indices", "Florida Forage Fish Research Program", "FFRP", "portfolio effect in estuarine fish"]
related: [hurdle-brt-habitat-suitability, predator-prey-spatial-overlap, fim-survey-design, juvenile-indices-and-stock-assessment, freshwater-inflow-and-nekton, red-tide-effects-on-estuarine-fish, snook-range-expansion, reef-fish-survey-design]
sources:
  - raw/Faletti_2019_PinfishDynamics.md
  - raw/Sinnickson_2021_RiverDischargeEwE.md
  - raw/FWRI_2023_FIMForageWorkshop.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Forage fish dynamics

## Summary

Forage fishes are small to intermediate-sized schooling fishes that are prey for numerous marine predators [Faletti et al. 2019, p. 1]. In Florida estuaries, the main fishery-independent source of forage fish abundance is the 21.3-m center-bag seine of the Florida Fish and Wildlife Research Institute (FWRI) Fisheries-Independent Monitoring (FIM) program. Faletti et al. (2019) built the longest multi-estuary series for one forage species, the Pinfish *Lagodon rhomboides*, from monthly seine hauls in Apalachicola Bay, Cedar Key, Tampa Bay, and Charlotte Harbor in 1998–2016. Mean density and biomass were stable over the 19 years, differed by up to an order of magnitude among estuaries, peaked in spring, and were explained mainly by submerged aquatic vegetation (SAV) cover [Faletti et al. 2019, pp. 6, 8, 12]. Sinnickson et al. (2021) used FIM catches of forage groups, including Pinfish, to parameterise and calibrate a food web model of the Suwannee River estuary, and found that drought reduced forage biomass about twice as much as floods increased it [Sinnickson et al. 2021, p. 1]. The Florida Fish and Wildlife Research Institute presented its 2023 forage fish research priorities and data products at the Florida Forage Fish Research Program data workshop [FWRI 2023, slides 28–42].

## Key points

### Index definition

Faletti et al. (2019) did not standardise a relative abundance index. Density for each seine haul was the number of Pinfish divided by the area sampled, expressed as fish per 100 m², and "averaged over all months and years for each estuary" [Faletti et al. 2019, p. 3]. A haul covered 9.1 m of pulled net with a 15.5 m line and a sampled area of 140 m² [Faletti et al. 2019, p. 3]. Annual series were means over all months within a year; monthly series were means over years within a month [Faletti et al. 2019, p. 3]. No year, month, or site effects were fitted to build these series. Zero hauls enter the means, although the text does not say so explicitly.

Biomass (g per 100 m²) was derived by extrapolating the measured subsample to the unmeasured fish and applying the length-weight relationship W = a × SL^b, where W is weight in grams and SL is standard length in millimetres [Faletti et al. 2019, p. 3]. The constants were estimated per estuary from 3,517 fish measured during FIM surveys in 2001–2017 [Faletti et al. 2019, p. 3]. In the field, all Pinfish were counted and up to ten randomly selected individuals were measured, then released alive [Faletti et al. 2019, p. 3].

Sinnickson et al. (2021) used a different index definition for the same program. Annual indices of abundance for fish functional groups were estimated from FIM data with delta generalised linear models, "necessary to standardize across gears and habitats, as some species were more adequately sampled in certain habitats, months, or with certain gears" [Sinnickson et al. 2021, p. 6]. A log-normal model of biomass density from positive sets was fitted first, then a binomial model for probability of occurrence, and "the product of the least squared means for each year from the two models was taken as the index" [Sinnickson et al. 2021, p. 6]. Predictors in both models were bottom and shoreline habitat types, bottom vegetation, gear type, salinity, temperature, dissolved oxygen, month, year, and location, and models were compared by lowest Akaike information criterion (AIC) [Sinnickson et al. 2021, p. 6].

The two definitions answer different questions. The nominal mean describes catch per unit area by estuary and month and suits comparisons of seasonal timing. The delta model removes gear, habitat, and month effects and suits a single time series that must be compared with other data, as in the model calibration of Sinnickson et al. (2021). Faletti et al. (2019) cite no evidence that the nominal mean is biased, and the two papers do not compare the approaches.

### Gear and design

Both papers rely on the stratified random design of the Fisheries-Independent Monitoring program. Faletti et al. (2019) describe strata defined by spatial zones, water depth, and habitat type (SAV, unvegetated, and shoreline), with each estuary divided into 1 nautical mile² grids stratified by depth and a 183 m² microgrid selected at random within each grid [Faletti et al. 2019, p. 3]. The institute describes the design as "usually stratified random", dividing a heterogeneous environment into homogeneous strata by space and sometimes habitat [FWRI 2023, slide 10].

The two papers describe the small seine slightly differently.

| Attribute | Faletti et al. 2019 | Sinnickson et al. 2021 |
|---|---|---|
| Net | 21.3 m center-bag seine | 21.3 m seine |
| Mesh | 3.2 mm [p. 3] | 3 mm [p. 3] |
| Depth limit | restricted to depths less than 1.8 m; grids with minimum depth 0.1–1.8 m selected [p. 3] | "generally less than 1.0 m in depth" [p. 3] |
| Target fish | not stated | fish less than 150 mm SL [p. 3] |
| Effort | mean 9–20 hauls per month per estuary [p. 3] | approximately thirty small seine hauls per month at Cedar Key [p. 3] |

The papers do not reconcile the effort figures. Faletti et al. (2019) also state that only hauls "a minimum of 5m away from the shoreline" were retained [Faletti et al. 2019, p. 3], and Sinnickson et al. (2021) describe sampling "along and near the shoreline" [Sinnickson et al. 2021, p. 3]. Gear history is on a FWRI timeline: the 21.3-m seine (juveniles) began in Tampa Bay and Charlotte Harbor in 1989, Cedar Key sampling in 1996, and Apalachicola Bay in 1998 [FWRI 2023, slide 7]. The Faletti et al. window of 1998–2016 begins in the Apalachicola Bay start year; the paper does not state the reason for the choice.

Both papers acknowledge selectivity. Faletti et al. (2019) note that the habitats Pinfish used at Cedar Key may have left larger fish more susceptible to the gear, and that the late-summer drop in density could reflect post-settlement mortality, escapement of larger individuals, or offshore movement [Faletti et al. 2019, p. 13]. Sinnickson et al. (2021) assigned catchability coefficients by group and gear, starting at 0.50, and adjusted them during mass balancing [Sinnickson et al. 2021, p. 6].

### Density and biomass

Mean density and biomass (plus or minus standard error) over all years were highest in Charlotte Harbor and lowest at Cedar Key [Faletti et al. 2019, p. 6]:

| Estuary | Density (fish per 100 m²) | Biomass (g per 100 m²) |
|---|---|---|
| Charlotte Harbor | 76.80 ± 8.40 | 266.18 ± 11.46 |
| Tampa Bay | 40.43 ± 4.42 | 103.18 ± 4.79 |
| Apalachicola Bay | 23.17 ± 2.39 | 89.19 ± 5.48 |
| Cedar Key | 6.37 ± 0.93 | 38.64 ± 3.45 |

Values varied "by as much as an order of magnitude between estuaries" [Faletti et al. 2019, p. 6], and Charlotte Harbor had about twice the density and biomass of Tampa Bay [Faletti et al. 2019, p. 12]. The authors found "no management concern" for Pinfish stocks because they saw no trend in density or biomass over the 19 years [Faletti et al. 2019, p. 12]. The paper reports no trend test or slope, so the absence of a trend rests on the plotted series. A formal stock assessment for Pinfish had not been completed [Faletti et al. 2019, p. 2].

### Seasonal timing

Density increased early in the year and peaked in March–May across the four estuaries [Faletti et al. 2019, p. 6]. Southern estuaries tended to have a one-month peak and northern estuaries peaks lasting three months [Faletti et al. 2019, p. 6]. Juvenile Pinfish settle in Florida seagrass beds from November to March, and adults migrate offshore to spawn between October and May after maturing at about 110 mm [Faletti et al. 2019, p. 2]. Density peaked earlier (March–April) than biomass (April–May) [Faletti et al. 2019, p. 12]. Within estuaries, peak synchrony between density and biomass lagged by one month in Charlotte Harbor (r = 0.96), two months in Apalachicola Bay (r = 0.86) and Tampa Bay (r = 0.94), and four months at Cedar Key (r = 0.80) [Faletti et al. 2019, p. 7]. The source prints the Charlotte Harbor value as "r = 0. 0.96", a typographical error read here as 0.96.

### Habitat models

Faletti et al. (2019) fitted a zero-altered negative binomial model separately for each estuary, selected "due to overdispersion of both zeroes and non-zero data" [Faletti et al. 2019, p. 5]. Submerged aquatic vegetation cover explained the most variability in both presence and density in all four estuaries, "2-38 times more variability than each of the other significant terms for presence and 2-11 times more variability for density" [Faletti et al. 2019, p. 8]. The quadratic SAV term followed, and the authors state that the SAV effect "reached a saturation level in each of the four estuaries" [Faletti et al. 2019, p. 13]. Standardised coefficients for Tampa Bay and Charlotte Harbor, the two estuaries most relevant to the Gulf coast work of the lab, were as follows [Faletti et al. 2019, p. 11]:

| Estuary and component | SAV | SAV² | Salinity | Temperature | Depth |
|---|---|---|---|---|---|
| Tampa Bay, presence | 2.0577*** | -0.7783*** | 0.6921*** | not selected | not selected |
| Tampa Bay, density | 1.0671*** | not selected | 0.3858*** | -0.6767*** | -0.1017** |
| Charlotte Harbor, presence | 1.7210*** | -0.4483* | 0.6606*** | 0.1891*** | 0.1863*** |
| Charlotte Harbor, density | 0.8109*** | -0.313* | 0.4445*** | -0.5587*** | 0.1460*** |

Salinity was positively related to density in the southern estuaries and negatively in the northern ones (Apalachicola Bay -0.0851, Cedar Key -0.3579) [Faletti et al. 2019, pp. 8–10, 11]. Temperature was negatively related to density in all four estuaries (-0.3354 to -0.6767) [Faletti et al. 2019, p. 11]. The authors report that the decrease in density at egress and the increase at settlement coincide with lower water temperatures [Faletti et al. 2019, p. 13]. They also report that Chacin et al. (2016) found no relationship between Pinfish density and temperature in Tampa Bay [Faletti et al. 2019, p. 13].

The paper contains statements that conflict with the coefficients as printed. The Conclusion says abundance and biomass were highest in areas with "more SAV coverage and higher temperatures" [Faletti et al. 2019, p. 14], whereas the density coefficients for temperature are negative in every estuary. The only positive temperature terms in the tables are in the presence models for Apalachicola Bay (0.3705) and Charlotte Harbor (0.1891) [Faletti et al. 2019, p. 11]. The Results also cite Fig 2B for the temperature effect on presence [Faletti et al. 2019, p. 8], but Fig 2B shows intra-annual density, and Table 2A is the likely intended reference. Coefficients and the main text are used here in preference to the Conclusion.

### Synchrony and portfolio

Faletti et al. (2019) detrended the density series to remove seasonal signals for inter-annual synchrony, retained only the seasonal signal for intra-annual synchrony, and computed cross-correlations for each estuary pair with lags of 0–3 months [Faletti et al. 2019, pp. 4, 7].

- Inter-annual density: positive between the two northern estuaries (Apalachicola Bay and Cedar Key, r = 0.30) and between the two southern ones (Tampa Bay and Charlotte Harbor, r = 0.53), negative between Tampa Bay and Cedar Key (r = -0.18), and asynchronous for other pairs [Faletti et al. 2019, p. 6].
- Intra-annual density: all pairs positive (r = 0.88–0.99), with the northern estuaries lagging the southern by about one month [Faletti et al. 2019, p. 7].
- Intra-annual biomass: generally positive (r = 0.77–0.92), but Cedar Key was negatively synchronous with Tampa Bay (r = -0.85) and Charlotte Harbor (r = -0.92) [Faletti et al. 2019, p. 7].

Table 1 labels Apalachicola Bay "AP" where the text uses "AB". The portfolio effect was the average coefficient of variation portfolio effect (CVPE), the mean of the local coefficients of variation divided by the coefficient of variation of the whole metapopulation, computed on peak density as a three-month moving average [Faletti et al. 2019, pp. 5, 7]. A CVPE of 1.0 "effectively represents a single homogeneous population" and values above 1.0 indicate asynchronous dynamics that stabilise the whole [Faletti et al. 2019, p. 5]. The four-estuary CVPE was 1.42 ("42% more stable than a single homogenous population"), the northern pair 1.35, and the southern pair 1.05 [Faletti et al. 2019, p. 7]. The low southern value suggested that Charlotte Harbor and Tampa Bay acted as one population, but the authors give a second reading, that the whole metapopulation "could have resulted from the metapopulation being well-mixed and acting as a single population" [Faletti et al. 2019, p. 12]. Synchrony could also arise from shared environmental drivers [Faletti et al. 2019, p. 12]. Cedar Key was the most variable estuary in peak density (CV = 1.12 against 0.63–0.77 elsewhere) [Faletti et al. 2019, p. 7].

### Growth

Pinfish standard length increased by a mean of 45–55 mm between December recruitment and October of the following year in all four estuaries [Faletti et al. 2019, p. 7]. Instantaneous growth rates were similar across estuaries, 0.15 to 0.17 per month [Faletti et al. 2019, p. 7]. Estuary values from the Fig 6 legend were 0.15 ± 0.010 (Apalachicola Bay), 0.17 ± 0.007 (Cedar Key), 0.17 ± 0.001 (Tampa Bay), and 0.17 ± 0.004 (Charlotte Harbor) [Faletti et al. 2019, p. 11]. Apalachicola Bay had the lowest rate [Faletti et al. 2019, p. 13]. Larger lengths at Cedar Key after July may reflect density-dependent growth at the lowest density, or greater gear susceptibility [Faletti et al. 2019, p. 13].

### Suwannee food web

Sinnickson et al. (2021) built the Suwannee River Estuary Model in Ecopath with Ecosim with 59 functional groups, 37 of them fish [Sinnickson et al. 2021, p. 4]. The Suwannee estuary lies about 180 km north of Tampa Bay [Sinnickson et al. 2021, p. 2], and the FIM program has sampled Cedar Key since 1996 [Sinnickson et al. 2021, p. 3]. Of about 300 species collected, 85 met the inclusion rule used to build groups [Sinnickson et al. 2021, p. 4].

Forage biomass was highest for adult mullet (4.79 g/m²), anchovies (*Anchoa* spp., 1.43 g/m²), and Pinfish (0.92 g/m²) and lowest for mojarra (0.12 g/m²), juvenile mullet (0.19 g/m²), and killifish (0.23 g/m²) [Sinnickson et al. 2021, p. 9]. Table 1 prints Pinfish as 0.91 t/km² [Sinnickson et al. 2021, p. 5], a small mismatch with the text. Pinfish had an ecotrophic efficiency of 0.955 and lost 12 percent of its biomass to predators [Sinnickson et al. 2021, p. 9].

Short-term scenarios produced the largest forage fish changes. Dry scenarios lowered total forage fish biomass by an average of 17 percent and sportfish by 14 percent, whereas the wet scenario raised them by 9 and 7 percent [Sinnickson et al. 2021, p. 10]. After three consecutive dry years, adult mullet declined 20 percent, Pinfish 17 percent, and anchovies 16 percent [Sinnickson et al. 2021, p. 10]. Mojarra and juvenile mullet were the most resistant forage groups (-10 to +4 percent) [Sinnickson et al. 2021, p. 10]. Long-term scenarios (2019–2068) produced decreases of one to five percent for forage and sportfish [Sinnickson et al. 2021, p. 11]; anchovies and killifish were the most sensitive forage taxa, each decreasing 5 percent in the most extreme scenario [Sinnickson et al. 2021, p. 12]. The mean forage-to-sportfish ratio was 3.6 across the three-year scenarios and 3.1 across the fifty-year scenarios [Sinnickson et al. 2021, p. 12].

Fits to the FIM indices were better when primary production was forced by nutrients than by discharge, and the model "frequently" underpredicted fish biomass under discharge forcing [Sinnickson et al. 2021, p. 9]. Pinfish, killifish, anchovies, and adult mullet fitted well under nutrient forcing, whereas ladyfish, snapper, and jack crevalle fitted poorly [Sinnickson et al. 2021, p. 10]. Faletti et al. (2019) and Sinnickson et al. (2021) overlap only at Cedar Key. Faletti et al. found the lowest Pinfish density there, so the Suwannee model describes a low-density Pinfish system relative to Charlotte Harbor or Tampa Bay, and its forage responses should not be transferred to those estuaries without a local model.

### Research priorities

The research institute presented its 2023 priorities for the Florida Forage Fish Research Program with data-type tags (survey, diet, applied science, and web-based access) [FWRI 2023, slide 28]. The priorities that apply to forage fish indices were:

- Inshore and offshore connectivity of forage fish abundance, and energy transfer from estuaries to offshore predators using diet data [FWRI 2023, slides 29, 37].
- Reef fish assemblage in relation to forage fish abundance from underwater video [FWRI 2023, slide 30].
- Chronic and acute drivers of abundance, including red tide, storms, droughts, Lake Okeechobee discharges, and septic tanks, and "spatially explicit temporal models relating perturbance to inshore/offshore datasets" [FWRI 2023, slide 31].
- Freshwater flow effects on fish communities in Tampa Bay watershed rivers, and revisiting salinity relationships for species [FWRI 2023, slide 32].
- Multivariate habitat preference including water velocity, depth, vegetation, salinity, temperature, substrate, and prey availability [FWRI 2023, slide 33].
- Molecular tools to detect fish species or eggs, and in diet studies [FWRI 2023, slides 34, 40].
- Regional variation in forage fish community composition among Florida estuaries: "which, where, when, and why?" [FWRI 2023, slide 36].
- Seasonal and annual diet shifts of predators against FIM catches of forage species, including offshore Tomtate and Pinfish diets, and coupling ecological and trophic data [FWRI 2023, slides 38, 41].

The FIM design aims to support "single-species assessment and management" and "multi-species, ecosystem-based modeling and management" [FWRI 2023, slide 5]. The program lists a trophodynamics database of over 40,000 stomach samples processed to date [FWRI 2023, slide 19].

### Data products

The research institute describes inshore data as held in SQL Server, with SAS and CSV formats possible but requiring more processing time, and length-weight data as SQL Server that can be provided as CSV [FWRI 2023, slide 26]. Metadata document tables, columns, relationships, and calculations including effort, length extrapolations, and splitter expansions, and the slides state that code lists are integral to the data [FWRI 2023, slide 27]. Planned access products include data publication, web-based interface tools, annual delivery of data and metadata to a repository, and "R package for querying FIM data from repository" [FWRI 2023, slide 42]. No contact or portal address appears on the slides. Faletti et al. (2019) deposited their analysis data at https://doi.org/10.17882/61775 and direct requests for further FIM data to FWRI [Faletti et al. 2019, p. 1]. The FWRI deck reports more than 420 peer-reviewed manuscripts from FIM and partners [FWRI 2023, slide 25].

## Methods and approaches

The steps below combine the procedures of Faletti et al. (2019) and Sinnickson et al. (2021) for a forage fish index from FIM seine data, for example Tampa Bay phenology of Pinfish or other forage species.

1. **Select the gear and haul set.** Use the 21.3-m center-bag seine only. Retain hauls from grids with minimum depth 0.1–1.8 m. Faletti et al. (2019) also kept only hauls a minimum of 5 m from the shoreline [Faletti et al. 2019, p. 3]. Confirm the haul definition and zone coding in the FIM metadata [FWRI 2023, slide 27].
2. **Compute density per haul.** Divide the count by the sampled area (140 m² per haul in Faletti et al. 2019) and express as fish per 100 m² [Faletti et al. 2019, p. 3]. Keep zero hauls in the data so that presence-absence and density models can use them.
3. **Compute biomass per haul.** Extrapolate the measured subsample (up to ten fish per haul) to all fish counted, and apply a length-weight relationship estimated per estuary from FIM length and weight data [Faletti et al. 2019, p. 3].
4. **Build a monthly series for phenology.** Average per-haul density over hauls within month and over years within month to obtain the seasonal curve, and average over months within a year for the annual series [Faletti et al. 2019, p. 3]. Report the month of peak density and the width of the peak, as Faletti et al. did (one month in southern estuaries and three in northern ones) [Faletti et al. 2019, p. 6].
5. **Standardise when the index will be compared or calibrated.** Estimate a delta model (log-normal positive biomass density plus binomial occurrence) with habitat, vegetation, gear, salinity, temperature, dissolved oxygen, month, year, and location, select by AIC, and take the product of the yearly least-squares means as the index [Sinnickson et al. 2021, p. 6]. Use the reciprocal of the mean annual coefficient of variation as the weight when the series enters a fitting objective [Sinnickson et al. 2021, p. 6].
6. **Model habitat.** Use a zero-altered negative binomial model (binomial presence-absence component and negative binomial density component), per estuary, with SAV cover, SAV², temperature, salinity, depth, and the SAV by temperature interaction, using forward and backward stepwise selection on AIC for both components [Faletti et al. 2019, p. 5]. Faletti et al. compared this family with zero-inflated negative binomial, zero-inflated Poisson, and zero-altered Poisson models, and retained the zero-altered negative binomial for higher R² and lower AIC [Faletti et al. 2019, p. 5]. Check collinearity: at a tolerance of 0.5 the variance inflation factors ranged 1.001–1.352 [Faletti et al. 2019, p. 6]. The paper names the MASS and car packages but not the function that fitted the zero-altered model [Faletti et al. 2019, p. 6]. The model has no spatial or temporal random effect, so repeated hauls in the same grid and month are treated as independent, which a mixed-effects extension would address (compare [[hurdle-brt-habitat-suitability]]).
7. **Test synchrony.** Detrend the monthly series for inter-annual synchrony and keep only the seasonal signal for intra-annual synchrony. Compute cross-correlations for each pair of estuaries with a 0–3 month lag window [Faletti et al. 2019, pp. 4, 7].
8. **Quantify the portfolio effect.** Take the three-month moving average of density, compute the local coefficient of variation for each estuary and for the combined series, and divide the mean local value by the combined value to obtain CVPE [Faletti et al. 2019, pp. 5, 7].
9. **Estimate growth.** Use monthly mean standard length with an emphasis on April through July, to avoid settlement (January–March) and ontogenetic movement (August–December), and fit ln(Lt) = ln(L0) + G × t [Faletti et al. 2019, p. 5]. Split the smaller cohort at recruitment into a "month 0" [Faletti et al. 2019, p. 5]. Detect multiple cohorts in December with the bimodality coefficient (a value above 0.55 suggests bimodality) and Hartigan's dip test [Faletti et al. 2019, p. 5]. The growth estimate assumes limited migration among estuaries [Faletti et al. 2019, p. 5].
10. **Choose species for community-level work.** Sinnickson et al. kept species occurring in more than one percent of hauls in all gear types or at least five percent of hauls in one gear type, and grouped them by hierarchical clustering on diet, habitat, and taxonomy [Sinnickson et al. 2021, p. 4].

Validation was limited in both papers. Faletti et al. validated the model family by AIC and R² and checked collinearity, but report no out-of-sample test. Sinnickson et al. validated the ecosystem model by sums of squares against the FIM and landings series, with Run 15 as the base run (sum of squares 794 against 1635 for Run 3) [Sinnickson et al. 2021, p. 9].

## Open questions

- Whether the nominal-mean index and a standardised index give the same seasonal peak and the same inter-annual ranking is not tested in either paper.
- The cause of the lack of strong synchrony in the north remains unresolved: Faletti et al. offer asynchrony, a well-mixed single population, and shared environmental drivers as readings that the data cannot separate [Faletti et al. 2019, p. 12].
- The explanation for lower density at Cedar Key and Apalachicola Bay (habitat quality, trophic resources, larval supply, or gear susceptibility) is untested, as none of these variables is in the models [Faletti et al. 2019, pp. 12–13].
- Temperature effects on Pinfish density disagree between Faletti et al. (negative in all four estuaries) and Chacin et al. (no relationship in Tampa Bay), and the Conclusion of Faletti et al. conflicts with their own coefficients.
- Sinnickson et al. note that the ecosystem model did not predict new species entering the system and recommend adding northward-expanding species with temperature forcing [Sinnickson et al. 2021, p. 14].
- FWRI lists discharge, red tide, storm, and drought effects on forage fish as priorities, but the slides give no method or result for forage species [FWRI 2023, slide 31].

## Connections

- **Related to:** [[hurdle-brt-habitat-suitability]]. The zero-altered negative binomial model of Faletti et al. is a hurdle model fitted with generalised linear models; the boosted regression tree version suits the same presence and density structure when relationships are nonlinear.
- **Informs:** [[predator-prey-spatial-overlap]]. Pinfish density and seasonal timing set prey availability for the predators studied in telemetry work, such as seatrout and Red Drum, which Faletti et al. list as Pinfish predators [Faletti et al. 2019, p. 2].
- **Depends on:** [[fim-survey-design]]. Gear, strata, and haul filters determine what the density index means.
- **Informs:** [[juvenile-indices-and-stock-assessment]]. Seine indices for juveniles feed assessments, and Pinfish lacks a formal assessment [Faletti et al. 2019, p. 2].
- **Related to:** [[freshwater-inflow-and-nekton]]. Sinnickson et al. link Suwannee discharge to forage biomass, and FWRI lists Tampa Bay river inflow as a priority [FWRI 2023, slide 32].
- **Related to:** [[red-tide-effects-on-estuarine-fish]]. Faletti et al. attribute stability despite red tide, severe cold events, and seagrass die-offs to these populations [Faletti et al. 2019, p. 12], and FWRI shows a 2018 red tide response for a fish whose species the slide does not name [FWRI 2023, slide 22].
- **Related to:** [[snook-range-expansion]]. Common Snook colonised the Suwannee estuary and exerted strong top-down control in the model [Sinnickson et al. 2021, p. 1].
- **Related to:** [[reef-fish-survey-design]]. The research institute frames forage fish and reef fish abundance together [FWRI 2023, slide 30].

## Sources

- **Faletti ME, Chacin DH, Peake JA, MacDonald TC, Stallings CD.** 2019. Population dynamics of Pinfish in the eastern Gulf of Mexico (1998–2016). *PLoS ONE* 14(8): e0221131. DOI: 10.1371/journal.pone.0221131.
  Extraction: [Faletti_2019_PinfishDynamics.md](../raw/Faletti_2019_PinfishDynamics.md)
- **Sinnickson D, Chagaris D, Allen M.** 2021. Exploring impacts of river discharge on forage fish and predators using Ecopath with Ecosim. *Frontiers in Marine Science* 8: 689950. DOI: 10.3389/fmars.2021.689950.
  Extraction: [Sinnickson_2021_RiverDischargeEwE.md](../raw/Sinnickson_2021_RiverDischargeEwE.md)
- **Florida Fish and Wildlife Conservation Commission, Fish and Wildlife Research Institute.** 2023. Florida's Marine Fisheries-Independent Monitoring (FIM) Program. Presentation, 43 slides, Florida Forage Fish Research Program Data Workshop, May 24, 2023. No DOI or report number; no named author.
  Extraction: [FWRI_2023_FIMForageWorkshop.md](../raw/FWRI_2023_FIMForageWorkshop.md)
