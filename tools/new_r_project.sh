#!/usr/bin/env bash
# Scaffold an R analysis project the lab's way (griffin-r-coding, conventions/code-format.md).
#
# Usage:  bash tools/new_r_project.sh project_name [parent_dir]
# Default parent is ~/github. Creates the folder layout, an .Rproj, a terse README,
# a .gitignore, scripts/00_setup.R, data/raw/MANIFEST.md, and a first commit.
# Nothing is pushed. Add a remote and push when the project is ready to share.

set -e
name="$1"
parent="${2:-$HOME/github}"
[ -n "$name" ] || { echo "usage: new_r_project.sh project_name [parent_dir]" >&2; exit 1; }
root="$parent/$name"
[ -e "$root" ] && { echo "$root already exists" >&2; exit 1; }

mkdir -p "$root"/{scripts,data/raw,data/derived,outputs/figures,outputs/tables,outputs/models,outputs/reports,docs}
cd "$root"

cat > "$name.Rproj" <<'RPROJ'
Version: 1.0

RestoreWorkspace: No
SaveWorkspace: No
AlwaysSaveHistory: No

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: knitr
LaTeX: pdfLaTeX
RPROJ

cat > .gitignore <<'IGN'
.Rproj.user/
.Rhistory
.RData
.Ruserdata
.DS_Store
Rplots.pdf
~$*
.claude/
data/derived/
outputs/models/
IGN

cat > README.md <<RD
# $name

One or two sentences on what the project is.

## Run

\`\`\`bash
Rscript scripts/01_data.R
\`\`\`

## Layout

| Path | Holds |
|---|---|
| scripts/ | numbered scripts in run order; 00_setup.R loads packages, the seed, the theme and output folders |
| data/raw/ | original files, never edited; see MANIFEST.md |
| data/derived/ | everything the code writes back out |
| outputs/ | figures, tables, models and reports |
| docs/ | Word deliverables and methods text |

## Outputs

| File | What it holds | Key columns |
|---|---|---|
RD

cat > data/raw/MANIFEST.md <<'MAN'
# Raw data

| File | Source | Received | Notes |
|---|---|---|---|
MAN

cat > scripts/00_setup.R <<'SETUP'
# Packages, seed, plotting theme and output folders shared by every script.
# Each numbered script sources this file and reads its inputs from files the
# earlier step wrote, so every script runs from a fresh session.

library(here)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)

set.seed(1)   # one seed for every stochastic step

# Okabe-Ito colours for categories; define species or group colours once here
PALETTE <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")

# One theme for every figure: no titles, legend at the bottom, minor grid off
theme_lab <- theme_bw(base_size = 10) +
  theme(panel.grid.minor = element_blank(), legend.position = "bottom")
theme_set(theme_lab)

# Output folders, created once
dir_figures <- here("outputs", "figures")
dir_tables  <- here("outputs", "tables")
dir_derived <- here("data", "derived")
for (d in c(dir_figures, dir_tables, dir_derived)) dir.create(d, recursive = TRUE, showWarnings = FALSE)
SETUP

git init -q
git add -A
git commit -q -m "Set up the $name project"
echo "Created $root with a first commit. Open $name.Rproj in RStudio."
