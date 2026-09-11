# adhd-mode

**ADHD-friendly output rules for AI coding assistants — Cursor, GitHub Copilot, Windsurf, Gemini CLI, Codex, Claude Code, and 20+ more tools. Always on. No slash command. No plugin marketplace.**

Drop one `AGENTS.md` in your repo. Every AI coding tool that reads it — and 20+ do, natively — stops burying the answer behind "Great question!" and starts leading with the action you can take right now.

> **What changed:** Your AI assistant now gives you action-first, numbered, no-preamble output — every response, every tool, automatically.

Rules adapted from [i-have-adhd](https://github.com/ayghri/i-have-adhd) by ayghri (MIT) — the original is a Claude Code / Codex / Cursor skill you invoke each session. This is the port that is just **on**.

## The problem

If you have ADHD (or just hate scrolling past filler), every AI coding tool wastes your time:

- **Cursor** buries the fix in context paragraphs.
- **GitHub Copilot** wraps every answer in "Great question!" and "Hope this helps!"
- **Windsurf** narrates instead of acting.
- **Gemini CLI** over-explains before getting to the point.
- **Codex** adds tangents you didn't ask for.

You don't need shorter answers. You need answers shaped so an ADHD brain can **act on them** — lead with the next action, number the steps, end with one thing to do next.

## The fix: 10 rules, one file

| # | Rule | What it does |
|---|---|---|
| 1 | Lead with the next action | First line = something you can do now |
| 2 | Number multi-step tasks | Numbered list, one bounded action per step |
| 3 | End with one concrete next action | One thing under 2 min |
| 4 | Suppress tangents | Finish first, offer second separately |
| 5 | Restate state every turn | "Step 3 of 5 done. Next: X." |
| 6 | Specific time estimates | "15 min" not "a bit" |
| 7 | Make wins visible | Show what works, concretely |
| 8 | Matter-of-fact errors | No "uh oh." Cause + fix. |
| 9 | Cap lists at 5 items | Split into "now" vs "later" |
| 10 | No preamble, no recap, no closers | Start with answer, end when done |

Plus a **pre-send check** (5 deletions before sending) and **6 override conditions** (when to break the rules). Full text in every rule file.

## Before / After

### Before (any tool, default)

> Great question! Let me take a look at your authentication flow. There are a few moving pieces here: the middleware, the token verification, and the cookie handling. Looking at `src/auth.ts`, the `verifyToken` function (around lines 42-58) seems to be using an older `jsonwebtoken` API. One approach would be to update the package and rewrite that function. After making the change, you'd want to run the auth tests to confirm nothing breaks. By the way, you might also want to look at your dependency versions overall. Hope this helps! Let me know if you want to dig deeper.

### After (adhd-mode)

> Run `npm install jsonwebtoken@latest`, then edit `src/auth.ts:42`.
>
> 1. Open `src/auth.ts`
> 2. Replace `verifyToken` (lines 42-58) with the snippet below
> 3. Run `npm test -- auth.spec.ts`
>
> Next: paste the first failing line if any test fails.

**That difference is the entire product.** Screenshot it. Share it. That's how this spreads.

## Install

### Option 1: One file, 20+ tools (fastest)

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/AGENTS.md
```

For Claude Code, also grab `CLAUDE.md`:

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/CLAUDE.md
```

That's it. Codex, Cursor, Copilot cloud agent, Windsurf, Gemini (with config), Aider, Zed, and 20+ others read `AGENTS.md` automatically.

### Option 2: One-command installer (detects all tools, merges safely)

```bash
curl -sSL https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/install/install.sh | bash
```

Windows: clone the repo, run `install\install.ps1`.

### Option 3: Per-tool files (strongest always-on guarantee)

<details>
<summary><b>Cursor</b> — .mdc with alwaysApply: true</summary>

```bash
mkdir -p .cursor/rules
curl -o .cursor/rules/adhd-mode.mdc https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/rules/cursor/adhd-mode.mdc
```
</details>

<details>
<summary><b>GitHub Copilot</b> — .github/copilot-instructions.md</summary>

```bash
mkdir -p .github
curl -o .github/copilot-instructions.md https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/rules/copilot/copilot-instructions.md
```
</details>

<details>
<summary><b>Windsurf</b> — .windsurf/rules/ (modern format)</summary>

```bash
mkdir -p .windsurf/rules
curl -o .windsurf/rules/adhd-mode.md https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/rules/windsurf/rules/adhd-mode.md
```
</details>

<details>
<summary><b>Gemini CLI</b> — GEMINI.md</summary>

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/rules/gemini/GEMINI.md
```

Tip: configure Gemini CLI to read `AGENTS.md` instead by adding `{"context":{"fileName":"AGENTS.md"}}` to `.gemini/settings.json`.
</details>

<details>
<summary><b>Codex</b> — AGENTS.md (same as Option 1)</summary>

Codex reads `AGENTS.md` natively. No extra file needed.
</details>

<details>
<summary><b>Claude Code</b> — CLAUDE.md or SKILL.md plugin</summary>

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/CLAUDE.md
```

For the on-demand plugin format (invoke-per-session), use `claude/SKILL.md` from this repo, or install the [original i-have-adhd](https://github.com/ayghri/i-have-adhd).
</details>

## Supported tools

| Tool | Primary (AGENTS.md) | Per-tool file | Always-on? |
|---|---|---|---|
| Codex | Yes (native) | — | Yes |
| Cursor | Yes (native) | `.cursor/rules/adhd-mode.mdc` | Yes (`alwaysApply: true`) |
| GitHub Copilot (cloud agent) | Yes (native) | — | Yes |
| GitHub Copilot (IDE chat) | — | `.github/copilot-instructions.md` | Yes |
| Windsurf | Yes (experimental) | `.windsurf/rules/adhd-mode.md` | Yes (`trigger: always_on`) |
| Gemini CLI | Yes (with config) | `GEMINI.md` | Yes |
| Aider, Zed, Factory, Jules, Devin, Amp | Yes (native) | — | Yes |
| Claude Code | Via `CLAUDE.md` → `@AGENTS.md` | `SKILL.md` (plugin) | Yes (import) / On invocation (plugin) |

## FAQ

<details>
<summary><b>What is adhd-mode?</b></summary>

adhd-mode is a set of 10 output rules that make AI coding assistants produce ADHD-friendly output. Instead of burying the answer behind preamble, tangents, and pleasantries, the AI leads with the next action, numbers multi-step tasks, and ends with one concrete next step. It works by placing a single `AGENTS.md` file in your repository that 20+ AI coding tools read automatically.
</details>

<details>
<summary><b>How is this different from i-have-adhd?</b></summary>

[i-have-adhd](https://github.com/ayghri/i-have-adhd) is a skill you invoke each session (`/i-have-adhd` in Claude Code, `$i-have-adhd` in Codex). adhd-mode is always on — you paste one file and every response is ADHD-shaped from the first message. It also covers tools the original doesn't (Copilot IDE chat, Windsurf modern format, Gemini CLI, Aider, Zed). The 10 rules are the same, credited and MIT-licensed. See [docs/COMPARISON.md](docs/COMPARISON.md) for the full breakdown.
</details>

<details>
<summary><b>Do I need an ADHD diagnosis to use this?</b></summary>

No. The rules help anyone who wants action-first, no-filler AI output. "ADHD-friendly" describes the output shape, not a medical requirement.
</details>

<details>
<summary><b>Which tools are supported?</b></summary>

Codex, Cursor, GitHub Copilot (cloud agent + IDE), Windsurf, Gemini CLI, Claude Code, Aider, Zed, Factory, Jules, Devin, Amp, and 20+ other tools that read `AGENTS.md` natively. See the table above.
</details>

<details>
<summary><b>How do I turn it off?</b></summary>

Say "stop adhd mode" or "normal mode" in any chat. The AI returns to its default output style for the rest of the session.
</details>

<details>
<summary><b>Will this slow down my AI or waste tokens?</b></summary>

The rules are ~2KB. Every tool loads them as part of the system prompt — negligible token cost. The output is shorter (no preamble, no closers), so responses actually use fewer tokens.
</details>

<details>
<summary><b>Can I customize the rules?</b></summary>

Yes. Fork the repo, edit `scripts/build.py` (the single source of truth), run `python scripts/build.py` to regenerate all files. See [CONTRIBUTING.md](CONTRIBUTING.md).
</details>

<details>
<summary><b>Is this free?</b></summary>

Yes. MIT licensed. The rules are adapted from [i-have-adhd](https://github.com/ayghri/i-have-adhd) (also MIT).
</details>

## How it works

All rule files are generated from a single source (`scripts/build.py`). CI asserts parity — the 10 rules are identical across every file. To customize: fork, edit `scripts/build.py`, run it, commit, push.

To add a new tool: see [CONTRIBUTING.md](CONTRIBUTING.md) and the [new-tool issue template](.github/ISSUE_TEMPLATE/new-tool.md).

## For Claude Code / Codex / Cursor users

The [original plugin](https://github.com/ayghri/i-have-adhd) gives you the same 10 rules on demand. Use the original if you like invoking per session; use adhd-mode if you want it always on. Same rules, same author credited. They complement each other.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for planned tools, features, and community milestones.

## License

MIT. The 10 output rules are adapted from [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT).
