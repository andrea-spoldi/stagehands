---
name: idp-engineer
description: >
  PLACEHOLDER — Phase 2 agent. Will implement Backstage Scaffolder templates,
  custom actions, and plugin code from an Architect-produced ADR. Not yet active.
metadata:
  author: idp-team
  version: "0.0"
  category: idp-team-agent
  role: engineer
  pipeline-position: 3
  emits: implementation
  consumes: adr
  status: planned
---

# IDP Engineer Agent (Planned — Phase 2)

This agent is not yet implemented. It will consume an ADR from the IDP Architect
and produce:

- Scaffolder template YAML and skeleton repos
- Custom Backstage actions (TypeScript)
- GitOps config generators
- PR descriptions linking back to the originating ADR and story

See `references/backstage-idp-conventions.md` for the shared conventions this
agent will follow once built.

## Design Notes (for whoever builds this next)

- Should consume the ADR's "Implementation Guidance → Sequencing" section directly.
- Should refuse to deviate from naming conventions without flagging it.
- Should produce a checklist cross-referenced against the ADR's own
  "Checklist for Implementation" section.
