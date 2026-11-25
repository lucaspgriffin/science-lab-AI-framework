---
title: "Cold-stunning and ocean warming"
slug: cold-stunning-and-ocean-warming
domain: "Conservation: human-wildlife interaction"
aliases: ["cold-stun strandings", "Kemp's ridley cold-stunning", "Cape Cod Bay strandings", "sea turtle hypothermic stranding"]
related: [vessel-strike-risk-from-ais-data, integrated-sdm-with-inla-spde, hurdle-brt-habitat-suitability]
sources:
  - raw/Griffin_2019_KempsRidleyColdStun.md
status: published
origin: literature-extractor and science-writer
last_updated: 2026-11-25
---

# Cold-stunning and ocean warming

## Summary

Cold-stunning is a hypothermic stranding response in which juvenile sea turtles become incapacitated as water
temperatures fall in late autumn. Griffin et al. (2019) modelled annual cold-stun counts of Kemp's ridley sea
turtles (*Lepidochelys kempii*) in Cape Cod Bay, Massachusetts, from 1982 to 2016, combining sliding-window
climate analysis, random forest variable screening, and a Bayesian negative binomial count model fitted with
Integrated Nested Laplace Approximations. Warmer sea surface temperature (SST) in the Gulf of Maine in late
October through early November was the dominant predictor of high stranding years, whereas hatchling production
in Mexico, used as a proxy for population abundance, was not. Projecting the recent SST trend forward, the
authors predicted a posterior mean of 2,349 cold-stunned turtles per year by 2031 [Griffin et al. 2019, p. 8].
The study frames cold-stunning as a small fraction of juvenile mortality but a growing logistical burden for
stranding response, and it recommends continued rescue and rehabilitation.

## Key points

### Stranding trend

Cold-stun strandings in Cape Cod Bay have shifted from occasional to routine. "Prior to 2009, only two years
(i.e., 1999 and 2002) had over 100 sea turtles stranded, since 2009, over a hundred sea turtles commonly strand
from cold-stunning each year in Cape Cod Bay" [Griffin et al. 2019, p. 2]. In 2014, more than 1,100 Kemp's
ridleys stranded in the bay [Griffin et al. 2019, p. 2], with the Discussion reporting that year's count as n =
1,188 [Griffin et al. 2019, p. 10]. Citing Still et al. (2005), the paper notes that juvenile Kemp's ridleys of
approximately three years old typically cold-stun in November, while larger loggerheads typically cold-stun in
December [Griffin et al. 2019, p. 2].

### Physiological thresholds

The study adopts thresholds drawn from earlier work: "Juvenile sea turtles become cold-stunned as sea surface
temperatures drop to around 10˚C, [12,18,29] with death occurring at temperatures ranging from 5.0–6.5˚C [29]"
[Griffin et al. 2019, p. 2]. The 10˚C onset value fixed one of the six aggregate SST statistics used as
candidate covariates (see Methods and approaches).

### Temperature signal

Warmer late-autumn water predicted more strandings, not fewer. "Annual Kemp's ridley cold-stunning events were
more likely to be higher when the corresponding late fall SSTs were warmer (Fig 4, minimum of daily mean SSTs,
posterior mean = 1.23; 95% Credible Intervals (CI) = 1.04, 1.41])" [Griffin et al. 2019, p. 7]. The covariate is
the minimum of daily mean SSTs over an optimal window from late October through early November [Griffin et al.
2019, p. 7]. The authors interpret warmer water as having "modified the northerly distribution of Kemp's
ridleys" and as acting "as an ecological bridge between the Gulf Stream and nearshore waters" [Griffin et al.
2019, p. 1]. Gulf of Maine SSTs, citing Pershing et al. (2015), "are warming 99% faster than the global ocean"
over the last decade [Griffin et al. 2019, p. 10].

### Hatchling abundance

Hatchling releases from the Tamaulipas index beaches in Mexico ranked as the second most important variable in
the random forest screen [Griffin et al. 2019, p. 7], yet carried no clear effect in the count model (posterior
mean = -0.02; 95% CI = -0.3, 0.25) [Griffin et al. 2019, p. 7]. The authors propose that the relationship "was
dampened due to variable hatchling survival (based on surface circulation patterns near nesting beaches) and due
to the variable probability of turtles moving from the western Gulf of Mexico nesting beaches into the Atlantic"
[Griffin et al. 2019, p. 9].

### Climate windows

Sliding-window analysis assigned the six SST statistics to three seasonal windows [Griffin et al. 2019, p. 7]:

- late June through early August for the number of days with daily mean SST above 20˚C;
- early August through the first half of October for the mean, maximum, and standard deviation of daily mean
  SSTs;
- late October through early November for the minimum of daily mean SSTs, and late November through early
  December for the number of days with daily mean SST below 10˚C.

Only the late October to early November minimum entered the final model.

### Model comparison

The full count model with both SST and hatchlings, each with measurement error, had a Deviance Information
Criterion (DIC) of 341.22 [Griffin et al. 2019, p. 7]. Hatchlings alone gave a DIC of 380.55, and SST alone gave
339.41 [Griffin et al. 2019, p. 7]. The SST-only model therefore fitted best, and models without SST fitted far
worse.

### 2031 forecast

Forecasting 15 years beyond the study period, "the posterior mean predicted Kemp's ridleys cold-stunning count
was 2,349 (95% CI = 1,328, 3,933)" by 2031 [Griffin et al. 2019, p. 8]. Predicted minimum SSTs for the forecast
years averaged 17.36 ± 0.40˚C (mean ± SD) [Griffin et al. 2019, p. 8]. The interval is wide; its lower bound
still exceeds the 2014 record count of 1,188 [Griffin et al. 2019, pp. 8, 10].

### Population share

Scaled against 2012 female population estimates from Gallaway et al. (2016) of 32,060, 23,057, and 22,918 at
ages two, three, and four, with female sex ratios of 0.65 and 0.74 for in situ and protected nests [Griffin et
al. 2019, p. 6], the 2031 forecast equals "approximately 1.8% of the juveniles (age classes two, three, and
four)" [Griffin et al. 2019, p. 8]. This calculation "assumes the population estimate of 2012 remains the same
until 2031" [Griffin et al. 2019, p. 6].

### Outlier years

Three years, 1999, 2002, and 2014, were not fully explained by the model [Griffin et al. 2019, p. 10]. For 2014,
the authors suggest that Hurricane Arthur, "an unusually early and severe hurricane to hit the northeast U.S."
in early July, may have contributed to the high count [Griffin et al. 2019, pp. 10–11].

### Response planning

The management case rests on planning capacity rather than population viability. The authors state that "It is
challenging to predict large-scale cold-stunning events, making it difficult to adequately plan and budget for
federal, state, and non-governmental organizations to mobilize their recovery efforts" [Griffin et al. 2019, p.
2]. Their conclusion is direct: "managers need to be prepared for increasing numbers of Kemp's ridley cold-stun
strandings to occur" [Griffin et al. 2019, p. 11]. Although the projected loss is under 2% of juveniles in age
classes two to four [Griffin et al. 2019, p. 11], the authors "recommend that all conservation efforts,
including the rehabilitation of cold-stunned Kemp's ridleys, be continued for this critically endangered
species" [Griffin et al. 2019, p. 11]. For responders, the practical reading is that an SST index available
before the stranding season gives an early signal of a heavy year, and that annual counts in the low thousands
are within the forecast range for the early 2030s.

## Methods and approaches

### Response data

Annual counts of stranded Kemp's ridleys from 1982 to 2016 came from the Sea Turtle Stranding and Salvage
Network, which has monitored Cape Cod Bay beaches since 1979 [Griffin et al. 2019, p. 3]. Years before 1982 were
omitted for lack of SST data [Griffin et al. 2019, p. 3]. Detection was treated as near complete: "With
stranding responders monitoring all potential stranding beaches from October-January, we assumed a high
probability of locating all stranded turtles for any given year" [Griffin et al. 2019, p. 3]. The series
contained n = 35 count years [Griffin et al. 2019, p. 5].

### Covariates

Temperature came from the NOAA Optimal Interpolation Sea Surface Temperature product, averaged daily over a
study area of nearly 50,000 km² spanning Cape Cod Bay, the Gulf of Maine, and part of Georges Bank; the grid is
printed as "25 x 25-degree grids" [Griffin et al. 2019, p. 3]. Six aggregate statistics were computed: mean,
maximum, minimum, standard deviation of daily mean SSTs, days below 10˚C, and days above 20˚C [Griffin et al.
2019, p. 3]. The 10˚C threshold reflects cold-stun onset, and the 20˚C threshold was "chosen to capture periods
of uncharacteristically warm SSTs" [Griffin et al. 2019, p. 3]. Atmospheric covariates were the June to
September sum of monthly North Atlantic Oscillation indices, lagged two years, and annual unsmoothed Atlantic
Multidecadal Oscillation indices lagged 1, 2, and 3 years [Griffin et al. 2019, p. 3]. Hatchling releases from
Rancho Nuevo, Playa Dos-Barra Del Tordo, and Barra Ostionales-Tepehuajes were lagged and averaged over 2, 3, and
4 years [Griffin et al. 2019, p. 3]. In total, 11 explanatory variables entered the first random forest run
[Griffin et al. 2019, p. 5].

### Window selection

Optimal climate windows for each SST statistic were chosen with the `slidingwin` function in the `climwin`
package, ranked by Akaike information criterion [Griffin et al. 2019, pp. 4–5]. Optimal days were collapsed to
half-months: days 1 to 14 counted as the early half and later days as the late half [Griffin et al. 2019, p. 5].

### Variable screening

Random forests (`randomForest` package) were fitted with 2,000 trees, although about 500 were sufficient for
stability [Griffin et al. 2019, p. 5]. Collinear SST variables with the lowest mean decrease in accuracy were
removed, and the model was rerun on the non-collinear set (minimum and standard deviation of daily mean SSTs,
days below 10˚C, and days above 20˚C) [Griffin et al. 2019, p. 5]. Because of the short series, only the top two
variables were carried into the count model [Griffin et al. 2019, p. 5].

### Count model

Counts were modelled with a negative binomial distribution using approximate Bayesian inference in the `INLA`
package [Griffin et al. 2019, p. 5]. Credible intervals were the 0.025 and 0.975 posterior quantiles [Griffin et
al. 2019, p. 5]. Covariate measurement error was carried through informative priors. Minimum SST received "a
heteroscedastic error structure (i.e., error changes from observation to observation)" derived from the
product's own error (mean ± SD = 0.19 ± 0.02˚C) [Griffin et al. 2019, pp. 5–6]. Hatchling error was set from the
standard deviation of the last 10 years of releases, used because "the trend appears to asymptote during this
period" [Griffin et al. 2019, p. 6]. Year was excluded as a covariate for high collinearity, assessed by
variance inflation factors [Griffin et al. 2019, p. 6]. Backwards stepwise selection used DIC [Griffin et al.
2019, p. 6]. All analyses ran in R version 3.4.2 [Griffin et al. 2019, p. 4].

### Diagnostics

First-order autoregressive and first- and second-order random walk structures were tested for temporal
autocorrelation, but "all autocorrelation structures led the model to over fit the data" and were dropped
[Griffin et al. 2019, p. 6]. The overdispersion statistic was 1.02, supporting the negative binomial [Griffin et
al. 2019, p. 8]. Minor negative autocorrelation at lag two remained in the residuals [Griffin et al. 2019, p.
8]. Residuals were plotted against fitted values and against each covariate in and out of the model [Griffin et
al. 2019, p. 6]. Observed values fell "heavily outside the final model's 95% CI", although the fitted trend
tracked the observed trend [Griffin et al. 2019, p. 8].

### Forecasting

Future SSTs were projected from the slope of the observed minimum SSTs and an intercept from their mean over the
last 15 years, generating 15 years of predicted values with a measurement error of 0.5 [Griffin et al. 2019, pp.
6, 8]. These came from the study area's own record "rather than from global climate models that have multiple
climatic scenarios" [Griffin et al. 2019, p. 6].

## Open questions

- The single SST covariate "likely acts as a proxy" for eddies, currents, and thermoclines that operate across
  scales; resolving those processes may improve prediction [Griffin et al. 2019, p. 9].
- Anomalous hurricanes could not be assessed but are proposed as predictors [Griffin et al. 2019, p. 11].
- The timing of Kemp's ridley immigration into and emigration out of northeastern U.S. coastal waters is unknown
  [Griffin et al. 2019, p. 11].
- Whether juveniles on the Atlantic coast return to the Gulf of Mexico to breed is unresolved, which limits
  inference on the population consequence of cold-stun losses [Griffin et al. 2019, p. 11].
- The linear SST projection and the fixed 2012 population estimate are strong assumptions; forecasts driven by
  climate-model scenarios and updated abundance would test the 2031 figure.

## Connections

- **Related to:** [[vessel-strike-risk-from-ais-data]]. Both articles concern anthropogenic pressure on sea
  turtles and other megafauna; cold-stunning is a climate-mediated stressor rather than a direct human
  interaction, but rehabilitated turtles re-enter waters where vessel exposure applies.
- **Method link:** [[integrated-sdm-with-inla-spde]]. The cold-stun count model uses the same `INLA` machinery,
  here without a spatial field, and shows how measurement-error priors can be added to covariates.
- **Method link:** [[hurdle-brt-habitat-suitability]]. Machine-learning screening before a parametric model is
  shared ground; the cold-stun study used random forests only to rank variables, not to predict.
- **Pattern:** range shifts under warming. Warmer water drawing turtles farther north is a distribution question
  that a future species distribution modelling article on sea turtle range shifts would address.

## Sources

- **Griffin et al. 2019.** Griffin LP, Griffin CR, Finn JT, Prescott RL, Faherty M, Still BM, Danylchuk AJ.
  "Warming seas increase cold-stunning events for Kemp's ridley sea turtles in the northwest Atlantic." *PLoS
  ONE* 14(1): e0211503. DOI: 10.1371/journal.pone.0211503. Page 2 (stranding history and thresholds); page 3
  (data and covariates); pages 4–6 (model structure and forecasting method); pages 7–8 (results and forecast);
  pages 9–11 (interpretation, limitations, and recommendations).

Extraction: [Griffin_2019_KempsRidleyColdStun.md](../raw/Griffin_2019_KempsRidleyColdStun.md)