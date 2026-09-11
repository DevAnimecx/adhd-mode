#!/usr/bin/env python3
"""adhd-mode rule renderer - SINGLE SOURCE OF TRUTH.

Edit the canonical text below (or a wrapper), then run:
    python scripts/build.py          rewrite rules/ and root files from this file
    python scripts/build.py --check  exit 1 if repo files differ from this source
"""
import argparse, pathlib, sys

VERSION = '1.0.0'
CREDIT = 'Rules adapted from [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT), the original skill. adhd-mode is the always-on, every-tool port.'
UPSTREAM = 'https://github.com/ayghri/i-have-adhd'
CORE = '# ADHD Output Mode\n\nThe reader has ADHD. Output is not just brief. It is shaped so an ADHD brain can act on it.\n\n## Persistence\n\nThese rules apply to every response for the rest of the session. They do not expire after a few turns.\n\nTurn them off only when the reader says "stop adhd mode" or "normal mode".\n\n## What ADHD changes about reading\n\n1. Working memory is small. Do not ask the reader to "keep in mind X."\n2. Knowing the answer is not doing the answer.\n3. Starting is the hardest step.\n4. Time estimates feel uniform. Vague estimates fail.\n5. Dopamine is scarce. Visible progress matters.\n\n## Rules\n\n### 1. Lead with the next action\nThe first line is something the reader can do. Not context. Not a plan. The action.\n\n### 2. Number multi-step tasks\nIf the work takes more than one step, write a numbered list. Each step is one bounded action.\n\n### 3. End with one concrete next action\nIf anything is left open, name ONE thing the reader can do in under two minutes.\n\n### 4. Suppress tangents\nIf a second issue exists, finish the first, then offer the second as a separate question.\n\n### 5. Restate state every turn\nThe reader cannot hold "we are on step 3 of 5" between messages. Restate it.\n\n### 6. Give specific time estimates\nVague estimates fail. Ballpark in concrete units.\n\n### 7. Make completed work visible\nShow what now works, in concrete terms.\n\n### 8. Matter-of-fact tone for errors\nNever use "Uh oh," "Oh no." State cause and fix.\n\n### 9. Cap lists at 5 items\nIf a list grows past five, split into "do now" vs "later."\n\n### 10. No preamble, no recap, no closing pleasantries\nForbidden openers: "Great question," "Let me...", "Sure!"\nForbidden closers: "Hope this helps," "Let me know if you need anything else."\n\n## Pre-send check\n\nBefore sending, delete:\n1. The first sentence if it announces what you are about to do.\n2. The last sentence if it asks "anything else?"\n3. Any "by the way" sidebar.\n4. Any hedging adverb adding no information.\n5. Any idiom or figurative phrase.\n\n## When to break the rules\n\nOverride when:\n1. User asks to "explain" or "walk me through."\n2. Destructive action ahead.\n3. Debug spiral (3+ turns of "still broken").\n4. Real ambiguity in the request.\n5. A rule fights the task.\n6. A rule fights the harness.\n'
STAMP = "adhd-mode v" + VERSION

def demote(md):
    out = []
    for line in md.splitlines():
        if line.startswith("#"): line = "#" + line
        out.append(line)
    return "\n".join(out)

def body(md):
    lines = md.splitlines()
    if lines and lines[0].startswith("# "): lines = lines[1:]
    while lines and not lines[0].strip(): lines = lines[1:]
    return demote("\n".join(lines)).strip()

def footer(): return "---\n" + CREDIT + " - " + STAMP + "\n"

def render_agents_md():
    head = ("# AGENTS.md\n\n"
            "This file is read natively by Codex, Cursor, GitHub Copilot, "
            "Gemini CLI (with config), Windsurf, Aider, Zed, and 20+ other "
            "AI coding agents. The section below is an output style, not a "
            "project rule. Add project-specific rules as separate sections.\n\n"
            "## Output Style\n\n")
    return head + body(CORE) + "\n\n" + footer()

def render_cursor():
    fm = ("---\n"
          "description: ADHD-friendly output mode. Action-first, numbered steps, no preamble. Always on.\n"
          "alwaysApply: true\n---\n\n")
    return fm + CORE.strip() + "\n\n" + footer()

def render_copilot():
    head = ("<!-- adhd-mode: these instructions shape ALL Copilot Chat and Copilot\n"
            "     coding-agent responses in this repo. They are always on.\n"
            "     Say \"stop adhd mode\" to pause.\n"
            "     Note: Copilot cloud agent also reads AGENTS.md natively. -->\n\n")
    return head + CORE.strip() + "\n\n" + footer()

def render_windsurf_modern():
    fm = ("---\n"
          "description: ADHD-friendly output mode. Action-first, numbered steps, no preamble. Always on.\n"
          "trigger: always_on\n---\n\n")
    return fm + CORE.strip() + "\n\n" + footer()

def render_windsurf_legacy(): return CORE.strip() + "\n\n" + footer()

def render_gemini():
    note = ("<!-- Loaded automatically by Gemini CLI for every session in this directory.\n"
            "     Always on. Say \"stop adhd mode\" to pause.\n"
            "     Tip: you can also configure Gemini CLI to read AGENTS.md via\n"
            "     .gemini/settings.json: {\"context\":{\"fileName\":\"AGENTS.md\"}} -->\n\n")
    return note + CORE.strip() + "\n\n" + footer()

def render_claude_skill():
    fm = ("---\n"
          "name: adhd-mode\n"
          "description: Shape output for a reader with ADHD: lead with the next action, number multi-step work, restate state across turns, suppress tangents, give specific time estimates, make wins visible. Stays on until \"stop adhd mode\".\n"
          "disable-model-invocation: true\nlicense: MIT\n---\n\n")
    return fm + CORE.strip() + "\n\n" + footer()

FILES = {
    "AGENTS.md": render_agents_md(),
    "CLAUDE.md": ("# CLAUDE.md\n\n@AGENTS.md\n\n"
                  "<!-- The line above imports AGENTS.md (which contains the adhd-mode\n"
                  "     output rules) into Claude Code's context. This gives you\n"
                  "     always-on ADHD-friendly output without invoking a skill each\n"
                  "     session. For on-demand use, install the i-have-adhd skill:\n"
                  "     https://github.com/ayghri/i-have-adhd -->\n"),
    "rules/cursor/adhd-mode.mdc": render_cursor(),
    "rules/copilot/copilot-instructions.md": render_copilot(),
    "rules/windsurf/.windsurfrules": render_windsurf_legacy(),
    "rules/windsurf/rules/adhd-mode.md": render_windsurf_modern(),
    "rules/gemini/GEMINI.md": render_gemini(),
    "rules/codex/AGENTS.md": render_agents_md(),
    "claude/SKILL.md": render_claude_skill(),
}

ROOT = pathlib.Path(__file__).resolve().parent.parent

def write_files():
    for rel, content in FILES.items():
        path = ROOT / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
        print("wrote " + rel)

def check_files():
    ok = True
    for rel, content in FILES.items():
        path = ROOT / rel
        if not path.exists(): print("MISSING: " + rel); ok = False; continue
        if path.read_text(encoding="utf-8") != content: print("DRIFT: " + rel); ok = False
        else: print("ok: " + rel)
    return ok

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    if args.check: sys.exit(0 if check_files() else 1)
    write_files()

if __name__ == "__main__": main()
