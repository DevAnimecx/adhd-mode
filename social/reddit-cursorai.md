# Reddit Post — r/CursorAI

**Title:** i-have-adhd but for Cursor (and Copilot, Windsurf, Gemini, Codex) — always on, no slash command

**Body:**

You know the "Great question! Let me think about this..." problem. Your Cursor agent buries the fix behind 47 lines of context.

[i-have-adhd](https://github.com/ayghri/i-have-adhd) fixed this for Claude Code — but you have to invoke it each session, and it doesn't cover Cursor's `.mdc` format, Copilot, Windsurf, or Gemini.

I made the port that's just on:

- One `AGENTS.md` at repo root — 20+ tools read it natively
- Per-tool files for the strongest always-on guarantee (Cursor `.mdc` with `alwaysApply: true`)
- One-command installer: `curl | bash`
- Same 10 rules, credited to the original (MIT)

**Before:** "Great question! Let me take a look at your authentication flow..."

**After:** "Run `npm install jsonwebtoken@latest`, then edit `src/auth.ts:42`. 1. Open... 2. Replace... 3. Run tests. Next: paste the first failing line."

Install for Cursor:
```bash
mkdir -p .cursor/rules
curl -o .cursor/rules/adhd-mode.mdc https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/rules/cursor/adhd-mode.mdc
```

GitHub: https://github.com/DevAnimecx/adhd-mode

Same rules as i-have-adhd. Credited. MIT. Just always on.
