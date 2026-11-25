---
name: manuscript-builder
description: |
  Converts a markdown manuscript (.md) into a journal-ready Word document (.docx) with proper formatting, citation styles, and optional tracked-change conversion. Use this skill whenever the user wants to: convert a markdown manuscript to Word format, render a manuscript for journal submission, build a .docx from a markdown draft, apply journal-specific formatting to a manuscript, or re-render a manuscript after edits. Also trigger when the user says "build the final docx", "format for submission", or "convert to Word". Works standalone or as the final step in the manuscript-pipeline workflow.
cost: light
---

# Manuscript Builder Skill

This skill automates the conversion of markdown manuscripts into journal-ready Word documents (.docx files) with proper formatting, citation styles, and optional change tracking.


## Required references: load before any rendering

Load from `conventions/`:
- `conventions/manuscript-format.template.md`: document structure, headings, citation format, paragraph indentation rules, end-of-document structure (Tables, then Figures, then References), pagination conventions.
- `conventions/figure-format.template.md`: figure and table format conventions.

Project-specific assets to provide:
- A pandoc reference document (e.g., `references/reference-template.docx`) with all paragraph and run styles pre-configured (Times New Roman 12 pt, black text, 1.15 line spacing, continuous line numbers, page-number footer; FirstParagraph and BodyText indent styles; TitlePageItem, Reference, Caption, and Compact-with-firstLine-0 styles).

Load these before rendering. They define the format the .docx output must match.

---
## Render pipeline (the fast path)

For a routine markdown to .docx render, the pipeline is **three steps**:

**Step 1: pandoc render.**

```bash
pandoc MS.md \
  -o MS.docx \
  --from=markdown \
  --to=docx \
  --reference-doc=references/reference-template.docx \
  --standalone \
  --resource-path=.
```

**Step 2: post-render styles fixup.** Pandoc overrides the reference doc's heading spacing and sizes with its own defaults. Patch them back to the lab default (before=480, after=120; size 28 half-points = 14 pt):

```python
import os, re, zipfile, shutil

docx_path = "MS.docx"
work = "/tmp/render_fixup"
if os.path.exists(work): shutil.rmtree(work)
os.makedirs(work)
with zipfile.ZipFile(docx_path) as zf: zf.extractall(work)

styles = f"{work}/word/styles.xml"
with open(styles) as f: xml = f.read()
for sid in ['Heading1', 'Heading2', 'Heading3']:
    m = re.search(rf'<w:style[^>]*w:styleId="{sid}"[^>]*>(.*?)</w:style>', xml, re.DOTALL)
    if m:
        old = m.group(0)
        new = re.sub(r'<w:spacing[^/]*/>', '<w:spacing w:before="480" w:after="120"/>', old)
        new = re.sub(r'<w:sz w:val="\d+"\s*/>', '<w:sz w:val="28"/>', new)
        new = re.sub(r'<w:szCs w:val="\d+"\s*/>', '<w:szCs w:val="28"/>', new)
        xml = xml.replace(old, new)
with open(styles, "w") as f: f.write(xml)

os.remove(docx_path)
with zipfile.ZipFile(docx_path, "w", zipfile.ZIP_DEFLATED) as zf:
    for root, _, files in os.walk(work):
        for file in files:
            full = os.path.join(root, file)
            zf.write(full, os.path.relpath(full, work))
```

**Step 3: post-render audit checklist** (see end of this skill). Skipping the audit is the most common source of regressions. Run it before declaring the render done.

This three-step pipeline produces a docx with the full ruleset applied (typography, indentation, line numbers, right-justified page numbers, generous Heading spacing, custom styles). Use this path unless the project requires journal-specific overrides documented in Phase 1 below.

---
## Critical formatting rules

These rules MUST be enforced on every render. They are the framework default:

1. **Typography:** Times New Roman 12 pt, black text, 1.15 line spacing for working drafts (double only if journal requires).
2. **Line numbers:** Continuous throughout. Set via `<w:lnNumType w:countBy="1" w:start="1" w:restart="continuous"/>` in the final `<w:sectPr>` of the reference doc.
3. **Page numbers:** Right-justified in footer, Times New Roman 12 pt, `PAGE` field. Wired through `word/footer1.xml` (using `<w:jc w:val="right"/>`) and a `<w:footerReference>` in `<w:sectPr>`.
3a. **Heading spacing:** Heading1 and Heading2 carry `before=480` (24 pt) and `after=120` (6 pt) so major section breaks are visually distinct. Verify in `word/styles.xml` after every render.
3c. **Heading sizes:** All headings render at 14 pt (`<w:sz w:val="28"/>`, `<w:szCs w:val="28"/>`), bold, black. Apply uniformly to Heading1, Heading2, Heading3 in the reference template. Pandoc may override heading font sizes during render; if so, post-render fixup must reset them alongside the spacing fixup (Step 2 of the render pipeline).
3b. **Title-page sub-group spacers:** Insert a `<w:p/>` empty paragraph (via `{=openxml}` block) between the affiliations block and the submission target, and between the Abstract paragraph and the Keywords line. This gives visual breathing room between distinct title-page sub-groups without bloating TitlePageItem's inter-item spacing.
4. **Indentation rule:** First paragraph after any heading = `FirstParagraph` style (firstLine=0). Subsequent paragraphs = `BodyText` style (firstLine=720). Pandoc auto-assigns these when both styles exist in the reference doc.
5. **Indent applies only to running prose paragraphs.** Do NOT apply to:
   - **Title page items** (authors, each affiliation, submission target, keywords). Wrap each line in `::: {custom-style="TitlePageItem"}`. *Critical:* the `<w:name>` element of the `TitlePageItem` style in the reference doc must EXACTLY match the custom-style attribute string. If `styleId="TitlePageItem"` has `<w:name w:val="Title Page Item"/>` (with spaces), pandoc will NOT match and will create a new `TitlePageItem0` style based on BodyText, which inherits the indent. Set `<w:name w:val="TitlePageItem"/>` (no spaces).
   - **Reference list entries.** Wrap the whole References list in a single `::: {custom-style="Reference"}` div. The `Reference` style uses hanging indent (left=720, hanging=720).
   - **Table and figure captions.** Wrap every `**Table N.**` and `**Figure N.**` paragraph in `::: {custom-style="Caption"}`. The `Caption` style has firstLine=0, italic.
   - **Table cell contents.** Pandoc applies `Compact` style inside tables; `Compact` must have `<w:ind w:firstLine="0"/>` explicitly set so it does NOT inherit BodyText's indent.
6. **No iteration metadata in the manuscript itself.** Strip working titles, alternates, "Round N of M" lines, status lines, drafted/stubbed bullet lists, and "Round-N status and handoff" sections before rendering. They belong in iteration logs, not the manuscript.
7. **No `---` horizontal-rule separators between sections** in the markdown.
8. **No duplicate display-item captions.** Embed figures with empty alt text `![](figures/path.png)` and follow with one wrapped caption paragraph.
9. **Page breaks (hard) at:** after title page, after Abstract, before References, before each Table, between Tables and Figures, before each Figure. Page-break syntax in pandoc Markdown:

   ````
   ```{=openxml}
   <w:p><w:r><w:br w:type="page"/></w:r></w:p>
   ```
   ````

10. **End-of-document structure, in order: Tables, then Figures, then References.** Display items live after body sections; body prose carries only in-text references like "(Table 1)" or "(Fig. 1)".

---
## Post-render audit checklist

Run this against `word/document.xml` and `word/styles.xml` of the rendered docx before handing it back:

```bash
mkdir -p /tmp/audit && cd /tmp/audit && unzip -oq <path-to>.docx
echo "Calibri/Cambria: $(grep -c 'Calibri\|Cambria' word/styles.xml)"  # should be 0
echo "Line numbers: $(grep -c '<w:lnNumType' word/document.xml)"        # >= 1
echo "Footer reference: $(grep -c '<w:footerReference' word/document.xml)"  # >= 1
echo "Page-number field: $(grep -c 'PAGE' word/footer1.xml 2>/dev/null)"     # >= 1
echo "Page-number right-justified: $(grep -c 'w:val=\"right\"' word/footer1.xml 2>/dev/null)"  # should be 1
echo "Heading2 before-spacing: $(grep -oE 'w:styleId=\"Heading2\"[^>]*>.*?<w:spacing[^/]*before=\"[0-9]+\"' word/styles.xml | grep -oE 'before=\"[0-9]+\"')"  # expect before="480"
echo "TitlePageItem: $(grep -c 'w:val=\"TitlePageItem\"' word/document.xml)"  # >= 1
echo "TitlePageItem0 (should be 0): $(grep -c 'w:val=\"TitlePageItem0\"' word/document.xml)"
echo "Reference: $(grep -c 'w:val=\"Reference\"' word/document.xml)"     # >= number of bibliography entries
echo "Caption: $(grep -c 'w:val=\"Caption\"' word/document.xml)"         # >= number of tables + figures
echo "Page breaks: $(grep -c '<w:br w:type=\"page\"' word/document.xml)" # at least 1 + tables + figures
```

Confirm the section order at the end is Tables, then Figures, then References by listing Heading2 entries:

```bash
grep -oE 'pStyle w:val="Heading2"[^>]*/></w:pPr><w:r[^>]*><w:t[^>]*>[^<]+' word/document.xml
```

If any check fails, fix the reference template or the markdown source and re-render. Do not hand the file back until every check passes.

---
## Overview

The manuscript builder takes a markdown source file (with or without YAML frontmatter), converts markdown structural elements to Word styles via pandoc, applies the lab's reference template, and outputs a validated .docx file. For journal-specific overrides (citation style, journal headings, word-limit checks, tracked-changes inline markup), the YAML frontmatter pipeline below is invoked. For routine working drafts, the fast path above is sufficient.

## Phase 1: Parse YAML Frontmatter

Extract the YAML metadata from the markdown file's frontmatter (between `---` delimiters).

**Required fields:**
- `title`: manuscript title (string)
- `authors`: list of author objects with `name`, `affiliation`, `email`
- `journal_target`: target journal name (string)
- `journal_profile`: object containing:
  - `citation_style`: enum: "Harvard", "APA", "Chicago", "Numbered", "Author-Date"
  - `in_text_format`: pattern for in-text citations, e.g., "(Author Year)" or "[1]"
  - `word_limits`: object with `total`, `abstract`, `keywords`

**Optional formatting overrides:**
- `font_family`: font name (string, default from journal profile)
- `font_size`: size in points (number, default 12)
- `line_spacing`: enum: "single", "1.5", "double" (default "double")
- `margins`: object with `top`, `bottom`, `left`, `right` in inches (default 1 inch)
- `page_size`: enum: "letter", "A4" (default "letter")

If a field is missing, use defaults from a project-level journal profiles file or fall back to "Generic Default" profile.

## Phase 2: Convert Markdown Structure

Map markdown syntax to docx styles and formatting:

- `# Heading 1`: Word "Heading 1" style (bold, numbered: 1., 2., 3., etc.)
- `## Heading 2`: Word "Heading 2" style (italicized, numbered: 2.1, 2.2, etc.)
- `### Heading 3`: Word "Heading 3" style (italicized, numbered: 2.1.1, etc.)
- Paragraph text: "Normal" style
- `**bold text**`: bold formatting
- `*italic text*`: italic formatting
- `` `code` ``: monospace/code formatting
- Unordered lists (`- ` or `* `): Word bullet list style
- Ordered lists (`1. `, `2. `, etc.): Word numbered list style
- Nested lists: hierarchical Word list formatting
- Tables (pipe-delimited markdown): Word table with borders and styles
- Blockquotes (`> `): indented, italicized block style
- Horizontal rules (`---`): section breaks (page break before Heading 1)
- `![alt text](image/path.png)`: embedded image (see Phase 3: Figure & Table Embedding)

## Phase 3: Figure & Table Embedding

The markdown manuscript includes `# Tables` and `# Figures` sections after `# References`, following standard journal submission format. This phase handles converting those sections into properly formatted Word content with embedded images.

### 3a: Detect Tables and Figures Sections

Parse the markdown for `# Tables` and `# Figures` heading sections after `# References`. Each section contains subsections (`## Table 1`, `## Figure 1`, etc.) with:

- **Tables:** A bold caption line (`**Table N.**`) followed by a pipe-delimited markdown table (or a placeholder)
- **Figures:** An optional markdown image link (`![Figure N](path)`) followed by a bold caption line (`**Fig. N.**`)

### 3b: Embed Figure Images

For each `![alt text](path)` found in the Figures section:

1. **Resolve the image path** relative to the manuscript's directory (if the manuscript is at `/workspace/draft.md` and the image path is `figures/paper/fig1.png`, resolve to `/workspace/figures/paper/fig1.png`)
2. **Check if the file exists.** If yes, read the image file as a buffer and embed it using docx-js `ImageRun`
3. **If the file does not exist**, insert a visible placeholder paragraph: `[FIGURE NOT FOUND: path]` in red italic text, so the author knows the image needs to be provided
4. **Scale images** to fit within page margins (max width = page width minus margins). Preserve aspect ratio. A reasonable default is 6 inches wide (8640 DXA) for full-width figures

**docx-js implementation for image embedding:**

```javascript
const { ImageRun } = require('docx');
const fs = require('fs');
const sizeOf = require('image-size');  // npm install image-size

// Read image and get dimensions
const imageBuffer = fs.readFileSync(imagePath);
const dimensions = sizeOf(imageBuffer);

// Scale to fit page width (6 inches = 432 points max width)
const maxWidthPx = 576;  // 6 inches at 96 DPI
const scale = Math.min(1, maxWidthPx / dimensions.width);
const width = Math.round(dimensions.width * scale);
const height = Math.round(dimensions.height * scale);

// Create image paragraph
new Paragraph({
  children: [
    new ImageRun({
      data: imageBuffer,
      transformation: { width, height },
      type: 'png'  // or 'jpg' based on file extension
    })
  ],
  alignment: AlignmentType.CENTER
});
```

### 3c: Format Figure Captions

Figure captions (`**Fig. N.** Caption text`) are rendered as:
- A separate paragraph below the image
- "Fig. N." in bold, followed by caption text in normal weight
- Font size one point smaller than body text (11pt if body is 12pt)
- Left-aligned (or centered, depending on journal style)

### 3d: Format Tables

Markdown pipe-delimited tables in the Tables section are converted to Word tables with:
- Table caption (`**Table N.** Caption text`) as a paragraph above the table, styled same as figure captions
- Proper borders (top and bottom of header row, bottom of table: standard scientific table style)
- Header row in bold
- Consistent column widths based on content

Placeholder tables (`*[Table to be inserted...]*`) are rendered as italic placeholder text in the document.

### 3e: Page Breaks

Each table and each figure starts on a new page. Insert a `PageBreak` before each `## Table N` and `## Figure N` subsection. This is standard for journal submissions.

### 3f: Supplementary Material

If a `# Supplementary Material` section exists, process it identically to the Tables and Figures sections but with "S" prefix numbering (Fig. S1, Table S1). Supplementary material follows the Figures section.

## Phase 4: Apply Journal-Specific Formatting

After converting markdown structure, apply journal-specific formatting rules:

1. Read the journal profile (project-level journal profiles file) using `journal_target` field.
2. Apply font family, font size, and line spacing to the entire document.
3. Set margins (convert from inches to DXA: 1 inch = 1440 DXA).
4. Override heading styles with journal-specific font sizes and spacing.
5. For unknown journals, use "Generic Default" profile.

### Default Formatting Conventions

Unless overridden by a journal profile, apply these defaults:

- **Font**: Times New Roman, black text throughout. No blue or colored text for headings or hyperlinks in the body: all text is black (hyperlinks in the reference list may retain standard Word hyperlink styling)
- **Main section headings**: Numbered (1. Introduction, 2. Methods, 3. Results, 4. Discussion), bold
- **Subsection headings**: Numbered (2.1, 2.2, 2.3), italicized
- **Paragraph indentation**: First paragraph after any heading has NO indent. All subsequent paragraphs within that section ARE indented (first-line indent of 0.5 inches / 720 DXA)
- **Author block**: Author names with superscript affiliation letters (a, b, c), affiliations listed below in smaller font, corresponding author marked with asterisk and email address provided

Reference the project-level journal profiles document for hardcoded defaults (publisher, citation style, formatting specs).

## Phase 5: Citation Formatting & Hyperlink Conversion

Preserve in-text citations as-is (they are already formatted by the paper-research skill). Validate that:

- All citations in the text match entries in the reference list.
- Citation format matches the specified in_text_format pattern.
- No missing citations or orphaned references.
- Reference list is alphabetically sorted (or numerically sorted if using numbered style).

Report validation warnings if inconsistencies are found.

### Hyperlink Conversion

The markdown manuscript contains hyperlinks throughout: both in-text citations and the reference list. These MUST be converted to clickable Word hyperlinks in the .docx output.

**In-text citation links:**
Markdown format: `Smith et al. ([2019](https://doi.org/10.xxxx/xxxxx))`
Renders to: "Smith et al. (2019)" where "2019" is a clickable hyperlink to the DOI URL.

**Reference list links:**
Markdown format: `[doi:10.xxxx/xxxxx](https://doi.org/10.xxxx/xxxxx)`
Renders to: "doi:10.xxxx/xxxxx" displayed as a clickable hyperlink.

**docx-js implementation for hyperlinks:**

```javascript
// In-text citation with hyperlinked year
new ExternalHyperlink({
  children: [
    new TextRun({ text: "2019", style: "Hyperlink" })
  ],
  link: "https://doi.org/10.xxxx/xxxxx"
})

// Reference list entry with hyperlinked DOI
new Paragraph({
  children: [
    new TextRun({ text: "Smith, A.B., Jones, C.D. 2019. Title. Journal 45(3): 445-458. " }),
    new ExternalHyperlink({
      children: [
        new TextRun({ text: "doi:10.xxxx/xxxxx", style: "Hyperlink" })
      ],
      link: "https://doi.org/10.xxxx/xxxxx"
    })
  ]
})
```

**Link handling rules:**
- Parse ALL markdown links `[text](url)` in the manuscript and convert to Word `ExternalHyperlink` objects
- If a reference has `[LINK UNAVAILABLE]` flag, render the flag as plain text (not a hyperlink) so the author can see it needs resolution
- Style hyperlinks with the Word "Hyperlink" character style (blue, underline): this is standard Word behavior
- DOI links should use the `https://doi.org/` resolver format, not bare `doi:` prefix

## Phase 6: Inline Markup Handling

The markdown may contain special markup for revision tracking:

- `~~deleted text~~`: marks text as deleted
- `++inserted text++`: marks text as inserted
- `[R1-C3: explanation text]`: comment markers

Support three modes:

**Highlight Mode (default):**
- `~~deleted~~`: rendered with red highlight + strikethrough
- `++inserted++`: rendered with yellow highlight
- `[R#-C#: text]`: converted to Word comment anchors (styled as [Comment: text])

**Tracked Changes Mode (optional):**
- `~~deleted~~`: Word tracked deletion (`<w:del>`)
- `++inserted++`: Word tracked insertion (`<w:ins>`)
- `[R#-C#: text]`: Word comment objects
- Requires docx XML manipulation (see Implementation Notes)

**Clean Mode:**
- Strip all markup (`~~`, `++`, comment markers)
- Render final clean text (for submission-ready version without revision marks)

Mode is specified in frontmatter as `inline_markup_mode: "highlight" | "tracked" | "clean"` (default: "highlight").

## Phase 7: Document Metadata

Insert document metadata:

- **Title**: centered, bold, Heading 1 style on first page
- **Authors**: centered below title, with superscript affiliation letters (a, b, c). List affiliations below in smaller font. Mark corresponding author with asterisk (*) and include email address
- **Abstract**: labeled section with abstract text from frontmatter
- **Keywords**: labeled, comma-separated list from frontmatter
- **Page numbers**: in footer, right-aligned
- **Line numbers**: continuous line numbering in the left margin (standard for journal review submissions; uses docx-js `lineNumbers` section property)
- **Running header** (optional): short title or journal abbreviation in document header
- **Word count summary**: at end or as document property (main text excluding abstract and references)

## Phase 8: Validate and Output

Before finalizing:

1. Scan entire document for unconverted markup (`~~`, `++`, `[R#` patterns) and warn if found.
2. Verify citation consistency (all in-text citations have references, all references are cited).
3. Check heading hierarchy (no H3 without H2, etc.).
4. Validate page breaks, margins, and formatting consistency.
5. Verify all figure/table cross-references: every `(Fig. N)` and `(Table N)` in the body text has a corresponding entry in the Tables/Figures sections, and vice versa.
6. Report any `[FIGURE NOT FOUND: path]` placeholders so the author knows which image files need to be provided.
7. Confirm output file is a valid .docx (ZIP-based format with proper internal structure).

**Output filename:** `[title-slug]_[journal-abbrev]_submission.docx`

Example: `small_mammal_canopy_occupancy_JAnimEcol_submission.docx`

## Implementation Notes

**Before starting any document creation, read the relevant `docx` skill's SKILL.md** for the complete reference on docx-js patterns, validation, and common pitfalls.

### Document Creation with docx-js

```javascript
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, HeadingLevel, BorderStyle, WidthType,
        PageNumber, PageBreak, ImageRun, ExternalHyperlink } = require('docx');
const sizeOf = require('image-size');  // npm install image-size

// Basic document structure
const doc = new Document({
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },  // US Letter
        margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 }  // 1 inch
      },
      lineNumbers: {
        countBy: 1,        // number every line
        restart: "continuous"  // continuous numbering (not per-page)
      },
    },
    headers: { default: new Header({ children: [/* running head */] }) },
    footers: { default: new Footer({ children: [
      new Paragraph({ alignment: AlignmentType.RIGHT, children: [new TextRun({ children: [PageNumber.CURRENT] })] })
    ] }) },
    children: [/* all document content */]
  }]
});
```

### Key Metrics

- Page size: US Letter = 12240 x 15840 DXA (CRITICAL: docx-js defaults to A4)
- 1 inch = 1440 DXA
- Font sizes: specified in half-points (24 = 12pt)
- Table widths: must set BOTH `size` and `width` properties (docx-js quirk)
- Numbered lists: use `numbering` config in Document constructor

### Parsing Inline Markup

When processing the markdown body, use regex to detect markup patterns:

```javascript
// Detection patterns
const DELETION = /~~([^~]+)~~/g;       // ~~deleted text~~
const INSERTION = /\+\+([^+]+)\+\+/g;  // ++inserted text++
const COMMENT = /\[R(\d+)-C(\d+):\s*([^\]]+)\]/g;  // [R1-C3: explanation]
```

- **Clean mode**: Strip all matches, keep only the non-markup text (for insertions, keep the text; for deletions, remove it)
- **Highlight mode**: Render deletions with red shading + strikethrough TextRun, insertions with yellow shading TextRun
- **Tracked changes mode**: Use docx XML manipulation (unpack, then insert `<w:ins>`/`<w:del>`, then pack)

### Validation

Always validate the output:

```bash
python scripts/office/validate.py output.docx
```

If validation fails, unpack, fix the XML, and repack:

```bash
python scripts/office/unpack.py output.docx unpacked/
# fix issues in unpacked/word/document.xml
python scripts/office/pack.py unpacked/ output.docx
```

### Word Count Calculation

Count words in the markdown body excluding:
- YAML frontmatter
- Reference list (`# References` section)
- Tables section (`# Tables` section: captions and table content)
- Figures section (`# Figures` section: captions)
- Supplementary Material section (`# Supplementary Material`)
- HTML comments (`<!-- ... -->`)
- Markup syntax (`~~`, `++`, `[R#-C#: ...]`)

Compare against `journal_profile.word_limit_total` and warn if exceeded.

## Invocation Patterns

This skill is triggered when the user says:

- "Convert this manuscript to Word"
- "Build the final docx"
- "Format for submission to [Journal]"
- "Render the manuscript"
- "Re-build the docx after edits"
- "Export the manuscript as .docx"
- "Create a Word document from my markdown"

It works standalone or as the final step in the **manuscript-pipeline workflow**.

## Integration with Manuscript Pipeline

The manuscript builder is the final output stage:

1. **paper-research** produces markdown draft with citations
2. **expert-review** iterates on structure and content
3. **manuscript-builder** receives final .md, outputs .docx for submission

## User Workflow

1. User provides path to markdown manuscript file or content.
2. Specify target journal or let system detect from frontmatter `journal_target`.
3. Optionally specify inline markup mode (highlight/tracked/clean).
4. Skill parses frontmatter, applies journal formatting, converts markdown to docx.
5. Validates output and returns .docx file ready for submission.

## Error Handling

- **Missing frontmatter:** Prompt user to add required fields (title, authors, journal_target).
- **Unknown journal:** Warn and fall back to "Generic Default" profile; prompt user to specify formatting overrides.
- **Unconverted markup:** Warn about remaining `~~`, `++`, `[R#` patterns and prompt to clean.
- **Citation mismatch:** Report missing citations or orphaned references.
- **Invalid markdown:** Gracefully handle malformed tables, lists, or nested structures.

## Output Example

Given `canopy_occupancy_draft.md` with `journal_target: "Journal of Animal Ecology"`, the skill outputs:
```
canopy_occupancy_draft_JAnimEcol_submission.docx
```

The .docx is fully formatted, validates with the validation script, and is ready to upload to the journal's submission system.
