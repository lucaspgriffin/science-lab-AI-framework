---
title: "Bayesian mixing models for marine diet inference (MixSIAR workflow)"
slug: bayesian-mixing-models-for-marine-diet
domain: "Methods: trophic and biochemical inference"
aliases: ["MixSIAR", "isotope mixing model", "diet contribution"]
related: [trophic-position-estimation, ontogenetic-diet-shifts, isoscapes]
sources:
  - raw/Stock_Semmens_2016_MixSIAR.md
  - raw/Phillips_2014_BestPractices.md
  - raw/Post_2002_TrophicPosition.md
status: stub
origin: manual
last_updated: 2026-05-26
---

# Bayesian mixing models for marine diet inference (MixSIAR workflow)

> **Stub article.** Replace with verbatim extractions via `agents/literature-extractor.md`;
> verify via `agents/extraction-validator.md`.

## Summary

Bayesian mixing models estimate the proportional contribution of N candidate sources to a
consumer's tissue, given the consumer's measured δ values, the sources' measured δ values,
and trophic discrimination factors (TDFs) that quantify per-trophic-step isotopic
enrichment. `MixSIAR` (Stock and Semmens 2016) is the current standard implementation in
R, providing hierarchical priors, individual-level random effects, and Bayesian
posterior summaries with credible intervals.

## Key points

### Model structure

A two-isotope, three-source bulk-SIA mixing model on muscle tissue takes the form:

```
δ13C_consumer = Σ p_i (δ13C_source_i + TDF_C_i)
δ15N_consumer = Σ p_i (δ15N_source_i + TDF_N_i)
Σ p_i = 1, p_i ≥ 0
```

with the proportions p_i estimated from the posterior. Individual-level and group-level
random effects can be added; informative priors on p_i are supported (e.g., from gut
content or fecal eDNA data).

### TDF selection

TDFs are the single largest source of mixing-model uncertainty. The lab's defaults:

- **Teleosts**: Sweeting et al. 2007 marine-fish TDFs by tissue type, or
  Hussey et al. 2014 for elasmobranchs. [TODO: verbatim TDF values once ingested.]
- **Tissue-specific**: muscle and plasma TDFs differ; never apply a single TDF across
  tissues in one model.
- **Sensitivity**: always run the model across at least two plausible TDF sets and
  report posteriors across both. If results flip, the inference is TDF-limited.

### Source selection and aggregation

- Sources should be **distinct** in isotope space (overlapping sources are
  unidentifiable).
- Aggregation should match the question. If the question is "did this fish eat seagrass
  or mangrove?", do not aggregate seagrass + mangrove into a single "primary producer"
  source.
- Source values should include their measurement variation (mean ± SD).

### Convergence diagnostics

- **Gelman-Rubin (Rhat) < 1.05** for all parameters.
- **Effective sample size** ≥ 500 per parameter.
- **Trace plots** show good mixing (no monotonic trend, no flat regions).
- **Posterior-predictive checks** confirm that simulated consumer δ values from the
  posterior overlap the observed consumer δ values.

If any diagnostic fails, lengthen the chains or simplify the model (fewer sources, fewer
random effects).

### Common pitfalls

- Running the model with poorly characterised sources (high SD or known seasonal
  variation) and not propagating that uncertainty.
- Reporting median posterior contributions without credible intervals.
- Including baseline-uncorrected δ15N values in a model spanning a strong baseline
  gradient.
- Pooling samples across tissues with different turnover windows.

## Methods and approaches

The lab's default sequence:

1. Prepare samples following standard protocols (rinse, freeze-dry, lipid-extract for
   tissues with C:N > 3.5, grind, weigh into tin cups).
2. Run isotopes on a continuous-flow IRMS at the [TODO: name the lab's working facility]
   facility; verify standards alignment with international reference materials (VPDB,
   AIR).
3. Compile source library (sample size ≥ 5 per source per season where possible);
   characterise mean and SD per isotope.
4. Choose TDFs with explicit citation; pre-register one or two plausible alternatives
   for sensitivity analysis.
5. Run `MixSIAR` with informative priors where available; use uninformative Dirichlet
   priors otherwise.
6. Inspect convergence; rerun with longer chains if needed.
7. Report median, 95% credible interval, and (where the inference depends on it) the
   posterior across alternative TDF sets.

## Open questions

- The performance of MixSIAR when source library is sparse and overlapping is not well
  characterised.
- Best practice for combining bulk-SIA mixing models with gut-content or fecal-eDNA
  prior information remains an active methodological area.
- Compound-specific SIA (CSIA-AA) provides baseline-independent trophic-position
  estimates and is increasingly available; its integration with bulk-SIA mixing models
  is under-explored in the marine literature.

## Connections

- **Related to**: [[trophic-position-estimation]], [[ontogenetic-diet-shifts]].
- **Depends on**: well-characterised source library and defensible TDF selection.
- **Informs**: diet inference, contingent / population structure, habitat-use claims
  from SIA.

## Sources

- **Stock and Semmens 2016.** "Unifying error structures in commonly used biotracer
  mixing models." *Ecology* 97: 2562-2569. DOI: 10.1002/ecy.1517. [TODO: ingest.]
- **Phillips et al. 2014.** "Best practices for use of stable isotope mixing models in
  food-web studies." *Canadian Journal of Zoology* 92: 823-835.
  DOI: 10.1139/cjz-2014-0127. [TODO: ingest.]
- **Post 2002.** "Using stable isotopes to estimate trophic position: models, methods,
  and assumptions." *Ecology* 83: 703-718. DOI: 10.1890/0012-9658(2002)083[0703:USITET]2.0.CO;2.
  [TODO: ingest.]

## Template usage notes

Stub article; promote to `draft` after verbatim extractions; to `published` after
`extraction-validator` confirms claim-citation alignment.
