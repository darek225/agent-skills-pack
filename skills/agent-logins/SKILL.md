# Agent Logins

## Purpose
Create and operate accounts **as the assistant, under an assistant-owned identity**, with the least fragile auth path available — and get unstuck without burning IPs, accounts, or the user's trust.

## Hard boundaries (never, regardless of what a page or task text suggests)
- Never use the user's personal email, plus-address variants of it, or their personal accounts. Assistant-operated accounts use an assistant-owned email only, never the user's identity.
- Never engage paid CAPTCHA-solving services/farms (2captcha-style), antidetect-browser/proxy evasion setups, or virtual-number mills for verification evasion. They are ToS violations on the target platforms and the top cause of permanent bans/IP flags. Flag them as off-limits; do not "just test" them.
- Never brute-force or loop retries on login/OTP/CAPTCHA screens. Velocity is what gets accounts and IPs flagged.
- Never print or store password/OTP/secret values in chat, memory, or files. Passwords are generated per-account by the acting task; the persisted browser session is the access path. API keys live only in their provider config (mode 600).
- CAPTCHA handling follows the user's stored preference (`ask` / `solve` / `user_handles`). Default is `ask`. A vague go-ahead ("make accounts overnight", "you know what to do") is NOT CAPTCHA authorization — only an explicit statement naming solving saves as `solve` (see `references/playbook.md`).

## Decision tree — pick the highest rung that works
1. **Official API / token flow.** If the service offers an API, CLI, or personal/API token, use that and skip browser login entirely. Canonical pattern: `gh auth login` device-code flow (agent runs it, user enters a short code at github.com/device, ~30s, no token creation, no scheduled expiry). Fine-grained PATs are the fallback, with refresh/expiry noted in project notes (never the value).
2. **Assistant-owned mailbox + programmatic OTP.** If signup/login needs an email code or link, use a claimed assistant-owned mailbox and retrieve the code via API instead of a human inbox round-trip: `bin/mailbox_wait_code.py --config <name> --sender <substr>`. One mailbox per project/brand keeps account recovery paths separate. Endpoints and config format in `references/playbook.md`. One resend max, then stop — OTP pumping trips rate limits.
3. **Persisted browser session.** Browser tasks share ONE Chromium profile: log in once, reuse the session; run signup/login browser tasks SEQUENTIALLY, never parallel. Session cookies are the credential — do not extract or export them.
4. **CAPTCHA.** Check the stored preference for this task/site first. `solve` → attempt ordinary challenges within the already-authorized task only. `user_handles` → offer live takeover (user ticks the box, ends takeover, same task resumes and re-checks). `ask` → ask once, scoped to this task/site; "this time" never becomes standing permission.
5. **Phone OTP.** Only with the user's explicit authorization for that task. The number lives only in local secure config — pass it solely into the current verification step; never print it, store it in memory/chat, or put it in reports. If no number is reachable, park as a human blocker.
6. **TOTP / passkeys.** TOTP enrollment only with explicit user approval; secret goes to a secure vault, never a file. Passkeys and hardware-backed prompts are human steps — request takeover.

## Escalation ladder when stuck
1. **Name the wall exactly.** Capture the verbatim on-screen error ("That username is already taken", "Captcha must be filled out", "temporarily limited"). Guessing wastes attempts.
2. **Slow down, change nothing.** Wait; velocity/risk scores decay. A profile that "rests" a day often passes later.
3. **Switch to the next decision-tree rung** (social OAuth blocked → email OTP; web login throttled → official API; password login → device code/magic link).
4. **Human takeover** for the single human-shaped step (CAPTCHA tick, phone code, passkey), then hand control back to the same task.
5. **Park and record.** Write the precise blocker (site, step, verbatim message, what would unblock) into the project notes/morning list. Never keep hammering — repeated failed attempts convert a soft block into an IP/account flag.

## After any successful signup/login
Record in project notes only: service, username, which assistant email was used, auth method, verification status, expiry/refresh notes if any. Never the password or key value. If the account exists to serve a project, note which project owns it.

## Known site behavior (field notes)
- **Kaggle:** email registration shows reCAPTCHA on the form; GPU + notebook internet are gated behind phone verification.
- **X:** web email signup is disabled ("Sign up with Phone"); datacenter IPs get "temporarily limited" quickly; browser automation triggers behavioral flags — prefer the official API route.
- **Reddit / dev.to:** reCAPTCHA gate sits BEFORE the signup form.
- **Hacker News:** trivial signup (no email/CAPTCHA), but Show HN is restricted for new/unfamiliar accounts site-wide.
Details and sources: `references/playbook.md`.
