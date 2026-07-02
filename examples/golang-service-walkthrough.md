# Walkthrough: Golang Service Creation

This example shows the full pipeline from raw request to implementation, as a
reference for onboarding new contributors to the agent suite.

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

## 4. IDP Engineer Output

See `skills/idp-engineer/SKILL.md` → Examples for the full implementation
(implementing ADR-001).

Key shape: components built in the ADR's own sequencing order (skeleton →
`flux:create-pr` custom action → template wiring → E2E validation still open),
a Checklist Cross-Reference that answers every item from the ADR's own
"Checklist for Implementation," and a PR description ready to open against the
platform's template repo.

## What to notice

- The PO story never prescribes *how* (no mention of Scaffolder actions or
  Flux) — only *what* and *why*. That's the Architect's job.
- The Architect's "Conventions Established" section is what keeps the next
  five templates consistent — read it before designing a new template.
- The Engineer doesn't redesign anything from the ADR — it implements the
  Scaffolder Action Chain step-for-step and cites the ADR's own idempotency/
  rollback notes to prove each step matches what was designed.
- All three outputs cite `references/backstage-idp-conventions.md` for naming
  and format — if your org's conventions differ, edit that file once and all
  three agents follow.
