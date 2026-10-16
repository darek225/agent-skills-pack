# Third-party skill & tool repos

39 source repos. Their skills (1,657 SKILL.md files, plus agents/commands) are **vendored** under `skills/community/<repo>/` — each with its source README and license file. The install commands below are for anyone who wants the full repo (tools, apps, build systems) beyond the skills.

> License notes: `Commons Clause` (canvas-ui) restricts commercial use. `AGPL-3.0` (OpenMontage) is copyleft — check obligations before integrating. tldraw's license has separate commercial terms.

## Design & UI

| Repo | What it is | License | Install |
|---|---|---|---|
| [paper-design/shaders](https://github.com/paper-design/shaders) | Zero-dependency canvas shaders, npm-installable | Apache-2.0 | `git clone --depth 1 https://github.com/paper-design/shaders && cd shaders && bun install && bun run build` |
| [ibelick/motion-primitives](https://github.com/ibelick/motion-primitives) | Animated UI kit (motion with restraint) | MIT | `git clone --depth 1 https://github.com/ibelick/motion-primitives && cd motion-primitives && npm install` |
| [DavidHDev/canvas-ui](https://github.com/DavidHDev/canvas-ui) | Creative canvas components (React/Vue/Svelte) | MIT + Commons Clause | `git clone --depth 1 https://github.com/DavidHDev/canvas-ui && cd canvas-ui && npm run registry` |
| [shadcn-ui/ui](https://github.com/shadcn-ui/ui) | shadcn component registry + CLI | MIT | `git clone --depth 1 https://github.com/shadcn-ui/ui` (see repo for CLI setup) |
| [21st-dev/magic-mcp](https://github.com/21st-dev/magic-mcp) | Search 10,000+ 21st.dev components or generate new ones via MCP | ISC | `git clone --depth 1 https://github.com/21st-dev/magic-mcp` (MCP server proxies the 21st.dev API — needs API key) |

## Agent design skills (critique, audit, taste)

| Repo | What it is | License | Install |
|---|---|---|---|
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Design critique/polish commands + rules that catch AI-looking UI | Apache-2.0 | `git clone --depth 1 https://github.com/pbakaus/impeccable && node cli/bin/cli.js --help` |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | Web-design guidelines (UI/a11y/UX audit), React best practices | Check repo | `git clone --depth 1 https://github.com/vercel-labs/agent-skills` |
| [anthropics/skills](https://github.com/anthropics/skills) | Anthropic's official skill collection (incl. frontend-design) | Check repo | `git clone --depth 1 https://github.com/anthropics/skills` |
| [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills) | Stitch generate-design / code-to-design / taste-design | Apache-2.0 | `git clone --depth 1 https://github.com/google-labs-code/stitch-skills` |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 192 color palettes, 74 font pairings, design tokens, brand | MIT | `git clone --depth 1 https://github.com/nextlevelbuilder/ui-ux-pro-max-skill && npm run build` |

## Coding-agent skills & harness

| Repo | What it is | License | Install |
|---|---|---|---|
| [affaan-m/ECC](https://github.com/affaan-m/ECC) | Agent harness performance optimization: 1,062 skills, 71 agents, 97 commands | MIT | `git clone --depth 1 https://github.com/affaan-m/ECC` (installer writes to ~/.claude — review first) |
| [mattpocock/skills](https://github.com/mattpocock/skills) | Practical Claude Code skills from a real `.agents` directory | MIT | `git clone --depth 1 https://github.com/mattpocock/skills` (installer writes to ~/.claude — review first) |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | Coding rules derived from Karpathy's model-failure observations | Check repo | `git clone --depth 1 https://github.com/multica-ai/andrej-karpathy-skills` |
| [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | Memory plugin: captures tool-use observations, generates session summaries | Apache-2.0 | `git clone --depth 1 https://github.com/thedotmack/claude-mem` (full install needs interactive browser sign-in) |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | Universal SEO skill: 26 sub-skills + 19 sub-agents | MIT | `git clone --depth 1 https://github.com/AgriciDaniel/claude-seo` |
| [browserbase/skills](https://github.com/browserbase/skills) | Browserbase's official agent skills for web access | Check repo | `git clone --depth 1 https://github.com/browserbase/skills` |
| [calesthio/OpenMontage](https://github.com/calesthio/OpenMontage) | Media toolkit: 138 tools, 139 skills | AGPL-3.0 | `git clone --depth 1 https://github.com/calesthio/OpenMontage && make setup` |

## Design-platform bridges (MCP)

| Repo | What it is | License | Install |
|---|---|---|---|
| [excalidraw/excalidraw-mcp](https://github.com/excalidraw/excalidraw-mcp) | Agent streams hand-drawn diagrams, editable fullscreen | Check repo | `git clone --depth 1 https://github.com/excalidraw/excalidraw-mcp && npm run build` |
| [tldraw/tldraw](https://github.com/tldraw/tldraw) | Canvas SDK + agent starter kit that reads/edits the canvas | tldraw license (commercial terms) | `git clone --depth 1 https://github.com/tldraw/tldraw` |
| [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide) | Official Figma MCP companion skills (30 skills) | Check repo | `git clone --depth 1 https://github.com/figma/mcp-server-guide` |

## Video generation

| Repo | What it is | License | Install |
|---|---|---|---|
| [higgsfield-ai/skills](https://github.com/higgsfield-ai/skills) | Higgsfield video-generation agent skills | MIT | `git clone --depth 1 https://github.com/higgsfield-ai/skills` |
| [AKCodez/higgsfield-claude-skills](https://github.com/AKCodez/higgsfield-claude-skills) | Additional Higgsfield Claude skills | Check repo | `git clone --depth 1 https://github.com/AKCodez/higgsfield-claude-skills` |
| [higgsfield-ai/cli](https://github.com/higgsfield-ai/cli) | Higgsfield CLI binary (browser OAuth login) | MIT | `git clone --depth 1 https://github.com/higgsfield-ai/cli` (API use needs interactive auth) |

## Also useful (tools, not repos)

| Tool | What it is | Install |
|---|---|---|
| [CLI-Anything](https://github.com/HKUDS/CLI-Anything) (~53k stars, Apache-2.0) | 100+ CLI tools behind one hub (`cli-hub`) — including LibreOffice document conversion | `git clone --depth 1 https://github.com/HKUDS/CLI-Anything ~/.local/share/cli-anything && ~/.local/share/cli-anything/install.sh` (check repo for current installer) |
| [REA](https://www.npmjs.com/package/rea-agents) | Record/replay browser scenarios with evidence IDs; `capture-browser-scenario` for light pages | `npm i -g rea-agents` |
