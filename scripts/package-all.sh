#!/usr/bin/env bash
# package-all.sh
#
# Syncs shared references, validates, and packages every skill in skills/
# into a .skill file (via Anthropic's skill-creator packaging tool, if
# available on this machine). Output goes to dist/.
#
# Usage: ./scripts/package-all.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$REPO_ROOT/dist"
PACKAGER="${SKILL_PACKAGER:-/mnt/skills/examples/skill-creator/scripts/package_skill.py}"

"$REPO_ROOT/scripts/sync-references.sh"

mkdir -p "$DIST_DIR"

if [ ! -f "$PACKAGER" ]; then
  echo "warning: packager not found at $PACKAGER" >&2
  echo "set SKILL_PACKAGER=/path/to/package_skill.py and re-run, or package manually." >&2
  exit 1
fi

PACKAGER_DIR="$(dirname "$(dirname "$PACKAGER")")"

for skill_dir in "$REPO_ROOT"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  echo "packaging $skill_name..."
  ( cd /tmp && PYTHONPATH="$PACKAGER_DIR" python "$PACKAGER" "$skill_dir" )
  mv "/tmp/${skill_name}.skill" "$DIST_DIR/"
done

echo ""
echo "Packaged skills written to $DIST_DIR"
