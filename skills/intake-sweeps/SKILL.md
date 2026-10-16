# Process intake sweeps end to end

Use when a principal keeps streaming links, repos, papers, or tools: process each batch completely so nothing is "installed" without being usable.

## Set the acceptance bar first

- Treat done as cloned, verified working, documented, cataloged, propagated into the relevant workflow, and restoration-noted for environment replacement. A sweep reported done at installed or cloned is not done.

- Keep a per-item status table from the start with one row per link or repo and a column for each acceptance step. Update it as you go so the final report writes itself.

- Scope each item before touching it: what it is, where it applies, and what implemented means for it. Park items that do not apply with a one-line reason instead of forcing them in.

## Fetch each item once, then ask

- Make one bounded fetch attempt per streamed link. If it is login-walled, paywalled, or otherwise unreadable, stop and ask the principal to paste the text or the key excerpt.

- Do not grind alternate mirrors, caches, or fetch paths after the first failure. One failed attempt plus a fast ask beats a long silent grind.

- Treat pasted content as the source and move on. Record what was unreadable and why in the item's row.

## Verify it really works

- For repos, clone, install per its own instructions, and run its own check, such as its tests, a smoke command, or the exact operation the principal will repeat. A clone with no successful run is not verified.

- For methods and write-ups, extract the actionable steps and confirm each one against the real tool or service. Label anything you could not run as untested.

- Record the installed version or commit, the date, and the verification command in the item's row. Future sessions restore from this record, not from memory.

## Document, catalog, propagate, and report

- Write durable notes where they belong: tool quirks in the project notes or environment docs, reusable methods as skills, service setup as connector docs. Link each note from the item's row.

- Propagate what applies into the live workflow: add the capability note to the affected goal, wire the helper into the pipeline, or schedule the restoration step. An install that changes nothing downstream is not implemented.

- Note the environment-replacement restoration path for anything that lives outside the repo, such as systemd units, keys, or browser sessions. If it cannot survive a replacement, say so plainly.

- Deliver a completion report with the per-item status table showing done, partial, or parked with reasons. Never summarize a sweep as nearly done while rows are still open.

## Alternatives for better results

- Ask the principal which items matter most when the batch is large, and work those first. A ranked partial sweep beats an unranked stalled one.

- When several items teach the same method, install it once and point the rest at it. Duplicated installs rot independently.
