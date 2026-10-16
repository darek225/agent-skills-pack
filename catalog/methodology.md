# Methodology

Distilled working methods. The procedures, not the stories.

## Agent memory that compounds

- **Layered distillation.** Keep raw daily logs as L0 evidence. Periodically distill upward: atoms (durable facts/decisions), scenarios (how multi-step work played out), persona (who the principal is, how to work with them). Layers stay readable Markdown — never lossy-compress meaning into an opaque summary.
- **Symbolic working state.** Any work spanning multiple turns/sessions keeps a compact STATE.md in its work dir: the goal, key decisions so far, open items, and pointers to raw logs. Read the state file, not the raw transcript.
- **Compile, don't just log.** An intake log records what arrived; durable topic knowledge gets *compiled* into one page per topic, extended (not appended) every time new intake touches it. If new information contradicts a page, flag the contradiction on the page explicitly. When starting work in a covered domain, read the page first.
- **Learning edge.** Every loop needs the long return path: when an accepted result reveals a lesson, it becomes a permanent constraint fed back to the planner — not just a line in a run log. Any failure not converted into a constraint will be met again.

## Loop engineering

- **Cheap gate before expensive work.** Run a deterministic signal scan first (API queries, timestamps, content hashes); if state is unchanged, end the check in code — no model launched.
- **Stable identity for polled items.** Anything checked on a schedule needs an identity stable across polls (content hash, issue ID + timestamp), or every poll spawns duplicate work.
- **Exact checks in code, semantic checks in the cheap model.** Counters, timestamp comparisons, dedup, and routing tables live in scripts. Only genuine meaning-judgments go to a model — and then the cheapest one that clears the bar.
- **Bounded runs.** Every agentic run gets stop conditions up front: what "done" looks like, attempt/spending limits, and what counts as a blocker. Retry only on new evidence.
- **Three corrections, then the plan is wrong.** If three fix attempts fail on the same unit, stop retrying and redesign the plan.

## Context management (for long agent sessions)

- **Cheap elision first, summarization second.** When a working note grows: first replace bulky middle tool output with a short stub carrying the decision-relevant facts (ids, paths, numbers, verdicts); summarize only if still too big. Keep the task statement and most recent turns verbatim.
- **Stubs must be self-sufficient.** Never stash a fact as "see file X" and assume a later session will fetch it — put the distilled fact in the summary itself, with the pointer only as backup.
- **Hard stuck rule.** 5 identical calls, or 5 identical failing calls, in a row = stop and change approach explicitly. 8 identical failing calls = abandon that approach and report the blocker.

## Website pre-build planning

1. Benchmark 3–5 best comparable sites before designing anything.
2. Write the plan down (BUILD_NOTES.md or equivalent) BEFORE writing code.
3. Consult the design resources catalog as ingredients, not a checklist.
4. Mobile-first; personally inspect mobile output before calling it done.
5. Run a design audit (impeccable / web-design-guidelines style) before shipping.
6. Structural uniqueness: shared components are fine as ingredients, but the finished site must never read as the same design re-skinned.

## Coding discipline

- **Tests are sacred.** Never edit, skip, or delete a test to make it pass. For every test written, confirm it would FAIL if the code under test did nothing.
- **Dependencies are verified, not guessed.** Confirm it exists on the official registry, identify the maintainer, check the last ship date. Never guess a package name.
- **Code against the installed version.** Check the installed version and read its actual docs/source before using a library API.
- **Scope discipline.** Change only what the task requires. Spot something else? List it, don't fix it mid-task.
- **Check the right exit code.** `cmd | head && echo OK` lies — `&&` sees `head`'s exit code, not `cmd`'s. Use `cmd; echo "exit: $?"` or `set -o pipefail`.
