# Worked Examples

## Coordinator said "no restart path", parent proved otherwise
A coordinator reported the dev Postgres (runtime-managed) had been down ~1h with "no VM-side restart path" and left the branch awaiting merge without full gates. The parent checked directly: no postgres binaries on the VM, no service, nothing listening — the DB was runtime-provided, genuinely unrestartable. Rather than accept the wait, the parent installed Postgres locally to build a stand-in for running the gates. Lesson: verify the blocker yourself (section 5), then route around it.

## Merge: trust but verify
A coordinator reported 85/85 verify:landing, 90/90 verify:design, clean typecheck, green build. The parent rebased the branch onto current `origin/main` (4/4 clean), re-ran all four gates independently, got identical counts, then merged `--no-ff` and pushed. Total extra cost: ~2 min. This is the bar for every merge.

## Dead worker recovery
Five worker attempts died across three daemon restarts. The coordinator recovered each time from the existing worktree: one dead worker's UI changes survived as staged changes and were reconciled rather than rebuilt. Always inspect the worktree before re-dispatching.

## Watchdog that replaced the 3h cron
An old 3-hour agent cron burned tokens every fire. Replaced with a zero-cost bash poll every 10 min that wakes an agent ONLY on trouble (stale heartbeat, missing worktree, plan exhausted). Same coverage, ~zero idle cost.
