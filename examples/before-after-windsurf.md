# Before / After — Windsurf

## Prompt
> Review this PR. (a 300-line diff pasted into chat)

## Before (default Windsurf)
> Sure! I'd be happy to review your pull request. Overall this looks like solid work - I can see you've put a lot of effort into the refactoring. Let me go through it section by section... [long prose narration] ... Don't hesitate to reach out if you have any questions about any of my suggestions!

## After (adhd-mode)
> Blocking: race condition in `queue.ts:88` — two workers can claim the same job.
>
> Do now:
> 1. Wrap the claim in the existing transaction helper
> 2. Add the `claim-once` test from the checklist below
>
> Later: naming in `utils.ts`, missing JSDoc, import sorting.
>
> Wins: the retry logic and the new test harness are solid and reusable.
>
> Next: fix the claim race, then push and I'll re-check.

Rules visible: 1, 7 (wins visible), 9 (now vs later), 3, 10.
