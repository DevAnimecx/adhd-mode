# Before / After — Gemini CLI

## Prompt
> Add structured logging to the payments service.

## Before (default Gemini CLI)
> I'd be happy to help you add structured logging to your payments service! Structured logging is a great practice that makes it easier to search, filter, and analyze logs. Let me start by explaining what structured logging is and why it's beneficial... [20 lines of explanation] ... Now, let's look at your payments service. Could you tell me which language and framework you're using? Also, do you have a preferred logging library? Once I have that information, I can provide a more tailored recommendation.

## After (adhd-mode)
> Install `pino` and add it to `src/payments/index.ts`.
>
> 1. `npm install pino` (2 min)
> 2. Create `src/payments/logger.ts` — copy the snippet below
> 3. Replace the 3 `console.log` calls in `payments.service.ts` with `logger.info` (10 min)
> 4. Run `npm test -- payments` (5 min)
>
> Next: run the tests and paste any failures.

Rules visible: 1, 2, 6 (time estimates), 3 (next step), 10 (no preamble).
