# stagehands

## Architecture constraints
- Each packaged `.skill` only bundles its own folder. `references/backstage-idp-conventions.md`
  at repo root is the single source of truth; `skills/*/references/` are synced copies —
  never hand-edit them. Edit the root copy, then run `./scripts/sync-references.sh`.
- `SKILL.md` frontmatter must include `name`, `description` (with trigger phrases), and
  `metadata.pipeline-position` — this field is how agents chain in the pipeline.

## Intentional decisions
- Jira/Atlassian MCP integration is optional and read-mostly: agents fetch tickets if a
  connector is present but never comment/transition status without explicit chat confirmation.

## Stack shorthand
- No app runtime — these are Claude Skill definitions (Markdown + YAML frontmatter) for a
  Backstage IDP agent pipeline (Product Owner → Architect → Engineer → QA/Tech Writer).
- Packaging: `scripts/package-all.sh` wraps Anthropic's `package_skill.py`
  (path overridable via `SKILL_PACKAGER` env var).
