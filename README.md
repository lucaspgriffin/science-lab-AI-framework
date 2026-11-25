<p align="center">
  <img src="logo2.png" alt="Science Lab AI" width="280">
</p>

<h1 align="center">Science Lab AI</h1>

<p align="center">
  <em>A customizable framework for using LLMs in scientific workflows.</em><br>
  <strong>Forked, not consumed.</strong><br>
  <span style="color:#6a6a66;">Repo: <code>science-lab-AI-framework</code></span>
</p>

<p align="center">
  <a href="LICENSE-DOCS"><img src="https://img.shields.io/badge/docs-CC%20BY%204.0-blue.svg" alt="Docs licence: CC BY 4.0"></a>
  <a href="LICENSE-CODE"><img src="https://img.shields.io/badge/code-MIT-green.svg" alt="Code licence: MIT"></a>
  <img src="https://img.shields.io/badge/version-0.2-orange.svg" alt="Version 0.2">
  <img src="https://img.shields.io/badge/status-early%20access-yellow.svg" alt="Status: early access">
</p>

---

## Contents

1. [What this is](#what-this-is)
2. [Why this exists](#why-this-exists)
3. [Architecture at a glance](#architecture-at-a-glance)
4. [Setup](#setup)
5. [Integrating with your AI tool](#integrating-with-your-ai-tool)
6. [Working with the framework day-to-day](#working-with-the-framework-day-to-day)
7. [Working within a token budget](#working-within-a-token-budget)
8. [Tracking the framework as it grows](#tracking-the-framework-as-it-grows)
9. [What is inside](#what-is-inside)
10. [What the setup interview asks](#what-the-setup-interview-asks)
11. [Fundamentals and templates](#fundamentals-and-templates)
12. [Extending the framework](#extending-the-framework)
13. [Vocabulary](#vocabulary)
14. [Roadmap](#roadmap)
15. [Citation](#citation)
16. [Licence](#licence)
17. [Contributing](#contributing)
18. [Acknowledgments](#acknowledgments)

---

## What this is

A **vendor-neutral framework** for setting up the persistent infrastructure a working scientist needs to leverage large language models as science tools across projects, sessions, and model generations.

The framework is built around four architectural primitives:

1. **Skills** as externalised conventions, methodological defaults, and workflows that the model invokes when it matches a relevant intent.
2. **Hooks** as deterministic, event-triggered scripts that fire on every commit, prompt, or session end to enforce conventions and keep derived state in sync.
3. **Knowledge bases** as curated, topic-organised, citation-anchored reference layers that grow with the researcher's career.
4. **Sub-agents** as specialist roles that mirror how a real lab divides cognitive labour.

Where Skills, Knowledge bases, and Sub-agents are best-effort (invoked when the model recognises a relevant intent), Hooks are guarantees: they fire regardless of what the model does. They are the framework's enforcement layer: they turn the rest from suggestions into infrastructure.

It is intentionally generic. Out of the box it does nothing lab-specific. The point is that you fork it, run the AI-assisted onboarding, and end up with a framework tuned to your lab, your voice, your methods, and your tools.

---

## Why this exists

LLMs are useful tools for supporting science, but they require essential scaffolding to produce reliable workflows and products. This framework is an operational layer containing the key elements scientists can use to build tailored workflows specific to their needs, making LLMs more useful and reliable. It is not a static, standardised tool; it is a structural framework for continuously evolving and improving workflows specific to your scientific uses and preferences.

It is not a packaged AI system. It is not vendor-specific. It is not a substitute for scientific judgment.

---

## Architecture at a glance

The scientist configures the framework; the framework structures the LLM's work; the LLM's outputs flow back through the framework for the scientist to review and iterate. Every interface is two-way.

```
     ┌──────────────────────────────────────────────────────────────────┐
     │                      Working scientist                           │
     │              holds authority, curates, iterates                  │
     └──────────────┬───────────────────────────────▲───────────────────┘
                    │                               │
               configures /                      reviews /
               maintains                         iterates
                    ▼                               │
     ┌──────────────────────────────────────────────────────────────────┐
     │   Skills  ◀──▶  Hooks  ◀──▶  Knowledge base  ◀──▶  Sub-agents   │
     └──────────────┬───────────────────────────────▲───────────────────┘
                    │                               │
               invokes /                         outputs /
               structures                        drafts
                    ▼                               │
     ┌──────────────────────────────────────────────────────────────────┐
     │           Any capable LLM (Claude / GPT / Gemini)                │
     └──────────────────────────────────────────────────────────────────┘
```

The cycle runs at every scale: a single chat session (LLM proposes; scientist verifies; framework updates), a project (skills get refined as analyses surface gaps), and a career (the knowledge base compounds across projects). The framework's job is to make every loop more reliable than the last.

Four hooks ship in v0.2: a git `pre-commit` hook that regenerates the dashboard whenever framework files are staged, two Claude Code `UserPromptSubmit` hooks (one routes prompts to always-load conventions, one enforces the `**Using:** ...` declaration on every response), and a Claude Code `Stop` hook that regenerates the dashboard at session end. See `hooks/README.md` for the full inventory and `hooks/install.sh` for one-step installation.

---

## Setup

The framework is designed to be set up with AI assistance, which is the most reliable and efficient route. Direct editing of the files is also supported, and the two approaches combine freely: many adopters use the AI-assisted onboarding for the bulk of the work and then hand-edit anywhere they want to be more specific.

> [!TIP]
> The AI-assisted onboarding takes about an hour and fills in voice, format, code, and agent conventions for your lab automatically. Reach for the manual edits only when you want to override what the interview produced.

### Recommended: AI-assisted onboarding (~1 hour)

```bash
# 1. Fork the framework on GitHub so the copy lives under your account.
#    UI: visit https://github.com/jakebrownscombe/science-lab-AI-framework and click "Fork".
#    Or via the gh CLI:
gh repo fork jakebrownscombe/science-lab-AI-framework --clone --remote

# 1b. If you forked via the UI rather than gh, clone your fork locally:
git clone https://github.com/<your-username>/science-lab-AI-framework.git my-lab-framework
cd my-lab-framework

# 1c. Install the pre-commit hook so the dashboard auto-regenerates on every commit
ln -sf ../../tools/git-hooks/pre-commit .git/hooks/pre-commit

# 1d. (Optional, recommended) Install the Claude Code hooks: always-load convention
#     routing, the "Using:" declaration, and session-end dashboard refresh.
bash hooks/install.sh
# Then paste the printed JSON stanza into ~/.claude/settings.json under "hooks".

# 2. Open the onboarding form in your browser
open setup/lab-onboarding.html
# (or your distribution's equivalent: xdg-open / start)

# 3. Fill out the form. Your answers persist locally via localStorage.
#    Click "Export to text" when you finish.

# 4. Paste the exported text into a chat session with any capable LLM,
#    along with the prompt printed at the bottom of the export.
#    The LLM uses setup/SKILL.md to populate your templates.

# 5. Review the generated files, edit anything that does not match your lab,
#    commit, and you are ready.
```

Forking (rather than cloning the upstream directly) gives you a remote copy on GitHub under your account, which lets you commit your lab-specific customisations, share with collaborators, and contribute improvements back as pull requests. It also lets the maintainers see who is using the framework via GitHub's forks count.

What you end up with: populated `conventions/voice.md`, `manuscript-format.md`, `code-format.md`, `figure-format.md`, `reply-format.md`, stubs for any domain-specialist agents you need, and a seeded knowledge base with your first three topics. If you prefer chat over a browser form, `setup/SKILL.md` runs the same interview directly in any LLM session.

### Direct editing (anytime)

Every file in the framework is designed to be edited. Use the AI-assisted onboarding to scaffold most of your setup, then customise wherever you want more specificity:

- Copy any `*.template.md` to its non-template name and fill in the slots by hand.
- Audit any `SKILL.md` and adjust domain-specific examples or steps.
- Seed `knowledge_base/` with topic folders following the `_topic.template/` skeleton.

The component READMEs inside each top-level folder walk you through what each file does and how to populate it.

---

## Integrating with your AI tool

The framework is a folder of markdown files. To use it, your AI tool needs to be able to read those files on demand and follow the routing they describe. The setup instructions below are for Anthropic's Claude, which is where the framework is developed and used daily. Similar workflows can be implemented in other LLM systems (GPT, Gemini, open-weight models, custom harnesses); see [Other harnesses](#other-harnesses) for the general pattern.

### Claude setup

`CLAUDE.md` at the repo root is the framework's **master instruction file**. It tells Claude which skills exist, which conventions to load before which kinds of task, which agents are available, and how to route a request to the right files. Claude Code auto-loads `CLAUDE.md` at every session start; everything else is referenced from there. The filename is the Anthropic convention; the content is vendor-neutral and reusable on other harnesses.

Two complementary steps wire the framework into Claude Code:

**1. Make the framework's instructions globally visible.** Claude Code reads `~/.claude/CLAUDE.md` at every session start. Symlink the framework's navigation file there:

```bash
# Back up any existing global CLAUDE.md first
[ -f ~/.claude/CLAUDE.md ] && mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.bak

# Symlink the framework's CLAUDE.md as your global instruction set
ln -s /absolute/path/to/science-lab-AI-framework/CLAUDE.md ~/.claude/CLAUDE.md
```

After this, every Claude Code session automatically loads the framework's routing tables, voice conventions, and skill catalogue.

**2. Make the framework files addressable.** The routing tables reference SKILL.md files inside the framework folder, which Claude Code can only read if the folder is in scope. Add an alias:

```bash
# In ~/.zshrc, ~/.bashrc, or your shell's profile
alias claude='claude --add-dir /absolute/path/to/science-lab-AI-framework/'
```

Now when you run `claude` from any project directory, Claude Code can read every file in the framework. Skills load on demand based on the task; voice conventions load on any writing task; the iteration workflow loads when you refine an analysis. That is the entire wiring; the CLAUDE.md routing table does the rest at runtime.

### Anthropic SDK and API

For applications built on the Anthropic SDK, load the framework's markdown files programmatically and inject them as system-prompt content or file references. Pattern: detect the task intent, read the relevant SKILL.md, prepend it to the system prompt, run.

### Other harnesses

Any AI tool that can read markdown files on demand (via file-system access, RAG, MCP, or attached file references), invoke sub-processes for sub-agent role-play within a session, and load external context via system prompts, project files, or retrieval can run the framework.

Concrete pattern: load `CLAUDE.md` as the session's high-level instructions; load relevant SKILL.md files when their trigger description matches the task; reference sub-agent role files when dispatching specialist work. Cross-harness adapter examples (ChatGPT custom-GPT projects, Gemini extensions, LangChain or LlamaIndex wrappers) are welcome as community contributions.

### What the framework does not require

- No proprietary file formats. Everything is markdown.
- No vendor SDK lock-in. No build step, no compile target, no install pipeline.
- No paid hosting. The framework runs locally; the LLM call is the only external dependency.

---

## Working with the framework day-to-day

Once your AI tool is wired up, you invoke the framework through natural conversation. When you ask the AI to do something, the routing tables in `CLAUDE.md` match your intent to the right skill, which loads the right conventions, which dispatches the right specialist agents. You start the conversation; the framework handles the rest.

### Common entry points

A few of the most-used starting prompts, with what fires under the hood. Examples below use the running fictional terrestrial-ecology lab; the pattern transfers to any domain.

- **Plan an analysis.** *"I want to model small-mammal occupancy across the canopy-cover gradient. Plan the statistical approach."* → `analysis-planning` fires; parallel sub-agents research fundamentals, published precedents, and detection-bias considerations; returns a justified plan with a diagnostics checklist.
- **Implement the analysis.** *"Now write the R code from that plan."* → `code-writing` fires; scaffolds scripts following your `code-format.md`, adds embedded diagnostics.
- **Review code.** *"Review the analysis code in `scripts/`."* → `code-review` fires; hybrid automated + sub-agent review with annotated issues.
- **Draft a paragraph.** *"Help me draft the intro for a paper on canopy-cover effects on small-mammal occupancy."* → `manuscript-writing` fires; loads your `voice.md` and `manuscript-format.md`, drafts in your lab's voice.
- **Triage reviewer comments.** *"Triage these reviewer comments."* → `reviewer-reply-planning` fires; classifies each comment, flags which need your input on a structural decision.
- **Run a full workflow.** *"Run the full analysis pipeline on this project."* → `analysis-pipeline` (the orchestrator) fires; chains plan, implement, review, iterate.

You can also invoke skills by name when you want explicit control: *"Use the code-review skill on `data_clean.R`"* or *"Run the manuscript-pipeline."* Skills can be chained across sessions, and longer projects typically loop through `research-iterate` (in `skills/workflows/`) for multi-round refinement.

### Iteration is the point

The framework assumes you come back. A first pass at `analysis-planning` will reveal gaps; the `research-iterate` workflow takes a project from first cut to publication-ready over multiple rounds, with parallel specialist critique and quality gates per round. The dashboard (next section) shows the framework's state at any moment, so you can see exactly which files have been added, modified, or are still pending across sessions.

---

## Working within a token budget

The framework's simple skills are cheap to run; the multi-phase workflows are not. A single `manuscript-writing` invocation might use 2-3K tokens; a full `manuscript-pipeline` orchestration can easily use 100K+. If you are working within a Claude Pro session limit, a Tier 1 API budget, or any other token-constrained context, the framework supports that, but you have to invoke it deliberately.

> [!WARNING]
> The orchestrator workflows (`manuscript-pipeline`, `analysis-pipeline`, `research-iterate`, `expert-review`, `paper-research`, `reviewer-reply-pipeline`) burn tokens fast. Treat them as final-polish tools, not as the default route. Use the simple skills directly during early-stage work.

### Cost tiers

Skills carry one of three rough cost profiles. The dashboard surfaces this on each skill card.

| Tier | Rough range | What it looks like |
|---|---|---|
| **Light** | 1-5K tokens | Single-job skills with no sub-agents: drafting a paragraph, rendering a `.docx`, replying to one reviewer comment, writing a synthesis |
| **Medium** | 10-30K tokens | Single skills that spawn internal sub-agents or run multi-pass review: `analysis-planning`, `code-review`, `reviewer-reply-planning`, `reviewer-reply-drafting` |
| **Heavy** | 50-200K+ tokens | Multi-phase orchestrators with parallel sub-agent dispatch: `paper-research`, `expert-review`, all `*-pipeline` skills, and especially `research-iterate` (which loops over rounds) |

### Budget-conscious patterns

- **Invoke simple skills directly, not orchestrators.** *"Plan the analysis"* (one skill call) is far cheaper than *"run the full analysis pipeline"* (chains plan, implement, review). Save the orchestrator for projects where the spend is justified.
- **Run pipeline phases manually, one at a time.** Instead of `manuscript-pipeline`, run `paper-research`, then `manuscript-writing`, then `expert-review` as discrete calls across separate sessions. Stop early if the output is good enough.
- **Reserve heavy workflows for stakes that justify them.** `research-iterate` and the orchestrator pipelines are designed for the "rough to publication-ready" transition with defensible quality gates. They are not the right tool for a sketch.
- **Trim parallel sub-agent dispatch.** Ask explicitly: *"Run expert-review with two reviewers instead of five"* or *"In research-iterate, skip the parallel critique this round."*
- **Choose the model to fit the task.** Lighter models (Haiku, Sonnet) handle routine writing and code generation cleanly. Reserve frontier models (Opus and equivalents) for synthesis steps that genuinely need them.
- **Session hygiene.** Start fresh sessions for new tasks; dragging long context across topics burns tokens on irrelevant history.

A workable budget pattern: use simple skills throughout the project lifecycle (one `analysis-planning`, one `code-writing`, one `code-review`, a few `manuscript-writing` calls), and reserve a single `research-iterate` pass for final polish before submission. That is roughly one heavy workflow plus a handful of light invocations, producing a defensible output without burning a month's tokens in one session.

---

## Tracking the framework as it grows

The dashboard at `tools/system-dashboard.html` is the central place to keep track of your framework as it develops. As you populate conventions, add domain-specialist agents, seed knowledge-base topics, or modify skills, the dashboard reflects what is in place and what is still pending.

> [!IMPORTANT]
> Keep the dashboard open as you build. It is the most reliable view of how your fork is evolving, both for yourself and for collaborators who clone from your version.

**The dashboard regenerates itself.** Two mechanisms keep it current without you remembering to run anything:

- **Pre-commit git hook.** Whenever you stage changes to `skills/`, `agents/`, `knowledge_base/`, `conventions/`, or `setup/`, the hook at `tools/git-hooks/pre-commit` runs the generator and stages the updated dashboard alongside your commit. Install once per clone:

  ```bash
  ln -sf ../../tools/git-hooks/pre-commit .git/hooks/pre-commit
  ```

- **AI instruction in CLAUDE.md.** When your AI tool modifies framework files, it is instructed to regenerate the dashboard before reporting the task complete. The pre-commit hook is the backstop.

Manual regeneration is still available if you need it (e.g., the hook is not installed, or you want to refresh after editing in a non-git workspace):

```bash
node tools/generate-state.js
open tools/system-dashboard.html
```

The generator scans every component (skills, agents, conventions, knowledge_base, setup, tools) and produces both `tools/system-state.json` and an updated dashboard with the JSON embedded inline. The dashboard works opened directly via `file://`; no local HTTP server required.

Six panels cover:

- **Overview**: total counts of skills, agents, knowledge-base topics, and an adopter checklist of what is set up.
- **Skills**: every SKILL.md with its frontmatter description, path, and last-modified date.
- **Agents**: the core roster plus any domain specialists you have added.
- **Knowledge base**: topic folders with article counts; template folders flagged separately from real topics.
- **Conventions**: each file flagged as suggested (ships populated), populated (you filled in a template), or template only (still empty).
- **Setup**: onboarding prompts plus a recap of which conventions are populated.

The dashboard is intentionally dependency-free static HTML. No server, no build pipeline, no external CDN. Run the generator, open the file, see the state.

---

## What is inside

```
science-lab-AI-framework/
├── README.md                this file
├── CLAUDE.md                master instruction file: routing tables, always-load contracts, operating principles
├── LICENSE-DOCS             CC BY 4.0 for documentation
├── LICENSE-CODE             MIT for tooling code
│
├── skills/                  invokable SKILL.md files
│   ├── simple/              one-job skills (analysis-planning, manuscript-writing, code-review, ...)
│   └── workflows/           multi-phase orchestrators (manuscript-pipeline, research-iterate, ...)
│
├── agents/                  specialist sub-agent role files
│   ├── lab-director.md      task routing and cross-domain integration
│   ├── quantitative-scientist.md   statistical modelling, ML, diagnostics
│   ├── science-writer.md    literature research and manuscript drafting
│   ├── literature-extractor.md   verbatim quantitative extraction with provenance
│   ├── extraction-validator.md   source-faithfulness verification
│   └── _domain-specialist.template.md   skeleton for your own domain agents
│
├── knowledge_base/          topic-organised wiki for your lab's accumulated thinking
│   ├── SKILL.md             ingest / compile / query / maintain procedure
│   ├── GLOBAL-CONCEPTS.template.md
│   └── _topic.template/     skeleton showing the per-topic file format
│
├── conventions/             rules and protocols that skills load by reference
│   ├── research.md                          source-faithfulness contract (opinionated)
│   ├── iteration-workflow.md                six-phase loop (opinionated)
│   ├── research-quality-gates.md            analytic / visual / literature / framing gates (opinionated)
│   ├── visual-review-protocol.md            render-and-read for figures (opinionated)
│   ├── readiness-assessment.md              expertise coverage check (opinionated)
│   ├── system-improvement-protocol.md       self-update mechanism (opinionated)
│   ├── voice.template.md                    writing voice scaffold (template)
│   ├── manuscript-format.template.md        IMRAD + section conventions (template)
│   ├── reply-format.template.md             reviewer reply conventions (template)
│   ├── figure-format.template.md            plotting library + style (template)
│   ├── code-format.template.md              project structure + naming (template)
│   └── goal-spec.template.md                per-project endpoint definition (template)
│
├── setup/                   AI-assisted onboarding
│   ├── SKILL.md             orchestrator: interview to populated files
│   ├── lab-onboarding.html  self-contained HTML form
│   └── prompts/             helper prompts the setup skill uses
│
├── hooks/                   event-triggered Claude Code automation
│   ├── inject-conventions.sh   UserPromptSubmit: route prompts to always-load conventions
│   ├── announce-skills.sh      UserPromptSubmit: enforce the "Using:" declaration
│   ├── refresh-state.sh        Stop: regenerate dashboard at session end
│   ├── install.sh              one-step install into ~/.claude/
│   └── README.md               hooks overview, install, customisation
│
└── tools/                   runnable code
    ├── generate-state.js    dashboard data generator (Node.js)
    ├── system-dashboard.html  self-contained dashboard viewer
    ├── git-hooks/           git-layer hooks (pre-commit dashboard refresh)
    └── README.md            how to run the dashboard
```

---

## What the setup interview asks

The HTML form covers seven phases. Answers persist in `localStorage` so partial fills survive a tab close; the chat-driven `setup/SKILL.md` walks through the same questions if you prefer.

- **Lab identity**: name, domain, primary methods and outputs.
- **Voice**: paste 2-3 sample paragraphs, set preferences for hedging, banned words, punctuation quirks.
- **Manuscript norms**: target journals, citation style, format conventions.
- **Code stack**: language, project structure, plotting library, version control.
- **Agent roster**: which domain specialists you need beyond the five core agents.
- **Knowledge-base seed**: three topics to populate first.
- **Quality preferences**: which research-iterate gates apply.

---

## Fundamentals and templates

The framework is yours to shape. Every file is editable, and the structure is built to accommodate replacement, removal, and extension. What ships in v0.2 is a starting point organised into two kinds of file:

- **Suggested fundamentals** (ship populated). A small set of baseline content that reflects current best practices for using LLMs reliably in research, especially around minimising hallucinations and maintaining source faithfulness. Includes: `conventions/research.md` (source-faithfulness contract), `conventions/iteration-workflow.md`, `conventions/research-quality-gates.md`, `conventions/visual-review-protocol.md`, `conventions/readiness-assessment.md`, `conventions/system-improvement-protocol.md`, and the five core sub-agent role files under `agents/`. These are recommended, not required. Keep them, modify them, or replace them as your lab develops its own conventions.
- **Templates** (ship empty, for you to fill). Everything stylistic, domain-specific, or lab-specific: voice, manuscript format, figure format, code format, reply format, and the domain-specialist agent skeleton. These ship as `*.template.md` files and are populated either by the AI-assisted onboarding or by direct editing.

The naming convention `*.template.md` flags the "yours to fill" files in `ls` output; everything else is a suggested starting point you can override at any time.

---

## Extending the framework

- **Add domain-specialist agents.** Copy `agents/_domain-specialist.template.md` to `agents/<your-specialist>.md` and fill in the slots. Update the Lab Director's routing table to send relevant tasks there.
- **Add knowledge-base topics.** Use the `_topic.template/` as a skeleton; populate with articles. Every claim cites its source; the `literature-extractor` and `extraction-validator` agents enforce source faithfulness.
- **Tune the skills.** The SKILL.md files in `skills/simple/` and `skills/workflows/` are designed to be edited. They are living documents, not fixed contracts.
- **Use the iteration workflow.** `conventions/iteration-workflow.md` and `skills/workflows/research-iterate/SKILL.md` together provide a structured loop for converting analyses into publication-ready outputs.
- **Self-update.** `conventions/system-improvement-protocol.md` defines how user feedback during a project becomes durable changes to the framework itself.

---

## Vocabulary

The terms used in this framework follow the paper:

| Term | Meaning |
|------|---------|
| **Skill** | A folder with a `SKILL.md` plus optional supporting files. The model invokes a skill by reading the SKILL.md when its trigger conditions match. |
| **Workflow** | A skill that orchestrates multiple phases or other skills (e.g., a pipeline that chains plan, implement, review). |
| **Sub-agent** | A specialist role definition (markdown file) that the model adopts for a delimited task within a session. |
| **Knowledge base** | A topic-organised, citation-anchored, markdown-native reference layer that the model loads for context. |
| **Convention** | A rule file (voice, research integrity, format) loaded by skills as a reference. |
| **Hook** | A deterministic script that fires on a system event (a git commit, a Claude Code prompt submission, a Claude Code session ending) rather than on user intent. Hooks are the framework's enforcement layer: they fire whether or not the model recognises that a rule should apply. The framework ships four hooks: a git pre-commit hook at `tools/git-hooks/pre-commit` plus three Claude Code hooks under `hooks/`. See `hooks/README.md`. |

Skills follow the open Agent Skills standard. Knowledge bases use plain Markdown for portability; retrieval can be wired through any framework that supports RAG or the Model Context Protocol.

---

## Roadmap

- **v0.2 (current)**: First public deposit. Core skills, agents, conventions, knowledge-base scaffold, setup interview, dashboard.
- **v0.3**: Worked adopter case studies. Tested with two or three labs outside the originating group. Refinements based on adopter friction.
- **v0.4**: Optional ports to non-Claude harnesses. Community-contributed domain-specialist agents.
- **v1.0**: Stable API for skills and agents. First peer-reviewed evaluation of adopter outcomes.

The framework is designed to be **non-stationary**. Models will change, vendor APIs will change, conventions in your lab will change. The structure is built so those changes update *files*, not the architecture.

---

## Citation

If you fork, adapt, or use this framework in published work, please cite it:

```bibtex
@software{brownscombe2026sciencelabaiframework,
  author    = {Brownscombe, Jacob W.},
  title     = {Science Lab {AI}: A customizable framework for using LLMs in scientific workflows},
  year      = {2026},
  version   = {0.2},
  url       = {https://github.com/jakebrownscombe/science-lab-AI-framework}
}
```

Use the "Cite this repository" link in the repo's right sidebar for APA and other formats.


---

## Licence

- **Documentation** (everything under `agents/`, `conventions/`, `knowledge_base/`, `setup/`, `skills/`, and the markdown files at root): Creative Commons Attribution 4.0 International (CC BY 4.0). See `LICENSE-DOCS`.
- **Code** (everything under `tools/`): MIT licence. See `LICENSE-CODE`.

This dual-licensing reflects the framework's nature: the methodological scaffolding is documentation that benefits from broad reuse with attribution; the runnable tooling is code that benefits from permissive integration.

---

## Contributing

The framework is built to be forked. Contributions back to the canonical repo are welcome in the following forms:

- **Adopter case studies**: short writeups of how a lab adapted the framework, what worked, what did not. These directly inform the next iteration.
- **Domain-specialist agents**: generic enough to be useful across labs, opinionated enough to be useful at all. PRs into `agents/community-specialists/`.
- **Knowledge-base topic skeletons**: per-domain INDEX.md + a starter article on a methods topic. PRs into `knowledge_base/community-topics/`.
- **Cross-harness ports**: adapters that let the framework run cleanly on GPT, Gemini, or open-weight models.
- **Dashboard extensions**: new panels, better visualisations, alternative renderers.

Please open an issue before substantial work to discuss scope. The framework is intentionally minimal at the core; not every contribution will be appropriate to merge upstream, but every contribution informs the design.

---

## Acknowledgments

This framework grew out of Dr. Jacob Brownscombe's AI framework. The lab-specific origin is intentionally factored out of the deposit so that the structure stands on its own. Thanks to the early users, reviewers, and pilots who tested the architecture against real research problems.

---

<p align="center">
  <em>Built for working scientists. Forked, not consumed.</em>
</p>
