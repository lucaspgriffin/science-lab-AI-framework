---
title: "Juvenile indices and stock assessment"
slug: "juvenile-indices-and-stock-assessment"
domain: "Methods: detection and survey"
aliases: ["young-of-the-year index", "sub-adult index", "FIM index of abundance", "year-class strength index"]
related: [fim-survey-design, freshwater-inflow-and-nekton, red-tide-effects-on-estuarine-fish, snook-range-expansion, forage-fish-dynamics, reef-fish-survey-design]
sources:
  - raw/Nehemiah_2022_SeatroutYearClass.md
  - raw/Addis_2020_RedDrumAssessment.md
  - raw/FWRI_2023_FIMForageWorkshop.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Juvenile indices

## Summary

The Fisheries-Independent Monitoring (FIM) program of the Florida Fish and Wildlife Research Institute turns seine catches of small fish into annual indices of abundance, and those indices serve stock assessment in two ways. In the 2020 red drum assessment, young-of-the-year and sub-adult indices are fitted as surveys inside a Stock Synthesis model for four Florida regions [Addis 2020, p. 21]. In the spotted seatrout study at Cedar Key, a young-of-the-year index is the response variable in a regression that asks which environmental factors and how much adult stock explain year-class strength [Nehemiah et al. 2022, p. 4].

Both studies build the index with a delta method: one model for occurrence, one for positive catch, and a final index equal to their product [Addis 2020, p. 17; Nehemiah et al. 2022, p. 4]. They differ in the size cutoff (40 mm standard length for red drum, 100 mm for spotted seatrout), the error distribution of the positive-catch model (gamma with a log link for red drum, log-normal for spotted seatrout), the spatial unit (a region pooling several estuaries versus one estuary split into zones), and the way uncertainty is reported. The FIM workshop slides place these indices among the program's stated inputs to state and federal assessments: abundance indices, size and age composition used for selectivity, reproduction, and stock identification [FWRI 2023, slide 21].

## Key points

### Index definitions

Both indices rest on the 21.3-m center-bag seine for young fish and the 183-m haul seine for larger fish, gears the program has fielded since 1989 and 1996 respectively [FWRI 2023, slide 7].

| Feature | Red drum, regional [Addis 2020] | Spotted seatrout, Cedar Key [Nehemiah et al. 2022] |
|---|---|---|
| Young-of-the-year gear | 21.3-m center-bag seine [p. 18] | 21.3-m center-bag seine [p. 3-4] |
| Young-of-the-year size cutoff | 40 mm SL (wording differs between sections, see below) [p. 18] | less than 100 mm SL [p. 3-4] |
| Season | September to March [p. 18] | Not stated for the index; monthly sampling since 1996 [p. 3] |
| Spatial unit | Region pooling several estuaries [p. 18] | Cedar Key zones B and C; zone F excluded [p. 4] |
| Older-fish gear and cutoff | 183-m haul seine, 300 mm SL and larger, year-round [p. 18] | 183-m seine, greater than 250 mm SL, 1997 to 2018 [p. 4] |
| Positive-catch model | Gamma, log link [p. 18] | Log-normal on log-transformed counts [p. 4] |
| Occurrence model | Binomial, 1 or 0 [p. 18] | Binomial, 1 or 0 [p. 4] |
| Uncertainty | Index SE (log) tabulated; method not stated [p. 50-53] | Monte Carlo, 10,000 iterations [p. 4] |

### Red drum young-of-the-year

Addis (2020) defines the age-0 index from 21.3-m center-bag seines: "Annual region-specific young-of-the-year (red drum smaller than or equal to 40 mm standard length during a 'recruitment window') indices were based on collections of Red Drum made using 21.3-m center-bag seines" [Addis 2020, p. 18]. Sets come from "the peak recruitment season of September-March" [Addis 2020, p. 18]. Section 3.2 gives the year rule: "Young-of-the-year were defined as Red Drum captured during the period September through March that were smaller than 40 mm SL, those caught after September were assigned to following year" [Addis 2020, p. 18]. The report words the cutoff as "smaller than or equal to 40 mm" in Section 3.1 and "smaller than 40 mm" in Section 3.2 [Addis 2020, p. 18].

In each sampled set, up to 20 fish within a size class were measured for standard length and all were counted. When more than 20 red drum were taken, the length frequencies of the measured 20 were expanded to the total catch [Addis 2020, p. 18].

### Red drum sub-adults

The sub-adult index uses year-round 183-m haul seine catches of fish 300 mm SL and larger, with fish under 30 cm SL excluded before the index is built [Addis 2020, p. 18]. In the haul seine survey all captured red drum are measured, and when five or fewer are caught they are taken to the laboratory for a full biological workup that includes age determination [Addis 2020, p. 18]. The full haul seine catch spans small fish, most between 6 cm and 80 cm total length in the northeast region and between 6 cm and 118 cm in the southeast region; the index uses only the 30 cm and larger fraction [Addis 2020, p. 18].

### Regional pooling

Estuaries are combined into assessment regions. The northwest region uses Apalachicola Bay and Cedar Key, the southwest region Tampa Bay and Charlotte Harbor, the northeast region the St. Johns River and coastal tributaries, and the southeast region the northern and southern Indian River Lagoon [Addis 2020, p. 18]. Index series start in different years by region. Young-of-the-year series begin in 1991 (southwest), 1998 (northwest and southeast), and 2002 (northeast), and sub-adult series in 1996 (southwest), 1997 (northwest and southeast), and 2001 (northeast) [Addis 2020, p. 50-53].

### Seatrout index

Nehemiah et al. (2022) built young-of-the-year indices "for Cedar Key using FIM catch data from 21.3-m center-bag seine nets in sampling zones B and C" for fish under 100 mm SL [Nehemiah et al. 2022, p. 3-4]. Zone B lies closest to the Suwannee River, zone C near the town of Cedar Key, and zone F inside the river; zone F was dropped "due to low sampling size and limited gear types used in this zone" [Nehemiah et al. 2022, p. 3-4]. The indices are standardised yearly mean catch per unit effort, built with the delta method of Lo et al. (1992) as applied by Addis et al. (2018) [Nehemiah et al. 2022, p. 4]. One combined model gives an all-zone index, and the same model gives separate indices for zones B and C [Nehemiah et al. 2022, p. 4].

### Index trends

For red drum, the young-of-the-year indices "were variable with no significant trend in the four assessment regions" and the strongest recent year-classes occurred in 2013 in the northeast, 2005 in the southeast, 2014 in the southwest, and 2018 to 2019 in the northwest [Addis 2020, p. 19]. The Executive Summary lists different recent peaks (southeast 2017, southwest 2014 to 2018), an inconsistency inside the report; Table 9 gives the southeast scaled index as 3.22 in 2005 and 1.84 in 2017 [Addis 2020, p. 2, 51]. Sub-adult indices were variable without trend in the northwest and southwest, declined in the northeast with a low in 2017, and in the southeast were stable from 1997 to 2013 before declining through 2019 [Addis 2020, p. 19].

For spotted seatrout at Cedar Key, "recruitment declined from 1998 to 2013, with the weakest year-class observed in 2013"; 1997 and 1998 were strong years, 2013 to 2016 increased, and 2017 and 2018 were average [Nehemiah et al. 2022, p. 5]. The zones differed. Zone B declined from 1997 to 2013 and had weak year-classes in 2017 and 2018, whereas zone C was fairly stable with poor year-classes in 2011 and 2013 and an increase from 2013 to 2018 [Nehemiah et al. 2022, p. 5].

### Entry into the assessment

The red drum Stock Synthesis models (version 3.3) ran from 1989 to 2019 with ages 0 to 40 and older, "one sex, one season, one growth pattern, two fleets (commercial and recreational), and three surveys (MRIP, FIM YOY, and FIM sub-adult indices)" [Addis 2020, p. 21]. Each region has two areas, inshore and offshore, with unidirectional movement by age; "estimated movement parameters allow proportions of individuals at age to escape the fishery into Area 2 starting at age 3" [Addis 2020, p. 21]. The fisheries-independent indices were included for juveniles and sub-adults in all four regions [Addis 2020, p. 21].

Selectivity is where the two index types differ inside the model. "FIM YOY selectivity was specified as fully selected for age 0, and FIM haul seine selectivity was specified as double logistic (dome shaped selectivity)" [Addis 2020, p. 23]. The recreational fleet used a simple logistic, flat-topped curve [Addis 2020, p. 23]. All selectivities were length-based [Addis 2020, p. 25].

### Composition weighting

Length and age compositions began with effective sample sizes equal to the square root of the number of samples with at least one measured or aged red drum in a length bin, and were then reweighted by the Francis (2011) procedure [Addis 2020, p. 23]. For the FIM sub-adult length compositions the final Francis weights were 2.879238 (northwest), 1.769768 (southwest), and 1.954348 (northeast); for conditional age at length they were 0.000007, 0.019079, and 0.083514 [Addis 2020, p. 54]. The southeast model used no Francis weights because "log likelihood increased with iterations, thus fits were not improved" [Addis 2020, p. 23]. In all regions, some conditional length-at-age datasets did not stabilise and "continued to decrease to zero if enough iterations (8-15+) were performed" [Addis 2020, p. 23].

### Fit to indices

Model fits to the juvenile indices were uneven. In the southwest and northeast, the predicted young-of-the-year index "remained quite flat and missed" many of the highest and lowest observed years [Addis 2020, p. 26, 28]. In the southeast, the model "under-predicted the observed high years of 2005 and 2017 and over-predicted the low years of 2001 and 2012-2013" [Addis 2020, p. 30]. For the northeast sub-adult index the observed series declined while the predicted series was "flat or slightly increasing" [Addis 2020, p. 28]. The southeast sub-adult index was fitted well, with predictions inside the observed confidence range in all years [Addis 2020, p. 30]. Predicted age-0 recruits in the northeast peaked at 5.5 million in 2013, the same year as the strongest observed young-of-the-year index there [Addis 2020, p. 19, 28].

### Escapement status

Escapement is the exponent of the negative sum of age-specific fishing mortality, E<sub>t</sub> = exp(−ΣF<sub>t</sub>), summed over ages 0–4 [Addis 2020, p. 23]. Management targets are 35 percent spawning potential ratio (SPR) and 40 percent escapement [Addis 2020, p. 34]. Current escapement (2017 to 2019) was 48 percent in the northwest, 72 percent in the southwest, 61 percent in the northeast, and 35 percent in the southeast; the southeast reached 55 percent in the terminal year 2019 but not on the three-year mean [Addis 2020, p. 3, 34]. Current SPR was 37, 66, 53, and 26 percent in the same regions [Addis 2020, p. 34]. The report concludes that red drum are "neither overfished nor undergoing overfishing in Florida", with spawning stock biomass ratios of 2.11, 1.60, 2.20, and 2.70 and fishing mortality ratios of 0.71, 0.21, 0.48, and 0.83 (northwest, southwest, northeast, southeast) [Addis 2020, p. 34].

### Index to year-class strength

Nehemiah et al. (2022) used the juvenile index outside an assessment model. Annual anomalies, each year's mean CPUE minus the 1996 to 2018 mean, formed the response in a multiple linear regression with forward stepwise selection [Nehemiah et al. 2022, p. 4]. The candidate predictors were adult abundance, mean water temperature from March to October (the spawning window), mean salinity from June to November (months of peak juvenile abundance), annual Suwannee River discharge, and a discharge by salinity interaction [Nehemiah et al. 2022, p. 4].

The final model "explained nearly 70% of the observed variation of annual recruitment in Cedar Key (adjusted R2 = 0.699)" and retained adult abundance (coefficient 0.835) and spawning-season temperature (0.196), both positive [Nehemiah et al. 2022, p. 5-6]. Salinity and discharge were not significant, and the highest predictor correlation was between discharge and salinity (r = -0.565) [Nehemiah et al. 2022, p. 5-6]. Univariate plots showed temperature was positively related to recruitment in the combined index and zone B but less so in zone C [Nehemiah et al. 2022, p. 6]. The paper states that it "is unable to determine which life stage of recruitment is being affected (i.e., spawning behavior, egg success, or juvenile survival)" [Nehemiah et al. 2022, p. 9].

## Methods and approaches

### Delta index recipe

1. Subset the data. Red drum indices were subset "to remove any months, zones, or strata that rarely encountered Red Drum" before standardisation [Addis 2020, p. 18]. Seatrout zone F was excluded for sparse sampling [Nehemiah et al. 2022, p. 4].
2. Model presence or absence with a binomial model of the target size class in each set, including zero-catch sets [Addis 2020, p. 18; Nehemiah et al. 2022, p. 4].
3. Model sets that caught the target size class with a positive-catch model: a gamma model with log link on the total catch for red drum [Addis 2020, p. 18], or a log-normal model on log-transformed counts for seatrout [Nehemiah et al. 2022, p. 4].
4. Choose covariates. Red drum candidates were year, month, bottom vegetation, bottom type, shore type, bay zone, temperature, and salinity [Addis 2020, p. 18-19]. Seatrout candidates were the same set with shoreline vegetation named explicitly, selected by forward stepwise regression [Nehemiah et al. 2022, p. 4]. The red drum report states a forward-selection rule (start from a year-only null model, add terms until the Bayes information criterion stops improving) only for the recreational index, and does not say that the rule was applied to the FIM indices [Addis 2020, p. 17].
5. Multiply the annual least-squares means of the two models to obtain the index [Nehemiah et al. 2022, p. 4].
6. Propagate variance. Nehemiah et al. (2022) ran a Monte Carlo simulation of 10,000 iterations from the annual least-squares means [Nehemiah et al. 2022, p. 4]. Addis (2020) tabulates "Index SE (log)" for each year but does not say how it was obtained for the FIM indices [Addis 2020, p. 50-53].
7. Express the series as a scaled index (red drum, scaled to the mean) or as anomalies about the series mean (seatrout) [Addis 2020, p. 50; Nehemiah et al. 2022, p. 4].

Terms retained in the seatrout combined models were year, zone, bottom vegetation, and a year by zone interaction in the positive-catch model, and year, zone, month, bottom vegetation, shore type, bottom type, and a zone by year interaction in the binomial model [Nehemiah et al. 2022, p. 5]. Neither paper names the software used for the index models; the seatrout paper states no software or packages at all.

### Reading index precision

Thin strata produce unstable annual values. In the northeast red drum series the 2019 young-of-the-year row reads 336 sets, 3 positive, a scaled index of 0.15, and a log standard error of 1.50, whereas 2013 reads 336 sets, 46 positive, an index of 3.81, and a standard error of 0.23 [Addis 2020, p. 51]. A reader reusing these indices should inspect the positive-set counts, not only the index.

### Seatrout covariate construction

Salinity was averaged from surface, bottom, and 1-m interval readings at 21.3-m seine sites, and only at sites where juvenile seatrout were caught [Nehemiah et al. 2022, p. 4]. Peak months were defined as "the months that FIM caught the most juvenile Spotted Seatrout annually", which was June to November throughout the series [Nehemiah et al. 2022, p. 4]. Temperature came from all 21.3-m seine sites, averaged March to October, a window chosen because seatrout spawning in Florida may last from March to October [Nehemiah et al. 2022, p. 4]. Discharge was the annual value at the Suwannee River gauge at Wilcox [Nehemiah et al. 2022, p. 4]. Juvenile anomalies began in 1996 and environmental and adult series in 1997, so the regression covers 1997 to 2018 at most; the paper does not state the number of years used [Nehemiah et al. 2022, p. 3-4].

The adult index for the stock term used 183-m seine catches of seatrout greater than 250 mm SL from the combined Cedar Key region, 1997 to 2018 [Nehemiah et al. 2022, p. 4].

### Assessment diagnostics

Addis (2020) tested convergence by jittering starting values by a random normal deviate times 20 percent of the parameter range, repeated 100 times; ran retrospective analyses removing seven successive years; and produced 500 bootstrapped datasets [Addis 2020, p. 23-24]. Retrospective Mohn's rho for recruitment was acceptable in the northwest (-0.13) and southwest (0.20), outside the acceptable range in the northeast (-0.45), and outside it for spawning biomass, fishing mortality, and recruitment in the southeast (-0.17, 0.33, and -0.24) [Addis 2020, p. 26, 28-29, 31]. The report recommends that "management reference points such as escapement rates or static SPR should continue to be more reliable indicators of stock status" than biomass estimates [Addis 2020, p. 34].

### Method comparison

The two index builds share a skeleton and diverge in four places that affect how each index can be used.

- Size cutoff. The red drum cutoff of 40 mm SL feeds a survey specified as fully selected at age 0 [Addis 2020, p. 18, 23]. The seatrout cutoff of 100 mm SL carries an explicit assumption that "major mortality events occur before fish reach 100 mm", which the authors say may not hold for this population [Nehemiah et al. 2022, p. 9].
- Spatial unit. Red drum indices are regional and combine estuaries with different sampling histories [Addis 2020, p. 18]; the seatrout index is a single estuary with a zone term, and zone-specific indices disagree about trend [Nehemiah et al. 2022, p. 5].
- Error structure. The red drum positive model is gamma on total catch; the seatrout positive model is log-normal on log counts [Addis 2020, p. 18; Nehemiah et al. 2022, p. 4]. Neither paper compares the choices.
- Use of the index. Red drum assessment treats the index as relative abundance with estimated catchability and selectivity, and the model's own recruitment series can then diverge from it. The seatrout study treats the index as a direct measure of year-class strength, an assumption the authors state: the study "assumes that the IOAs generated from FIM sampling data are an appropriate measurement of year-class strength for this species" [Nehemiah et al. 2022, p. 9].

The FIM workshop slides show a comparable use for another gear. An offshore camera index plots a nominal index, a standardised index, and confidence intervals, with the standardised index peaking at about 2.1 individuals per camera in 2016 (value read from the plot, approximate) [FWRI 2023, slide 21].

## Open questions

- Variance for the red drum FIM indices. The report tabulates log standard errors but does not state their source, so it is unclear whether the assessment weights the indices by delta-method variance, Monte Carlo variance, or another estimate [Addis 2020, p. 50-53].
- Year assignment. The red drum rule reads "those caught after September were assigned to following year", and the report does not define it further [Addis 2020, p. 18]. The seatrout paper does not state a month window or year rule for the index [Nehemiah et al. 2022, p. 3-4].
- Size cutoff consistency. Red drum is "smaller than or equal to 40 mm" in one section and "smaller than 40 mm" in another [Addis 2020, p. 18].
- Poor fits to juvenile indices. Flat predicted young-of-the-year series in the southwest and northeast, and a mismatch in the northeast sub-adult trend, leave open whether the indices track year-class strength or whether the model structure cannot express annual variation [Addis 2020, p. 26-28].
- Environmental drivers in assessments. Addis (2020) lists "investigations of environmental covariates related to recruitment" among standing recommendations and notes that the assessment has no reliable quantitative data on red tide effects [Addis 2020, p. 36, 129]. Nehemiah et al. (2022) state that current seatrout assessments "rely solely on adult and juvenile abundance indices with no incorporation of density-independent drivers of recruitment" [Nehemiah et al. 2022, p. 8].
- Model selection in the seatrout regression. Table 1 reports AIC of -31.2 for the upper model and -26.1 for the final model, and adjusted R-squared of 0.656 and 0.699. The Methods say the best model was selected by AIC, and the paper does not explain why the final model was kept [Nehemiah et al. 2022, p. 4, 6].
- Temperature window. The Figure 4 caption gives the spawning window as March to November, while the Methods and Table 1 give March to October [Nehemiah et al. 2022, p. 4, 8].
- Mechanism. The seatrout study cannot separate effects on spawning behaviour, egg success, and juvenile survival, and names snook predation, seagrass availability, and high-temperature spawning limits as untested alternatives [Nehemiah et al. 2022, p. 7-9].
- Older fish. Because surveys and the fishery target juveniles and sub-adults, red drum assessment models "are largely uninformed on older spawning adults" [Addis 2020, p. 36].

## Connections

- **Draws on:** [[fim-survey-design]]. The strata, grids, and gears that produce the seine catches are the input to every index described here; a change in gear or zones changes what the index measures.
- **Related to:** [[freshwater-inflow-and-nekton]]. The seatrout regression tests river discharge and salinity as drivers of year-class strength and finds neither significant, a result to read against inflow studies at Cedar Key.
- **Related to:** [[red-tide-effects-on-estuarine-fish]]. Addis (2020) states that the assessment has no reliable data to incorporate red tide mortality, so index-based detection of episodic events is currently outside the model.
- **Related to:** [[snook-range-expansion]]. Nehemiah et al. (2022) raise snook predation on juvenile seatrout as a possible effect of warming, a possible route from warming to juvenile mortality that the study did not test.
- **Related to:** [[forage-fish-dynamics]]. The workshop slides list abundance indices among FIM inputs to assessments and pair them with trophic data on forage species [FWRI 2023, slides 21, 38].
- **Related to:** [[reef-fish-survey-design]]. The workshop slide that shows a nominal and standardised index for an offshore camera survey places video-based indices alongside the seine indices [FWRI 2023, slide 21].
- **Pattern:** index-to-year-class translation. A juvenile index used as a response variable (seatrout) and the same kind of index fitted as a survey (red drum) answer different questions, and the two uses carry different assumptions.

## Sources

- **Addis, D. 2020.** The 2020 stock assessment of Red Drum, *Sciaenops ocellatus*, in Florida. Florida Fish and Wildlife Conservation Commission, Florida Fish and Wildlife Research Institute, St. Petersburg, FL. In-House Report IHR 2020-002. 129 pp. DOI: none (report number IHR 2020-002). Extraction: [Addis_2020_RedDrumAssessment.md](../raw/Addis_2020_RedDrumAssessment.md)
- **Nehemiah, S., Chagaris, D., Lowerre-Barbieri, S., and Allen, M. 2022.** Environmental factors and stock abundance influence year-class strength of Spotted Seatrout at Cedar Key, Florida. *Marine and Coastal Fisheries: Dynamics, Management, and Ecosystem Science* 14: e10201. DOI: 10.1002/mcf2.10201. Extraction: [Nehemiah_2022_SeatroutYearClass.md](../raw/Nehemiah_2022_SeatroutYearClass.md)
- **Florida Fish and Wildlife Conservation Commission, Fish and Wildlife Research Institute. 2023.** Florida's Marine Fisheries-Independent Monitoring (FIM) Program. Presentation, 43 slides, Florida Forage Fish Research Program Data Workshop, 24 May 2023. DOI: none (workshop slides, no named author). Used for stock assessment inputs only. Extraction: [FWRI_2023_FIMForageWorkshop.md](../raw/FWRI_2023_FIMForageWorkshop.md)
