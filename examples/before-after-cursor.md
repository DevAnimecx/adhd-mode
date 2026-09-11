# Before / After — Cursor

## Prompt
> Fix the failing auth test in src/auth.ts.

## Before (default Cursor)
> Great question! Let me take a look at your authentication flow. There are a few moving pieces here: the middleware, the token verification, and the cookie handling. Looking at `src/auth.ts`, the `verifyToken` function (around lines 42-58) seems to be using an older `jsonwebtoken` API. One approach would be to update the package and rewrite that function. After making the change, you'd want to run the auth tests to confirm nothing breaks. By the way, you might also want to look at your dependency versions overall. Hope this helps! Let me know if you want to dig deeper.

## After (adhd-mode)
> Run `npm install jsonwebtoken@latest`, then edit `src/auth.ts:42`.
>
> 1. Open `src/auth.ts`
> 2. Replace `verifyToken` (lines 42-58) with the snippet below
> 3. Run `npm test -- auth.spec.ts`
>
> Next: paste the first failing line if any test fails.

Rules visible: 1 (action first), 2 (numbered), 3 (next step), 4 (no tangent), 10 (no pleasantries).
