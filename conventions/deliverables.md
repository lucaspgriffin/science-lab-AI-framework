# Deliverables and hand-off

> Always-load for anything that leaves the session: a report, memo, summary, slide deck, figure or animation for a partner, a repository for a collaborator, a Shiny app, or a commit. These rules come from Lucas's own corrections across projects and apply with `voice.md`, `figure-format.md` and `code-format.md`.

## 1. Form

- **Documents go out as Word files.** Manuscript drafts, coauthor write-ups, reports to funders and partners, and summaries for collaborators are `.docx` in the project's `docs/` folder, never Markdown. Once a Word file exists it is the document: later changes go into the file, tracked or in a copy beside it, and no script may rebuild and overwrite it.
- **Word and PDF names use spaces**, with an underscore only before a final date, status or draft number. Code, CSV and figure files keep underscores.
- **Slides are plain.** A short title, the figure, and three or four ordinary bullets in normal-size dark text on white. No tinted cards, no hero numbers, no lead-sentence-plus-callout layouts, no decorative shapes. This overrides any slide-design guidance that ships with a tool.
- **Figures and animations carry little text.** No title on a publication figure; the caption carries it. For a presentation map or animation, a large title, at most one short subtitle, no caption or credit line, big markers, moderate playback. Offer extras rather than adding them.
- **Headings** follow the heading rule in `CLAUDE.md`: short topic labels, four words at most, never a question or a finding.

## 2. Content

- **State the work as it stands.** No audit sections, error logs, review rounds, version history, dated history such as "until 31 October", notes to Lucas, or finished to-do items. Corrections are told in chat and recorded in commit messages or `DATA_ISSUES.md`, never in the document.
- **Let the data be the subject.** "The ASV table lists 176 taxa", not "The sequencing provider named 176 taxa".
- **Enumerate alternatives before interpreting.** When a result could have several causes, including measurement and gear artefacts, list every candidate and test the testable ones before choosing a reading. Lucas rejects narrow either-or interpretations.
- **Honest scope.** State effective sample sizes and limitations plainly. Prefer a relative index or a descriptive framing to a model the data cannot support. Do not reach for an SDM, a bootstrap or a consensus layer when the sample is a handful of animals.
- **Every group is described**, including groups too small to test, with values and sample size.
- **Verified citations only.** Every citation and literature-derived constant is checked against the primary source for value, direction, species and context before it enters a draft. Unverifiable claims are omitted or left as plain text with that said.

## 3. Quality before hand-off

- **Finish and check before reporting.** For a deep-dive analysis, run it end to end, render and read every figure at least twice, recompute the headline numbers independently, read the document text against the data, and only then hand over. Lucas forwards results to funders and partners and expects them to be right the first time.
- **Run a reviewer pass on substantive work.** Dispatch the relevant specialist agents and the quantitative scientist as critics before delivery. A single pass misses flaws that parallel critique finds, and Lucas values the critique over a confident summary.
- **Run the scans.** `tools/check_headings.py` and `tools/check_tells.py` on every document, including Word files a script built, and report a one-line Heading scan and Tell scan in the delivery reply.
- **Treat inherited explanations as claims to test.** A collaborator's reading of a data problem is checked against the raw records before it is repeated.

## 4. Repositories and git

- **Nothing in a repository shows that an AI was involved.** No attribution line in commits, no "Generated with" text, no AI-sounding prose in a README. The `attribution` setting and the `guard-git.sh` hook enforce this.
- **Commit and push verified work without asking.** Lucas has said so more than once. Commit at natural breakpoints with a plain subject line that says what changed and a body that says why, with numbers before and after when a result moved. Never commit code that errors. Still ask before a force-push, a history rewrite, deleting tracked data, or pushing to someone else's repository.
- **Forks pull from upstream and push only to origin.**
- **Collaborator-ready repositories** carry a terse README that states the current pipeline, a `data/raw/MANIFEST.md` when raw data are not tracked, and no working notes, draft emails, review files or retired code. Say plainly that `.gitignore` does not remove history, and offer a fresh repository with one starting commit when that matters.

## 5. Apps and deployment

- Shiny apps deploy with `Rscript -e "rsconnect::deployApp()"` from the app's folder, with explicit `appFiles` when the folder holds more than the app. Deploy only when asked, and when asked, run the one-liner without investigating the configuration first.
- App text computes its statistics from the data. No hardcoded counts.

## 6. Editor-facing material

- A tracked-changes manuscript, correction letter or notice for a journal editor is prepared as a Word file beside the original, with Lucas's name as the author of the changes, short comments in his voice, and the response following `reply-format.md`.
