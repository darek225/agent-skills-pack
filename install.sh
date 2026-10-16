#!/usr/bin/env bash
# install.sh — install the skill-pack skills and (optionally) third-party repos.
#
# Usage:
#   ./install.sh [target-dir] [--tools] [--tools-dir DIR]
#
#   target-dir   where to install skills/  (default: ~/.agents/skills)
#   --tools      also shallow-clone the third-party repos from
#                catalog/third-party-skills.md into tools/
#   --tools-dir  where to put tools/       (default: <target-dir>/../tools)
#
# Idempotent: re-running skips skills that are already installed and repos
# that are already cloned. No curl|bash anywhere in this script.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$HOME/.agents/skills}"
TOOLS_DIR=""
DO_TOOLS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tools) DO_TOOLS=1; shift ;;
    --tools-dir) TOOLS_DIR="$2"; shift 2 ;;
    *) shift ;;
  esac
done

if [[ -z "$TOOLS_DIR" ]]; then
  TOOLS_DIR="$(dirname "$TARGET_DIR")/tools"
fi

say() { printf '[skill-pack] %s\n' "$*"; }

# ---------------------------------------------------------------- skills ---
say "Installing skills -> $TARGET_DIR"
mkdir -p "$TARGET_DIR"
installed=0
skipped=0
for skill in "$SCRIPT_DIR"/skills/*/; do
  name="$(basename "$skill")"
  dest="$TARGET_DIR/$name"
  if [[ -d "$dest" ]]; then
    say "  skip  $name (already installed)"
    skipped=$((skipped + 1))
  else
    cp -r "$skill" "$dest"
    say "  ok    $name"
    installed=$((installed + 1))
  fi
done
say "skills: $installed installed, $skipped already present"

# ----------------------------------------------------------------- tools ---
if [[ "$DO_TOOLS" -eq 1 ]]; then
  say "Cloning third-party repos -> $TOOLS_DIR (shallow)"
  mkdir -p "$TOOLS_DIR"
  # owner/repo pairs, matching catalog/third-party-skills.md
  repos=(
    paper-design/shaders
    ibelick/motion-primitives
    DavidHDev/canvas-ui
    affaan-m/ECC
    mattpocock/skills
    multica-ai/andrej-karpathy-skills
    thedotmack/claude-mem
    AgriciDaniel/claude-seo
    browserbase/skills
    calesthio/OpenMontage
    higgsfield-ai/skills
    AKCodez/higgsfield-claude-skills
    higgsfield-ai/cli
    anthropics/skills
    google-labs-code/stitch-skills
    nextlevelbuilder/ui-ux-pro-max-skill
    pbakaus/impeccable
    vercel-labs/agent-skills
    excalidraw/excalidraw-mcp
    tldraw/tldraw
    figma/mcp-server-guide
    shadcn-ui/ui
    21st-dev/magic-mcp
  )
  cloned=0
  present=0
  for repo in "${repos[@]}"; do
    dir="$TOOLS_DIR/$(echo "$repo" | tr '/' '-')"
    if [[ -d "$dir/.git" ]]; then
      say "  skip  $repo (already cloned)"
      present=$((present + 1))
    else
      say "  clone $repo"
      if git clone --depth 1 "https://github.com/$repo" "$dir" >/dev/null 2>&1; then
        cloned=$((cloned + 1))
      else
        say "  FAIL  $repo (left for you to retry manually)"
      fi
    fi
  done
  say "tools: $cloned cloned, $present already present"
  say "NOTE: some repos need their own setup steps — see catalog/third-party-skills.md"
  say "NOTE: check each repo's LICENSE before commercial use (AGPL and Commons Clause apply to some)"
else
  say "Skipping third-party repos (pass --tools to clone them)"
fi

say "Done."
