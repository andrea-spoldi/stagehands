#!/usr/bin/env bash
# sync-references.sh
#
# Skills must be self-contained when packaged (the packager bundles only
# what's inside the skill folder), but we want one source of truth for
# shared conventions. This script copies references/ into every skill's
# local references/ folder.
#
# Run this before packaging, or wire it into CI / a pre-commit hook so the
# copies never drift from the source of truth.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REF_SRC="$REPO_ROOT/references"

if [ ! -d "$REF_SRC" ]; then
  echo "error: $REF_SRC not found" >&2
  exit 1
fi

synced=0
for skill_dir in "$REPO_ROOT"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  rm -rf "${skill_dir}references"
  cp -r "$REF_SRC" "${skill_dir}references"
  echo "synced -> $skill_name"
  synced=$((synced + 1))
done

echo ""
echo "Synced references into $synced skill(s)."
