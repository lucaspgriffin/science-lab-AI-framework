---
name: code-writing
description: |
  Produces well-structured analysis scripts (R or Python) following the lab's coding conventions, with embedded diagnostics and inline output at every stage. Use this skill when the user mentions: implementing an analysis, writing code for a model, building analysis scripts, coding the analysis, fitting a model, or producing scripts from a plan. Also trigger when an analysis plan exists and the user wants to move to code. The skill follows a nine-phase sequence from data inspection through model fitting, diagnostics, predictions, sensitivity, and reporting. All scripts follow conventions from `conventions/code-format.template.md` with section headers, inline output, and numbered sequential files. Works standalone or as the second step in the analysis-pipeline.
cost: medium
---

# Code Writing Skill

Produces numbered analysis scripts following the lab's conventions with embedded diagnostics, inline output, and systematic progression from data inspection through publication-ready outputs.


## Required references: load before any work

For code structure and figure/table conventions:
- `conventions/code-format.template.md`
- `conventions/figure-format.template.md` (when producing figures or tables)

For any literature research, citations, or source handling:
- `conventions/research.md`

These are non-negotiable. Load them before substantive work.

---
## Overview

This skill follows a nine-phase implementation sequence:
0. **Phase 0**: Data inspection: load and summarize raw data
1. **Phase 1**: Data cleaning & preprocessing: filter, QC, feature engineering
2. **Phase 2**: Exploratory visualization: response vs predictors, collinearity
3. **Phase 3**: Model fitting: primary model per plan
4. **Phase 4**: Diagnostic checks: gam.check, k.check, DHARMa, autocorrelation
5. **Phase 5**: Model comparison: fit alternatives, AIC/ANOVA table
6. **Phase 6**: Predictions & figures: prediction grids, publication plots
7. **Phase 7**: Sensitivity analysis: robustness tests per plan
8. **Phase 8**: Output & reporting: save objects, results summary, manuscript-ready text

Each phase produces or extends scripts. Diagnostics are embedded at each step, not deferred.

---

## Before You Begin

**Required reading:**
- `conventions/code-format.template.md`: section headers (`# ---- Name ----`), inline output conventions, project structure

**Check for an analysis plan:**
- If `[name]_analysis_plan.md` exists (from analysis-planning), read it and follow its specifications for model type, random effects, diagnostics, and sensitivity tests
- If `[name]_diagnostics_checklist.md` exists, use it as the diagnostic specification
- If no plan exists, work from the user's description but note that planning first is recommended

**Check for any domain extensions** the lab maintains: they typically include domain-specific data cleaning patterns, diagnostic checks, and code snippets.

---

## Language Choice

This skill works for both R and Python projects. Examples below use R (with `mgcv`, `tidyverse`, `DHARMa`) for concreteness; substitute the appropriate library when the project is in Python (e.g., `pandas`, `scikit-learn`, `statsmodels`, `pymc`). The conventions (section headers, inline output, numbered scripts, project structure) apply equally to both languages.

---

## Project Structure

Before writing any code, ensure the project directory structure exists:

```
project/
├── data/
│   ├── raw/           # Original data files (never modified)
│   └── processed/     # Cleaned data outputs
├── R/  or  src/       # Analysis scripts (numbered)
├── output/
│   ├── figures/       # All plots (diagnostic + publication)
│   ├── tables/        # Results tables, comparison tables
│   └── models/        # Saved model objects (.rds, .pkl)
└── [name]_code_summary.md   # Results narrative
```

Create this structure at the start. All file paths in scripts must be relative.

---

## Phase 0: Data Inspection

### Objective
Load the raw data and present a comprehensive summary so the user can confirm the data are as expected.

### Script: `R/01_data_cleaning.R` (first section)

```r
# ---- Load Packages ----
library(tidyverse)
library(mgcv)
# [additional packages as needed]

# ---- Load Raw Data ----
dat_raw <- read_csv("data/raw/[filename].csv")

nrow(dat_raw)
ncol(dat_raw)
names(dat_raw)

# ---- Data Overview ----
str(dat_raw)
summary(dat_raw)

# Key variables
length(unique(dat_raw$[id_variable]))  # unique subjects/sites
range(dat_raw$[date_variable])         # temporal extent
table(dat_raw$[grouping_variable])     # sample sizes by group

# Check for missing values
colSums(is.na(dat_raw))

# Response variable distribution
hist(dat_raw$[response], main = "Response variable distribution")
table(dat_raw$[response] == 0)  # zeros (if relevant)
```

### Key Convention
Every `nrow()`, `length(unique())`, and `table()` call serves as inline output: when the script runs, these values print to the console. This makes the script self-documenting. Equivalent: `df.shape`, `df.nunique()`, `df.value_counts()` in pandas.

### USER CHECKPOINT
Present the data summary. Confirm the data look correct before proceeding.

---

## Phase 1: Data Cleaning & Preprocessing

### Objective
Filter, QC, and prepare the analysis-ready dataset. Print what happened at every step.

### Script: `R/01_data_cleaning.R` (continued)

### Mandatory Pattern: Track Rows at Every Step

```r
# ---- Filter Study Period ----
dat <- dat_raw %>%
  filter(date >= study_start & date <= study_end)
nrow(dat)
cat("Retained", round(nrow(dat)/nrow(dat_raw)*100, 1), "% after date filter\n")

# ---- Remove [criteria] ----
dat <- dat %>%
  filter([criteria])
nrow(dat)
cat("Retained", round(nrow(dat)/nrow(dat_raw)*100, 1), "% after [criteria] filter\n")

# ---- Feature Engineering ----
dat <- dat %>%
  mutate(
    [new_variable] = [calculation],
    [factor_variable] = factor([variable], levels = [levels])
  )

# Verify new variables
summary(dat$[new_variable])
table(dat$[factor_variable])
```

### Domain-Specific Cleaning
If a domain extension applies, integrate its cleaning patterns (lab-specific): e.g., independent-detection thresholding for camera-trap data (typically 30 minutes between consecutive same-species detections at a station), capture-event aggregation for mark-recapture data, observer-effect filtering for vegetation transects.

### Output
- `data/processed/[name]_analysis_ready.csv`: The clean dataset
- Print final summary: nrow, unique IDs, variables included

```r
# ---- Save Cleaned Data ----
write_csv(dat, "data/processed/[name]_analysis_ready.csv")
cat("\nFinal dataset:", nrow(dat), "observations,",
    length(unique(dat$[id])), "individuals\n")
```

---

## Phase 2: Exploratory Visualization

### Objective
Visualize response vs predictors, check for outliers, collinearity, and grouping patterns.

### Script: `R/02_exploration.R`

```r
# ---- Load Cleaned Data ----
dat <- read_csv("data/processed/[name]_analysis_ready.csv")
nrow(dat)

# ---- Response Distribution ----
# [histogram, density plot, or barplot depending on type]
# For proportions with zeros:
hist(dat$[response], breaks = 50, main = "Response distribution")
cat("Zeros:", sum(dat$[response] == 0), "/", nrow(dat),
    "(", round(sum(dat$[response] == 0)/nrow(dat)*100, 1), "%)\n")

# ---- Response vs Predictors ----
# Continuous predictors: scatterplots with LOESS
# Categorical predictors: boxplots
# For each key predictor, create an informative plot

# ---- Collinearity Check ----
# For continuous predictors
cor_matrix <- cor(dat[, c("[pred1]", "[pred2]", "[pred3]")], use = "complete.obs")
print(round(cor_matrix, 2))
# Flag any |r| > 0.7

# ---- Group-Level Patterns ----
# Sample sizes by group
dat %>%
  group_by([grouping_var]) %>%
  summarise(n = n(), mean_response = mean([response]), .groups = "drop") %>%
  print()

# ---- Save Exploration Figures ----
# [save to output/figures/01_exploration.png or similar]
```

### What to Flag
- Predictors with |r| > 0.7: discuss concurvity risk
- Groups with very small sample sizes: may need pooling
- Outliers in response or predictors: discuss with user
- Non-linear patterns: inform smooth specifications

---

## Phase 3: Model Fitting

### Objective
Fit the primary model as specified in the analysis plan.

### Script: `R/03_models.R`

```r
# ---- Load Data ----
dat <- read_csv("data/processed/[name]_analysis_ready.csv")
nrow(dat)

# ---- Primary Model: [name/description] ----
# [Model specification from analysis plan]
# Example for a hurdle GAM:

## Part 1: Presence/absence
m1_pa <- bam(present ~ s(predictor1, k = 20) + s(predictor2) +
               s(subject_id, bs = "re"),
             family = binomial, data = dat, discrete = TRUE)
summary(m1_pa)

## Part 2: Intensity given presence
m1_int <- bam(response ~ s(predictor1, k = 20) + s(predictor2) +
                s(subject_id, bs = "re"),
              family = betar(), data = dat_pos, discrete = TRUE)
summary(m1_int)
```

### Inline Output Standard
After every model fit, always print:
- `summary(model)`: coefficients, deviance explained, smooths table
- Number of observations used
- Any warnings during fitting

### When bam() vs gam()
- Use `bam()` with `discrete = TRUE` when n > ~10,000
- Use `gam()` for smaller datasets
- Document the choice in a comment

---

## Phase 4: Diagnostic Checks

### Objective
Run all diagnostics from the checklist. Save diagnostic plots. Flag issues with remediation hints.

### Script: `R/03_models.R` (continued, immediately after model fitting)

```r
# ---- Diagnostics: [model name] ----

## gam.check: residual plots and basis adequacy
par(mfrow = c(2, 2))
gam.check(m1_pa)
# Save diagnostic plot
png("output/figures/02_diagnostics_m1_pa.png", width = 10, height = 8, units = "in", res = 300)
par(mfrow = c(2, 2))
gam.check(m1_pa)
dev.off()

## k.check: formal basis adequacy test
k.check(m1_pa)
# If any smooth has k' close to edf, increase k

## DHARMa: quantile residual diagnostics
library(DHARMa)
sim <- simulateResiduals(m1_pa)
plot(sim)
png("output/figures/02_diagnostics_m1_pa_dharma.png", width = 10, height = 5, units = "in", res = 300)
plot(sim)
dev.off()
testDispersion(sim)
testZeroInflation(sim)

## Autocorrelation
acf(residuals(m1_pa, type = "deviance"), main = "ACF of deviance residuals")

## Concurvity
concurvity(m1_pa, full = TRUE)
concurvity(m1_pa, full = FALSE)
```

### Diagnostic Decision Tree

After running diagnostics, follow this tree:

1. **k.check flags a smooth**: Increase k by 5 to 10, refit, recheck. Repeat until adequate.
2. **DHARMa shows overdispersion**: Try nb() instead of poisson(), or add observation-level RE
3. **DHARMa shows zero-inflation**: Switch to hurdle model or zero-inflated family
4. **ACF shows significant lags**: Add `rho` parameter to `bam()`, or include temporal smoother
5. **Concurvity > 0.8**: Consider removing or combining correlated smooths
6. **Convergence warnings**: Simplify RE structure, try different optimizer, check for complete separation

Each remediation should be documented inline:
```r
# k.check flagged s(predictor1): increasing k from 10 to 20
# [refit model with increased k]
# k.check now passes
```

---

## Phase 5: Model Comparison

### Objective
Fit alternative models from the plan and compare.

### Script: `R/03_models.R` (continued)

```r
# ---- Alternative Models ----

## Alternative 1: [description]
m_alt1 <- bam([formula], family = [family], data = dat, discrete = TRUE)
summary(m_alt1)

## Alternative 2: [description]
m_alt2 <- bam([formula], family = [family], data = dat, discrete = TRUE)
summary(m_alt2)

# ---- Model Comparison ----
AIC(m1_pa, m_alt1, m_alt2)

# Detailed comparison table
comparison <- data.frame(
  model = c("Primary", "Alt1", "Alt2"),
  AIC = c(AIC(m1_pa), AIC(m_alt1), AIC(m_alt2)),
  dev_explained = c(
    summary(m1_pa)$dev.expl,
    summary(m_alt1)$dev.expl,
    summary(m_alt2)$dev.expl
  )
)
print(comparison)
write_csv(comparison, "output/tables/model_comparison.csv")
```

---

## Phase 6: Predictions & Figures

### Objective
Generate prediction grids and publication-quality figures.

### Script: `R/04_predictions_figures.R`

```r
# ---- Load Models ----
# [or continue from previous script if in same session]

# ---- Prediction Grid ----
newdata <- expand.grid(
  predictor1 = seq(min(dat$predictor1), max(dat$predictor1), length.out = 200),
  predictor2 = mean(dat$predictor2),
  subject_id = dat$subject_id[1]  # representative level for RE
)

# ---- Generate Predictions ----
pred <- predict(m1_pa, newdata = newdata, type = "response",
                se.fit = TRUE, exclude = "s(subject_id)")
newdata$fit <- pred$fit
newdata$se <- pred$se.fit
newdata$lower <- plogis(qlogis(pred$fit) - 1.96 * pred$se.fit)  # back-transform CIs
newdata$upper <- plogis(qlogis(pred$fit) + 1.96 * pred$se.fit)

# ---- Publication Figure ----
# Figure rules: PNG only, no PDF; NO Unicode in labels (use expression()).
# See conventions/code-format.template.md "Critical rules" block for both rules + the
# plotmath reference table.
p <- ggplot(newdata, aes(x = predictor1, y = fit)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2) +
  geom_line(linewidth = 1) +
  labs(x = "Predictor 1 (units)",
       y = "[Response variable]") +
  theme_classic(base_size = 14)

ggsave("output/figures/03_predictions.png", p,
       width = 8, height = 6, dpi = 300)

# ---- Save Prediction Objects ----
saveRDS(newdata, "output/models/predictions_[name].rds")
```

### Figure Standards
- **PNG only** at 300 dpi (no PDF): full rule in `conventions/code-format.template.md` Critical Rules block.
- **No Unicode in labels**: use `expression()` or `bquote()`. Plotmath reference in `conventions/code-format.template.md` Critical Rules block.
- Use `theme_classic()` or `theme_bw()` as base (or equivalent in matplotlib / seaborn).
- Always include axis labels with units.
- Always show uncertainty (ribbons for continuous, error bars for discrete).
- Font size >= 12 pt for readability at publication scale.
- Use `ggsave()` (or `plt.savefig()`) with explicit dimensions.

---

## Phase 7: Sensitivity Analysis

### Objective
Execute robustness tests from the analysis plan's sensitivity design.

### Script: `R/05_sensitivity.R`

```r
# ---- Sensitivity Analysis ----

# ---- Test 1: [threshold name] ----
# Original threshold: [value]
# Testing: [alt value 1], [alt value 2]

## [alt value 1]
dat_sens1 <- dat %>% filter([modified criteria])
nrow(dat_sens1)
cat("[Threshold]:", [alt value 1], ", n =", nrow(dat_sens1), "\n")

m_sens1 <- bam([same formula as primary], data = dat_sens1, discrete = TRUE)
summary(m_sens1)

## [alt value 2]
dat_sens2 <- dat %>% filter([modified criteria])
nrow(dat_sens2)

m_sens2 <- bam([same formula as primary], data = dat_sens2, discrete = TRUE)
summary(m_sens2)

## Compare sensitivity results
sens_comparison <- data.frame(
  threshold = c("Original", "[alt1]", "[alt2]"),
  n = c(nrow(dat), nrow(dat_sens1), nrow(dat_sens2)),
  dev_explained = c(
    summary(m1_pa)$dev.expl,
    summary(m_sens1)$dev.expl,
    summary(m_sens2)$dev.expl
  ),
  # [key effect estimate for comparison]
  key_effect_direction = c("[+/-]", "[+/-]", "[+/-]")
)
print(sens_comparison)
write_csv(sens_comparison, "output/tables/sensitivity_[test_name].csv")
```

### What Constitutes "Sensitive"
- Direction of key effects changes (sign flip): **Results are sensitive**, report prominently
- Effect size changes by >20% but direction holds: **Moderately sensitive**, report and discuss
- No substantial change: **Robust**, report briefly as confirmation

### Optional Sub-agents
For large sensitivity analyses with independent tests, launch parallel sub-agents:
- Each agent runs one sensitivity test independently
- Merge results into a comparison table

---

## Phase 8: Output & Reporting

### Objective
Save all objects, produce final results summary, and write a brief results narrative for manuscript integration.

### Script: `R/03_models.R` or `R/05_sensitivity.R` (final section)

```r
# ---- Save Model Objects ----
saveRDS(m1_pa, "output/models/m1_pa.rds")
saveRDS(m1_int, "output/models/m1_int.rds")

# ---- Results Summary Table ----
results <- data.frame(
  model = "[primary model name]",
  family = "[family]",
  n = nrow(dat),
  n_groups = length(unique(dat$[id])),
  deviance_explained = summary(m1_pa)$dev.expl,
  # [key effects and p-values]
  aic = AIC(m1_pa)
)
write_csv(results, "output/tables/results_summary.csv")

# ---- Session Info ----
sessionInfo()
```

### Results Narrative (`[name]_code_summary.md`)

Write a brief markdown document summarizing key results for manuscript integration:

```markdown
---
analysis_title: "[title]"
model: "[primary model]"
n: [sample size]
date: "[date]"
---

## Key Results

[2-3 paragraphs summarizing main findings, suitable for adaptation into a manuscript results section]

## Model Performance

- Deviance explained: [X%]
- Key effects: [list with direction and significance]

## Sensitivity

[1 paragraph on robustness of results]

## Figures

- `output/figures/03_predictions.png`: [description]
- `output/figures/02_diagnostics.png`: [description]
```

### USER CHECKPOINT
Review code + outputs. Recommend code-review as next step.

---

## Key Principles

1. **Diagnostics at every step, not deferred.** Each model fit is immediately followed by its diagnostic checks. Issues are caught and addressed before building on top of a flawed model.
2. **Inline output is mandatory.** Every major data operation prints what happened. The script is self-documenting when run.
3. **Section headers are navigation.** `# ---- Name ----` headers create an editor outline. Use them for every major step.
4. **Relative paths only.** No absolute paths. The project should work from any location.
5. **Save everything.** Model objects (.rds, .pkl), prediction objects, results tables, diagnostic plots. Don't rely on the session persisting.
6. **Follow the plan.** If an analysis plan exists, implement what it specifies. Document any deviations with justification.
7. **Domain extensions inject patterns.** If the lab maintains a domain extension that applies, use its data cleaning, diagnostic, and code patterns.
8. **Publication figures from the start.** Don't make "quick" plots with the intention to improve later. Build publication-quality figures from the beginning.

---

## Troubleshooting

**Q: The model won't converge.**
A: Try these in order: (1) simplify RE structure, (2) reduce k for smooths, (3) try `bam()` with `discrete = TRUE`, (4) try different optimizer (`optimizer = "efs"`), (5) check for complete separation in binary data, (6) consider whether the model is too complex for the data.

**Q: There's no analysis plan: the user just wants code.**
A: Proceed but note that planning first is recommended. Use a sensible default for the response type and document the reasoning inline in the script comments.

**Q: The data are very large (>1M rows).**
A: Always use `bam()` with `discrete = TRUE` in R, or chunked / dask-backed processing in Python. Cache intermediate results. Print progress indicators for long operations.

**Q: The user wants Python instead of R (or vice versa).**
A: The general conventions still apply (inline output, diagnostic checks, project structure) but the specific libraries differ. Use the appropriate ecosystem (e.g., `statsmodels`, `pymc`, `scikit-learn`, `pyGAM` in Python; `mgcv`, `brms`, `glmmTMB` in R). Follow `conventions/code-format.template.md` for any language-specific guidance.

**Q: Diagnostic checks reveal the model is fundamentally wrong.**
A: Don't patch a broken model. Go back to Phase 3 and try an alternative from the plan. If no alternatives were planned, return to analysis-planning to research better options.
