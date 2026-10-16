# False Alarm Retraction

## Purpose
Keep user-facing breakage claims honest: verify a reported wall before escalating it as persistent, and explicitly retract an alarm when later evidence contradicts it.

## Workflow
1. When a delegated worker, browser task, or tool reports a wall (logged out, API dead, fallback unavailable) that you are about to relay to the user, verify it first with an independent check: read session or credential state, run a second attempt, or check the most recent successful run. One failed attempt is a data point, not a verdict.
2. If you already told the user something is broken and new evidence contradicts it, retract in the same channel as soon as the contradiction is known. Name the claim you made, state what the new evidence shows, and withdraw the request.
3. If the evidence is ambiguous (the wall may have been real and transient), say so plainly instead of quietly moving on.

## Output Contract
- A retraction names the original claim, the contradicting evidence with its time, and the withdrawn ask — one or two sentences, not an apology essay.
- Breakage claims sent to the user carry the verification that backs them (what check confirmed the wall).

## Operating Rules
- Never escalate a single failed attempt as a persistent, user-action-required blocker without an independent check.
- Retract in the same conversation the alarm went out in, as soon as you know — never report the later success as if the alarm never happened.
- If verification confirms the wall, escalate normally; this changes nothing about real blockers.
- When torn between 'transient glitch' and 'real wall,' report the ambiguity rather than picking a confident story.
