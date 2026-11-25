#!/usr/bin/env python3
"""Flag prose that reads as AI-written (the tell scan in griffin-writing-style and CLAUDE.md).

Usage:
  check_tells.py FILE [FILE ...]   Print every hit with its line. Exit 1 if any.
  check_tells.py --hook            Read a Claude Code PostToolUse payload on stdin and
                                   return hits to the model. Always exits 0.

Reads .md, .Rmd, .qmd, .txt, .html and .docx. Code chunks, fenced code, YAML headers,
URLs and inline code are skipped, so the scan sees prose only.
"""
import json
import re
import sys
import zipfile
from html import unescape
from pathlib import Path

EXTENSIONS = {".md", ".rmd", ".qmd", ".txt", ".html", ".docx"}

# Each rule: label, compiled pattern. Labels are what the model reads back.
RULES = [
    ("em dash", re.compile(r"—|–(?=\s)|(?<=\w) -- (?=\w)")),
    ("spaced hyphen as dash", re.compile(r"(?<=[a-z,]) - (?=[a-z])")),
    ("announcer phrase", re.compile(
        r"\b(that follows|stands? out|deserves? (a|its own)|worth noting|worth reading|"
        r"shapes? everything|the picture is|taken together|in short|put simply|"
        r"two things|three things|this matters for|it is (also )?worth|"
        r"the question is whether|a few (things|points) to note|let us|let's)\b", re.I)),
    ("counted preview", re.compile(r"^(Two|Three|Four|Several|A few)\b(?![^.]*\d)", re.M)),
    ("AI word", re.compile(
        r"\b(persist(s|ed|ing|ence)?|delv(e|es|ed|ing)|leverag(e|es|ed|ing)|crucial(ly)?|"
        r"underscor(e|es|ed|ing)|highlight(s|ed|ing)? the (importance|need|role)|"
        r"serves? as|notably|importantly|intriguingly|interestingly|"
        r"robust(ly)? (framework|approach|understanding)|nuanced|multifaceted|"
        r"holistic|landscape of|tapestry|testament to|navigate the|"
        r"in today's|it is important to note|plays? a (key|critical|vital) role)\b", re.I)),
    ("cataloguing transition", re.compile(r"^(Furthermore|In addition|Moreover|Additionally),", re.M)),
    ("idiom", re.compile(
        r"\b(where the data sit|rests? on (few|a handful)|the signature of|flagged, not moved|"
        r"carr(y|ies) a value|rather than anything|this (notebook|document|report|script) (reads|describes|presents|walks)|"
        r"used by most steps below|shown (later|below)|as (we|you) will see|"
        r"on the strength of|placed (spawning|the|it|them)|every (study|paper) since|(has|have) worked from|a first pass|(leaves?|leaving) (some )?room for|holds? (both|it|them) fixed|fits? an? |(would|will) welcome|enough to test|too few to say|carr(y|ies) (weight|the)|belongs? in the framing)\b", re.I)),
    ("sentence starts with acronym", re.compile(
        r"(?:(?<=^)|(?<=[.!?]\s)|(?<=[.!?]\s\s))(?!(?:OK|US|UK|USA|RNA|DNA|PCR)\b)([A-Z]{2,}[A-Za-z0-9]*)\b(?=\s+[a-z])", re.M)),
    ("internal label", re.compile(
        r"\b(Phase \d|Model \d+\b(?! [a-z])|Part [A-Z]\b|decision \d|E\d\b(?!\.\d)|Option [A-Z]\b|Round \d)")),
    ("dated history", re.compile(
        r"\b(until \d{1,2} \w+|as of \d|previous(ly)? (version|draft|round)|earlier (version|draft)|"
        r"was corrected|has been (updated|revised)|in (this|the latest) (revision|version)|audit( log| trail)?|"
        r"review round|to-?do)\b", re.I)),
    ("placeholder", re.compile(r"\[(QUANTIFY|X|TBD|INSERT|CITE|TODO)[^\]]*\]|\bTODO\b|\bTBD\b")),
    ("colon before list in prose", re.compile(r"[a-z]: (?:\(?[a-z0-9]\)|first,|\(1\))", re.I)),
]

PROSE_SKIP = re.compile(r"^\s*(#|\||!\[|<|```|---|\* |- |\d+\. |> )")


def prose_lines_markdown(text):
    """Yield (line number, line) for prose lines only."""
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
        if in_fence or not line.strip():
            continue
        clean = re.sub(r"`[^`]*`", "", line)            # inline code
        clean = re.sub(r"https?://\S+", "", clean)      # links
        clean = re.sub(r"\{[^}]*\}", "", clean)         # pandoc attributes
        if re.match(r"^\s*#", clean):                   # headings are checked elsewhere
            continue
        yield number, clean


def prose_lines_html(text):
    body = re.sub(r"<(script|style|pre|code)[^>]*>.*?</\1>", "", text, flags=re.S | re.I)
    for match in re.finditer(r"<(p|li|td|caption)[^>]*>(.*?)</\1>", body, re.S | re.I):
        clean = unescape(re.sub(r"<[^>]+>", "", match.group(2))).strip()
        if clean:
            yield text.count("\n", 0, match.start()) + 1, clean


def prose_lines_docx(path):
    xml = zipfile.ZipFile(path).read("word/document.xml").decode("utf8")
    for number, para in enumerate(re.findall(r"<w:p[ >].*?</w:p>", xml, re.S), 1):
        if re.search(r'<w:pStyle w:val="Heading\d"', para):
            continue
        text = "".join(re.findall(r"<w:t(?: [^>]*)?>([^<]*)</w:t>", para))
        if text.strip():
            yield number, unescape(text)


def hits(path):
    suffix = path.suffix.lower()
    if suffix == ".docx":
        lines = list(prose_lines_docx(path))
    else:
        text = path.read_text(encoding="utf8", errors="replace")
        lines = list(prose_lines_html(text) if suffix == ".html" else prose_lines_markdown(text))
    found = []
    for number, line in lines:
        for label, pattern in RULES:
            for match in pattern.finditer(line):
                found.append((number, label, match.group(0).strip()))
    return found


def run_files(names):
    total = 0
    for name in names:
        found = hits(Path(name))
        total += len(found)
        print(f"{name}: {len(found)} tells")
        for number, label, text in found:
            print(f"  line {number}: {label}: {text!r}")
    return 1 if total else 0


def run_hook():
    payload = json.load(sys.stdin)
    name = (payload.get("tool_input") or {}).get("file_path", "")
    path = Path(name)
    if not name or path.suffix.lower() not in EXTENSIONS or not path.is_file():
        return 0
    # Files that document the rules quote the tells on purpose, so they are not scanned.
    if any(part in {"node_modules", ".git", "raw", "references", "conventions", "agents"} for part in path.parts) \
            or path.name in {"SKILL.md", "CLAUDE.md", "check_tells.py"}:
        return 0
    found = hits(path)
    if found:
        lines = [f"line {n}: {label}: {t!r}" for n, label, t in found[:25]]
        more = f" (+{len(found) - 25} more)" if len(found) > 25 else ""
        message = (
            f"Tell scan: {len(found)} hits in {path.name}{more}. These read as AI-written or break "
            "the collaborator-ready rule. Recast each, then report the tell scan when handing over:\n"
            + "\n".join(lines)
        )
        print(json.dumps({"hookSpecificOutput": {
            "hookEventName": "PostToolUse", "additionalContext": message}}))
    return 0


if __name__ == "__main__":
    sys.exit(run_hook() if sys.argv[1:] == ["--hook"] else run_files(sys.argv[1:]))
