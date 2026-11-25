---
title: "Machine-learning resource selection"
slug: machine-learning-resource-selection
domain: "Methods: spatial inference"
aliases: ["random forest RSF", "RSF with machine learning", "use-availability random forest", "relative habitat selection from COAs"]
related: [resource-selection-functions-with-clogit, hurdle-brt-habitat-suitability, integrated-sdm-with-inla-spde, detection-efficiency-and-range-testing, home-range-and-utilisation-distributions]
sources:
  - raw/Griffin_2021_SharkRSF_ML.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Machine-learning resource selection

## Summary

A resource selection function (RSF) compares locations an animal used with locations available to it and returns relative selection across habitat covariates. Griffin et al. (2021) paired this use-availability design with random forest classifiers to predict relative habitat selection for four shark species, and for eight potential prey of tiger sharks, inside Buck Island Reef National Monument, a no-take marine protected area off St. Croix, United States Virgin Islands. Used points were centres of activity (COAs) derived from a passive receiver array; available points were random background points inside 400 m buffers around each receiver. Random forests tuned by spatial cross-validation reached 80 to 95% overall accuracy on a 40% holdout set [Griffin et al. 2021, pp. 7–8]. Predictions were mapped on a 200 m grid across the protected area, capped at the maximum depth each species was detected, and averaged between predator and prey to locate areas of overlapping selection. The paper frames the approach as a way to extend selection estimates beyond receiver coverage "as long as within the original measured parameters" [Griffin et al. 2021, p. 14].

## Key points

### Study system

Buck Island Reef National Monument is a 77 km² no-take reserve surrounding a 0.7 km² uninhabited island 2.5 km northeast of St. Croix [Griffin et al. 2021, p. 3]. Depths run from shallow habitats (<10 m) near the island to more than 1,000 m off the shelf, and a lagoon 50–150 m wide rings most of the island [Griffin et al. 2021, p. 3]. The array grew from 17 VR2W receivers in 2011 to 147 in 2017, deployed at 2–40 m depth and downloaded twice a year; analyses used 2013–2019, when coverage and tag deployment were most substantial [Griffin et al. 2021, p. 3]. Sharks carried surgically implanted V13 or V16 transmitters (delay 60–180 s, battery life 360–3,217 days) [Griffin et al. 2021, p. 3].

The four focal sharks were Caribbean reef (*Carcharhinus perezi*, 14 tagged), lemon (*Negaprion brevirostris*, 10), nurse (*Ginglymostoma cirratum*, 11), and tiger sharks (*Galeocerdo cuvier*, 8) [Griffin et al. 2021, p. 3]. Potential prey of tiger sharks were juvenile green turtles (*Chelonia mydas*), juvenile Caribbean reef and lemon sharks (<120 cm FL), great barracuda (*Sphyraena barracuda*), horse-eye jack (*Caranx latus*), yellowtail snapper (*Ocyurus chrysurus*), and mutton snapper (*Lutjanus analis*) [Griffin et al. 2021, pp. 3, 6]. Tiger sharks in the predator-prey analysis were large juveniles and adults (n = 8, >200 cm FL) [Griffin et al. 2021, p. 6].

### Sample sizes

Total COAs ranged from 115,475 for Caribbean reef sharks to 7,310 for mutton snapper [Griffin et al. 2021, Table 1, p. 7].

| Group | Individuals | Total COAs | Mean tracking (d) |
|---|---|---|---|
| Caribbean reef shark | 14 | 115,475 | 991.43 |
| Lemon shark | 10 | 60,509 | 592.20 |
| Nurse shark | 11 | 48,920 | 541.82 |
| Tiger shark | 8 | 19,120 | 720.62 |
| Caribbean reef shark (juvenile) | 12 | 91,055 | 906.17 |
| Lemon shark (juvenile) | 8 | 27,167 | 383.00 |
| Green turtle | 36 | 45,787 | 156.86 |
| Great barracuda | 19 | 17,041 | 342.74 |
| Horse-eye jack | 5 | 13,708 | 335.00 |
| Yellowtail snapper | 8 | 15,363 | 443.62 |
| Mutton snapper | 4 | 7,310 | 153.75 |

Values from [Griffin et al. 2021, Table 1, p. 7]. Table 1 lists fewer green turtles (36) and barracuda (19) than the tagging totals in the Methods (58 and 25); the paper does not give the reason [Griffin et al. 2021, pp. 3, 7].

### Model performance

Overall accuracy on the 40% holdout set ranged from 80 to 95%, and sensitivity from 85 to 98% [Griffin et al. 2021, pp. 7–8]. Specificity was the weaker metric for the more wide-ranging species: 0.76 for tiger sharks, 0.72 for horse-eye jack, and 0.78 for mutton snapper [Griffin et al. 2021, Table 2, p. 8].

| Group | Accuracy | Sensitivity | Specificity | Precision |
|---|---|---|---|---|
| Caribbean reef shark | 0.90 | 0.90 | 0.89 | 0.89 |
| Lemon shark | 0.94 | 0.97 | 0.91 | 0.92 |
| Nurse shark | 0.85 | 0.91 | 0.79 | 0.81 |
| Tiger shark | 0.83 | 0.91 | 0.76 | 0.79 |
| Caribbean reef shark (juvenile) | 0.89 | 0.90 | 0.89 | 0.89 |
| Lemon shark (juvenile) | 0.94 | 0.97 | 0.91 | 0.91 |
| Green turtle | 0.95 | 0.97 | 0.93 | 0.94 |
| Great barracuda | 0.87 | 0.85 | 0.89 | 0.89 |
| Horse-eye jack | 0.80 | 0.89 | 0.72 | 0.76 |
| Yellowtail snapper | 0.92 | 0.92 | 0.93 | 0.93 |
| Mutton snapper | 0.88 | 0.98 | 0.78 | 0.81 |

Values from [Griffin et al. 2021, Table 2, p. 8]. Fall-out and miss rate are the complements of specificity and sensitivity and are omitted here.

### Shark habitat selection

Depth was the most important or second most important predictor for all four sharks, and predicted selection (ŷ) generally declined with depth [Griffin et al. 2021, p. 8]. Selection by Caribbean reef, nurse, and tiger sharks fell beyond 3 km from Buck Island [Griffin et al. 2021, p. 8].

- **Caribbean reef sharks** showed high ŷ "in depths of 20–30 m, areas <2 km away from land, and in areas of sand with scattered coral and rock" [Griffin et al. 2021, p. 8], with higher values along the western shelf next to water deeper than 50 m.
- **Lemon sharks** selected shallow (0–5 m) channel, lagoon, and reef crest habitats directly next to land; ŷ fell rapidly with distance and was lowest beyond 1,000 m [Griffin et al. 2021, p. 8].
- **Nurse sharks** selected areas 0–2,000 m from land at depths <15 m and 25–30 m [Griffin et al. 2021, p. 8].
- **Tiger sharks** had the greatest ŷ 500–2,000 m from land, in water <30 m deep, and over aggregate reef, sand, sand with scattered coral and rock, and pavement [Griffin et al. 2021, p. 8]. Depth and distance to land interacted strongly at 10–15 m and 25–30 m [Griffin et al. 2021, p. 13].

These patterns were "largely consistent" with earlier mixed-model presence models from the same array, with accuracy of 83–94% for sharks [Griffin et al. 2021, p. 13]. The two approaches disagreed for tiger sharks: the earlier models showed tiger shark presence increasing with depth, whereas RSF ŷ declined beyond 30 m [Griffin et al. 2021, p. 13]. Tiger sharks are known to use depths greater than 50 m that lie outside array coverage, which the authors cite from unpublished data [Griffin et al. 2021, p. 13].

### Predator-prey overlap

Relative selection surfaces were averaged between tiger sharks and each prey species, and cells where prey selection was <0.5 were removed to isolate areas of high overlap [Griffin et al. 2021, p. 6]. Juvenile green turtles and tiger sharks overlapped most south of the island, where seagrass beds along bank habitats were most abundant [Griffin et al. 2021, p. 8]. Across prey, high overlap "coincide[s] mainly with the seagrass beds south of Buck Island and the western continental shelf break" [Griffin et al. 2021, p. 13].

### Sensitivity results

Rebinning COAs at 60 min instead of 90 min left the top two predictors unchanged for every shark, and most accuracy metrics moved by about 1–2%, although some moved by 5–7% [Griffin et al. 2021, p. 9]. Accuracy fell for nurse sharks (85 to 80%) and rose for barracuda (87 to 92%), horse-eye jack (80 to 90%), and mutton snapper (88 to 96%) [Griffin et al. 2021, p. 9]. The 60 min models also reversed the depth response for Caribbean reef sharks, with ŷ increasing rather than decreasing with depth [Griffin et al. 2021, p. 9]. Buffers of 200 m lowered accuracy and predicted high selection homogeneously across the reserve; buffers of 600 m reproduced the 400 m results [Griffin et al. 2021, p. 10].

Mixed-model RSFs fitted for comparison had most variance explained by fixed effects, and only the lemon shark model approached its random forest in accuracy (92% versus 94%) [Griffin et al. 2021, p. 10]. Juvenile green turtle accuracy rose from 0.77 in an earlier mixed-model RSF with fewer predictors to 0.95 with the random forest [Griffin et al. 2021, p. 14].

## Methods and approaches

The workflow below follows Griffin et al. (2021); all analyses ran in R 3.6.2, and code with a sample dataset is posted at https://github.com/lucaspgriffin [Griffin et al. 2021, pp. 4, 15].

1. **Detection filtering.** Remove detections within 60 s of each other for an individual, single detections within 12 h, and detections implying movement faster than 3 m per second [Griffin et al. 2021, p. 3].
2. **Used points.** Compute COAs with `VTRACK` using 90 min time bins [Griffin et al. 2021, p. 4]. Assign diel period with `maptools`.
3. **Availability.** Draw 400 m buffers around each receiver for each year it was deployed. The buffer exceeds measured detection range (mean 58.2% detection probability at 100 m, cited from Selby et al. 2016) because "COAs are able to provide approximate positioning estimates even outside of receiver detection range" [Griffin et al. 2021, p. 4]. The 400 m choice matches earlier work at the same site [Griffin et al. 2021, p. 15].
4. **Background points.** Place random background points "equal to the number of observed COAs ... per individual, diel period (night vs. day), and year across all available resource units" [Griffin et al. 2021, p. 4].
5. **Grid.** Keep only points within 400 m of a receiver and collapse them into 200 m × 200 m raster cells with `raster` and `sp` [Griffin et al. 2021, p. 4].
6. **Covariates.** Five categorical habitat layers (zone, fine-scale structure, fine-scale cover, broad-scale cover, and percent coral cover) with two to 10 levels each, plus two continuous layers, depth (m) and distance to land (m) [Griffin et al. 2021, pp. 4, 13].
7. **Random forest.** Fit one model per species with `ranger` through `mlr`: 500 trees, sampling with replacement, 60% of data for training and 40% held out [Griffin et al. 2021, p. 4].
8. **Tuning.** Tune `mtry`, `sample.fraction`, and `min.node.size` by spatial cross-validation: split the training set into five geographic sections, draw 50 random hyperparameter sets per section (250 models), and select the optimum with `tuneParams` [Griffin et al. 2021, pp. 4–6]. Retrain the final model on the full 60% training set.
9. **Validation.** Score the holdout with `calculateConfusionMatrix` and `calculateROCMeasures` from `mlr` for accuracy, error rate, and class-level performance [Griffin et al. 2021, p. 6].
10. **Interpretation.** Rank predictors by permutation importance (mean decrease in accuracy), min-max normalised; estimate the Friedman H-statistic with `iml::Interaction` on models refit to 25% of the training data to save computation; draw partial dependence plots with `pdp` for the top predictor and the top three two-way interactions, restricted to depths of 50 m or less [Griffin et al. 2021, p. 6].
11. **Prediction.** Predict ŷ across the reserve grid, constraining extrapolation "to the maximum depth observed for the given species based on acoustic detections" [Griffin et al. 2021, p. 6].
12. **Extrapolation check.** Map covariate-space coverage for depth and distance to land with `dsmextra::compute_extrapolation`. Areas shallower than 50 m fell within sampled covariate space, whereas deeper, offshore areas showed univariate extrapolation [Griffin et al. 2021, pp. 6–7, 10].
13. **Comparisons.** Build 50% and 95% kernel density estimates with `adehabitatHR` (200 m smoothing) and individual Brownian bridge movement models for broad comparison; fit mixed-model RSFs in `glmmTMB` with individual as a random effect and the top three random forest predictors as standardised fixed effects, checked with variance inflation scores and scored with marginal and conditional R² in `performance` [Griffin et al. 2021, pp. 6–7].
14. **Sensitivity.** Rerun with 60 min COA bins and with 200 m and 600 m buffers, holding hyperparameters fixed [Griffin et al. 2021, p. 6].

The authors recommend "testing a wide range of parameter inputs from COA time bin selection to available habitat buffer size," guided by ecological knowledge, array coverage, and accuracy [Griffin et al. 2021, p. 15]. Time bins "should consider both the programmed tag delay and the speed of tagged animals," shorter for fast species and longer for slow ones [Griffin et al. 2021, p. 15]. For new arrays intended for selection work, they suggest grid designs that give "proportionally representative coverage" rather than placement guided by prior beliefs about space use [Griffin et al. 2021, p. 14].

## Open questions

- Random forests cannot easily include random effects, so individual-level effects may bias outputs [Griffin et al. 2021, p. 7]. The lemon shark mixed model suggested high individual variation [Griffin et al. 2021, p. 10].
- Spatial and temporal autocorrelation are not modelled, and "defining the correct correlation structure still remains challenging" in a use-availability design [Griffin et al. 2021, p. 14].
- The holdout set contained the same individuals as the training set. Testing on withheld individuals "may better help to assess model performance and transferability" [Griffin et al. 2021, p. 14].
- Buffer size, time bin, and grid resolution all change results; the depth reversal for Caribbean reef sharks under 60 min bins shows that scale choices can alter ecological conclusions [Griffin et al. 2021, pp. 9, 15].
- Variable detection range across habitats is not corrected within the 400 m buffers [Griffin et al. 2021, p. 15].
- Selection beyond the array, such as tiger shark use of water deeper than 50 m, remains outside the covariate space the model can support [Griffin et al. 2021, pp. 10, 13].

## Connections

- **Related to:** [[resource-selection-functions-with-clogit]]. That article covers matched case-control RSFs with conditional logistic regression, where availability is paired within individuals. The random forest approach here trades that stratification for flexible interactions and higher accuracy, which is why the individual-effect limitation above matters when choosing between them.
- **Related to:** [[hurdle-brt-habitat-suitability]]. Both are tree ensembles for habitat prediction; boosted trees model prevalence and intensity from survey data, whereas this approach models use versus availability from telemetry.
- **Contrasts with:** [[integrated-sdm-with-inla-spde]]. The INLA framework includes a spatial random field and can absorb the autocorrelation this method leaves unmodelled.
- **Depends on:** [[detection-efficiency-and-range-testing]]. The 400 m buffer is justified against measured detection range, and uneven range across habitats is a stated bias.
- **Depends on:** [[home-range-and-utilisation-distributions]]. Kernel and Brownian bridge estimates were the comparison surfaces for the RSF predictions.
- **Informs:** centres-of-activity estimation and array design for selection studies (articles not yet written).

## Sources

- **Griffin LP, Casselberry GA, Hart KM, Jordaan A, Becker SL, Novak AJ, DeAngelis BM, Pollock CG, Lundgren I, Hillis-Starr Z, Danylchuk AJ, Skomal GB (2021).** A novel framework to predict relative habitat selection in aquatic systems: applying machine learning and resource selection functions to acoustic telemetry data from multiple shark species. *Frontiers in Marine Science* 8: 631262. DOI: 10.3389/fmars.2021.631262.

Extraction: [Griffin_2021_SharkRSF_ML.md](../raw/Griffin_2021_SharkRSF_ML.md)
