# Hacker News — Show HN Post

**Title:** Show HN: adhd-mode — Always-on ADHD-friendly output rules for every AI coding tool

**Body:**

Hi HN,

I've been frustrated by AI coding assistants that bury the answer behind "Great question!" and 47 lines of context. [i-have-adhd](https://github.com/ayghri/i-have-adhd) (25k+ stars) fixed this for Claude Code — but you have to invoke it each session, and it doesn't cover Copilot, Windsurf, or Gemini CLI.

adhd-mode ships the same 10 rules as a single `AGENTS.md` file that 20+ AI coding tools read natively (via the Linux Foundation-stewarded AGENTS.md standard). It's always on — no slash command, no plugin marketplace.

The 10 rules: lead with the action, number multi-step tasks, end with one concrete next step, suppress tangents, restate state, give time estimates, make wins visible, matter-of-fact errors, cap lists at 5, no preamble/closers.

One-command install:
```bash
curl -sSL https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/install/install.sh | bash
```

Or just drop `AGENTS.md` in your repo root. That's it.

Rules adapted from i-have-adhd (MIT), credited. The repo also has per-tool files (Cursor `.mdc` with `alwaysApply: true`, Copilot `copilot-instructions.md`, Windsurf `.windsurf/rules/` with `trigger: always_on`, etc.) for the strongest always-on guarantee.

GitHub: https://github.com/DevAnimecx/adhd-mode

Happy to answer questions about the rules, the tool coverage, or the AGENTS.md standard.
