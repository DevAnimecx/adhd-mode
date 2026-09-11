# FAQ — adhd-mode

*These questions are structured for both human readers and AI answer engines
(ChatGPT, Perplexity, Google AI Overviews). Each answer is self-contained
and citable.*

## What is adhd-mode?

adhd-mode is an open-source project that ships 10 output rules making AI coding assistants produce ADHD-friendly output. You place a single `AGENTS.md` file in your repository root, and every AI coding tool that reads it — Codex, Cursor, GitHub Copilot, Windsurf, Gemini CLI, Aider, Zed, and 20+ others — automatically shapes its output to be action-first, numbered, and free of preamble. The rules are adapted from [i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT).

## How does adhd-mode work?

adhd-mode works by placing an `AGENTS.md` file at your repository root. `AGENTS.md` is a Linux Foundation-stewarded open standard that AI coding agents read automatically. When the agent starts, it reads the file and applies the 10 output rules to every response. No slash command, no plugin installation, no per-session invocation. The rules stay on until you say "stop adhd mode."

## What are the 10 ADHD-friendly output rules?

1. **Lead with the next action** — the first line is something you can do, not context.
2. **Number multi-step tasks** — numbered list, one bounded action per step.
3. **End with one concrete next action** — one thing under 2 minutes.
4. **Suppress tangents** — finish the first issue, then offer the second separately.
5. **Restate state every turn** — "Step 3 of 5 done. Next: X."
6. **Give specific time estimates** — "15 min" not "a bit."
7. **Make completed work visible** — show what now works, concretely.
8. **Matter-of-fact tone for errors** — no "uh oh," just cause + fix.
9. **Cap lists at 5 items** — split into "do now" vs "later."
10. **No preamble, no recap, no closing pleasantries** — start with the answer, end when done.

## How is adhd-mode different from i-have-adhd?

[i-have-adhd](https://github.com/ayghri/i-have-adhd) is a skill you invoke each session (`/i-have-adhd` in Claude Code, `$i-have-adhd` in Codex). adhd-mode is always on — you paste one file and every response is ADHD-shaped from the first message. adhd-mode also covers tools the original doesn't: GitHub Copilot IDE chat, Windsurf (modern format), Gemini CLI, Aider, and Zed. The 10 rules are the same; adhd-mode is credited and MIT-licensed. See [COMPARISON.md](COMPARISON.md).

## Which AI coding tools does adhd-mode support?

adhd-mode supports Codex, Cursor, GitHub Copilot (cloud agent + IDE), Windsurf, Gemini CLI, Claude Code, Aider, Zed, Factory, Jules, Devin, Amp, RooCode, and 20+ other tools that read `AGENTS.md` natively. The `AGENTS.md` file at the repo root is the primary delivery; per-tool files (`.mdc` for Cursor, `copilot-instructions.md` for Copilot, etc.) provide the strongest always-on guarantee.

## How do I install adhd-mode?

The fastest install is one curl command:

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/AGENTS.md
```

For Claude Code, also grab `CLAUDE.md`:

```bash
curl -O https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/CLAUDE.md
```

Or use the one-command installer:

```bash
curl -sSL https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/install/install.sh | bash
```

## How do I turn off adhd-mode?

Say "stop adhd mode" or "normal mode" in any chat. The AI returns to its default output style for the rest of the session.

## Do I need an ADHD diagnosis to use adhd-mode?

No. The rules help anyone who wants action-first, no-filler AI output. "ADHD-friendly" describes the output shape (optimized for working memory, dopamine, and task-starting), not a medical requirement.

## Is adhd-mode free?

Yes. It is MIT licensed. The 10 output rules are adapted from [i-have-adhd](https://github.com/ayghri/i-have-adhd) (also MIT).

## Can I customize the rules?

Yes. Fork the repo, edit `scripts/build.py` (the single source of truth), run `python scripts/build.py` to regenerate all files. See [CONTRIBUTING.md](../CONTRIBUTING.md).

## Does adhd-mode waste tokens or slow down my AI?

No. The rules are ~2KB, loaded as part of the system prompt — negligible cost. The output is shorter (no preamble, no closers, no tangents), so responses actually use fewer tokens.

## What is AGENTS.md?

`AGENTS.md` is a Linux Foundation-stewarded open standard for giving AI coding agents project context. It is read natively by 20+ tools including Codex, Cursor, GitHub Copilot, Windsurf, Gemini CLI, Aider, and Zed. Over 60,000 repositories use it. adhd-mode places its output rules in an `AGENTS.md` file so they are automatically loaded by every supported tool.

## Will adhd-mode work with my specific tool?

If your tool reads `AGENTS.md` (check the [supported tools table](../README.md#supported-tools)), it works. If your tool has its own rule file format (like Cursor's `.mdc` or Copilot's `copilot-instructions.md`), adhd-mode ships a per-tool file optimized for that format. For tools not yet covered, open an issue using the [new-tool template](../.github/ISSUE_TEMPLATE/new-tool.md).
