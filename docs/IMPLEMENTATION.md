# Implementation Guide — How Each Tool Loads Rules

*Deep technical reference. Verified 2026-09-11.*

## AGENTS.md (universal)

`AGENTS.md` is a Linux Foundation-stewarded open standard. When an AI coding agent starts, it walks from the current directory up to the project root (identified by `.git` or equivalent), reading every `AGENTS.md` it finds. Files are concatenated root-down; the nearest file wins on conflict.

**Tools that read AGENTS.md natively:** Codex, Cursor, GitHub Copilot (cloud agent), Windsurf (experimental), Aider, Zed, Factory, Jules, Devin, Amp, RooCode, Augment, Warp, and 20+ others.

**adhd-mode's AGENTS.md** wraps the 10 rules under a `## Output Style` section, demoting rule headings one level so they read as output rules, not project rules.

## Cursor (.cursor/rules/*.mdc)

Cursor uses `.mdc` (Markdown Cursor) files in `.cursor/rules/`. Each file has YAML frontmatter with three fields:

- `description` — helps the agent decide relevance
- `globs` — file patterns that trigger the rule
- `alwaysApply` — when `true`, injected into every chat

adhd-mode uses `alwaysApply: true` so the rules are in every Agent chat, regardless of context. Globs and description are ignored when `alwaysApply` is true.

**Note:** Cursor also reads `AGENTS.md` natively. Both can coexist; explicit `.mdc` rules override `AGENTS.md` guidance.

## GitHub Copilot (.github/copilot-instructions.md)

Copilot reads two types of custom instructions:

1. **Repository-wide:** `.github/copilot-instructions.md` — applies to all Copilot requests in the repo.
2. **Path-specific:** `.github/instructions/*.instructions.md` with `applyTo` frontmatter — applies to specific file patterns.

adhd-mode uses the repository-wide file. Copilot's cloud agent also reads `AGENTS.md` natively, so placing `AGENTS.md` at the root covers the cloud agent too.

**Adherence:** Copilot instructions are advisory — they shape but don't strictly control output. They get diluted in long chats. Mitigation: re-paste the instructions or reference them mid-conversation.

## Windsurf (.windsurf/rules/*.md)

Windsurf (formerly Codeium Cascade) uses `.windsurf/rules/*.md` files with YAML frontmatter:

- `description` — what the rule is about
- `trigger` — one of `always_on`, `model_decision`, `glob`, `manual`
- `globs` — required when `trigger: glob`

adhd-mode uses `trigger: always_on` so the rules are included in every message. The legacy `.windsurfrules` file at the repo root also works and is kept as a fallback.

**Limit:** 12,000 characters per workspace rule file. adhd-mode's rules are ~2.5KB — well within the limit.

## Gemini CLI (GEMINI.md)

Gemini CLI reads `GEMINI.md` files hierarchically:

1. **Global:** `~/.gemini/GEMINI.md`
2. **Project root:** `./GEMINI.md`
3. **Subdirectory:** `./src/GEMINI.md` (JIT context)

All found files are concatenated and sent with every prompt. adhd-mode places `GEMINI.md` at the project root.

**Alternative:** Configure Gemini CLI to read `AGENTS.md` instead by adding `{"context":{"fileName":"AGENTS.md"}}` to `.gemini/settings.json`.

## Codex (AGENTS.md)

Codex reads `AGENTS.md` from the project root and walks down from the root to the current directory. It also reads `~/.codex/AGENTS.md` for global instructions. Files are concatenated root-down with a 32 KiB total cap.

**Override:** `AGENTS.override.md` takes precedence over `AGENTS.md` in the same directory.

## Claude Code (CLAUDE.md + SKILL.md)

Claude Code reads `CLAUDE.md` (not `AGENTS.md`) from the project root and `~/.claude/CLAUDE.md` for global instructions.

**Always-on approach:** adhd-mode's `CLAUDE.md` contains `@AGENTS.md` — Claude Code's import syntax that pulls `AGENTS.md` contents into its context. This gives always-on ADHD output.

**Plugin approach:** `SKILL.md` with `disable-model-invocation: true` makes the rules available as a plugin you invoke with `/adhd-mode`. This mirrors the original i-have-adhd's activation model.

## Test protocol

To verify rules work in each tool, use these 6 canonical prompts:

| # | Prompt | Rules tested |
|---|---|---|
| P1 | "Fix the failing auth test in src/auth.ts" | 1 (action first), 2 (numbered), 3 (next step) |
| P2 | "Why is my build slow?" | 4 (no tangents), 9 (≤5 list), 10 (no preamble) |
| P3 | Feed it a task that errors out | 8 (matter-of-fact errors), 3 |
| P4 | "Review this PR" (paste a diff) | 9 (now vs later), 7 (wins visible) |
| P5 | "Add structured logging to payments" | 6 (time estimate), 2 |
| P6 | "Explain how the auth flow works" | Override — normal explanation is correct |

Score pass / partial / fail per rule per tool. Record in `tests/results.md`.
