#!/usr/bin/env python3
"""Flag R code that breaks the lab coding rules (griffin-r-coding, conventions/code-format.md).

Usage:
  check_r_style.py FILE [FILE ...]   Print every hit with its line. Exit 1 if any.
  check_r_style.py --hook            Read a Claude Code PostToolUse payload on stdin and
                                     return hits to the model. Always exits 0.

Reads .R, .Rmd and .qmd. In notebooks only the R chunks are scanned. A .R file is also
parsed with Rscript so a syntax error is caught at the edit, not at the run.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

EXTENSIONS = {".r", ".rmd", ".qmd"}

# Each rule: label, pattern, and the rule it comes from, written for the reader.
RULES = [
    ("setwd()", re.compile(r"\bsetwd\s*\("),
     "use an RStudio project with here(), never setwd()"),
    ("absolute path", re.compile(r"[\"'](/Users/|/home/|[A-Z]:\\\\)"),
     "paths go through here(); no absolute paths"),
    ("rm(list = ls())", re.compile(r"\brm\s*\(\s*list\s*=\s*ls\s*\("),
     "each script runs from a fresh session instead"),
    ("cat()", re.compile(r"(?<![\w.$])cat\s*\("),
     "no cat() output; run the object, or message() for a one-line status"),
    ("print()", re.compile(r"(?<![\w.$])print\s*\("),
     "run the object instead of print(); print(p) is fine only inside a loop"),
    ("tryCatch()", re.compile(r"\btryCatch\s*\("),
     "fail fast; reserve tryCatch() for file or network access with a specific recovery"),
    (".RData", re.compile(r"\b(save|load|save\.image)\s*\(|\.RData\b"),
     "save single objects as .rds with saveRDS()/readRDS()"),
    ("geom_smooth(method = lm)", re.compile(r"geom_smooth\s*\([^)]*method\s*=\s*[\"']?(lm|glm|loess)"),
     "draw the reported model with predict(), not a smoother the text does not test"),
    ("figure title", re.compile(r"\bggtitle\s*\(|labs\s*\([^)]*\btitle\s*=|\bsubtitle\s*="),
     "no titles or subtitles on figures; the caption carries the title"),
    ("= assignment", re.compile(r"^[A-Za-z_.][\w.]*\s*=\s*(?!=)"),
     "use <- for assignment"),
    ("bare T/F", re.compile(r"=\s*(T|F)\s*[,)]"),
     "spell out TRUE and FALSE"),
    ("install.packages()", re.compile(r"\binstall\.packages\s*\("),
     "install packages outside the script"),
    ("rainbow palette", re.compile(r"\brainbow\s*\(|scale_colou?r_hue|scale_fill_hue"),
     "Okabe-Ito for categories, viridis for continuous"),
    ("helper wrapper", re.compile(r"^\s*(fit|run|do|make|build|get|compute)_\w+\s*(<-|=)\s*function"),
     "write the step out in place with the package function; no fit_*() style helpers"),
    ("named helper", re.compile(r"\w+_with_bootstrap\s*(<-|=)\s*function"),
     "call boot() in place instead of wrapping it"),
    ("Co-Authored-By", re.compile(r"Co-Authored-By|Generated with \[?Claude|noreply@anthropic"),
     "nothing in a repo shows that an AI was involved"),
    ("as.Date() on a date-time", re.compile(r"as\.Date\s*\(\s*\w*(time|dt|datetime|posix|stamp)\w*\s*\)", re.I),
     "as.Date() on a date-time needs tz = or it silently shifts days"),
]

LOOP_OPEN = re.compile(r"\b(for|while)\s*\(")


def r_lines(path):
    """Yield (line number, code line, inside_loop) for the R code in the file."""
    text = path.read_text(encoding="utf8", errors="replace")
    notebook = path.suffix.lower() in {".rmd", ".qmd"}
    in_chunk = not notebook
    depth = 0          # brace depth
    loop_depths = []   # brace depth at which an open loop body started
    for number, line in enumerate(text.splitlines(), 1):
        if notebook:
            if re.match(r"^\s*```\{r", line):
                in_chunk = True
                continue
            if in_chunk and line.strip().startswith("```"):
                in_chunk = False
                continue
            if not in_chunk:
                continue
        code = re.sub(r"#.*$", "", line)                 # drop comments
        code = re.sub(r"\"(\\.|[^\"])*\"|'(\\.|[^'])*'", '""', code)  # blank string bodies
        if LOOP_OPEN.search(code) and "{" in code:
            loop_depths.append(depth)
        yield number, line, code, bool(loop_depths)
        depth += code.count("{") - code.count("}")
        while loop_depths and depth <= loop_depths[-1]:
            loop_depths.pop()


def hits(path):
    found = []
    pipes = set()
    for number, raw, code, in_loop in r_lines(path):
        if "%>%" in code:
            pipes.add("%>%")
        if "|>" in code:
            pipes.add("|>")
        for label, pattern, why in RULES:
            target = raw if label in {"Co-Authored-By", "absolute path"} else code
            if label == "print()" and in_loop:
                continue
            if pattern.search(target):
                found.append((number, label, why))
    if len(pipes) > 1:
        found.append((0, "mixed pipes", "keep one pipe per file, %>% or |>, never both"))
    # Fenced-prefix calls are flagged only in scripts and notebooks, not in R/ functions.
    if "R" not in path.parts:
        prefixed = [n for n, raw, code, _ in r_lines(path)
                    if re.search(r"\b(?!dplyr::(select|filter)\b)[A-Za-z][\w.]*::[A-Za-z]", code)]
        if len(prefixed) > 2:
            found.append((prefixed[0], "pkg:: prefixes",
                          f"{len(prefixed)} lines use pkg::fun; load with library() and call bare"))
    return found


def parse_error(path):
    """Return the parse error from Rscript, or None when the file parses or R is absent."""
    if path.suffix.lower() != ".r":
        return None
    try:
        result = subprocess.run(
            ["Rscript", "--vanilla", "-e", f"invisible(parse('{path}'))"],
            capture_output=True, text=True, timeout=20)
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return None
    if result.returncode != 0:
        return result.stderr.strip().splitlines()[-3:]
    return None


def run_files(names):
    total = 0
    for name in names:
        path = Path(name)
        found = hits(path)
        error = parse_error(path)
        total += len(found) + (1 if error else 0)
        print(f"{name}: {len(found)} style hits" + (", parse error" if error else ""))
        if error:
            print("  " + " | ".join(error))
        for number, label, why in found:
            print(f"  line {number}: {label}: {why}")
    return 1 if total else 0


def run_hook():
    payload = json.load(sys.stdin)
    name = (payload.get("tool_input") or {}).get("file_path", "")
    path = Path(name)
    if not name or path.suffix.lower() not in EXTENSIONS or not path.is_file():
        return 0
    found = hits(path)
    error = parse_error(path)
    if not found and not error:
        return 0
    lines = []
    if error:
        lines.append("Parse error: " + " | ".join(error))
    lines += [f"line {n}: {label}: {why}" for n, label, why in found[:25]]
    message = (
        f"R style check: {len(found)} hits in {path.name}"
        + (" and a parse error" if error else "")
        + ". These break griffin-r-coding rules. Fix them before reporting back:\n"
        + "\n".join(lines)
    )
    print(json.dumps({"hookSpecificOutput": {
        "hookEventName": "PostToolUse", "additionalContext": message}}))
    return 0


if __name__ == "__main__":
    sys.exit(run_hook() if sys.argv[1:] == ["--hook"] else run_files(sys.argv[1:]))
