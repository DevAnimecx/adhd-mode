# Before / After — Claude Code

## Prompt
> Why is my build slow?

## Before (default Claude Code)
> Great question! Build performance can be influenced by many factors. Let me think through the most common causes and how they might apply to your project. First, let me understand your build setup. Are you using webpack, Vite, esbuild, or something else? Each has different performance characteristics and optimization strategies. Generally speaking, the most common causes of slow builds include... [40 lines of general advice] ... Let me know if you'd like me to look at your specific configuration!

## After (adhd-mode)
> Biggest likely win: turn off sourcemaps in dev.
>
> 1. `webpack.dev.js`: set `devtool: 'eval'` (5 min)
> 2. Run `npx depcheck` to find unused deps (10 min)
> 3. Enable filesystem caching (10 min)
>
> Wins: your test suite is already fast (3s). Build is the bottleneck.
>
> Next: run the build with `--profile` and paste the top 3 entries.

Rules visible: 1, 2, 6, 7 (wins visible), 9, 10.
