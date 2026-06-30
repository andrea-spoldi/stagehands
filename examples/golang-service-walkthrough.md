# Walkthrough: Golang Service Creation

This example shows the full pipeline from raw request to ADR, as a reference
for onboarding new contributors to the agent suite.

## 1. Raw Input

> "Developers need a way to provision a new Golang service."

## 2. IDP Product Owner Output

See `skills/idp-product-owner/SKILL.md` → Examples → Example 1 for the full
story (IDP-001).

Key shape: persona = developer, 7 acceptance criteria, explicit Out of Scope
(database provisioning, custom domains, non-Go languages), no open questions.

## 3. IDP Architect Output

See `skills/idp-architect/SKILL.md` → Examples for the full ADR (ADR-001).

Key shape: 5-step Scaffolder action chain (fetch → publish → CI trigger →
Flux PR → Catalog register), each step annotated with failure mode and
rollback strategy, 3 alternatives considered and rejected, risk table,
and a clear implementation sequencing.

## What to notice

- The PO story never prescribes *how* (no mention of Scaffolder actions or
  Flux) — only *what* and *why*. That's the Architect's job.
- The Architect's "Conventions Established" section is what keeps the next
  five templates consistent — read it before designing a new template.
- Both outputs cite `references/backstage-idp-conventions.md` for naming and
  format — if your org's conventions differ, edit that file once and both
  agents follow.
