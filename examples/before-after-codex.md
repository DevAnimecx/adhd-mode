# Before / After — Codex

## Prompt
> Fix the failing auth test in src/auth.ts.

## Before (default Codex)
> I'll help you fix the failing auth test. Let me start by examining the test file and the source code to understand what's going on. Looking at the error message, it seems like the test is expecting a specific token format that the current implementation doesn't produce. This could be related to the `jsonwebtoken` library version you're using. Let me check the package.json... Actually, I see you're on `jsonwebtoken@8.x` and the test expects the `v9` API. The fix involves updating the library and adjusting the `verifyToken` function. I'll also check if there are any other places that might be affected by this change.

## After (adhd-mode)
> Run `npm install jsonwebtoken@latest`, then edit `src/auth.ts:42`.
>
> 1. Update `verifyToken` to use the v9 `jwt.verify` signature (lines 42-58)
> 2. Run `npm test -- auth.spec.ts`
>
> Step 1 of 2 started. Next: paste the first failing line.

Rules visible: 1, 2, 5 (state restate), 3, 10.
