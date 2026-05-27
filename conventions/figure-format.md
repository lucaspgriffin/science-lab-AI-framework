---
lab: Griffin Lab
pi: Lucas P. Griffin, University of South Florida
generated: 2026-05-26
source: inferred from observed practice (cobia_sdm_explore, tarpon_dashboard, SJB-Receiver-Map-App) and griffin-writing-style Word/PDF figure conventions
---

# Figure format: Griffin Lab plotting and visualisation conventions

Render-time companion to `conventions/manuscript-format.md`. Manuscript-format specifies how
many figures and how legends are structured; this file specifies how each figure is rendered:
tooling, palette, typography, panel labelling, scale bars, export format.

---

## 1. Plotting tooling

- **Default**: R `ggplot2` (3.4+) with `patchwork` for multi-panel composition and `ggspatial`
  for map insets, scale bars, and north arrows.
- **Maps**: `ggplot2` + `sf` + `ggspatial`. For interactive HTML maps (Shiny apps, exploration),
  `leaflet`. For animated movement visualisations, `gganimate` or `move`.
- **Diagnostic and exploratory plots**: base R `plot()` is fine; convert to `ggplot2` for any
  publication-bound figure.
- **Tables in figures**: `gt`, `kableExtra`, or `flextable` (the last for Word submissions).
- **Plotting code lives** under `scripts/` alongside the analysis scripts when figures are
  generated as a downstream step, or under a dedicated `scripts/figures/` (or `code/figures/`)
  folder. One script per main figure: `fig_NN_short_descriptor.R`.
- **Package versions** pinned via `renv` for any project producing a publication figure.

---

## 2. Colour palette

- **Categorical (default)**: **Okabe-Ito 8-colour palette**, colourblind-safe across
  deuteranopia, protanopia, and tritanopia. Hex codes:
  `#E69F00, #56B4E9, #009E73, #F0E442, #0072B2, #D55E00, #CC79A7, #000000`.
- **Categorical (overflow, > 8 categories)**: switch to a `paletteer`-curated set
  (`paletteer::paletteer_d("ggsci::default_nejm")`) or Tol's `bright` extended with `muted`.
  Use sparingly: more than 8 categorical colours strain reader memory.
- **Sequential**: `viridis` (default), `mako` for darker-background plots, `cividis` when
  print-monochrome compatibility matters.
- **Diverging**: `RdBu` via `scale_colour_distiller(palette = "RdBu")`; reverse when needed
  for direction-of-effect convention (e.g., negative-effect = red, positive-effect = blue).
- **Bathymetry / depth**: `cmocean::cmocean("deep")` or `cmocean::cmocean("topo")` for
  bathymetric maps; reads naturally as deeper = darker.
- **Temperature**: `cmocean::cmocean("thermal")` for SST and related.
- **Never use rainbow / jet** palettes for quantitative data.

---

## 3. Typography

- **Default font**: Arial (sans-serif) for figures. The lab's Word documents are Times New
  Roman 12 pt black, but figures sit in sans-serif for publication.
- **Axis labels**: 9 pt at final figure width.
- **Tick labels**: 8 pt.
- **Panel labels** (A, B, C, ...): 12 pt bold.
- **Legend text**: 8 pt.
- **Minimum size** for any printed text at the final column width: 7 pt. Anything smaller is
  re-rendered.

---

## 4. Panel labelling

- Top-left corner of each panel, **12 pt bold**, no parentheses (just `A`, `B`, `C`),
  positioned outside the plot area.
- Sub-panels use letter+number (`A1`, `A2`, `A3`) only when the sub-panel is clearly a
  subdivision of a single conceptual unit (e.g., a species-distribution response curve
  showing the same model across three covariates). Otherwise sub-panels continue the letter
  sequence.

---

## 5. Axes, ticks, grids

- Axes shown as solid 0.75 pt lines, **left and bottom only** (no top or right axis lines).
- Ticks outward.
- 5–7 major tick positions per axis; minor ticks shown only for log-scale axes.
- **No background grid by default.** A light grey horizontal grid (`alpha = 0.2`) is
  acceptable for bar charts or coefficient plots where horizontal reference helps the read.
- Log axes use base 10 with explicit `10^N` labels (`scales::label_log()`).
- **Zero lines emphasised** (1.0 pt black) on response-curve plots that cross zero on the
  log-odds or log-link scale, or on coefficient-plot panels.

---

## 6. Maps, scale bars, and overlays

For any spatial figure (study-area map, detection density, predicted-distribution surface):

- **Scale bar**: lower-right via `ggspatial::annotation_scale()`. White-on-dark for
  satellite-imagery basemaps, black-on-light for OpenStreetMap or polygon basemaps. 5–10% of
  plot width. Unit label below ("5 km", "100 km", as appropriate to extent).
- **North arrow**: `ggspatial::annotation_north_arrow()` on any panel where map orientation
  matters. Standard `style = "north_arrow_fancy_orienteering"` or `"north_arrow_minimal"`.
- **No spatial figure published without a scale bar and (where orientation matters) a north
  arrow.**
- **Projection**: choose an appropriate equal-area or conic projection for the study extent
  (Albers Equal Area for U.S. coastal work; UTM zone for tighter regional studies; WGS84 only
  for global / very small extents). Document the EPSG code in the figure script.
- **Coastlines**: `rnaturalearth` for global / regional context; high-resolution NOAA
  shoreline (`prettymapr::searchbbox()` or downloaded shapefiles) for local studies.
- **Bathymetry**: `marmap::getNOAA.bathy()` or pre-downloaded GEBCO grids for marine maps.

---

## 7. Statistical annotation

- **Error bars**: 95% confidence or credible intervals by default. SEM only when sample size
  is annotated on the figure.
- **Significance markers**: `*` P < 0.05, `**` P < 0.01, `***` P < 0.001, `ns` not
  significant. The exact test is named in the legend, not on the figure.
- **Sample size**: annotated as `n = N` near the test statistic when n varies across panels;
  otherwise placed in the legend.
- The lab prefers **continuous effect figures with credible/confidence intervals** over
  threshold `P < 0.05` annotations. Partial effects, marginal predictions, and posterior
  draws read more honestly than asterisk-on-bar plots.

---

## 8. Export format

- **Main figures**: vector PDF (preferred) for any plot rendered programmatically;
  high-resolution PNG (600 dpi) when raster is required (e.g., basemap tiles, smoothed
  rasters). Each figure exported in both formats so submission systems can use whichever the
  journal prefers.
- **Supplementary figures**: 300 dpi PNG for scanning, PDF for vector content.
- **File naming**: `fig_NN_short_descriptor.pdf` and `.png` (e.g.,
  `fig_03_predicted_distribution_seasonal.pdf`).
- **Compression**: PNGs compressed losslessly; PDFs unmodified. No JPEG for any plot
  containing text or sharp edges.
- **Save device**: `ggsave()` with explicit `device = cairo_pdf` for PDFs containing
  non-ASCII or italicised scientific names; explicit `dpi = 600` for PNG.

---

## 9. Accessibility

- All categorical colour choices pass deuteranopia simulation (default Okabe-Ito handles
  this).
- Where colour encodes ordinal or quantitative meaning, also encode it with **linetype** or
  **marker shape** so the figure remains readable in grayscale.
- Critical contrasts (treatment vs control, observed vs predicted, present vs absent) use
  redundant encoding (colour + shape, or colour + label).
- Figures intended for talks additionally use larger fonts (12 pt minimum) and high-contrast
  palette settings; consider a parallel `fig_NN_short_descriptor_talk.R` script that
  rebuilds the same figure at presentation scale.

---

## 10. Tables

- Rendered with `gt` or `kableExtra` for HTML and rmarkdown reports; `flextable` for Word
  submissions.
- **Font**: Arial 9 pt body text; **bold** headers.
- **Lines**: horizontal lines only (top, header bottom, table bottom). No vertical lines.
- **Numeric columns**: right-aligned with a fixed number of decimal places per column. Counts
  as integers. Percentages with one decimal place. P-values with three decimals (or `< 0.001`).
- Tables with more than 8 columns or 20 rows are flagged for figure conversion or
  supplementary-table relocation.

---

## 11. Render-and-read protocol

When the model produces or modifies a figure, it must render the figure and inspect the
rendered output, not just write the code. Checks:

1. Does the figure render without errors?
2. Are all axes labelled with units?
3. Is the legend readable at intended print size?
4. Does the figure visually communicate what the Results section claims?
5. For maps: is the scale bar present and oriented correctly?

Any failure routes back to the figure script for revision. Full protocol:
`conventions/visual-review-protocol.md`.

---

## 12. Shiny app conventions

For dashboard / app projects (`SJB-Receiver-Map-App`, `tarpon_dashboard`,
`stonybrook_telemetry_app`):

- **Default app font**: a clean sans-serif (system default or imported via `bslib`).
- **Map layers**: `leaflet` with named layer groups so the user can toggle them on / off.
- **Colour scale legend**: always present for any quantitative map layer; placed bottom-left
  by default.
- **Performance**: pre-process large rasters / detection matrices to the smallest dataset
  that supports the app's view; do not stream raw `.csv` per click.
- **Deployment**: `Rscript -e "rsconnect::deployApp()"` from the repo root. Pin
  `rsconnect`-known package versions in `manifest.json` when publishing to shinyapps.io.

---

## Cross-references

- Document-level figure conventions (count, placement, legends): `conventions/manuscript-format.md`
- Visual review protocol (four-test render-and-read): `conventions/visual-review-protocol.md`
- Voice (for legend text style): `conventions/voice.md`
- Code conventions (where figure scripts live, naming, version pinning):
  `conventions/code-format.md`
