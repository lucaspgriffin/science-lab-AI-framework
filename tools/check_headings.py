#!/usr/bin/env python3
"""Flag section headings that break the lab heading rule (CLAUDE.md, Section headings).

Usage:
  check_headings.py FILE [FILE ...]   Print every failing heading. Exit 1 if any fail.
  check_headings.py --hook            Read a Claude Code PostToolUse payload on stdin and
                                      return any failures to the model. Always exits 0.

Reads .md, .Rmd, .qmd, .html and .docx. Fenced code chunks and YAML headers are skipped.
"""
import json
import re
import sys
import zipfile
from html import unescape
from pathlib import Path

MAX_WORDS = 4
EXTENSIONS = {".md", ".rmd", ".qmd", ".html", ".docx"}

# Numbering may precede the label and does not count toward the word limit.
PREFIX = re.compile(
    r"^(?:Step\s+\d+[.:]|Part\s+\d+[.:]|Appendix(?:\s+[A-Z0-9]+|\s+script)?[.:]|"
    r"[A-Z]?\d+(?:\.\d+)*[.:)]?)\s+"
)
BANNED_FIRST = {
    "what", "how", "why", "which", "who", "when", "where", "does", "do", "did", "is",
    "are", "was", "were", "can", "could", "should", "will", "would", "the", "a", "an",
    "our", "we", "this", "these", "those", "here",
}
FINITE_VERB = re.compile(
    r"\b(is|are|was|were|has|have|sets|set by|follows|rose|fell|carries|changed|shapes|"
    r"drives|explains|matters|found|shows|showed|repeats|predicts|determines)\b",
    re.IGNORECASE,
)
GERUND_PHRASE = re.compile(r"^[A-Z][a-z]+ing\s+(the|this|that|these|a|an|our)\b")


def problems(heading):
    """Return the reasons a heading fails; an empty list means it passes."""
    text = " ".join(heading.split())
    # Rendered reports stack numbering, as in "20.7 E6." or "6 Step 00:".
    while PREFIX.match(text):
        text = PREFIX.sub("", text, count=1)
    if not text:
        return []
    found = []
    words = text.split()
    if text.endswith("?"):
        found.append("question")
    if words[0].lower().strip('"') in BANNED_FIRST:
        found.append(f"starts with '{words[0]}'")
    if len(words) > MAX_WORDS:
        found.append(f"{len(words)} words")
    if ":" in text:
        found.append("colon")
    if FINITE_VERB.search(text):
        found.append("reads as a sentence")
    if GERUND_PHRASE.match(text):
        found.append("narrated phrase")
    return found


def markdown_headings(text):
    in_fence = False
    in_yaml = text.startswith("---")
    for number, line in enumerate(text.splitlines(), 1):
        if in_yaml:
            if number > 1 and line.strip() == "---":
                in_yaml = False
            continue
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            continue
        match = None if in_fence else re.match(r"^#{1,6}\s+(.+?)\s*#*\s*$", line)
        # A heading on the first line is the document title, not a section heading.
        if match and number > 1:
            yield number, re.sub(r"\{[#.][^}]*\}\s*$", "", match.group(1)).strip()


def html_headings(text):
    for match in re.finditer(r"<h[1-6]([^>]*)>(.*?)</h[1-6]>", text, re.DOTALL | re.IGNORECASE):
        if re.search(r'class="[^"]*(title|author|date)', match.group(1)):
            continue
        clean = re.sub(r"<[^>]+>", "", match.group(2))
        clean = unescape(clean).strip()
        if clean:
            yield text.count("\n", 0, match.start()) + 1, clean


def docx_headings(path):
    xml = zipfile.ZipFile(path).read("word/document.xml").decode("utf8")
    for number, para in enumerate(re.findall(r"<w:p[ >].*?</w:p>", xml, re.DOTALL), 1):
        if not re.search(r'<w:pStyle w:val="Heading\d"', para):
            continue
        # Tracked deletions use w:delText, so only surviving text is read here.
        text = "".join(re.findall(r"<w:t(?: [^>]*)?>([^<]*)</w:t>", para))
        if text.strip():
            yield number, unescape(text).strip()


def headings(path):
    suffix = path.suffix.lower()
    if suffix == ".docx":
        return list(docx_headings(path))
    text = path.read_text(encoding="utf8", errors="replace")
    return list(html_headings(text) if suffix == ".html" else markdown_headings(text))


def failures(path):
    return [(n, h, problems(h)) for n, h in headings(path) if problems(h)]


def run_files(names):
    total = 0
    for name in names:
        path = Path(name)
        found = failures(path)
        total += len(found)
        print(f"{name}: {len(headings(path))} headings, {len(found)} failing")
        for number, heading, why in found:
            print(f"  line {number}: {heading}  [{', '.join(why)}]")
    return 1 if total else 0


def run_hook():
    payload = json.load(sys.stdin)
    name = (payload.get("tool_input") or {}).get("file_path", "")
    path = Path(name)
    if not name or path.suffix.lower() not in EXTENSIONS or not path.is_file():
        return 0
    found = failures(path)
    if found:
        lines = [f"line {n}: {h} [{', '.join(w)}]" for n, h, w in found[:25]]
        message = (
            f"Heading rule failures in {path.name}. Headings are short plain topic labels, "
            "such as Results, Meal cost, Repeatability. Fix these before continuing:\n"
            + "\n".join(lines)
        )
        print(json.dumps({"hookSpecificOutput": {
            "hookEventName": "PostToolUse", "additionalContext": message}}))
    return 0


if __name__ == "__main__":
    sys.exit(run_hook() if sys.argv[1:] == ["--hook"] else run_files(sys.argv[1:]))
