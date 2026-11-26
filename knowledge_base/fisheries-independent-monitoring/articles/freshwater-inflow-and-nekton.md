---
title: "Freshwater inflow and nekton"
slug: "freshwater-inflow-and-nekton"
domain: "Methods: detection and survey"
aliases: ["river discharge and estuarine fish", "freshwater inflow effects on juvenile fish", "discharge and salinity covariates in FIM analyses", "inflow and recruitment"]
related: [flats-habitat-management, cold-stunning-and-ocean-warming, fim-survey-design, juvenile-indices-and-stock-assessment, red-tide-effects-on-estuarine-fish, snook-range-expansion, forage-fish-dynamics, reef-fish-survey-design]
sources:
  - raw/Whaley_2023_SeatroutInflow.md
  - raw/Sinnickson_2021_RiverDischargeEwE.md
  - raw/Nehemiah_2022_SeatroutYearClass.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Freshwater inflow and nekton

## Summary

Data from the Florida Fish and Wildlife Conservation Commission Fisheries-Independent Monitoring program (FIM) have been used in three studies of whether river discharge and salinity shape estuarine fish on Florida's northern and Big Bend Gulf coast. Each used a different statistical approach and reached a different kind of answer. In Apalachicola Bay, mixed-effects logistic models of juvenile spotted seatrout (*Cynoscion nebulosus*) occurrence showed that inflow in the three months before and including peak recruitment was related to the occurrence of fish up to 100 mm standard length (SL), but not to the occurrence of larger juveniles [Whaley et al. 2023, p. 1]. In the Suwannee River estuary, an Ecopath with Ecosim food web model forced with discharge scenarios projected larger biomass losses under drought than gains under flood [Sinnickson et al. 2021, p. 1]. At Cedar Key, annual river discharge and June to November salinity were not significant predictors of a juvenile seatrout year-class anomaly, whereas adult abundance and spawning-season water temperature were [Nehemiah et al. 2022, p. 1].

The three results are not in conflict. They differ in response (occurrence in a sample, biomass of a functional group, annual index anomaly), in the time scale at which discharge was summarised (monthly categories over lags of 1 to 12 months, a monthly forcing series, an annual mean), and in what the design can separate. Occurrence models resolve the lag and size class at which inflow matters. Ecosystem models resolve consequences across species but depend on assumed mechanisms. Index regressions test a single annual summary against a short series.

## Key points

### Occurrence by size class

Whaley et al. (2023) modelled the probability of encountering juvenile spotted seatrout in four size classes (15–50, 51–100, 101–150, and 151–200 mm SL) in shallow water (less than 1.5 m depth) of Apalachicola Bay, using monthly FIM seine samples from 2001–2018 [Whaley et al. 2023, pp. 1, 3]. The Apalachicola River supplies most of the freshwater to the bay and drains a 50,500 km2 basin [Whaley et al. 2023, p. 3].

- **Seagrass.** Seagrass area within 400 m of the sample site was positively related to encounter probability in all four size classes, regardless of inflow conditions [Whaley et al. 2023, p. 17].
- **Smaller juveniles.** Encounter probability of the 15–50 mm and 51–100 mm classes was most closely related to inflow in the three months leading up to and including peak recruitment, compared with 1-month, 6-month, and 12-month windows [Whaley et al. 2023, p. 17]. The two classes shared the same best-model predictors across their two data sets, which the authors took as "strong evidence" for the models [Whaley et al. 2023, p. 17].
- **Larger juveniles.** The 101–150 mm and 151–200 mm classes were "generally unrelated to inflow conditions" and were instead tied to abundant seagrass and multiple nearby habitat types [Whaley et al. 2023, p. 17]. The best models for both classes contained no inflow variable, and in the 151–200 mm class none of the inflow parameter estimates in the confidence set were important because their 95% confidence intervals overlapped zero [Whaley et al. 2023, p. 13].
- **Wet conditions.** Under predominantly wet conditions small juveniles were encountered even more often in seagrass, particularly near 100% coverage, where seagrass dominance lowered habitat richness [Whaley et al. 2023, p. 19]. There was weak evidence that wet conditions reduced encounters far from an inlet, which the authors read as flushing of small fish toward the inlet [Whaley et al. 2023, pp. 18–19].
- **Salt marsh.** Marsh associations changed sign with flow in the 51–100 mm class: under wet conditions within 3 months of peak recruitment these fish were less likely to be encountered near marsh, and under dry conditions more likely [Whaley et al. 2023, p. 13]. The authors suggested flooded marsh made fish less susceptible to capture, because the seine fished the marsh edge only and could not sample the interior surface [Whaley et al. 2023, pp. 19–20].

Effect directions by size class and flow condition are in Table 3 of the paper. Coefficients, standard errors, and confidence limits are in supporting tables S1 to S4 and are not summarised here [Whaley et al. 2023, p. 10].

### Model support and validation

For each size class, the confidence set (cumulative Akaike weight of 0.95) held seven models for 15–50 mm, four for 51–100 mm, six for 101–150 mm, and eight for 151–200 mm, out of 17 candidates [Whaley et al. 2023, pp. 9, 13]. The top-ranked model for 15–50 mm and 51–100 mm carried 3-month inflow interacting with seascape-scale and estuary-scale terms (Akaike weights 0.69 and 0.45) [Whaley et al. 2023, p. 10]. The top-ranked model for 101–150 mm and 151–200 mm was the model with seascape and estuary terms and no inflow effect (weights 0.42 and 0.34) [Whaley et al. 2023, p. 10].

Predictive performance was summarised from 1,000 repeated 80:20 splits (Table 2). Mean testing and training values are given below [Whaley et al. 2023, p. 10].

| Size class (SL) | Testing AUC | Training AUC | Testing Brier | Training Brier |
|---|---|---|---|---|
| 15–50 mm | 0.76 | 0.81 | 0.13 | 0.12 |
| 51–100 mm | 0.73 (0.75 for one model) | 0.79 | 0.08 | 0.08 |
| 101–150 mm | 0.75 | 0.82 | 0.15 | 0.14 |
| 151–200 mm | 0.70 | 0.79 | 0.13 | 0.12 |

The authors described performance as "good to excellent for testing and training data sets, respectively" [Whaley et al. 2023, p. 9]. The size classes with a supported inflow effect did not have systematically better testing AUC than those without one, so the discrimination values do not by themselves separate the inflow signal from the habitat signal. The Brier scores are best compared within a size class, because the encounter prevalence for each class is not among the values recorded in the extraction.

### Ecosystem scenarios

Sinnickson et al. (2021) built the Suwannee River Estuary Model in Ecopath with Ecosim, with 59 functional groups, 37 of them fish, and age stanzas for snook, spotted seatrout, red drum (*Sciaenops ocellatus*), and mullet [Sinnickson et al. 2021, p. 4]. The estuary lies about 180 km north of Tampa Bay and is fed by a river that flows 396 km unobstructed to the Gulf [Sinnickson et al. 2021, pp. 2–3]. The authors described the model as one focused on bottom-up effects.

- **Short-term scenarios.** Dry scenarios (three consecutive dry years) produced the largest changes, averaging decreases of 17% in forage fish biomass and 14% in sportfish biomass, whereas the wet scenario raised them by only 9% and 7% [Sinnickson et al. 2021, p. 10]. The abstract summarised this as drought effects approximately twice as large as flood effects [Sinnickson et al. 2021, p. 1].
- **Groups most affected.** After three dry years, adult mullet (20%), pinfish (17%), and anchovies (16%) showed the greatest mean declines among forage fish [Sinnickson et al. 2021, p. 10]. The largest decrease of any sportfish run was 26% for sand seatrout, and the largest increase in a wet run was 15%, also for sand seatrout [Sinnickson et al. 2021, p. 10]. Jack crevalle and snappers (−8 to +5%) and mojarra and juvenile mullet (−10 to +4%) were the most resistant groups [Sinnickson et al. 2021, p. 10].
- **Variance.** Raising the variance of the random flow component by 30% decreased sportfish and forage fish biomass by 4% and 5%, against 0.65% and 0.83% under low variance [Sinnickson et al. 2021, p. 10]. The authors concluded that changes in both the mean and the variability of discharge can have strong ecological effects [Sinnickson et al. 2021, pp. 10–11].
- **Long-term scenarios.** Four climate scenarios were run for 50 years (2019–2068), and the mean of the last 20 years was taken because biomass reached equilibrium after about 30 years [Sinnickson et al. 2021, p. 8]. Changes were minimal, with decreases of 1 to 5% for forage fish and sportfish [Sinnickson et al. 2021, p. 11]. Mean discharge across the scenarios ranged from 8,067 to 9,454 cfs, and the largest decreases came under the scenario with a 13% drop in mean discharge (RCP 8, 2080s) [Sinnickson et al. 2021, pp. 8, 11].
- **Snook.** Snook had recently colonised the estuary, and the model showed strong top-down effects of snook on spotted seatrout, sand seatrout, and other sciaenids [Sinnickson et al. 2021, p. 1]. The long-term snook decreases are relative to a status quo run in which snook continued to increase, so they are not absolute declines [Sinnickson et al. 2021, p. 12].

### Year-class covariates

Nehemiah et al. (2022) tested whether discharge and salinity explained year-class strength of juvenile spotted seatrout at Cedar Key, alongside adult abundance and spawning-season temperature. The response was the annual anomaly of a juvenile index (seine-caught young-of-the-year less than 100 mm SL, zones B and C, 1996–2018) [Nehemiah et al. 2022, pp. 3–5].

- The final regression retained adult abundance (coefficient 0.835) and March to October water temperature (0.196) and had an adjusted R2 of 0.699 [Nehemiah et al. 2022, p. 6].
- Annual river discharge, June to November salinity, and their interaction were candidates in the upper model, where none was significant, and none entered the final model [Nehemiah et al. 2022, p. 6].
- Univariate plots showed a slight positive discharge relationship that was "highly variable", with above-average and below-average year-classes at similar discharge in all zones [Nehemiah et al. 2022, p. 6].
- The correlation between annual discharge and salinity was the largest among predictors (r = −0.565); all other Pearson coefficients were below 0.5 [Nehemiah et al. 2022, p. 5].
- The authors had hypothesised that years with high salinity and low discharge would give weak recruitment, and the data did not support that hypothesis [Nehemiah et al. 2022, p. 3].

Table 1 prints the upper model with a lower AIC (−31.2) than the final model (−26.1), although the Methods state that the best model was chosen by AIC, and the final model has the higher adjusted R2 (0.699 against 0.656) [Nehemiah et al. 2022, pp. 4, 6]. The paper does not explain this choice, so the table is reported as printed.

### Management use

Each paper draws a management implication from its result, and the strength of each follows from the approach.

- Whaley et al. (2023) wrote that inflow relationships "may also help develop water management strategies to potentially assist recovery of declining seatrout populations, particularly targeting freshwater inflow during the period prior to and including peak recruitment" [Whaley et al. 2023, p. 20]. They also stated that early life stages "appear to be the most vulnerable to reductions in inflow in Apalachicola Bay" [Whaley et al. 2023, p. 19].
- Sinnickson et al. (2021) wrote that the model "can be used to inform water management districts on the impact that anomalously low flow events can have on ecological productivity" and that managers may consider "a feedback policy that varies harvests during different flow regimes" [Sinnickson et al. 2021, p. 15]. They cautioned that model fitting uncertainty must be accounted for when interpreting group responses, and that jack crevalle and snappers should not be assumed to be well predicted [Sinnickson et al. 2021, p. 14].
- Nehemiah et al. (2022) did not recommend inflow management. They recommended adding water temperature to adult abundance when evaluating recruitment trends [Nehemiah et al. 2022, pp. 8–9].

### Comparison

| Feature | Whaley et al. 2023 | Sinnickson et al. 2021 | Nehemiah et al. 2022 |
|---|---|---|---|
| Estuary | Apalachicola Bay | Suwannee River estuary | Cedar Key |
| Response | Presence or absence by size class | Biomass of functional groups | Annual anomaly of juvenile index |
| Discharge metric | Proportion of wet, normal, and dry months over 1, 3, 6, and 12 months | Monthly forcing series and scenarios | Annual mean |
| Inflow effect | Present for classes up to 100 mm SL, absent above | Larger loss in drought than gain in flood | Not significant |
| Inference type | Statistical association | Simulation conditional on model structure | Statistical association |

The Cedar Key and Suwannee studies share an estuary and a river but not a conclusion. Nehemiah et al. found no annual discharge signal in the juvenile index, while the ecosystem model of Sinnickson et al. depended on discharge only through a nutrient pathway and responded weakly in long-term runs. The weak response in both studies, set against the 3-month effect in Apalachicola Bay, is consistent with inflow acting over a short pre-recruitment window that an annual mean would dilute. That reading is an interpretation: no study fitted the same lag structure to the same estuary.

## Methods and approaches

### Occurrence models

Whaley et al. (2023) used the following design, which a lab member can reuse for any FIM seine data set with a gauge record.

- **Data filter.** Samples were kept only within the peak recruitment window set from monthly length-frequency histograms: June to November for the two small classes (3,094 unique samples) and August to December for the two large classes (1,782 unique samples) [Whaley et al. 2023, p. 5]. Catch was converted to presence or absence by size class.
- **Gears.** The small classes came from the 21.3-m center-bag seine (3.2-mm stretched mesh) and the large classes from the 183-m haul seine (38-mm stretched mesh), so the two pairs of classes differ in gear, season, and sample set [Whaley et al. 2023, pp. 4–5].
- **Inflow metric.** Monthly flow at USGS gauge 02359170 (Apalachicola River near Sumatra) was classed against a 30-year reference period (1961–1990) as above normal (at or above the upper quartile), normal, or below normal (at or below the lower quartile) [Whaley et al. 2023, p. 6]. For lags of 1, 3, 6, and 12 months before and including the sampling month, the proportion of wet and dry months entered the model, with normal flow as the baseline. The 1-month variable was a binary wet or dry indicator and was not standardised; the longer lags were standardised to mean zero and unit SD [Whaley et al. 2023, p. 6].
- **Seascape terms.** Within a 400 m radius of each 10 m grid cell: area of salt marsh, oyster beds, and seagrass, habitat richness (the sum of three presence indicators), and mean depth. Distance to the nearest major inlet was computed over water with a cost-distance function [Whaley et al. 2023, p. 5].
- **Model set.** Seventeen candidate logistic models per size class: twelve combining one inflow lag with interactions with seascape terms, estuary terms, or both; four with an inflow main effect only; and one with no inflow term. All models carried every seascape and estuary predictor, a Month × Year random intercept, depth, and latitude or longitude (whichever had the lower AICc) [Whaley et al. 2023, pp. 6–8]. Predictors with a Pearson correlation above |0.5| were not placed in the same model [Whaley et al. 2023, p. 6].
- **Selection and importance.** Confidence sets were defined by cumulative Akaike weight of 0.95, and a parameter was important if its confidence interval excluded zero [Whaley et al. 2023, p. 8].
- **Diagnostics and validation.** Simulation-based residual checks (DHARMa), variance inflation factors, Moran's I, and Durbin-Watson tests showed no lack of fit. Validation used 1,000 random 80:20 training and testing splits per model, summarised by AUC and Brier score [Whaley et al. 2023, p. 8].
- **Prediction.** Model-averaged maps used Akaike weights rescaled within each confidence set, clipped to depths of about 1.8 m or less, under the wettest, normal, and driest observed inflows [Whaley et al. 2023, p. 8]. Analyses were run in R 4.0.3 with glmmTMB, ROCR, rms, AICcmodavg, raster, and biomod2 [Whaley et al. 2023, p. 9].

The paper contains four inconsistencies that bear on the numbers above. Table 2 labels the largest class "150–200mm" where the text and other tables say 151–200 mm [Whaley et al. 2023, p. 10]. The Results text says 101–150 mm seatrout were less likely to be found near oyster reefs, whereas Table 3 prints no clear effect for that cell [Whaley et al. 2023, pp. 10, 13]. The caption of Figure 6 (from the published correction) gives a 6-month lag for the larger classes, while the text lists support for 1, 3, 6, and 12-month windows [Whaley et al. 2024, p. 6]. The Table 1 caption refers to seine and trawl surveys, although only seines are described [Whaley et al. 2023, p. 7]. The inflow baseline is printed as "% normal = 1 − % wet + % dry", which is presumably a typographical slip for 1 − (% wet + % dry) [Whaley et al. 2023, p. 6].

### Ecosystem models

Sinnickson et al. (2021) drew on FIM data at three steps.

- **Group selection.** Of about 300 species collected, those in more than 1% of hauls in all gear types or at least 5% of hauls in one gear type were retained, giving 85 species grouped by hierarchical clustering on diet, habitat, and taxonomy [Sinnickson et al. 2021, p. 4].
- **Base biomass.** Numerical densities from 1997 samples were converted to biomass density with length composition and length-weight relationships, then averaged across the three gears (small seine, large seine, and otter trawl). Catchability began at 0.50 and was tuned during mass balancing [Sinnickson et al. 2021, p. 6]. Adult snook biomass came from 2007, the first year the species was consistently seen [Sinnickson et al. 2021, p. 6].
- **Fitting series.** Annual indices from delta generalised linear models (lognormal positive catch and binomial occurrence, with habitat, gear, salinity, temperature, dissolved oxygen, month, year, and location as predictors, selected by AIC) were used as reference series. Each series was weighted by the reciprocal of its mean annual coefficient of variation [Sinnickson et al. 2021, p. 6]. Snook was upweighted by about three orders of magnitude in the first three of seven vulnerability searches [Sinnickson et al. 2021, p. 7].

Sixteen configurations crossed forcing function (discharge or nutrients), a primary production anomaly, and prey switching (0, 0.5, 1.0, 1.5). Sums of squares ranged from 1635 for Run 3 to 794 for Run 15, which became the base run [Sinnickson et al. 2021, pp. 7, 9]. Nutrient forcing consistently fitted better than discharge forcing, and discharge forcing under-predicted fish biomass [Sinnickson et al. 2021, p. 9]. Nutrients were converted from discharge as total nutrients = 159.96 × ln(discharge) − 694.14, a relationship with R2 = 0.323 [Sinnickson et al. 2021, p. 8]. This weak link means the scenario responses pass through a loosely constrained step.

Scenario flows were built by multiplicative decomposition of the monthly record, ARIMA models for the trend and random components, and 30 simulated series per flow type. Wet and dry years were those more than one SD from the mean annual discharge [Sinnickson et al. 2021, pp. 7–8]. Small mismatches between text and tables exist: pinfish biomass is 0.92 g/m2 in the text and 0.91 in Table 1, and ecotrophic efficiencies are given to three decimals in the text and two in the table [Sinnickson et al. 2021, pp. 5, 9]. The authors also noted that the weak flood response may follow from the Michaelis-Menten nutrient uptake in Ecopath with Ecosim [Sinnickson et al. 2021, p. 13].

### Year-class regression

Nehemiah et al. (2022) built the index with the delta method: a binomial occurrence model plus a lognormal positive-catch model, with year, month, bottom vegetation, shoreline vegetation, bottom type, temperature, salinity, and zone as candidates, chosen by forward stepwise regression. Uncertainty came from 10,000 Monte Carlo iterations [Nehemiah et al. 2022, p. 4]. Zone F, inside the river, was excluded for low sample size and limited gears [Nehemiah et al. 2022, p. 4]. Anomalies were the difference between each yearly index and the 1996–2018 mean. Covariate windows were March to October for temperature, June to November (months of peak juvenile abundance) for salinity, and annual for discharge from the USGS gauge at Wilcox [Nehemiah et al. 2022, p. 4]. Salinity was averaged over surface, bottom, and 1-m depth intervals, using only sites where juvenile seatrout were caught [Nehemiah et al. 2022, p. 4]. That site filter conditions salinity on fish presence and may reduce its power to detect a salinity effect on occurrence.

This paper has two inconsistencies. The caption of Figure 4 gives the spawning window as March to November, while the Methods and Table 1 give March to October [Nehemiah et al. 2022, pp. 4, 8]. The Figure 2 caption defines boxes by the "2.5th to 7.5th percentile" whereas Figure 5 gives the 25th to 75th, so the former is likely a slip [Nehemiah et al. 2022, pp. 5, 9]. The paper does not state the number of years in the regression, the number of seine sets, or the software used.

## Open questions

- Whether a short pre-recruitment inflow window explains the absence of an annual discharge effect at Cedar Key has not been tested. Fitting the Apalachicola lag structure (1, 3, 6, and 12 months) to the Cedar Key index would settle it.
- The Apalachicola size-class contrast mixes gear, season, and sample set, so a true ontogenetic shift in inflow dependence cannot be fully separated from gear selectivity. The authors noted that marsh-edge seining could not sample the marsh interior [Whaley et al. 2023, p. 20].
- Which life stage is affected remains unresolved. Nehemiah et al. state that their results "are unable to determine which life stage of recruitment is being affected (i.e., spawning behavior, egg success, or juvenile survival)" [Nehemiah et al. 2022, p. 9]. Whaley et al. propose transport of eggs and larvae, planktonic food, and turbidity-mediated predation as mechanisms but report that the relative importance of mechanisms remains unclear [Whaley et al. 2023, pp. 1, 19].
- The nutrient link in the Suwannee model is weak (R2 = 0.323), and the discharge-forced fits were worse than the nutrient-forced fits. Direct estimation of salinity responses by group would test the authors' suggestion that earlier studies differed because fish were allowed to respond to salinity [Sinnickson et al. 2021, p. 13].
- Snook confound the Suwannee scenarios. The model did not predict the inclusion of any new species [Sinnickson et al. 2021, p. 14], and Nehemiah et al. raise snook predation as a possible link between warmer water and juvenile seatrout survival [Nehemiah et al. 2022, p. 8].
- Habitat layers in Apalachicola Bay vary in date (seagrass from October 2010 imagery, oyster maps compiled from 1970 to 2018), and live oyster cover has declined [Whaley et al. 2023, p. 5]. Whether dated layers mask inflow-by-habitat interactions is unknown.

## Connections

- **Related to:** [[flats-habitat-management]]. The seagrass result in Apalachicola Bay, a positive association across all four size classes and strongest under wet conditions, is habitat evidence that bears on nursery management for a recreational species.
- **Related to:** [[cold-stunning-and-ocean-warming]]. Nehemiah et al. found spawning-season temperature positively related to year-class strength, and cite documented cold events at or below 9 °C in the study region. Temperature responses and inflow responses need to be separated in any FIM covariate analysis.
- **Depends on:** [[fim-survey-design]]. The gear, stratification, and zone definitions determine what size class and habitat each occurrence or index response represents.
- **Informs:** [[juvenile-indices-and-stock-assessment]]. Nehemiah et al. state that current spotted seatrout assessments rely on adult and juvenile indices with "no incorporation of density-independent drivers of recruitment" [Nehemiah et al. 2022, p. 8], so covariate results feed the case for environmental terms.
- **Related to:** [[snook-range-expansion]] and [[forage-fish-dynamics]]. The Suwannee model links snook colonisation to predation on sciaenids and to forage fish responses, which separates discharge effects from top-down effects.
- **Related to:** [[red-tide-effects-on-estuarine-fish]]. Any inflow covariate in a FIM analysis can be confounded with other disturbances that vary by year.

## Sources

- **Whaley et al. 2023.** Whaley SD, Shea CP, Santi EC, Gandy DA (2023) The influence of freshwater inflow and seascape context on occurrence of juvenile spotted seatrout *Cynoscion nebulosus* across a temperate estuary. *PLoS ONE* 18(11): e0294178. DOI: 10.1371/journal.pone.0294178. Figure captions are from the correction: Whaley et al. (2024) *PLoS ONE* 19(2): e0299241 (cited here as Whaley et al. 2024). Extraction: [Whaley_2023_SeatroutInflow.md](../raw/Whaley_2023_SeatroutInflow.md)
- **Sinnickson et al. 2021.** Sinnickson D, Chagaris D, Allen M (2021) Exploring impacts of river discharge on forage fish and predators using Ecopath with Ecosim. *Frontiers in Marine Science* 8: 689950. DOI: 10.3389/fmars.2021.689950. Extraction: [Sinnickson_2021_RiverDischargeEwE.md](../raw/Sinnickson_2021_RiverDischargeEwE.md)
- **Nehemiah et al. 2022.** Nehemiah S, Chagaris D, Lowerre-Barbieri S, Allen M (2022) Environmental factors and stock abundance influence year-class strength of spotted seatrout at Cedar Key, Florida. *Marine and Coastal Fisheries* 14: e10201. DOI: 10.1002/mcf2.10201. Extraction: [Nehemiah_2022_SeatroutYearClass.md](../raw/Nehemiah_2022_SeatroutYearClass.md)
