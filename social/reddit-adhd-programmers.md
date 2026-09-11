# Reddit Post — r/ADHD_Programmers

**Title:** I made my AI coding tools stop burying the answer. It's been life-changing.

**Body:**

I have ADHD. Every AI coding assistant wastes my working memory:

- "Great question!" (I didn't ask for a conversation)
- 47 lines of context before the actual fix
- Tangents I didn't ask for
- "Hope this helps!" (it didn't, I'm still scrolling)

[i-have-adhd](https://github.com/ayghri/i-have-adhd) fixed this for Claude Code. But I use Cursor + Copilot + Gemini. So I ported the same 10 rules to work in every tool — always on, no slash command.

One file in my repo. Every AI tool reads it. Every response is now:
- Action first (not context first)
- Numbered steps (not prose)
- One concrete next action (not "let me know!")
- No preamble, no closers, no tangents

It's called adhd-mode. Same 10 rules as i-have-adhd, credited and MIT-licensed.

**Before:** "Great question! Let me take a look..."

**After:** "Run `npm install jsonwebtoken`, then edit `src/auth.ts:42`. 1. Open... 2. Replace... 3. Run tests. Next: paste the first failing line."

One command to install:
```bash
curl -sSL https://raw.githubusercontent.com/DevAnimecx/adhd-mode/main/install/install.sh | bash
```

GitHub: https://github.com/DevAnimecx/adhd-mode

If it saved you one scroll past one "Great question!", star it.
