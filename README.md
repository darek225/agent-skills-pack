# Agent Skills Mega-Pack

A battle-tested skill pack for AI agents: six original skills distilled from real agent operations, a catalog of 23 verified third-party repos, design references, and working methodology. Point your agent at `skills/` and go.

## What's inside

```
skill-pack/
├── README.md
├── LICENSE                    # MIT
├── install.sh                 # idempotent installer
├── skills/                    # the six original skills
│   ├── agent-logins/          # create & operate assistant-owned accounts without burning them
│   ├── coordinator-ops/       # reliable multi-agent builds: contracts, verification, recovery
│   ├── false-alarm-retraction/ # verify walls before escalating; retract disproven alarms
│   ├── book-craft/            # nonfiction manuscript editing: developmental → proof
│   ├── client-voice-copy/     # copy in the principal's voice, with voice-profile template
│   └── intake-sweeps/         # process batches of links/repos end to end, never "done at installed"
└── catalog/
    ├── third-party-skills.md  # 23 installed+verified repos (design, agent skills, MCP bridges)
    ├── design-resources.md    # reference galleries for web design
    └── methodology.md         # distilled methods: memory, loops, context, planning, discipline
```

## The six skills

| Skill | When to reach for it |
|---|---|
| **agent-logins** | Any signup/login/verification task. Auth ladder (API → mailbox OTP → browser session → takeover), CAPTCHA preference handling, escalation ladder, field notes on major sites. Includes a working OTP-polling helper (`bin/mailbox_wait_code.py`). |
| **coordinator-ops** | Dispatching a coordinator subagent for a multi-step build. Lock/heartbeat protocol, independent verification before merge, dead-worker recovery, cheap stall detection, deploy ritual. |
| **false-alarm-retraction** | Before relaying any "it's broken" claim from a worker/tool to a human. Verify first with an independent check; retract explicitly when later evidence contradicts you. |
| **book-craft** | Nonfiction manuscript work. Project law (manifesto/outline/conventions), the four-pass rewrite ladder, voice protection, quality gates, blind acquiring-editor read. |
| **client-voice-copy** | Any public-facing copy. Interview the principal section by section, draft from their verbatim words, propose before anything goes live. Ships a reusable voice-profile template. |
| **intake-sweeps** | A principal keeps streaming links/repos. Acceptance bar up front (cloned ≠ done), one fetch attempt then ask, verify each item really works, document/catalog/propagate, per-item status table. |

## How to use it

**Option A — just the skills.** Copy `skills/` into your agent's skills directory (e.g. `~/.agents/skills`) and point the agent at them. Each skill is one `SKILL.md` plus an optional `skill.yaml`; two ship with `references/` detail docs and one with a `bin/` helper.

**Option B — full install.** Run `./install.sh` (skills → `~/.agents/skills`). Add `--tools` to also shallow-clone all 23 third-party repos into a `tools/` directory. Re-running is safe — installed skills and cloned repos are skipped.

```bash
./install.sh                  # skills only
./install.sh --tools          # skills + third-party repos
./install.sh ~/my-skills --tools --tools-dir ~/my-tools
```

**Design work.** Read `catalog/design-resources.md` before building any site, and `catalog/methodology.md` for the pre-build planning checklist.

## License notes

This pack itself is MIT (see LICENSE). The third-party repos in the catalog carry **their own licenses** — most are MIT/Apache-2.0, but `calesthio/OpenMontage` is AGPL-3.0 (copyleft), `DavidHDev/canvas-ui` is MIT + Commons Clause (non-commercial restriction), and tldraw has separate commercial terms. Check before commercial use. Their code is not vendored here; the catalog links out.

## Who it's for

Anyone running an AI agent (Claude Code, Cursor, OpenCode, or similar) who wants operational skills that survived real use: the auth ladders, verification rituals, and editing methods that only get written down after something breaks without them.
