---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida
generated: 2026-05-26
source: inferred from observed practice across cobia_sdm_explore, tarpon_dashboard, SJB-Receiver-Map-App, terrapin_*, BlueShark_ISDM, and related project repos
---

# Code format: Griffin Lab project structure and coding conventions

The lab is R-dominant with selective Python use (e.g., `build_pptx.py` utilities, occasional
Jupyter for data exploration). Code is organised around numbered analysis scripts driven by
a single config file. The conventions below describe the working pattern; deviation is fine
where the project has good reason.

---

## 1. Default project structure

The lab's standard analysis-project layout:

```
project_name/
├── README.md                  # one-page project overview, status, primary contact
├── project_name.Rproj         # RStudio project file (always set the working directory here)
├── renv.lock                  # R environment lockfile (renv-based projects)
├── 00_config.R                # all run parameters; never hardcoded in downstream scripts
├── scripts/                   # numbered analysis scripts (or code/ for larger projects)
│   ├── 00_config.R            # if not at root
│   ├── 01_data_preparation.R
│   ├── 02a_env_data_glorys.R
│   ├── 02b_extract_oisst.R
│   ├── 03a_inla_isdm.R        # or 03_model.R / 03_fit_model.R
│   ├── 03b_brt_models.R
│   ├── 04_projections.R
│   ├── 05_model_comparison.R
│   ├── 06_publication_figures.R
│   └── explore_*.R            # exploratory scripts (not part of the production pipeline)
├── data/
│   ├── raw/                   # immutable, never modified after deposit; gitignored
│   ├── processed/             # outputs of cleaning and joining; gitignored
│   └── external/              # third-party reference data (climate rasters, range maps)
├── outputs/                   # rendered artefacts, model objects, tables, figures
│   ├── tables/
│   ├── figures/
│   └── models/                # serialised model objects with version pinning
├── manuscript/                # for repos that also hold the writing
└── .gitignore
```

Shiny app projects (e.g., `SJB-Receiver-Map-App`, `tarpon_dashboard/*_app/`) collapse to a
flat `app.R` + `data/` + `rsconnect/` structure with a top-level `README.md`. Deployment is
via `Rscript -e "rsconnect::deployApp()"` from the repo root.

`data/raw/` and `data/processed/` are gitignored. A `data/raw/MANIFEST.md` (or equivalent
README) lists expected files and their sources.

---

## 2. Naming conventions

- **Files**: `snake_case.R`. Numbered pipeline scripts: `NN_short_descriptor.R` (e.g.,
  `01_data_preparation.R`). Sub-steps use a letter suffix: `02a_*.R`, `02b_*.R`.
- **Figure scripts** (when separated): `fig_NN_short_descriptor.R`.
- **Variables**: `snake_case`. Existing dot-naming (`my.data`) in older code is grandfathered;
  new code uses snake_case.
- **Constants** and config keys: `UPPER_SNAKE_CASE` (e.g., `OISST_START_YEAR`,
  `ACTIVE_TIER`, `MESH_MAX_EDGE_INNER`).
- **Functions**: verb-first (`fit_isdm`, `extract_oisst_at_points`, `summarise_detections`).
  Avoid one-letter names except for trivial loop counters.
- **Data frames / tibbles**: suffix with structure where it disambiguates (`captures_df`,
  `sites_df`, `tags_df`, `det_history`).
- **Exploratory / scratch scripts**: prefix `explore_*.R` or `scratch_*.R`; live alongside or
  under an `exploratory/` subfolder.

---

## 3. Version control

- **Repository**: GitHub. Public for published projects; private for in-progress.
- **Branching**: `main` is the publication-ready state. Feature branches for new analyses
  (e.g., `feature/spde-1d-smoothers`, `fix/oisst-date-coercion`). Merge to main via PR after
  review (where collaborators exist) or self-merge after the change is tested.
- **Commit messages**: imperative mood, under 72 characters subject line. Body explains the
  *why* when the change is non-obvious. The lab's recent history (e.g., "Recompute station
  names to match shifted grid", "Shift grid west to cover missing water near A5") is the
  reference pattern.
- **Gitignored** by default: `data/raw/`, `data/processed/`, large geospatial files
  (`*.tif`, `*.gpkg`, large `*.nc`), `.Rproj.user/`, `.Rhistory`, `.RData`, `renv/library/`,
  IDE settings, `.DS_Store`, `rsconnect/` deployment caches that contain user-specific paths.
- **Release tagging**: on a manuscript submission, tag `submission-vN`. At acceptance, tag
  `published-vN`. The published tag's commit hash is the code citation in the manuscript.
- **Credentials**: never commit credentials or API tokens. Use environment variables or local
  config files that are gitignored. Where MARC/CMEMS/Copernicus credentials are needed, load
  them from `~/.Renviron` or a local `.secrets.R` that is gitignored.

---

## 4. Documentation

- **Functions**: roxygen2-style docstrings on any function that is reused across scripts.
  Include parameter types, return type, and one example call where it clarifies use.
- **Scripts**: each script's first 10–20 lines are a header block with: purpose, inputs,
  outputs, dependencies, last-modified date, author. Numbered pipeline scripts also note the
  upstream script that produces their inputs and the downstream script that consumes their
  outputs.
- **Inline comments**: explain *why*, not *what*. Density: one comment per analytical step,
  not per line. Reserve longer comment blocks for explaining a non-obvious choice (e.g.,
  why a specific mesh parameter was chosen, why a particular fit option was needed).
- **README**: every project has a top-level README with the one-page project summary,
  environment setup, how to run the pipeline (`Rscript scripts/01_*.R; Rscript scripts/02_*.R; ...`
  or a single orchestrator), and contact information.
- **Project memory**: where the project benefits from a persistent notebook of lessons
  learned (model-fitting gotchas, package-version issues), keep a `MEMORY.md` or
  `NOTES.md` in the project root; commit it.

---

## 5. Testing

- **Tested**: reusable functions used across more than one script. Statistical wrapper
  functions get test cases with known-answer inputs. Data-cleaning and parsing utilities get
  tests for malformed input (missing dates, duplicate detections, NA-filled rows).
- **Not strictly tested**: one-off analysis scripts, exploratory scripts, figure-rendering
  scripts. These are validated by inspection.
- **Framework**: `testthat`.
- **No mandatory coverage floor.** Add tests where the cost of a silent failure is high
  (e.g., environmental-data extraction, detection-history construction, telemetry
  preprocessing).
- **CI**: GitHub Actions is fine for projects that benefit from it; not required for every
  project.

---

## 6. Dependency management

- **R**: `renv` for projects where a stable environment matters (publication-bound analyses,
  Shiny deployments). `renv.lock` committed. For lightweight exploratory work, system-level
  packages are acceptable.
- **Key packages**:
  - Data: `tidyverse` (default), `data.table` for very large detection tables.
  - Modelling: `glmmTMB`, `lme4`, `brms` for hierarchical models; `INLA` + `inlabru` for SDM
    and spatial-effects work; `unmarked` for occupancy / N-mixture; `gbm` for boosted
    regression trees.
  - Movement / telemetry: `glatos`, `actel`, `momentuHMM`, `crawl`, `move`, `adehabitatHR`.
  - Spatial: `sf`, `terra`, `stars`, `tidyterra`, `ggspatial`.
  - Plotting: `ggplot2`, `patchwork`, `cowplot`, `gganimate`.
  - Reporting: `gt`, `kableExtra`, `flextable`, `quarto` / `rmarkdown`.
- **Python**: limited to where R is impractical (e.g., `python-pptx` for slide-deck
  generation, occasional `xarray` for NetCDF). Manage with `uv` or `venv` + `requirements.txt`.
- **Copernicus / NOAA data**: credentials loaded from `~/.Renviron`, never committed.
- **System libraries**: GDAL / PROJ / GEOS via Homebrew on macOS; containerise via Docker
  when running on cluster.

---

## 7. Performance patterns

- **Vectorise**: prefer vectorised operations (`dplyr`, `data.table`, `purrr::map_*`) over
  `for` loops. Use `for` only when the iteration has side effects (writing files, fitting
  models with very different specifications) or when readability strongly benefits.
- **Parallelise long-running model fits**: `future` + `furrr` with explicit worker counts
  pulled from `00_config.R`, not hardcoded. `brms` and `cmdstanr` use chain-level
  parallelism from their own options.
- **Spatial data**: rasters read with `terra::rast()` and cropped to study-area extent before
  any operation. Avoid loading full global rasters when a study-area subset will do.
- **Anti-patterns**:
  - `rbind()` in a loop (use `dplyr::bind_rows()` on a list).
  - `for (i in seq_along(x)) df[i, ] <- ...` (use `dplyr::mutate()` or `purrr::map_dfr()`).
  - `for (d in unique_dates)` where `unique_dates` is a `Date` vector: R coerces to numeric.
    Iterate by `seq_along()` and subset by index.
  - Reading and overwriting the same raster file: `terra::writeRaster()` will error. Write to
    a temp file, then rename.
  - `rasterize(fun = mean)` silently renames the output to `"mean"`; preserve the original
    layer name explicitly.

---

## 8. Logging and provenance

- **Logging**: `cli` for user-facing messages; `futile.logger` for long-running scripts that
  need a log file. Logs go to `outputs/logs/<script_name>_<timestamp>.log`.
- **Workflow tracking**: long-running multi-step pipelines can be wrapped in `targets` so
  each step is cached, parameterised, and re-runnable. Not required for short pipelines.
- **Run identification**: every run that produces a result records a `run_id` derived from
  the git commit hash plus a UTC timestamp. The run_id appears in output filenames and in
  result-table metadata.
- **Session info**: scripts that produce a result call `sessionInfo()` at the end and write
  the output to the log file (or to a sibling `sessioninfo.txt`). This is critical for
  reproducibility.

---

## 9. Code review conventions

- Code review is informal for solo work; substantive for collaborative manuscripts and any
  Shiny app that will be deployed.
- The `code-review` skill in `skills/simple/code-review/SKILL.md` runs an automated review on
  request.
- Review checklist:
  1. Does the code follow sections 2 through 7 above?
  2. Is the analytical step justified (especially statistical choices)?
  3. Are diagnostics included where relevant (residuals, posterior checks, mesh diagnostics)?
  4. Does the README still accurately describe the project?
  5. Are there hardcoded paths, credentials, or unset random seeds?

---

## 10. Anti-patterns to flag on sight

- Hardcoded absolute paths (`/Users/lucasgriffin/...`); all paths go through `00_config.R`
  or `here::here()`.
- `library()` calls scattered throughout a script; all package loads happen in the script
  header block.
- Modifying `data/raw/` (immutable).
- Reading large rasters without cropping to study area first.
- Stochastic steps (bootstrap, MCMC, cross-validation fold assignment) without a seed in
  `00_config.R`.
- `suppressWarnings()` without a comment explaining why.
- Credentials in code (Copernicus, ERDDAP, AWS, etc.).
- Untracked changes to `renv.lock` (run `renv::snapshot()` and commit the lockfile).
- Pipeline scripts that depend on the previous script's environment in memory rather than on
  written intermediate files; each script should be runnable from a fresh R session.

---

## Cross-references

- Code-implementation skill: `skills/workflows/code-implementation/SKILL.md`
- Code-review skill: `skills/simple/code-review/SKILL.md`
- Figure-rendering conventions: `conventions/figure-format.md`
- Project goal specification (per-project): `conventions/goal-spec.template.md`
- Deployment (Shiny apps): `Rscript -e "rsconnect::deployApp()"` from the repo root
