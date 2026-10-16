#!/usr/bin/env bash
# install.sh — install everything in the skill-pack.
#
# Usage:
#   ./install.sh [target-dir]
#
#   target-dir   where to install skills/  (default: ~/.agents/skills)
#
# Copies the 6 original skills plus all 1,657 vendored community skills.
# Idempotent: re-running skips skills that are already installed.
# No curl|bash anywhere in this script.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$HOME/.agents/skills}"

say() { printf '[skill-pack] %s\n' "$*"; }

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
say "NOTE: community skills keep their source repos' licenses — see catalog/third-party-skills.md"
say "Done."
