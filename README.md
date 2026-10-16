# Agent Skills Mega-Pack

A battle-tested skill pack for AI agents: six original skills distilled from real agent operations, **1,657 community skills vendored from 39 repos**, design references, and working methodology. Point your agent at `skills/` and go.

## What's inside

```
skill-pack/
├── README.md
├── LICENSE                    # MIT (third-party skills keep their own licenses)
├── install.sh                 # idempotent installer
├── skills/                    # everything, in one place
│   ├── agent-logins/          # create & operate assistant-owned accounts without burning them
│   ├── coordinator-ops/       # reliable multi-agent builds: contracts, verification, recovery
│   ├── false-alarm-retraction/ # verify walls before escalating; retract disproven alarms
│   ├── book-craft/            # nonfiction manuscript editing: developmental → proof
│   ├── client-voice-copy/     # copy in the principal's voice, with voice-profile template
│   ├── intake-sweeps/         # process batches of links/repos end to end, never "done at installed"
│   └── community/             # 1,657 skills from 39 repos (ECC, OpenMontage, Claude Code skills,
│                              #   design systems, MCP bridges, video/avatar, SEO, Figma, Higgsfield…)
└── catalog/
    ├── third-party-skills.md  # source repos, licenses, and what each contributed
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

**Just copy it.** Clone the repo and point your agent at `skills/` — the six original skills plus all 1,657 community skills are already here, no downloads needed. Each skill is one `SKILL.md` (some with `skill.yaml`, `references/`, or `bin/` helpers).

```bash
git clone https://github.com/darek225/agent-skills-pack.git
./install.sh                  # copies skills/ → ~/.agents/skills
./install.sh ~/my-skills      # copies to a custom location
```

`install.sh` is idempotent — re-running skips what's already installed.

**Design work.** Read `catalog/design-resources.md` before building any site, and `catalog/methodology.md` for the pre-build planning checklist.

## License notes

This pack itself is MIT (see LICENSE). The community skills in `skills/community/` are vendored from their source repos and keep **their own licenses** — most are MIT/Apache-2.0, but `calesthio/OpenMontage` is AGPL-3.0 (copyleft), `DavidHDev/canvas-ui` is MIT + Commons Clause (non-commercial restriction), and tldraw has separate commercial terms. Each vendored directory includes its source repo's README and license file. Check before commercial use.

## Who it's for

Anyone running an AI agent (Claude Code, Cursor, OpenCode, or similar) who wants operational skills that survived real use: the auth ladders, verification rituals, and editing methods that only get written down after something breaks without them.
