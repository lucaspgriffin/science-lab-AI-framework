---
topic: fisheries-independent-monitoring
domain: "Methods: detection and survey"
description: Florida Fish and Wildlife Research Institute Fisheries-Independent Monitoring (FIM) program. Covers the estuarine seine and trawl survey and the offshore reef fish video survey, how FIM catches become indices of abundance, their use in stock assessment, and published analyses of FIM data on recruitment, freshwater inflow, red tide, range shifts and forage fish.
last_updated: 2026-11-25
article_count: 7
ingested_sources: 10
owner: fisheries-stock-management-specialist
co_owners: [quantitative-scientist, species-distribution-modelling-specialist]
---

# Fisheries-independent monitoring

## Topic overview

The lab uses FIM data for Tampa Bay forage phenology, Cedar Key and Charlotte Harbor sportfish work, and seatrout and snook questions. This topic holds what the published record says about how the survey works and how its data have been analysed. It covers survey design and its changes over time, gear and size filters, index standardisation, use in stock assessment, and applied analyses built on FIM catches.

It does not cover fishery-dependent data (MRIP, trip tickets) except where an assessment combines them with FIM indices. Habitat suitability models fitted to fishery-independent catches sit in species-distribution-modelling. Telemetry studies of the same species sit in acoustic-telemetry-methods and movement-ecology-analysis.

## Key concepts

- **Stratified-random design.** Each estuary is split into zones, and monthly sites are drawn at random from grid cells within habitat and depth strata, so effort is spread across the estuary and habitats.
- **Standard gears.** A 21.3-m center-bag seine for small fish in shallow water, a 183-m haul seine for larger fish along shorelines, and a 6.1-m otter trawl in deeper water, each with its own depth limit and size selectivity.
- **Delta index.** Annual abundance index built as the product of a binomial occurrence model and a model of positive catches, with covariates for month, zone, habitat and water quality.
- **Design change and continuity.** Added or dropped strata, gears and effort have to be handled in index standardisation, for example by zone as a factor, a split index, or common months.
- **Offshore video survey.** Stereo-baited remote underwater video on mapped hard bottom of the West Florida Shelf, stratified by habitat and depth, with MaxN counts.

## Articles in this topic

| Article | Summary |
|---|---|
| [fim-survey-design](articles/fim-survey-design.md) | How the estuarine FIM survey works: estuaries and start years, the three standard gears, stratified-random design, design changes, and the filters each published analysis applied |
| [juvenile-indices-and-stock-assessment](articles/juvenile-indices-and-stock-assessment.md) | Delta-method young-of-the-year and sub-adult indices, their fit inside the 2020 red drum assessment, and a seatrout index used to explain year-class strength at Cedar Key |
| [freshwater-inflow-and-nekton](articles/freshwater-inflow-and-nekton.md) | River discharge and salinity effects on juvenile seatrout occurrence in Apalachicola Bay, forage fish and sportfish in a Suwannee ecosystem model, and seatrout recruitment at Cedar Key |
| [red-tide-effects-on-estuarine-fish](articles/red-tide-effects-on-estuarine-fish.md) | Karenia brevis effects on sand seatrout spawning in Tampa Bay, with the FIM juvenile trawl series kept apart from the hydrophone survey |
| [snook-range-expansion](articles/snook-range-expansion.md) | Common snook increase at Cedar Key and the Suwannee estuary in FIM catches, fewer cold days, and research needs at the range edge |
| [forage-fish-dynamics](articles/forage-fish-dynamics.md) | Pinfish density, habitat models and synchrony across four Gulf estuaries, forage groups in the Suwannee ecosystem model, and FIM forage fish research priorities |
| [reef-fish-survey-design](articles/reef-fish-survey-design.md) | The offshore reef fish video survey on the West Florida Shelf: habitat mapping, strata from assemblage structure, count models and simulated allocation scenarios |

## Ingested sources (`raw/`)

| Source | Status | Headline finding |
|---|---|---|
| [Schrandt_2024_SurveyDesignChanges](raw/Schrandt_2024_SurveyDesignChanges.md) | validated | Three case studies of changes to the FIM estuarine survey, with before and after effort and guidance on keeping long-term series consistent |
| [FWRI_2023_FIMForageWorkshop](raw/FWRI_2023_FIMForageWorkshop.md) | validated (slide values read from images are approximate) | Program objectives, survey timeline since 1989, data collected and data uses, presented to the Florida Forage Fish Research Program |
| [Addis_2020_RedDrumAssessment](raw/Addis_2020_RedDrumAssessment.md) | validated | Regional red drum assessment fitted to FIM young-of-the-year and sub-adult indices; all four regions neither overfished nor undergoing overfishing, with southeast escapement below the 40% target |
| [Nehemiah_2022_SeatroutYearClass](raw/Nehemiah_2022_SeatroutYearClass.md) | validated | Cedar Key spotted seatrout year-class strength related to environmental factors and adult stock using a FIM seine index |
| [Whaley_2023_SeatroutInflow](raw/Whaley_2023_SeatroutInflow.md) | validated | Juvenile spotted seatrout occurrence in Apalachicola Bay depends on inflow lags and seascape context, differently by size class |
| [Sinnickson_2021_RiverDischargeEwE](raw/Sinnickson_2021_RiverDischargeEwE.md) | validated | Ecopath with Ecosim model of the Suwannee estuary built and fitted with FIM data; short-term dry scenarios reduce forage fish by 17% and sportfish by 14% |
| [Faletti_2019_PinfishDynamics](raw/Faletti_2019_PinfishDynamics.md) | validated | Pinfish density and biomass from the 21.3-m seine in four Gulf estuaries, 1998 to 2016, with habitat models and among-estuary synchrony |
| [Purtlebaugh_2020_SnookExpansion](raw/Purtlebaugh_2020_SnookExpansion.md) | validated | 625 common snook in Suwannee and Cedar Key FIM catches, rising steeply from 2016 to 2018 as cold days declined |
| [Walters_2013_RedTideSandSeatrout](raw/Walters_2013_RedTideSandSeatrout.md) | validated | During the 2005 red tide, sand seatrout spawning aggregations declined sharply in the exposed lower bay and rose in the unaffected upper bay; FIM juvenile river trawl catches were low from 2005 to 2008 |
| [Switzer_2023_ReefFishSurveyDesign](raw/Switzer_2023_ReefFishSurveyDesign.md) | validated | Assemblage structure and habitat mapping used to define strata for the multispecies reef fish video survey on the West Florida Shelf |

## Cross-references to other topics

- **species-distribution-modelling**: hurdle boosted regression trees for zero-inflated fishery-independent catches apply directly to FIM seine and trawl data.
- **marine-traffic-and-anthropogenic-impacts**: cold-stunning work shares the cold-event framing used for snook in FIM data.
- **catch-and-release-survival**: flats habitat management and recreational fishery status connect to FIM sportfish indices.
- **acoustic-telemetry-methods** and **movement-ecology-analysis**: telemetry of snook, tarpon and red drum complements FIM indices with individual movement.

## Bibliography pointers

`raw/`: per-source structured extractions. Further open-access FIM papers listed by FWRI that are not yet ingested: Stevens et al. 2016 (Ecosphere, snook cold event), Peake et al. 2022 (Ecosphere, forage fish communities), Schrandt et al. 2021 (Ecological Indicators, Tampa Bay nekton index), Lewis et al. 2021 (Ecological Indicators, community shifts after disturbance), Schrandt et al. 2021 (Fisheries Research, juvenile reef fish recruitment design), Switzer et al. 2020 and 2015, Christiansen et al. 2020, Hart et al. 2021 (Marine and Coastal Fisheries), and Troast et al. 2020 (Diversity and Distributions).

## Provenance and source-faithfulness

Standard `conventions/research.md` rules apply.
