---
citation: "Griffin LP, Casselberry GA, Hart KM, Jordaan A, Becker SL, Novak AJ, DeAngelis BM, Pollock CG, Lundgren I, Hillis-Starr Z, Danylchuk AJ, Skomal GB (2021) A novel framework to predict relative habitat selection in aquatic systems: applying machine learning and resource selection functions to acoustic telemetry data from multiple shark species. Frontiers in Marine Science 8:631262"
doi: 10.3389/fmars.2021.631262
journal: Frontiers in Marine Science
year: 2021
volume: "8"
pages: "631262"
keywords: [resource selection, space use, acoustic telemetry, machine learning, random forest, marine protected area, sharks, predator-prey]
source_pdf: "/Users/lucasgriffin/Library/Mobile Documents/com~apple~CloudDocs/CV materials/Tenure Track Applications/2023_01_WHOI/Griffin et al. 2021 Frontiers in Marine Science.pdf"
extracted_by: literature-extractor (pdftotext, page-marked text)
extracted_on: 2026-11-25
validated_by: extraction-validator
validated_on: 2026-11-25
status: validated
---

# Griffin et al. 2021

## Verbatim abstract

> "Resource selection functions (RSFs) have been widely applied to animal tracking data to examine relative habitat selection and to help guide management and conservation strategies. While readily used in terrestrial ecology, RSFs have yet to be extensively used within marine systems. As acoustic telemetry continues to be a pervasive approach within marine environments, incorporation of RSFs can provide new insights to help prioritize habitat protection and restoration to meet conservation goals. To overcome statistical hurdles and achieve high prediction accuracy, machine learning algorithms could be paired with RSFs to predict relative habitat selection for a species within and even outside the monitoring range of acoustic receiver arrays, making this a valuable tool for marine ecologists and resource managers. Here, we apply RSFs using machine learning to an acoustic telemetry dataset of four shark species to explore and predict species-specific habitat selection within a marine protected area. In addition, we also apply this RSF-machine learning approach to investigate predator-prey relationships by comparing and averaging tiger shark relative selection values with the relative selection values derived for eight potential prey-species. We provide methodological considerations along with a framework and flexible approach to apply RSFs with machine learning algorithms to acoustic telemetry data and suggest marine ecologists and resource managers consider adopting such tools to help guide both conservation and management strategies." (Abstract, p. 1 (PDF p. 1))

## Study system and design

- Species: "Caribbean reef (Carcharhinus perezi), lemon (Negaprion brevirostris), nurse (Ginglymostoma cirratum), and tiger (Galeocerdo cuvier) sharks within a Caribbean MPA." (Introduction, p. 3 (PDF p. 3))
- Potential prey of tiger sharks: "juvenile green turtles, juvenile Caribbean reef sharks, juvenile lemon sharks, great barracuda (Sphyraena barracuda), horse-eye jack (Caranx latus), yellowtail snapper (Ocyurus chrysurus), and mutton snapper (Lutjanus analis)" (Introduction, p. 3 (PDF p. 3))
- Site: "Buck Island Reef National Monument (BIRNM), a 77 km2 no-take MPA, is located on the northeast shelf of St. Croix, United States Virgin Islands" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Island: "Buck Island is an uninhabited, 0.7 km2 island that is situated in the middle of the MPA, and 2.5 km northeast of St. Croix." (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Depth range of the MPA: "shallow-water habitats (<10 m) near the island to deep-water habitats (>1,000 m) off the continental shelf" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Lagoon width: "lagoon habitat (50–150 m wide, around the island excluding the west and southwest sides of the island)" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Receivers: "Between 2011 and 2019, a total of 147 VEMCO VR2W receivers (Innovasea Systems Inc., Nova Scotia, Canada) were deployed as a passive acoustic receiver array within BIRNM" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Receiver depths and downloads: "Receivers were deployed, in depths ranging from 2 to 40 m, either on sand screws or cement block anchors around the island with receiver downloads occurring twice a year" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Array growth: "The array began with 17 receivers in 2011 and reached its greatest coverage with 147 receivers in 2017." (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Years analysed: "we collected and analyzed acoustic telemetry data from only 2013–2019 when detection coverage and tag deployment was most substantial across BIRNM" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Tags: "surgically implanted V13 or V16 transmitters (delay 60–180 s, battery life 360–3,217 days, Innovasea Systems Inc., Nova Scotia, Canada)" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Sharks tagged: "14 Caribbean reef sharks (between 2013 and 2019), 10 lemon sharks (between 2013 and 2019), 11 nurse sharks (between 2013 and 2019), and eight tiger sharks (between 2015 and 2019)" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Prey tagged: "58 juvenile green turtles (between 2013 and 2014), 25 great barracuda (hereinafter referred to as barracuda) (between 2014 and 2015), five horse-eye jack (between 2016 and 2017), eight yellowtail snapper (between 2015 and 2017), and four mutton snapper (between 2015 and 2016)" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Detection filtering: "detections that occurred within 60 s of each other for a given individual, singular detections occurring within 12 h, and detections that indicated unrealistic movements (>3 m per second)" (Study Area and Field Data Collection, p. 3 (PDF p. 3))
- Software: "All analyses were conducted in R version 3.6.2 (R Core Team, 2019)." (Framework, p. 4 (PDF p. 4))
- Packages named: VTRACK (centres of activity), maptools (diel period), raster and sp (rasters), ranger and mlr (random forest), iml (H-statistic), pdp (partial dependence), ggplot2 (smoother), adehabitatHR (kernel density), dsmextra (extrapolation), glmmTMB and performance (mixed models) (Methods, pp. 4–7 (PDF pp. 4–7))
- Ethics: "The animal study was reviewed and approved by University of Massachusetts Amherst IACUC no. 2013-0031 and 20190043." (Ethics Statement, p. 15 (PDF p. 15))
- Park permits: "Research conducted within BIRNM was approved by NPS under study no. BUIS-00058 and individual research collection permit nos. BUIS-2013-SCI_0003, BUIS-2014SCI-0006, and BUIS-2019-0010." (Ethics Statement, p. 15 (PDF p. 15))
- Turtle permits: "For green turtle fieldwork, permitting was under NMFS permits 16146 and 20315, issued to KH" (Ethics Statement, p. 15 (PDF p. 15))
- Code: "Code for the resource selection function framework with a sample dataset can be found at https://github.com/lucaspgriffin." (Data Availability Statement, p. 15 (PDF p. 15))

## Quantitative claims

### Headline results

- Accuracy 80 to 95%, sensitivity 85 to 98%: "RF model accuracy and model performance varied across species with overall accuracy ranging from 80 to 95% and sensitivity (true positive rate) from 85 to 98% (Table 2)." (Results, pp. 7–8 (PDF pp. 7–8))
- Depth importance: "Predictor importance and rank varied across shark species, with depth (m) as either the most important or within the top two most important predictors for all four species (Figure 2)." (Results, p. 8 (PDF p. 8))
- Depth direction: "Overall, ŷ values generally decreased as depth increased for all sharks (Figure 3)." (Results, p. 8 (PDF p. 8))
- Distance to land, 3 km: "While ŷ values decreased for Caribbean reef, nurse, and tiger sharks in areas >3 km from Buck Island, tiger sharks appeared to have higher ŷ values farther away from the island at distances approximately between 500 and 2,000 m." (Results, p. 8 (PDF p. 8))
- Lemon shark distance: "Lemon shark ŷ values decreased rapidly as distance from land increased, with lowest values occurring >1,000 m." (Results, p. 8 (PDF p. 8))
- Shark accuracy range versus earlier work: "largely consistent with those presented by Casselberry et al. (2020) that used GLMMs and detection data from fixed receiver locations to model presence in BIRNM habitats, but with improved model accuracy (83–94%) and additional covariates" (Discussion, p. 13 (PDF p. 13))

### Confusion matrix

Values from Table 2, "Confusion matrix performance metrics derived from using the trained random forest model to predict across the 40% holdout dataset." Columns in order: accuracy, sensitivity, specificity, fall-out, miss rate, precision. (Table 2, p. 8 (PDF p. 8))

- Caribbean reef: 0.90, 0.90, 0.89, 0.11, 0.10, 0.89
- Lemon: 0.94, 0.97, 0.91, 0.09, 0.03, 0.92
- Nurse: 0.85, 0.91, 0.79, 0.21, 0.09, 0.81
- Tiger: 0.83, 0.91, 0.76, 0.24, 0.09, 0.79
- Caribbean reef (juv.): 0.89, 0.90, 0.89, 0.11, 0.10, 0.89
- Great barracuda: 0.87, 0.85, 0.89, 0.11, 0.15, 0.89
- Green turtle: 0.95, 0.97, 0.93, 0.07, 0.03, 0.94
- Horse-eye jack: 0.80, 0.89, 0.72, 0.28, 0.11, 0.76
- Lemon (juv.): 0.94, 0.97, 0.91, 0.09, 0.03, 0.91
- Mutton snapper: 0.88, 0.98, 0.78, 0.22, 0.02, 0.81
- Yellowtail snapper: 0.92, 0.92, 0.93, 0.07, 0.08, 0.93
- Table 2 prints the species labels "Caribbean ref (juv.)" and "Great brracuda" as typeset in the source.

### Sample sizes

Values from Table 1, "Tagging and detection data for shark species and the potential prey species for tiger sharks, including a subset of juvenile Caribbean reef and lemon sharks, monitored within Buck Island National Monument." Columns in order: ID count, Avg. size (cm), SD size (cm), Total COA, Avg. COA, SD COA, Avg. tracking dur. (d), SD tracking dur. (d). Table 1 is rotated on the page and the text layer scrambles its columns; row assignments below were read from the rendered page (Table 1, p. 7 (PDF p. 7)).

- Caribbean reef (Carcharhinus perezi): 14, 97.79, 24.90, 115475, 8248.21, 8665.22, 991.43, 822.96
- Lemon (Negaprion brevirostris): 10, 81.30, 35.58, 60509, 6050.90, 10680.64, 592.20, 799.34
- Nurse (Ginglymostoma cirratum): 11, 128.45, 30.77, 48920, 4447.27, 5223.02, 541.82, 537.57
- Tiger (Galeocerdo cuvier): 8, 231.50, 26.69, 19120, 2390.00, 2280.74, 720.62, 610.98
- Caribbean reef (juv.) (Carcharhinus perezi): 12, 90.58, 18.30, 91055, 7587.92, 8728.62, 906.17, 860.23
- Great barracuda (Sphyraena barracuda): 19, 83.74, 10.51, 17041, 896.89, 1236.71, 342.74, 113.77
- Green turtle (Chelonia mydas): 36, 48.40, 7.86, 45787, 1271.86, 1180.64, 156.86, 117.22
- Horse-eye jack (Caranx latus): 5, 57.20, 8.98, 13708, 2741.60, 2049.30, 335.00, 180.69
- Lemon (juv.) (Negaprion brevirostris): 8, 67.38, 22.03, 27167, 3395.88, 9338.61, 383.00, 735.18
- Mutton snapper (Lutjanus analis): 4, 52.62, 7.48, 7310, 1827.50, 1373.26, 153.75, 102.25
- Yellowtail snapper (Ocyurus chrysurus): 8, 29.44, 4.25, 15363, 1920.38, 1069.84, 443.62, 166.56
- Table 1 ID counts for green turtle (36) and great barracuda (19) are lower than the tagging counts in the Methods (58 and 25); the paper does not state the reason.
- Predator and juvenile prey size classes: "large juvenile and mature tiger sharks (n = 8, >200 cm FL) and their potential prey species, including juvenile green turtles, juvenile Caribbean reef sharks (n = 12, <120 cm FL), juvenile lemon sharks (8, <120 cm FL)" (RSFs and Predator-Prey Relationships, p. 6 (PDF p. 6))

### Detection range

- "detection range was variable across BIRNM habitats with an average of 58.2% (95% confidence interval: 44–73% CI) probability of detection at 100 m distance from a receiver (Selby et al., 2016)" (Defining Available Resource Units, p. 4 (PDF p. 4)). This value is cited from Selby et al. 2016, not measured in this paper.

### Partial dependence

- Caribbean reef sharks: "two-way predictor interactions highlighted relatively high ŷ values in depths of 20–30 m, areas <2 km away from land, and in areas of sand with scattered coral and rock (Figure 4A)" (Results, p. 8 (PDF p. 8))
- Lemon sharks: "more likely to select for shallow areas directly adjacent to land, specifically in shallow (0–5 m) habitats classified as channel, lagoon, and reef crest (Figures 3B, 4B)" (Results, p. 8 (PDF p. 8))
- Nurse sharks: "more likely to select for habitats between 0 and 2,000 m away from land but within <15 and 25–30 m of depth" (Results, p. 8 (PDF p. 8))
- Tiger sharks: "the greatest ŷ values away from land (500–2,000 m), in <30 m depth, and in aggregate reef, sand, sand with scattered coral and rock, and pavement habitats (Figures 3D, 4D)" (Results, p. 8 (PDF p. 8))
- Tiger shark interactions: "high interactions between depth and distance to land at depths between 10–15 and 25–30 m (Figure 4)" (Discussion, p. 13 (PDF p. 13))
- Tiger shark depth disagreement with earlier model: "Casselberry et al. (2020) showed probability of presence in the acoustic array increasing with depth across habitat types (coral, rock, and colonized hardbottom, submerged vegetation, and unconsolidated sediments), while ŷ values consistently decreased with depths beyond 30 m in RSF models." (Discussion, p. 13 (PDF p. 13))
- Caribbean reef sharks deep water: "Caribbean reef sharks exhibited higher relative selection values along the western shelf near adjacent deep water habitats (>50 m)." (Results, p. 8 (PDF p. 8))

### Sensitivity analyses

- 60-minute bins: "The RF models using COA data of 60-min bins produced similar results to models that used COA data of 90-min bins (Appendix B). The top two most important variables remained unchanged for all shark species" (Additional Methodological Considerations, p. 9 (PDF p. 9))
- Accuracy differences: "While accuracy metrics were similar for all species across the 60- and 90-min RF models (∼1–2% differences), some varied substantially (e.g., 5–7%) (Table 2 and Appendix Table B1)." (Additional Methodological Considerations, p. 9 (PDF p. 9))
- Species-level accuracy changes: "The use of 60-min time bins led to a decrease in overall accuracy for nurse sharks (85–80%) but an increase in overall accuracy for barracuda (87–92%), horse-eye jack (80–90%), and mutton snapper (88–96%)." (Additional Methodological Considerations, p. 9 (PDF p. 9))
- Caribbean reef shark depth reversal: "the new 60-min binned RF models indicated ŷ values generally increased (rather than decreased) with depth for Caribbean reef sharks and ŷ values for aggregate reef were lower for tiger sharks" (Additional Methodological Considerations, p. 9 (PDF p. 9))
- 200 m buffers: "RF models using 200 m buffers for available habitat construction scored lower accuracy measurements and also predicted higher relative selection homogeneously across BIRNM" (Additional Methodological Considerations, p. 10 (PDF p. 10))
- 600 m buffers: "models using 600 m buffers for available habitat construction produced similar accuracy measures and predictions across BIRNM as compared to the original models" (Additional Methodological Considerations, p. 10 (PDF p. 10))
- Extrapolation reliability: "areas within the MPA that remained in shallower water (<50 m) were analogous to the range of our covariates as measured by depth (m) and distance to land (m), confirming our approach to limiting extrapolations to the maximum observed depth was warranted" (Additional Methodological Considerations, p. 10 (PDF p. 10))

### Mixed model comparison

- "GLMMs and respective marginal and conditional R2 values indicated variance was largely explained by the fixed effects (marginal R2) alone (Supplementary Table 2)." (Additional Methodological Considerations, p. 10 (PDF p. 10)). The R2 values themselves are in Supplementary Table 2, not in the main text.
- Lemon shark: "GLMM accuracy for lemon sharks was also nearly as accurate as the RF model (92% versus 94%, respectively). Accuracy metrics for the other GLMMs were substantially lower than respective RF models" (Additional Methodological Considerations, p. 10 (PDF p. 10))
- Green turtle comparison with Griffin et al. 2020: "when implementing a RF using the juvenile green turtle data in this study, we found a higher accuracy compared to that as reported by Griffin et al. (2020) (0.95 versus 0.77, respectively), who also applied RSFs on juvenile green turtle acoustic telemetry data from BIRNM but were fitted with GLMMs and fewer predictor variables" (Discussion, p. 14 (PDF p. 14))

### Predator-prey overlap

- Overlap threshold: "by removing raster cells where relative selection values of potential prey were <0.5, we examined specific high overlap areas between tiger sharks and each potential prey species" (RSFs and Predator-Prey Relationships, p. 6 (PDF p. 6))
- Location of overlap: "juvenile green turtles (Figure 6A) and tiger sharks were most likely to overlap in selection south of the island where seagrass beds along bank habitats were most abundant" (Predator-Prey Relationships, p. 8 (PDF p. 8))
- Depth of open habitat: "habitats south and west of Buck Island are more open at depths of ∼12 m" (Discussion, p. 13 (PDF p. 13))

### Covariate structure

- "RSFs paired with machine learning algorithms were able to easily assess five separate habitat covariates that ranged from two and 10 factor levels each along with two additional continuous predictors" (Discussion, p. 13 (PDF p. 13))

### Cited comparison values

- Ocean protection target, cited from O'Leary et al. 2016 and Sala et al. 2018: "With calls to protect at least 30% of the ocean by 2030 through establishing MPAs" (Discussion, p. 13 (PDF p. 13))
- Detection probability 58.2% at 100 m, cited from Selby et al. 2016 (see Detection range above).
- Green turtle accuracy 0.77, cited from Griffin et al. 2020 (see Mixed model comparison above).
- Tiger sharks beyond 50 m: "tiger sharks are known to use depths greater than 50 m in and around BIRNM that are beyond the depths of acoustic array coverage (Casselberry unpublished data)" (Discussion, p. 13 (PDF p. 13))

## Methods worth reusing

- Centres of activity: "using the VTRACK package (Campbell et al., 2012), this algorithm was implemented with 90-min time bins to provide animal positioning data across BIRNM" (Defining Available Resource Units, p. 4 (PDF p. 4))
- Available resource units: "we defined our available resource units by deriving 400 m buffers around each receiver for each year it was deployed (i.e., 2013–2019)" (Defining Available Resource Units, p. 4 (PDF p. 4))
- Buffer rationale: "we decided to extend the buffer size to 400 m since COAs are able to provide approximate positioning estimates even outside of receiver detection range" (Defining Available Resource Units, p. 4 (PDF p. 4))
- Background points: "Background points were randomly distributed equal to the number of observed COAs (see Barbet-Massin et al., 2012) per individual, diel period (night vs. day), and year across all available resource units (Figure 1)." (Defining Available Resource Units, p. 4 (PDF p. 4))
- Raster resolution: "Only using COAs and background points that were within the 400 m buffer from any receiver, they were then collapsed into 200 m × 200 m raster cells." (Defining Available Resource Units, p. 4 (PDF p. 4))
- Habitat layers: "Derived habitat raster files included classifications aggregated by zone (fore reef, reef flat, lagoon, etc.) (Supplementary Figure 2A), fine-scale structure (aggregate reef, sand, pavement with sand channels, etc.) (Supplementary Figure 2B), fine-scale cover [seagrass patchy (10%–<50%), seagrass patchy (50–<90%), seagrass continuous (90–100%), etc.], broad-scale cover (algae, live coral, seagrass, etc.), and percent coral cover (i.e., 0–<10%, 10–<50%)." (Aggregating Habitat Information, p. 4 (PDF p. 4))
- Continuous covariates: "we generated two relevant habitat raster files including distance to land (m) (Buck Island) and depth (m)" (Aggregating Habitat Information, p. 4 (PDF p. 4))
- Random forest settings: "RF models were fit for each species with 500 trees, replacement, and with 60% of the data. The 40% remainder of each dataset, known as the holdout dataset, were then used to test model performance." (Applying RSFs With Machine Learning, p. 4 (PDF p. 4))
- Implementation: "RF models were implemented in the ranger (Wright and Ziegler, 2015) and mlr (Bischl et al., 2016) packages." (Applying RSFs With Machine Learning, p. 4 (PDF p. 4))
- Hyperparameters tuned: "the number of predictors that should be used in each tree (mtry), the fraction of observations to be used in each tree (sample.fraction) with lower fractions leading to lower correlation across trees, and the number of observations a terminal node (within a tree) should at least have (min.node.size)" (Applying RSFs With Machine Learning, pp. 4–5 (PDF pp. 4–5))
- Spatial cross-validation for tuning: "we first partitioned the training dataset into five distinct geographic sections and then for each partition, we generated 50 random combinations of hyperparameters and subsequently chose the optimal combination (see Lovelace et al., 2019) using the tuneParams function from the mlr package" (Applying RSFs With Machine Learning, pp. 5–6 (PDF pp. 5–6))
- Tuning budget: "50 iterations of random hyperparameter values across each of the five partitions resulted in 250 models in total. Subsequently, the optimal hyperparameter combinations were used to tune and train the final RF for each species, using the 60% training dataset." (Applying RSFs With Machine Learning, p. 6 (PDF p. 6))
- Performance metrics: "The functions calculateConfusionMatrix and calculateROCMeasures from the mlr package (Bischl et al., 2016) were used to determine overall and class (present versus background point) accuracy, error rate, and performance of each RF." (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Variable importance: "Predictor, also known as feature, importance was also assessed using the permutation importance method (mean decrease in accuracy)" and "all importance values were normalized (min-max normalization)" (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Interaction strength: "we derived the H-statistic (Friedman and Popescu, 2008) using the Interaction function from the iml package (Molnar et al., 2018). This calculation, which can be extremely computationally intensive when examining every possible interaction, was implemented after rerunning each RF model but with only 25% of the training dataset." (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Partial dependence: "we constructed partial dependency plots, using the pdp package (Greenwell, 2017), for the most important feature as identified by the mean decrease in accuracy approach. Partial dependency plots were also generated for the top three two-way interactions" (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Depth cap on plots: "All partial dependency plots were restricted to depths of 50 m or less so to avoid extrapolating outside the shelf of BIRNM where no receivers were located." (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Prediction constraint: "Model extrapolation across the MPA was constrained to the maximum depth observed for the given species based on acoustic detections." (Performance, Interpretation, and Prediction, p. 6 (PDF p. 6))
- Kernel density: "Kernel utilization distributions and subsequent kernel density estimates were constructed using the adehabitatHR package (Calenge, 2006) with 200 m smoothing parameters." with "the 50 and 95% kernel density estimates" (Kernel Density Estimates, p. 6 (PDF p. 6))
- Sensitivity runs: "we also implemented RF models using COA data binned at 60-min timesteps" and "we again ran RF models but with available habitat defined using either 200 or 600 m buffers. Hyperparameter inputs were kept consistent with original respective models." (Additional Methodological Considerations, p. 6 (PDF p. 6))
- Extrapolation assessment: "we explored and mapped extrapolation reliability in BIRNM using the dsmextra package (Bouchet et al., 2020). Using the presence/background locations and their depth (m) and distance to land (m) values, the compute_extrapolation function evaluated areas across BIRNM that fell within the sampled covariate space" (Additional Methodological Considerations, pp. 6–7 (PDF pp. 6–7))
- Mixed model check: "we implemented RSF GLMMs with individual ID as the random effect for each shark species using the top three most important variables as fixed effects that were identified by RF models. All variables were examined for correlation issues using variance inflation scores and continuous variables were standardized." (Additional Methodological Considerations, p. 7 (PDF p. 7))
- Mixed model fitting and fit metrics: "All models were implemented and assessed using 60% of the dataset via the glmmTMB (Magnusson et al., 2017) and performance (Lüdecke et al., 2019) packages. Two goodness-of-fit metrics, marginal R2 and conditional R2, were calculated for each model." (Additional Methodological Considerations, p. 7 (PDF p. 7))
- Predator-prey averaging: "relative habitat selection values across BIRNM were averaged between tiger sharks and each potential prey species" (RSFs and Predator-Prey Relationships, p. 6 (PDF p. 6))
- Individual space use: "using all available detection data, we constructed individual BBMMs and plotted individual space use within BIRNM" (Additional Methodological Considerations, p. 7 (PDF p. 7))

## Management statements

- "The RSFs show that favorable habitats exist in this low coverage region for nurse, Caribbean reef, and tiger sharks, particularly at intersections between reef, pavement, and sand habitats. This further highlights the suitability of this MPA for shark conservation and management in St. Croix" (Discussion, p. 13 (PDF p. 13))
- "Areas of high tiger shark-prey overlap coincide mainly with the seagrass beds south of Buck Island and the western continental shelf break, while many potential prey species also have high selection potential in areas north of Buck Island." (Discussion, p. 13 (PDF p. 13))
- "areas of high averaged relative selection highlight important regions in BRINM that could be used to inform future habitat monitoring or restoration studies, particularly with the potential for habitat degradation as the climate changes" (Discussion, p. 13 (PDF p. 13))
- "The RSF modeling framework provided here can produce high accuracy models of relative habitat selection for multiple species of differing ecologies and can be averaged across species to highlight overlapping potential space use or selection." (Discussion, p. 14 (PDF p. 14))
- "These models can then be used to extrapolate to areas lacking acoustic receiver coverage, as long as within the original measured parameters" (Discussion, p. 14 (PDF p. 14))
- "For future studies aimed at examining relative selection, we suggest grid array designs (Heupel et al., 2006; Kraus et al., 2018) to achieve proportionally representative coverage of areas rather than deployments guided by a priori beliefs of animal space use" (Discussion, p. 14 (PDF p. 14))
- "we recommend testing a wide range of parameter inputs from COA time bin selection to available habitat buffer size. Such inputs should be guided by ecological knowledge, acoustic telemetry coverage, and model accuracy metrics." (Discussion, p. 15 (PDF p. 15))
- "COA time bin selection should consider both the programmed tag delay and the speed of tagged animals, with smaller time bins for faster moving species and larger time bins for slow moving animals" (Discussion, p. 15 (PDF p. 15))
- "we suggest marine ecologists should also adopt these methods to improve resource management actions. Such applications could help to prioritize habitat protection and restoration in the face of continued anthropogenic threats" (Conclusion, p. 15 (PDF p. 15))

## Stated limitations

- Kernel density bias: "these estimates were used for broad comparison since they are likely biased to some extent due to unequal sample sizes across individuals" (Kernel Density Estimates, p. 6 (PDF p. 6))
- No random effects in random forest: "RF models are currently unable to easily incorporate random effects to account for individual level effects, thus, model outputs are potentially biased to some extent" (Additional Methodological Considerations, p. 7 (PDF p. 7))
- Simplified mixed models: "no temporal or spatial autocorrelation dependency structures, interaction terms, or non-linear relationships were included" (Additional Methodological Considerations, p. 7 (PDF p. 7))
- Extrapolation beyond covariate range: "extrapolation space became unreliable (univariate extrapolation) in areas off the shelf in deeper and further areas from land" (Additional Methodological Considerations, p. 10 (PDF p. 10))
- Lemon shark individual variation: "the GLMM involving lemon sharks appeared to have substantial variance explained by both the fixed and random effects combined (conditional R2), suggesting individual variation may be higher within this species dataset" (Additional Methodological Considerations, p. 10 (PDF p. 10))
- Autocorrelation and individual effects: "the difficulty to account for spatial-temporal autocorrelation and individual level effects presents additional challenges" (Discussion, p. 14 (PDF p. 14))
- Correlation structure: "defining the correct correlation structure still remains challenging within a use/availability (presences/pseudo-absences) sampling design" (Discussion, p. 14 (PDF p. 14))
- Transferability: "using test datasets that contain individuals not used in the training dataset may better help to assess model performance and transferability" (Discussion, p. 14 (PDF p. 14))
- Detection range bias: "while potentially incorporating biases due to variable detection ranges (see Selby et al., 2016), we chose a 400 m buffer around each receiver to allow for COAs and associated background points to extend beyond observed detection ranges" (Discussion, p. 15 (PDF p. 15))
- Buffer choice: "While 400 m buffers were chosen for consistency to Selby et al. (2019) and Griffin et al. (2020), future researchers should explore and evaluate multiple extents for a given species, study area, and array." (Discussion, p. 15 (PDF p. 15))
- Scale: "future RSF studies using acoustic telemetry should also investigate the role of spatial and/or temporal scales on selection modeling (McGarigal et al., 2016); this is especially relevant when collapsing habitat and presences/background points for model implementation" (Discussion, p. 15 (PDF p. 15))
- Data availability: "The datasets generated for this study are not readily available because studies for each individual species are currently ongoing." (Data Availability Statement, p. 15 (PDF p. 15))

## Lab references cited

- Griffin et al. 2019, immature green turtle movements and space use, Culebra, Puerto Rico
- Griffin et al. 2020, immature green turtle space use and relative habitat selection, Buck Island
- Brownscombe et al. 2019a, accounting for detection range variation in acoustic telemetry arrays
- Brownscombe et al. 2019b, conducting and interpreting fish telemetry studies
- Brownscombe et al. 2020, machine learning to identify cryptic reproductive habitats
- Casselberry et al. 2020, network analysis of the Buck Island shark community
- Cooke et al. 2004, biotelemetry as a mechanistic approach to ecology
- Cooke 2008, biotelemetry in endangered species research
- Donaldson et al. 2014, acoustic telemetry monitoring in aquatic ecosystems
- Hussey et al. 2015, aquatic animal telemetry review
- Kessel et al. 2014, detection range testing review
- Nguyen et al. 2019, uptake of fish tracking studies
- Becker et al. 2016 and 2020, great barracuda spatial ecology at Buck Island (Danylchuk coauthor)
- Novak et al. 2020a and 2020b, horse-eye jack and yellowtail snapper at Buck Island (Danylchuk coauthor on 2020a)

## Provenance

The text was obtained from a pdftotext page-marked dump of the publisher PDF (20 PDF pages; journal pagination 1 to 20 matches PDF pagination). All 20 pages were read in full, including the reference list. Table 1 (p. 7) is rotated on the page and its text layer separates numbers from species names, so row assignments were confirmed against a rendered image of the page; Table 2 (p. 8) was legible in the text layer. Figures 2 to 6 are maps and plots with no numeric labels in the text layer, so no values were read from figures. Supplementary Tables 1 and 2 (buffer sensitivity accuracies and the mixed model R2 and accuracy values), Appendix Table B1 (60-minute bin accuracies), and the Appendix A code vignette are not in the PDF and were not extracted. The in-text 60-minute accuracy changes and the lemon shark mixed model accuracy were taken from the main text only.
