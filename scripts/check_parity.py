#!/usr/bin/env python3
"""Assert all rule files carry identical rule headings and the same version stamp."""
import pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
FILES = [
    "AGENTS.md", "rules/cursor/adhd-mode.mdc", "rules/copilot/copilot-instructions.md",
    "rules/windsurf/.windsurfrules", "rules/windsurf/rules/adhd-mode.md",
    "rules/gemini/GEMINI.md", "rules/codex/AGENTS.md", "claude/SKILL.md",
]
RULE_RE = re.compile(r"^#{3,4}\s+(\d+\.\s+.+?)\s*$", re.M)
STAMP_RE = re.compile(r"adhd-mode v(\d+\.\d+\.\d+)")

def load(rel):
    text = (ROOT / rel).read_text(encoding="utf-8")
    if text.startswith("---"):
        parts = text.split("---", 2)
        text = parts[2] if len(parts) == 3 else text
    return text

def main():
    base_rules, base_ver, ok = None, None, True
    for rel in FILES:
        text = load(rel)
        rules = RULE_RE.findall(text)
        vers = STAMP_RE.findall(text)
        if not vers: print("FAIL " + rel + ": missing stamp"); ok = False; continue
        ver = vers[0]
        if base_rules is None: base_rules, base_ver = rules, ver
        elif rules != base_rules or ver != base_ver: print("FAIL " + rel + ": differs from " + FILES[0]); ok = False
        else: print("ok: " + rel + " (" + str(len(rules)) + " rules, v" + ver + ")")
    if not ok: sys.exit(1)
    print("parity: all " + str(len(FILES)) + " files match.")

if __name__ == "__main__": main()
