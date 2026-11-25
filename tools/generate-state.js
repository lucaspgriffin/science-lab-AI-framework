#!/usr/bin/env node

/**
 * generate-state.js
 *
 * Scans the lab-skills-framework folder structure and produces a JSON
 * snapshot consumed by system-dashboard.html. Pure Node.js (fs, path);
 * no npm dependencies, no package.json required. Node 18+ recommended.
 *
 * Usage
 * -----
 *   node tools/generate-state.js
 *       Defaults: --root="<this script>/.." (the framework root),
 *                 --out="<root>/tools/system-state.json".
 *
 *   node tools/generate-state.js --root /path/to/framework
 *   node tools/generate-state.js --root . --out tools/state.json
 *   node tools/generate-state.js --pretty            (multi-line JSON)
 *
 * Expected directory layout (under --root)
 * ----------------------------------------
 *   skills/simple/<skill-name>/SKILL.md
 *   skills/workflows/<workflow-name>/SKILL.md
 *   agents/<agent>.md                  (also picks up _*.template.md)
 *   knowledge_base/<topic>/...         (template folders prefixed with _ are flagged)
 *   conventions/<name>.md              (suggested fundamental, ships populated)
 *   conventions/<name>.template.md     (scaffold; flagged as unpopulated when the
 *                                       sibling <name>.md is absent)
 *   setup/prompts/<*.md>               (optional onboarding prompts)
 *
 * Output shape (top-level keys)
 * -----------------------------
 *   {
 *     generated:   ISO timestamp,
 *     root:        absolute path scanned,
 *     framework:   { name, version, status }    parsed from CLAUDE.md if present,
 *     totals:      { skills, agents, kb_topics, conventions, ... },
 *     skills:      { simple: [...], workflows: [...] },
 *     agents:      { core: [...], templates: [...] },
 *     knowledge_base: { topics: [...], templates: [...] },
 *     conventions: [ { name, kind, populated, path, ... } ],
 *     setup:       { prompts: [...], populated_conventions: [...] }
 *   }
 *
 * Each skill / agent / convention entry carries: name, path (relative to root),
 * summary (first non-empty paragraph after the YAML frontmatter or first heading),
 * size_bytes, mtime (ISO).
 */

'use strict';

const fs = require('fs');
const path = require('path');

// ---------------------------------------------------------------------------
// CLI parsing
// ---------------------------------------------------------------------------

function parseArgs(argv) {
  const args = { root: null, out: null, pretty: false };
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--root') args.root = argv[++i];
    else if (a === '--out') args.out = argv[++i];
    else if (a === '--pretty') args.pretty = true;
    else if (a === '--help' || a === '-h') {
      process.stdout.write(
        'Usage: node generate-state.js [--root <path>] [--out <path>] [--pretty]\n'
      );
      process.exit(0);
    }
  }
  return args;
}

const args = parseArgs(process.argv);
const ROOT = path.resolve(args.root || path.join(__dirname, '..'));
const OUT = path.resolve(
  args.out || path.join(ROOT, 'tools', 'system-state.json')
);

// ---------------------------------------------------------------------------
// FS helpers
// ---------------------------------------------------------------------------

function readFile(p) {
  try { return fs.readFileSync(p, 'utf8'); } catch { return ''; }
}

function listDir(p) {
  try { return fs.readdirSync(p, { withFileTypes: true }); } catch { return []; }
}

function statSafe(p) {
  try { return fs.statSync(p); } catch { return null; }
}

function relFromRoot(absPath) {
  return path.relative(ROOT, absPath).split(path.sep).join('/');
}

// ---------------------------------------------------------------------------
// Markdown helpers
// ---------------------------------------------------------------------------

function stripFrontmatter(text) {
  if (!text.startsWith('---')) return { frontmatter: null, body: text };
  const end = text.indexOf('\n---', 3);
  if (end === -1) return { frontmatter: null, body: text };
  return {
    frontmatter: text.slice(3, end).trim(),
    body: text.slice(end + 4).replace(/^\n+/, '')
  };
}

function parseFrontmatter(fmText) {
  if (!fmText) return {};
  const result = {};
  let key = null;
  let buffer = [];
  const flush = () => {
    if (key !== null) {
      const joined = buffer.join('\n').trim();
      result[key] = joined.replace(/^["']|["']$/g, '');
    }
  };
  for (const line of fmText.split('\n')) {
    const m = line.match(/^([A-Za-z][\w-]*):\s*(.*)$/);
    if (m && !line.startsWith(' ') && !line.startsWith('\t')) {
      flush();
      key = m[1];
      buffer = m[2] === '' || m[2] === '|' ? [] : [m[2]];
    } else if (key !== null) {
      buffer.push(line.replace(/^\s+/, ''));
    }
  }
  flush();
  return result;
}

/** First non-empty, non-heading, non-quote paragraph; trimmed to ~280 chars. */
function firstParagraph(body) {
  const lines = body.split('\n');
  const paras = [];
  let current = [];
  for (const line of lines) {
    if (line.trim() === '') {
      if (current.length) { paras.push(current.join(' ').trim()); current = []; }
    } else {
      current.push(line);
    }
  }
  if (current.length) paras.push(current.join(' ').trim());
  for (const p of paras) {
    const t = p.trim();
    if (!t) continue;
    if (t.startsWith('#')) continue;
    if (t.startsWith('>')) continue;
    if (t.startsWith('---')) continue;
    return t.length > 280 ? t.slice(0, 277).trimEnd() + '...' : t;
  }
  return '';
}

function firstHeading(body) {
  for (const line of body.split('\n')) {
    const m = line.match(/^#{1,3}\s+(.+?)\s*$/);
    if (m) return m[1].trim();
  }
  return null;
}

function describeMd(absPath) {
  const text = readFile(absPath);
  const { frontmatter, body } = stripFrontmatter(text);
  const fm = parseFrontmatter(frontmatter);
  const stat = statSafe(absPath);
  return {
    path: relFromRoot(absPath),
    frontmatter_name: fm.name || null,
    description: fm.description ? collapse(fm.description) : null,
    cost: fm.cost ? fm.cost.trim().toLowerCase() : null,
    title: firstHeading(body),
    summary: firstParagraph(body),
    size_bytes: stat ? stat.size : 0,
    mtime: stat ? stat.mtime.toISOString() : null
  };
}

function collapse(s) {
  return s.replace(/\s+/g, ' ').trim();
}

// ---------------------------------------------------------------------------
// Skills: skills/simple/<name>/SKILL.md and skills/workflows/<name>/SKILL.md
// ---------------------------------------------------------------------------

function scanSkills(category) {
  const dir = path.join(ROOT, 'skills', category);
  const out = [];
  for (const entry of listDir(dir)) {
    if (!entry.isDirectory()) continue;
    const skillFile = path.join(dir, entry.name, 'SKILL.md');
    if (!statSafe(skillFile)) continue;
    const info = describeMd(skillFile);
    const cost = info.cost && ['light', 'medium', 'heavy'].includes(info.cost)
      ? info.cost
      : 'unknown';
    out.push({
      name: entry.name,
      category,
      ...info,
      cost
    });
  }
  out.sort((a, b) => a.name.localeCompare(b.name));
  return out;
}

// ---------------------------------------------------------------------------
// Agents: agents/*.md, distinguishing core from _*.template.md
// ---------------------------------------------------------------------------

function scanAgents() {
  const dir = path.join(ROOT, 'agents');
  const core = [];
  const templates = [];
  const SKIP = new Set(['README.md', 'SKILL.md', 'INDEX.md']);
  for (const entry of listDir(dir)) {
    if (!entry.isFile()) continue;
    if (!entry.name.endsWith('.md')) continue;
    if (SKIP.has(entry.name)) continue;
    const abs = path.join(dir, entry.name);
    const info = describeMd(abs);
    const isTemplate = /^_.+\.template\.md$/.test(entry.name) ||
                       entry.name.endsWith('.template.md');
    const record = {
      name: entry.name.replace(/\.template\.md$/, '').replace(/^_/, '')
                       .replace(/\.md$/, ''),
      file: entry.name,
      ...info
    };
    if (isTemplate) templates.push(record);
    else core.push(record);
  }
  core.sort((a, b) => a.name.localeCompare(b.name));
  templates.sort((a, b) => a.name.localeCompare(b.name));
  return { core, templates };
}

// ---------------------------------------------------------------------------
// Knowledge base: knowledge_base/<topic>/ folders; templates prefixed with _
// ---------------------------------------------------------------------------

function scanKnowledgeBase() {
  const dir = path.join(ROOT, 'knowledge_base');
  const topics = [];
  const templates = [];
  for (const entry of listDir(dir)) {
    if (!entry.isDirectory()) continue;
    const topicDir = path.join(dir, entry.name);
    const articlesDir = path.join(topicDir, 'articles');
    const indexPath = path.join(topicDir, 'INDEX.md');

    const articleFiles = listDir(articlesDir)
      .filter(e => e.isFile() && e.name.endsWith('.md'))
      .map(e => e.name);

    const allMd = listDir(topicDir)
      .filter(e => e.isFile() && e.name.endsWith('.md'))
      .map(e => e.name);

    const stat = statSafe(topicDir);
    const indexInfo = statSafe(indexPath)
      ? describeMd(indexPath)
      : { description: null, summary: null, title: null };

    const record = {
      slug: entry.name,
      path: relFromRoot(topicDir),
      has_index: !!statSafe(indexPath),
      article_count: articleFiles.length,
      file_count: allMd.length,
      title: indexInfo.title,
      summary: indexInfo.summary,
      mtime: stat ? stat.mtime.toISOString() : null
    };
    if (entry.name.startsWith('_')) templates.push(record);
    else topics.push(record);
  }
  topics.sort((a, b) => a.slug.localeCompare(b.slug));
  templates.sort((a, b) => a.slug.localeCompare(b.slug));
  return { topics, templates };
}

// ---------------------------------------------------------------------------
// Conventions: distinguish .md (populated) from .template.md (scaffold)
//   Populated state: a *.template.md is "populated" if a sibling *.md exists
//   without the .template marker. A standalone *.md (no template) is also
//   counted as populated.
// ---------------------------------------------------------------------------

function scanConventions() {
  const dir = path.join(ROOT, 'conventions');
  const SKIP = new Set(['README.md', 'INDEX.md', 'SKILL.md']);
  const files = listDir(dir).filter(e =>
    e.isFile() && e.name.endsWith('.md') && !SKIP.has(e.name)
  );
  const byBase = new Map();
  for (const e of files) {
    const isTemplate = e.name.endsWith('.template.md');
    const base = isTemplate
      ? e.name.replace(/\.template\.md$/, '')
      : e.name.replace(/\.md$/, '');
    if (!byBase.has(base)) byBase.set(base, { template: null, populated: null });
    if (isTemplate) byBase.get(base).template = e.name;
    else byBase.get(base).populated = e.name;
  }

  const entries = [];
  for (const [base, pair] of byBase) {
    const populatedAbs = pair.populated
      ? path.join(dir, pair.populated)
      : null;
    const templateAbs = pair.template
      ? path.join(dir, pair.template)
      : null;
    const sourceAbs = populatedAbs || templateAbs;
    const info = describeMd(sourceAbs);
    entries.push({
      name: base,
      kind: pair.template && !pair.populated ? 'template-only'
          : pair.template && pair.populated ? 'template-populated'
          : 'opinionated',
      populated: !!pair.populated,
      template_path: templateAbs ? relFromRoot(templateAbs) : null,
      populated_path: populatedAbs ? relFromRoot(populatedAbs) : null,
      title: info.title,
      summary: info.summary,
      size_bytes: info.size_bytes,
      mtime: info.mtime
    });
  }
  entries.sort((a, b) => a.name.localeCompare(b.name));
  return entries;
}

// ---------------------------------------------------------------------------
// Setup: setup/prompts/ optional onboarding scripts
// ---------------------------------------------------------------------------

function scanSetup() {
  const dir = path.join(ROOT, 'setup', 'prompts');
  const prompts = [];
  for (const e of listDir(dir)) {
    if (!e.isFile() || !e.name.endsWith('.md')) continue;
    const info = describeMd(path.join(dir, e.name));
    prompts.push({ name: e.name.replace(/\.md$/, ''), ...info });
  }
  prompts.sort((a, b) => a.name.localeCompare(b.name));
  return { prompts };
}

// ---------------------------------------------------------------------------
// Framework metadata: parse CLAUDE.md for version / status
// ---------------------------------------------------------------------------

function scanFramework() {
  const claudeMd = readFile(path.join(ROOT, 'CLAUDE.md'));
  const meta = { name: path.basename(ROOT), version: null, status: null };
  const versionMatch = claudeMd.match(/v(\d+(?:\.\d+)+)/);
  if (versionMatch) meta.version = 'v' + versionMatch[1];
  const statusMatch = claudeMd.match(/##\s+Status\s*\n+([^\n]+)/);
  if (statusMatch) meta.status = collapse(statusMatch[1]);
  // Prefer an explicit "# <name>" h1 at the very top of README; otherwise the
  // directory basename. We accept the h1 only if it appears before any "##"
  // subheading or markdown code block, to avoid picking up section headings or
  // shell-script line comments later in the file.
  const readme = readFile(path.join(ROOT, 'README.md'));
  if (readme) {
    const lines = readme.split('\n');
    for (const line of lines) {
      if (line.match(/^##\s/)) break;
      if (line.match(/^```/)) break;
      const h1 = line.match(/^#\s+([^#].+?)\s*$/);
      if (h1) { meta.name = h1[1].trim(); break; }
      const htmlH1 = line.match(/<h1[^>]*>([^<]+?)<\/h1>/);
      if (htmlH1) { meta.name = htmlH1[1].trim(); break; }
    }
  }
  return meta;
}

// ---------------------------------------------------------------------------
// Assemble
// ---------------------------------------------------------------------------

const skillsSimple = scanSkills('simple');
const skillsWorkflows = scanSkills('workflows');
const agents = scanAgents();
const kb = scanKnowledgeBase();
const conventions = scanConventions();
const setup = scanSetup();
const framework = scanFramework();

const populatedConventions = conventions.filter(c => c.populated).map(c => c.name);

const allSkills = [...skillsSimple, ...skillsWorkflows];
const countCost = (tier) => allSkills.filter(s => s.cost === tier).length;

const totals = {
  skills_simple: skillsSimple.length,
  skills_workflows: skillsWorkflows.length,
  skills: skillsSimple.length + skillsWorkflows.length,
  cost_light: countCost('light'),
  cost_medium: countCost('medium'),
  cost_heavy: countCost('heavy'),
  cost_unknown: countCost('unknown'),
  agents_core: agents.core.length,
  agents_templates: agents.templates.length,
  kb_topics: kb.topics.length,
  kb_topic_templates: kb.templates.length,
  kb_articles: kb.topics.reduce((s, t) => s + t.article_count, 0),
  conventions_total: conventions.length,
  conventions_populated: populatedConventions.length,
  conventions_template_only: conventions.filter(c => c.kind === 'template-only').length,
  setup_prompts: setup.prompts.length
};

const state = {
  generated: new Date().toISOString(),
  root: ROOT,
  framework,
  totals,
  skills: { simple: skillsSimple, workflows: skillsWorkflows },
  agents,
  knowledge_base: kb,
  conventions,
  setup: { ...setup, populated_conventions: populatedConventions }
};

const json = args.pretty
  ? JSON.stringify(state, null, 2)
  : JSON.stringify(state);

fs.mkdirSync(path.dirname(OUT), { recursive: true });
fs.writeFileSync(OUT, json + '\n');

process.stderr.write(
  `Wrote ${relFromRoot(OUT)} (${(json.length / 1024).toFixed(1)} KB, ` +
  `${totals.skills} skills, ${totals.agents_core} agents, ` +
  `${totals.kb_topics} KB topics, ${totals.conventions_total} conventions)\n`
);

// Also inject the JSON into the dashboard HTML so it works when opened via file://
// (browsers block fetch() of local files; an inline <script type="application/json">
//  block bypasses that restriction entirely)
const DASHBOARD = path.join(ROOT, 'tools', 'system-dashboard.html');
if (fs.existsSync(DASHBOARD)) {
  const html = fs.readFileSync(DASHBOARD, 'utf8');
  const stateBlock = /(<script type="application\/json" id="state">)([\s\S]*?)(<\/script>)/;
  if (stateBlock.test(html)) {
    // Escape `</script` inside the JSON so the closing tag does not get interpreted.
    // (Splitting the literal so this comment block does not trigger the same issue.)
    const safe = json.replace(/<\/(script)/gi, '<\\/$1');
    const updated = html.replace(stateBlock, `$1${safe}$3`);
    fs.writeFileSync(DASHBOARD, updated);
    process.stderr.write(
      `Embedded state into ${relFromRoot(DASHBOARD)} ` +
      `(dashboard now works via file://)\n`
    );
  } else {
    process.stderr.write(
      `Note: ${relFromRoot(DASHBOARD)} has no inline state block; ` +
      `dashboard will still work via HTTP.\n`
    );
  }
}
