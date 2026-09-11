# adhd-mode vs i-have-adhd — Detailed Comparison

## At a glance

| Feature | i-have-adhd | adhd-mode |
|---|---|---|
| **What it is** | A Claude Code / Codex / Cursor skill | A universal `AGENTS.md` + per-tool files |
| **Activation** | Invoke per session (`/i-have-adhd`, `$i-have-adhd`) | Always on (auto-loaded by the tool) |
| **Tools covered** | Claude Code, Codex, Cursor, Qwen Code | 20+ (Codex, Cursor, Copilot, Windsurf, Gemini, Claude, Aider, Zed, ...) |
| **Install** | Plugin marketplace commands | One `curl` or one file paste |
| **Copilot support** | No | Yes (`copilot-instructions.md` + AGENTS.md) |
| **Windsurf support** | No | Yes (modern `.windsurf/rules/` + legacy) |
| **Gemini CLI support** | No | Yes (`GEMINI.md` + AGENTS.md config) |
| **Claude Code** | Plugin (invoke per session) | `CLAUDE.md` → `@AGENTS.md` (always on) + `SKILL.md` (plugin) |
| **Rule text** | Original | Identical (adapted, credited, MIT) |
| **License** | MIT | MIT |
| **Customization** | Fork, edit `SKILL.md` | Fork, edit `scripts/build.py`, regenerate |
| **Anti-drift** | Single file | Single-source build + parity CI |
| **Installer** | Manual per tool | One-command, safe-merge, idempotent |

## When to use which

**Use i-have-adhd if:**
- You use Claude Code and like invoking the skill per session.
- You want on-demand control (turn it on for some tasks, off for others).
- You want the original, maintained by the original author.

**Use adhd-mode if:**
- You use 2+ AI tools and want consistent behavior across all of them.
- You want it always on, no slash command.
- You use GitHub Copilot, Windsurf, or Gemini CLI (not covered by the original).
- You want a one-command installer.

**Use both:**
- They complement each other. Claude Code users can install the original plugin for on-demand use AND `CLAUDE.md` with `@AGENTS.md` for always-on. Same rules, no conflict.

## Relationship

adhd-mode is **not** a competitor. It is a port that credits and links to the original. The README explicitly says "Rules adapted from i-have-adhd by ayghri (MIT)." If the original expands to cover Copilot/Windsurf/Gemini, adhd-mode's installer, per-tool optimizations, and parity CI remain useful.

## Star count (verified 2026-09-11)

| Repo | Stars | Forks | Created |
|---|---|---|---|
| [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) | ~25,700 | ~1,600 | 2026-05-13 |
| adhd-mode | 0 (not yet launched) | 0 | 2026-09-11 |
