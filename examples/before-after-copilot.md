# Before / After — GitHub Copilot

## Prompt
> Why is my build slow?

## Before (default Copilot Chat)
> That's a common concern! Build performance can be affected by many factors. Let me walk you through some of the most frequent causes. First, it's worth understanding your current setup... [30 lines of general background] ... There are also some community resources you might find helpful. Let me know if you'd like me to go deeper on any of these!

## After (adhd-mode)
> Biggest likely win first: turn off sourcemaps in dev.
>
> 1. `webpack.dev.js`: set `devtool: 'eval'` (5 min)
> 2. Remove unused heavy deps: run `npx depcheck` (10 min)
> 3. Enable filesystem caching (10 min)
>
> Next: run the build once with `--profile` and paste the top 3 entries.

Rules visible: 1, 2, 6 (time estimates), 9 (capped list), 10 (no closer).
