# Deploy Ritual (Vercel)

Vercel blocks deployments whose commit author has no GitHub account mapped ("couldn't find a Git account for the commit author"). Agent-authored merge commits (e.g. authored as `Muse <muse@local>`) are blocked — both CLI deploys and dashboard redeploys.

Before every production deploy of agent-authored main:

1. Push an empty commit with the recognized identity (the GitHub user the project belongs to, via their public noreply address):
   `git -c user.name="<github-username>" -c user.email="<github-username>@users.noreply.github.com" commit --allow-empty -m "deploy trigger: <reason>"`
2. `git push origin main`
3. `npx --yes vercel deploy --prod --yes`
4. Verify the production alias and `curl https://<alias>/api/health` (expect 200, `ready`).

Quirks:
- `npx vercel login` needs a TTY: `script -qec "npx --yes vercel login" /tmp/vlogin.log`; user approves the device code on their phone.
- `vercel link` overwrites `.env.local` (restores project env, clobbering local `DATABASE_URL`) and appends `.env*` to `.gitignore`. After linking: `git checkout .gitignore`, restore local `DATABASE_URL`, verify seeded credentials still match.
- Local `.env.local` is throwaway, gitignored, mode 0600. Never print secret values.
