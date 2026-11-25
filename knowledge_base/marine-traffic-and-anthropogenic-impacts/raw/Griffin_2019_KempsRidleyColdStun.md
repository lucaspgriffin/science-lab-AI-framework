---
citation: "Griffin LP, Griffin CR, Finn JT, Prescott RL, Faherty M, Still BM, Danylchuk AJ (2019) Warming seas increase cold-stunning events for Kemp's ridley sea turtles in the northwest Atlantic. PLoS ONE 14(1): e0211503"
doi: 10.1371/journal.pone.0211503
journal: PLoS ONE
year: 2019
volume: "14"
issue: "1"
pages: "e0211503"
keywords: []
source_pdf: "/Users/lucasgriffin/Library/Mobile Documents/com~apple~CloudDocs/CV materials/Tenure Track Applications/2023_01_WHOI/Griffin et al. 2019 PLoS ONE.pdf"
extracted_by: literature-extractor (pdftotext, page-marked text)
extracted_on: 2026-11-25
validated_by: extraction-validator
validated_on: 2026-11-25
status: validated
---

# Griffin et al. 2019

Journal page numbers and PDF page numbers coincide in this article (printed as "n / 15" on each page). The paper prints no keyword list, so the keywords field is empty.

## Verbatim abstract

> "Since the 1970s, the magnitude of turtle cold-stun strandings have increased dramatically within the northwestern Atlantic. Here, we examine oceanic, atmospheric, and biological factors that may affect the increasing trend of cold-stunned Kemp's ridleys in Cape Cod Bay, Massachusetts, United States of America. Using machine learning and Bayesian inference modeling techniques, we demonstrate higher cold-stunning years occur when the Gulf of Maine has warmer sea surface temperatures in late October through early November. Surprisingly, hatchling numbers in Mexico, a proxy for population abundance, was not identified as an important factor. Further, using our Bayesian count model and forecasted sea surface temperature projections, we predict more than 2,300 Kemp's ridley turtles may cold-stun annually by 2031 as sea surface temperatures continue to increase within the Gulf of Maine. We suggest warmer sea surface temperatures may have modified the northerly distribution of Kemp's ridleys and act as an ecological bridge between the Gulf Stream and nearshore waters. While cold-stunning may currently account for a minor proportion of juvenile mortality, we recommend continuing efforts to rehabilitate cold-stunned individuals to maintain population resiliency for this critically endangered species in the face of a changing climate and continuing anthropogenic threats." (Abstract, p. 1 (PDF p. 1))

## Study system and design

- Species: "Kemp's ridley (Lepidochelys kempii)" (Introduction, p. 2 (PDF p. 2)).
- Site: "Cape Cod Bay, Massachusetts, United States of America" (Abstract, p. 1 (PDF p. 1)); SST study area "spans across Cape Cod Bay, Gulf of Maine, and a portion of Georges Bank (Fig 1)" (Materials and methods, p. 3 (PDF p. 3)).
- Study area size: "This nearly 50,000 km2 area encompasses the greater northern area of Cape Cod Bay and Gulf of Maine" (Materials and methods, p. 3 (PDF p. 3)).
- Stranding data source: "Sea turtle cold-stunning data were provided by the Sea Turtle Stranding and Salvage Network (STSSN, ... S1 Table), which is coordinated by the National and Oceanic Atmospheric Administration (NOAA)." (Materials and methods, p. 3 (PDF p. 3)).
- Monitoring history: "STSSN has monitored Cape Cod Bay beaches since 1979." (Materials and methods, p. 3 (PDF p. 3)).
- Survey effort assumption: "With stranding responders monitoring all potential stranding beaches from October-January, we assumed a high probability of locating all stranded turtles for any given year." (Materials and methods, p. 3 (PDF p. 3)).
- Response variable and years: "We used the overall count of found Kemp's ridley stranded turtles per year from 1982–2016." (Materials and methods, p. 3 (PDF p. 3)).
- Why 1982 start: "Stranding data from years prior to 1982 were omitted because of limited availability of sea surface temperature (SST) data." (Materials and methods, p. 3 (PDF p. 3)).
- Sample size: "With a relatively small number of observations (n = 35 count years between 1982–2016), we decided to only use the two most important variables in our count model." (Materials and methods, p. 5 (PDF p. 5)).
- SST product and grid: "Using the Optimal Interpolation Sea Surface Temperature database (OISST, https://www.ncdc.noaa.gov/oisst) from NOAA, we calculated the average daily SST from 1982–2016 at 25 x 25-degree grids" (Materials and methods, p. 3 (PDF p. 3)).
- Six SST statistics: "These aggregate SST statistics include mean, maximum, minimum, standard deviation of daily mean SSTs, number of days with daily mean SST below 10˚C, and number of days with daily mean SST above 20˚C." (Materials and methods, p. 3 (PDF p. 3)).
- NAO covariate: "we derived the sum of monthly North Atlantic Oscillation (NAO) indices of each year between June and September" (Materials and methods, p. 3 (PDF p. 3)); "the average annual monthly NAO indices were lagged by two years" (Materials and methods, p. 3 (PDF p. 3)).
- AMO covariate: "The annual average monthly Atlantic Multidecadal Oscillation (AMO) indices, unsmoothed ..., were derived on an annual basis and also lagged by 1, 2, and 3 years." (Materials and methods, p. 3 (PDF p. 3)).
- Hatchling covariate: "we used the annual number of hatchlings released from the Tamaulipas index beaches (Rancho Nuevo, Playa Dos-Barra Del Tordo, Barra Ostionales-Tepehuajes)" (Materials and methods, p. 3 (PDF p. 3)); "Nesting data were lagged and averaged by 2, 3, and 4 years" (Materials and methods, p. 3 (PDF p. 3)).
- Total explanatory variables: "We first ran the random forest model on all 11 explanatory variables to choose the top two variables that best explained cold-stunning counts." (Materials and methods, p. 5 (PDF p. 5)).
- Software: "All statistical analyses were carried out using the software R [35] (version 3.4.2)." (Materials and methods, p. 4 (PDF p. 4)).
- Packages: "climwin package [36]" (Materials and methods, p. 4 (PDF p. 4)); "randomForest package [38]" (Materials and methods, p. 5 (PDF p. 5)); "Integrated Nested Laplace Approximations in the INLA package [41,42]" (Materials and methods, p. 5 (PDF p. 5)).
- Funding and ethics: "The author(s) received no specific funding for this work." (p. 2 (PDF p. 2)). No animal-ethics protocol number is stated; the study used stranding count data.
- Data availability: "all relevant data are within the manuscript and its Supporting Information files (cold-stun counts and hatchling counts)" (Data Availability Statement, p. 1 (PDF p. 1)).

## Quantitative claims

### Headline results

- SST effect: "Annual Kemp's ridley cold-stunning events were more likely to be higher when the corresponding late fall SSTs were warmer (Fig 4, minimum of daily mean SSTs, posterior mean = 1.23; 95% Credible Intervals (CI) = 1.04, 1.41])." (Results, p. 7 (PDF p. 7)).
- Hatchling effect: "number of hatchlings was found not to be important in original model (number of hatchlings, posterior mean = -0.02; 95% Credible Intervals (CI) = - 0.3, 0.25])" (Results, p. 7 (PDF p. 7)).
- 2031 forecast: "By 2031, the posterior mean predicted Kemp's ridleys cold-stunning count was 2,349 (95% CI = 1,328, 3,933) (Fig 5)." (Results, p. 8 (PDF p. 8)).
- Population-level share: "we estimate that approximately 1.8% of the juveniles (age classes two, three, and four) may cold-stun by 2031." (Results, p. 8 (PDF p. 8)).
- Same share, Discussion phrasing: "we estimate that less than 2% of the juveniles within age classes two, three, and four may be cold-stunned in 2031." (Discussion, p. 11 (PDF p. 11)).

### Sample sizes

- Count years: "n = 35 count years between 1982–2016" (Materials and methods, p. 5 (PDF p. 5)).
- 2014 event: "we suggest Hurricane Arthur may have contributed to the high cold-stun count in 2014 (n = 1,188)." (Discussion, p. 10 (PDF p. 10)).
- Outlier years: "While we were unable to explain all outlier cold-stun years (1999, 2002, and 2014)" (Discussion, p. 10 (PDF p. 10)).

### Climate windows

- Days above 20˚C: "The earliest time window occurred from late June thru early August for number of days with daily mean SST > 20˚C." (Results, p. 7 (PDF p. 7)).
- Mean, maximum, SD: "The optimal time window for three of the SST statistics (mean, maximum, and standard deviation of the daily mean SSTs) occurred from early August thru the first half of October." (Results, p. 7 (PDF p. 7)).
- Minimum and days below 10˚C: "The third time window occurred from late October thru early November for the minimum of the daily mean SSTs, and from late November thru early December for number of days with daily mean SST < 10˚C." (Results, p. 7 (PDF p. 7)).

### Model selection

- Full model: "Both minimum of daily mean SSTs and number of hatchlings along with their respective measurement error structures were included in the Bayesian count model (DIC 341.22)." (Results, p. 7 (PDF p. 7)).
- Hatchlings only: "Using number of hatchlings alone as a covariate within the model produced a much higher DIC value of 380.55" (Results, p. 7 (PDF p. 7)).
- SST only: "using minimum of daily mean SSTs alone as a covariate produced a DIC value of 339.41." (Results, p. 7 (PDF p. 7)).
- Variable importance: "Minimum of daily mean SSTs and number of hatchlings were the two most important variables associated with annual Kemp's ridley cold-stunning counts (Fig 3) identified by the random forest models." (Results, p. 7 (PDF p. 7)).

### Model diagnostics

- Overdispersion: "The calculated overdispersion statistic was 1.02, indicating no overdispersion issues and the negative binomial was an adequate probability distribution." (Results, p. 8 (PDF p. 8)).
- Autocorrelation: "Negative temporal autocorrelation at a lag of two was still present among the residuals, but it was minor and largely accounted for by using temperature as a covariate." (Results, p. 8 (PDF p. 8)).
- Fit: "The observed values from the full dataset were heavily outside the final model's 95% CI; yet, the fitted trend appeared to closely match the trend in the observed data (Fig 4)." (Results, p. 8 (PDF p. 8)).

### Forecast inputs

- Predicted SST: "we generated predicted temperatures (mean ± SD = 17.36 ± 0.40˚C) for 15 years in advance of our study period using the slope and intercept of observed minimum of daily mean SSTs in the past 15 years." (Results, p. 8 (PDF p. 8)).
- Forecast error: "we incorporated a measurement error of 0.5 to all temperatures to incorporate more realistic uncertainty." (Results, p. 8 (PDF p. 8)).
- Forecast horizon: "we forecasted annual Kemp's ridley cold-stunning counts 15 years into the future." (Results, p. 8 (PDF p. 8)).

### Measurement error priors

- SST error: "We applied a heteroscedastic error structure (i.e., error changes from observation to observation) to the minimum of daily mean SSTs, which was derived from the OISST platform (mean ± SD = 0.19± 0.02˚C)." (Materials and methods, p. 5 to 6 (PDF p. 5 to 6)).
- Hatchling error: "we derived our informative prior for this parameter by calculating the standard deviation of the last 10 years of hatchlings released and then scaled each observation by this standard deviation." (Materials and methods, p. 6 (PDF p. 6)).

### Random forest settings

- Trees: "Initial exploration indicated ~ 500 trees were sufficiently stable for random forest models; however, the number of trees was set to 2,000 for all random forest models to ensure optimal performance was reached." (Materials and methods, p. 5 (PDF p. 5)).

### Historical context

- Pre- and post-2009: "Prior to 2009, only two years (i.e., 1999 and 2002) had over 100 sea turtles stranded, since 2009, over a hundred sea turtles commonly strand from cold-stunning each year in Cape Cod Bay." (Introduction, p. 2 (PDF p. 2)).
- 2014 event: "in 2014, over 1,100 Kemp's ridleys stranded in Cape Cod Bay, Massachusetts." (Introduction, p. 2 (PDF p. 2)).

### Cited comparison values

- Long-term total (Still et al. 2005, ref 18): "Within the past 40 years, over 4,700 Kemp's ridleys have stranded within Cape Cod" (Introduction, p. 2 (PDF p. 2)).
- Age class and timing (Still et al. 2005, ref 18): "In Cape Cod Bay, juvenile Kemp's ridleys (approximately three years old) typically cold-stun in November, while the larger bodied loggerheads can withstand colder water temperatures and typically cold-stun in December [18]." (Introduction, p. 2 (PDF p. 2)).
- Cold-stun onset and death thresholds (cited from refs 12, 18, 29; Schwartz 1978 for death): "Juvenile sea turtles become cold-stunned as sea surface temperatures drop to around 10˚C, [12,18,29] with death occurring at temperatures ranging from 5.0–6.5˚C [29]." (Introduction, p. 2 (PDF p. 2)).
- Florida 2010 event (Avens et al. 2012, ref 13): "in 2010, approximately 5,000 juvenile green turtles were cold-stunned and stranded across Florida [13]" (Introduction, p. 2 (PDF p. 2)).
- Florida 2010 mortality (refs 13, 21): "only 20–22% of stranded turtles died that were recovered from St. Joseph Bay and Mosquito Lagoon, respectively [13,21]." (Introduction, p. 2 (PDF p. 2)).
- Population estimates (Gallaway et al. 2016, ref 48): "Gallaway et al. [48] reported the 2012 estimated Kemp's ridley female population at age two, three, and four were 32,060, 23,057, and 22,918, respectively. Female sex ratios were reported at 0.65 and 0.74 for in situ and protected nests, respectively." (Materials and methods, p. 6 (PDF p. 6)).
- Gulf of Maine warming (Pershing et al. 2015, ref 50): "Over the last decade, SSTs are warming 99% faster than the global ocean within the Gulf of Maine [50]." (Discussion, p. 10 (PDF p. 10)).
- Hurricane Arthur (NHC report): "Hurricane Arthur (1–5 July, 2014, ...), a category 2 hurricane (on Saffir-Simpson Hurricane Wind Scale) was an unusually early and severe hurricane to hit the northeast U.S." (Discussion, p. 11 (PDF p. 11)).

## Methods worth reusing

- Sliding window: "We used a sliding window approach [36,37] to determine the optimal climate time window for each of the six aggregate SST statistics" (Materials and methods, p. 4 (PDF p. 4)); "the slidingwin function was used to test for and produce, via Akaike information criterion, the best possible climate time window for each aggregate SST statistic." (Materials and methods, p. 5 (PDF p. 5)).
- Half-month collapse: "If the optimal day was between the 1st and 14th day of a month, it was considered as the early half of the month and if the optimal day was after the 14th day of a month, it was considered as the late half of the month." (Materials and methods, p. 5 (PDF p. 5)).
- Threshold rationale: "Number of days with daily mean SST below 10˚C was chosen because the onset of cold-stun symptoms begins at 10˚C [12,18,29]. Number of days with daily mean SST above 20˚C was chosen to capture periods of uncharacteristically warm SSTs." (Materials and methods, p. 3 (PDF p. 3)).
- Random forest variable screening: "We then eliminated the collinear aggregate SST variables that had the lowest mean decrease in accuracy and subsequently ran the model again with the top non-collinear SST variables (minimum and standard deviation of daily mean SSTs, number of days with daily mean SST below 10˚C, and number of days with daily mean SST above 20˚C)." (Materials and methods, p. 5 (PDF p. 5)).
- Count model: "we modeled annual Cape Cod Bay Kemp's ridley cold-stunning counts using a negative binomial distribution with approximate Bayesian inference models using Integrated Nested Laplace Approximations in the INLA package [41,42]." (Materials and methods, p. 5 (PDF p. 5)).
- Credible intervals: "we can infer the unknown parameter is 95% likely to fall within a range of values around each posterior distribution as defined by the 0.025 and 0.975 quantiles." (Materials and methods, p. 5 (PDF p. 5)).
- Measurement error: "we modified variance estimates around each parameter using informative prior distributions to include measurement error of our selected covariates." (Materials and methods, p. 5 (PDF p. 5)).
- Hatchling error justification: "The counts of hatchlings released from the last 10 years were used because the trend appears to asymptote during this period" (Materials and methods, p. 6 (PDF p. 6)).
- Autocorrelation structures: "Multiple structures, including first-order autoregressive and first and second-order random walks, were applied and assessed, following Zuur et al. [46], to address potential issues with temporal autocorrelation. However, all autocorrelation structures led the model to over fit the data, and we decided to exclude these structures." (Materials and methods, p. 6 (PDF p. 6)).
- Year excluded: "we decided not to include year as a covariate due to high collinearity (assessed via variance inflation factors) with the two parameters of minimum of daily mean SSTs and number of hatchlings." (Materials and methods, p. 6 (PDF p. 6)).
- Selection and checks: "We performed backwards step-wise model selection using Deviance Information Criterion (DIC, [47]), and autocorrelation was assessed using the acf function from the stats package [35]." (Materials and methods, p. 6 (PDF p. 6)).
- Residual checks: "The final model was examined for overdispersion and homogeneity by plotting the residuals against fitted values, and for potential patterns in residuals by plotting residuals versus each covariate in the model and each covariate not in the model." (Materials and methods, p. 6 (PDF p. 6)).
- SST projection: "we first calculated the slope of the observed minimum of daily mean SSTs and an intercept from the mean minimum of daily mean SSTs for the last 15 years. Using the calculated slope and intercept, we generated predicted temperatures for 15 years in advance of our study period. We set the measurement error for all 15 predicted temperature values to 0.5" (Materials and methods, p. 6 (PDF p. 6)).
- Population-share calculation: "Using the averaged female population age estimate at age two, three, and four, and the averaged female sex ratios, as reported by Gallaway et al. [48], we estimated the total number of turtles at age two, three, and four and then compared this estimate with our mean 2031 cold-stun prediction count. This assumes the population estimate of 2012 remains the same until 2031." (Materials and methods, p. 6 (PDF p. 6)).

## Management statements

- "we recommend continuing efforts to rehabilitate cold-stunned individuals to maintain population resiliency for this critically endangered species in the face of a changing climate and continuing anthropogenic threats." (Abstract, p. 1 (PDF p. 1)).
- "It is challenging to predict large-scale cold-stunning events, making it difficult to adequately plan and budget for federal, state, and non-governmental organizations to mobilize their recovery efforts, especially in years when large numbers of turtles are cold-stunned." (Introduction, p. 2 (PDF p. 2)).
- "we suggest future studies to consider anomalous hurricanes as potential predictors for atypically large cold-stunning events." (Discussion, p. 11 (PDF p. 11)).
- "Despite the potentially small effect on the overall population, we believe that it is important to continue recovery and rehabilitation efforts for juvenile cold-stunned Kemp's ridleys in the northeast U.S. to bolster population resiliency." (Discussion, p. 11 (PDF p. 11)).
- "Thus, we recommend that all conservation efforts, including the rehabilitation of cold-stunned Kemp's ridleys, be continued for this critically endangered species." (Discussion, p. 11 (PDF p. 11)).
- "As we continue to observe warming SSTs in the northeast U.S. driven by climate change, managers need to be prepared for increasing numbers of Kemp's ridley cold-stun strandings to occur." (Conclusion, p. 11 (PDF p. 11)).
- "Future studies should 1) determine when Kemp's ridleys typically immigrate into and emigrate out of coastal waters of the northeastern U.S., and 2) if juvenile Kemp's ridley turtles migrate back into the Gulf of Mexico to breed as adults." (Conclusion, p. 11 (PDF p. 11)).

## Stated limitations

- "the model would be improved with a greater understanding of the small and large scale oceanic processes at work, such as eddies, currents, and thermoclines, which all operate on multiple spatial and temporal scales. However, our single covariate likely acts as a proxy for these processes" (Discussion, p. 9 (PDF p. 9)).
- "Potentially, this statistical relationship between strandings and hatchlings was dampened due to variable hatchling survival (based on surface circulation patterns near nesting beaches) and due to the variable probability of turtles moving from the western Gulf of Mexico nesting beaches into the Atlantic [49]." (Discussion, p. 9 (PDF p. 9)).
- "While we were unable to explain all outlier cold-stun years (1999, 2002, and 2014)" (Discussion, p. 10 (PDF p. 10)).
- "Since we were unable to assess this with our methods, we suggest future studies to consider anomalous hurricanes as potential predictors" (Discussion, p. 11 (PDF p. 11)).
- "We also do not know to what extent juvenile Kemp's ridleys on the Atlantic coast return to the Gulf of Mexico to reproduce" (Discussion, p. 11 (PDF p. 11)).
- "The observed values from the full dataset were heavily outside the final model's 95% CI" (Results, p. 8 (PDF p. 8)).
- "This assumes the population estimate of 2012 remains the same until 2031." (Materials and methods, p. 6 (PDF p. 6)).
- "Predicted SSTs were derived specifically for our constructed study area using the observed minimum of daily mean SSTs rather than from global climate models that have multiple climatic scenarios." (Materials and methods, p. 6 (PDF p. 6)).

## Lab references cited

- Still, Griffin and Prescott 2005, climatic and oceanographic factors in daily cold-stunning patterns in Cape Cod Bay (ref 18).

No Brownscombe, Danylchuk, Cooke or Adams papers appear in the reference list. Brownscombe is thanked in the Acknowledgments.

## Provenance

Text was obtained by pdftotext from the open-access PLoS ONE PDF, with page markers inserted per PDF page. All 15 PDF pages were read in full, including the reference list and supporting-information descriptions. Figures 1 to 5 are captioned only in the text file; no values were read from figure panels, so no approximate figure-derived values appear above. The S1 and S2 CSV tables (annual cold-stun counts 1982 to 2016 and hatchlings released 1966 to 2018) are referenced but not included in the PDF, so per-year counts other than the 2014 value stated in the Discussion were not extracted. The paper prints no keyword list and no animal-ethics protocol number.
