# Coordinator Ops

## Purpose
Make delegated multi-agent builds trustworthy: the coordinator's contract, how to verify its work independently, how to recover from dead workers, and how to detect stalls cheaply.

## Workflow

### 1. Dispatch with a contract, not just a task
Every coordinator gets, in its prompt:
- **Worktree + branch**: fresh `git worktree`, branch off current `origin/main`. Never build on the main tree.
- **Lock file**: path + exact JSON schema. Coordinator writes `{"status":"building","started_at","heartbeat","phase","last_commit_sha",...}` and refreshes the heartbeat **every ≤15 min AND on every commit, push, and gate run**.
- **Terminal states only**: `awaiting-merge` (with `gate_summary` incl. exact counts) or `failed` (with `failure_reason`). Never left `building`. An empty final report = failure.
- **Never merge to main itself.** It pushes the branch and reports; the parent merges.
- **Honest-skip rule**: if the work turns out already done or non-viable, no padding commits — report why and name the next slice.

### 2. Verify independently before merging
Never merge on the coordinator's report alone:
1. `git fetch origin`, rebase the branch onto current `origin/main` (expect zero conflicts for isolated tracks; resolve carefully otherwise).
2. Re-run the gates yourself on the rebased tree: typecheck, the relevant test/verify suites, the build. Read exact counts; compare against the coordinator's claims.
3. Only then `git merge --no-ff` into the main tree and push.

### 3. Recover, don't restart
- **Dead worker, committed work survives**: check `git log`/staged changes in the worktree before re-dispatching — a dead worker's commits are often intact and verifiable.
- **Daemon restarts kill workers silently**: the heartbeat going stale (>30 min while `building`) is the signal. Re-dispatch a recovery coordinator pointed at the existing worktree/branch, not a fresh one.
- **Worktree HEAD unchanged 90+ min while `building`** = alive but stuck: inspect, then redirect or replace.

### 4. Watch cheaply, wake rarely
Deterministic condition → hook/poll script (zero-LLM), not an agent cron:
- Poll script under a hooks dir, state under a state dir, ends in exactly one `silent`/`wake`.
- Wake only on: stale heartbeat (>30 min building), `awaiting-merge` older than 2h, missing worktree, missing lock, or plan exhausted.
- `dry_run` until the script is correct, then `enable`. New hooks start disabled.

### 5. Distrust "impossible"
When a coordinator reports something can't be done (no restart path, tool unavailable, blocked):
1. Check it yourself with direct tools before accepting — coordinators satisfice.
2. Prefer building a stand-in over waiting (e.g. install the missing service locally) when the wait has no ETA.
3. Record the actual constraint found (with the commands run) so the next session doesn't re-learn it.

## Operating Rules
- GitHub work headless: `git`/`gh` CLI only, never the browser.
- One coordinator per track; workers fan out under it, never sideways.
- Lock writes are JSON via file tools/exec, never hand-edited prose.
- Production deploys of agent-authored commits need the recognized-author ritual (see references/deploy-ritual.md).
- Keep this file to the operational core; worked examples live in `references/`.
