---
topic: stable-isotopes-and-trophic-ecology
domain: "Methods: trophic and biochemical inference"
description: Stable isotope analysis (SIA) and trophic-ecology inference for marine and estuarine fishes. Covers bulk δ13C / δ15N / δ34S, mixing models (MixSIAR / simmr), trophic position estimation, isoscapes, ontogenetic diet shifts, compound-specific SIA, and integration with telemetry and diet (gut content, fecal eDNA) data.
last_updated: 2026-11-25
article_count: 2
ingested_sources: 1
owner: stable-isotope-and-trophic-ecology-specialist
co_owners: []
---

# Stable isotope ecology

## Topic overview

A recurring workstream in the Griffin Lab: stable-isotope analysis (SIA) to infer diet,
trophic position, habitat origin, and population / contingent structure in marine fishes.
Active projects span ontogenetic isotope shifts in Atlantic tarpon (SIA_tarpon_ontogenetic_shifts),
lizardfish isoscapes, adult tarpon fecal diet analyses, and a published integration of
telemetry + SIA for resource ecology (Griffin et al. 2022, *Journal of Applied Ecology*).

Scope covers the bulk-SIA workflow (sample prep through interpretation), Bayesian mixing
models, trophic-position estimation, isoscape construction, and the integration of SIA
evidence with telemetry, gut content, and fecal eDNA. Does not cover otolith
microchemistry (different sub-discipline) or compound-specific stable isotope methods at
implementation depth (cite the relevant CSIA literature; the lab's CSIA work is
collaborative).

## Key concepts

- **Bulk SIA**. Per-sample δ13C, δ15N, (sometimes) δ34S values, integrated over the
  tissue's turnover window. Tissue-specific (plasma: weeks; muscle: months; otolith
  organic matrix: lifetime).
- **Trophic discrimination factors (TDF)**. Per-trophic-step isotopic enrichment used to
  back-calculate sources and trophic position; typically ~1 ‰ for δ13C and ~3.4 ‰ for
  δ15N per trophic level, but with species- and tissue-specific variation.
- **Mixing models**. Bayesian inference for source-contribution proportions to a
  consumer's tissue, given source isotope values and TDFs. The lab's default is
  `MixSIAR`; `simmr` and `IsotopeR` are alternatives.
- **Trophic position (Post 2002)**. Estimating consumer trophic position from δ15N with
  a baseline correction (using a primary consumer as the baseline anchor) to control for
  spatial and temporal variation in δ15N at the base of the food web.
- **Isoscape**. Spatial gradient of isotope baseline values; allows assignment of
  individuals to feeding or natal regions. δ13C and δ34S are spatial in marine systems;
  δ2H and δ18O dominate in freshwater.
- **Lipid effects**. Lipids are δ13C-depleted; lipid-rich samples bias δ13C toward more
  negative values. Standard mitigation: lipid extraction or mathematical correction
  (Logan et al. 2008; Post et al. 2007).
- **Ontogenetic diet shifts**. Body-size-structured isotope variation reflecting prey
  switching, habitat change, or trophic-position change over the life history.

## Articles in this topic

| Article | Summary |
|---|---|
| [bayesian-mixing-models-for-marine-diet](articles/bayesian-mixing-models-for-marine-diet.md) | Bayesian mixing models (MixSIAR) for diet source contributions in marine fishes |
| [isoscape-assignment-of-foraging-areas](articles/isoscape-assignment-of-foraging-areas.md) | Lizardfish-baseline δ13C and δ15N isoscapes fitted in INLA and used to assign tarpon fin and plasma to foraging areas within telemetry-constrained search areas |

## Ingested sources (`raw/`)

| Source | Status | Headline finding |
|---|---|---|
| [Griffin_2026_TarponForagingLandscapes](raw/Griffin_2026_TarponForagingLandscapes.md) | validated (correction to the fin adjustment in preparation) | Assignment of 417 tarpon with 85 tracked; discrete foraging regions support large-scale migrations; northern Gulf captures assign to the northern Gulf across the sensitivity grid |

## Cross-references to other topics

- **movement-ecology-analysis**: SIA can corroborate or contradict telemetry-derived
  residency patterns (the "telemetry-isotope mismatch").
- **acoustic-telemetry-methods**: paired SIA + acoustic detection on the same individuals
  is a high-value research design for the lab.
- **catch-and-release-survival**: stress proxies (cortisol, blood lactate) are
  occasionally measured alongside SIA on captured fish; physiological data sit alongside
  but are distinct from isotope inference.

## Bibliography pointers

`raw/`: per-source structured summaries.

Foundational references:

- **Post 2002**, *Ecology* 83: 703-718. "Using stable isotopes to estimate trophic
  position: models, methods, and assumptions." The standard trophic-position framework.
- **Stock and Semmens 2016**, *Ecology* 97: 2562-2569. "Unifying error structures in
  commonly used biotracer mixing models." MixSIAR methodological reference.
- **Logan et al. 2008**, *Journal of Animal Ecology* 77: 838-846. "Lipid corrections in
  carbon and nitrogen stable isotope analyses: comparison of chemical extraction and
  modelling methods." Lipid-correction reference.
- **Hussey et al. 2014**, *Ecology Letters* 17: 239-250. "Rescaling the trophic structure
  of marine food webs." Elasmobranch-specific TDF and trophic structure.
- **Sweeting et al. 2007**, *Journal of Experimental Marine Biology and Ecology* 340:
  1-10. "Effects of body size and environment on diet-tissue δ15N fractionation in
  fishes." Marine-fish TDF.
- **Griffin et al. 2022**, *Journal of Applied Ecology* 59: 1869-1881. "Application of
  telemetry and stable isotope analyses to inform the resource ecology and management of
  a marine fish." Lab paper integrating SIA with telemetry.

## Provenance and source-faithfulness

Standard `conventions/research.md` rules apply.
