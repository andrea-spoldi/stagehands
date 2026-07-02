# TASKS.md

State store for session-planner. See `.claude/skills/session-planner/references/tasks-schema.md`
for the schema.

```json
{
  "project": "stagehands — Claude skills suite (Product Owner, Architect, Engineer, QA, Tech Writer agents) implementing a virtual engineering team for a Backstage IDP.",
  "updated": "2026-07-02",

  "current_session": {
    "id": null,
    "goal": null,
    "task_ref": null,
    "started": null,
    "status": "done",
    "blocker": null
  },

  "backlog": [
    {
      "id": "T-001",
      "title": "Write core IDP Engineer SKILL.md",
      "description": "Mindset, input contract (consumes ADR), and process steps: load conventions, parse the ADR's Implementation Guidance -> Sequencing section, generate Scaffolder template YAML / custom actions / GitOps config generators, produce an implementation checklist cross-referenced against the ADR's own Checklist for Implementation. Model structure on skills/idp-architect/SKILL.md.",
      "size": "M",
      "priority": 1,
      "status": "done",
      "tags": ["idp-engineer", "phase-2"]
    },
    {
      "id": "T-002",
      "title": "Add a worked Example to idp-engineer/SKILL.md",
      "description": "Edge Cases already landed as part of T-001. Remaining: a full worked example (implementation output for ADR-001 from examples/golang-service-walkthrough.md), mirroring the architect skill's Examples style, to close the loop on the walkthrough doc.",
      "size": "S",
      "priority": 2,
      "status": "done",
      "tags": ["idp-engineer", "phase-2"]
    },
    {
      "id": "T-003",
      "title": "Sync references and update README status",
      "description": "Run ./scripts/sync-references.sh, then update README.md's Agents table (IDP Engineer: Planned -> Active) and Roadmap section.",
      "size": "S",
      "priority": 3,
      "status": "done",
      "tags": ["idp-engineer", "docs"]
    },
    {
      "id": "T-004",
      "title": "Add eval prompts for Engineer agent",
      "description": "Populate evals/idp-engineer/evals.json following the pattern in evals/idp-architect/evals.json. Depends on T-001 existing first.",
      "size": "S",
      "priority": 4,
      "status": "done",
      "tags": ["idp-engineer", "evals"]
    }
  ],

  "decisions": [
    {
      "id": "D-001",
      "date": "2026-07-02",
      "decision": "Decomposed the L-sized 'Build IDP Engineer agent' backlog item into T-001..T-004 instead of scheduling it directly.",
      "rationale": "session-planner rule: L tasks must never be scheduled directly. Splitting by the README's 'Contributing a new agent' steps keeps each session atomic (S/M) and matches how idp-architect was structured.",
      "supersedes": null
    }
  ],

  "completed": [
    {
      "id": "T-001",
      "title": "Write core IDP Engineer SKILL.md",
      "completed_date": "2026-07-02",
      "session_ref": "S-001",
      "notes": "Mindset, input contract, Jira-key passthrough, 4-step process, output template (Sequencing Followed / Components Implemented / Checklist Cross-Reference / PR Description), self-review, and edge cases. Note: Examples section deliberately deferred to T-002. Edge Cases section was pulled forward from T-002's scope since it fit naturally with Step 4/Output Format — T-002 now covers Examples only."
    },
    {
      "id": "T-002",
      "title": "Add a worked Example to idp-engineer/SKILL.md",
      "completed_date": "2026-07-02",
      "session_ref": "S-001",
      "notes": "Full implementation example for ADR-001 (Golang Service) added to SKILL.md. Also extended examples/golang-service-walkthrough.md with a '4. IDP Engineer Output' section and updated its intro/What-to-notice to cover all three agents instead of two."
    },
    {
      "id": "T-003",
      "title": "Sync references and update README status",
      "completed_date": "2026-07-02",
      "session_ref": "S-001",
      "notes": "Ran ./scripts/sync-references.sh (3 skills synced). Updated README.md: Agents table (Engineer Planned -> Active), Roadmap (Phase 2 marked done), top-of-file pipeline diagram (dropped the [Engineer*] placeholder asterisk), repo layout comment, and Packaging section's expected dist/ output list."
    },
    {
      "id": "T-004",
      "title": "Add eval prompts for Engineer agent",
      "completed_date": "2026-07-02",
      "session_ref": "S-001",
      "notes": "Created evals/idp-engineer/evals.json (3 evals), mirroring the architect/PO eval style: (1) happy-path full implementation of ADR-001, (2) ADR missing its Scaffolder Action Chain -> engineer must flag the gap instead of inventing rollback behavior, (3) ADR naming conflicts with backstage-idp-conventions.md -> engineer must flag rather than silently pick one. Phase 2 (IDP Engineer agent) is now fully complete: SKILL.md, worked example, docs, and evals."
    }
  ]
}
```

## Backlog (human-readable)

| ID    | Title                                          | Size | Priority | Status  |
|-------|-------------------------------------------------|------|----------|---------|
| T-001 | Write core IDP Engineer SKILL.md                | M    | 1        | done |
| T-002 | Add a worked example to idp-engineer skill       | S    | 2        | done |
| T-003 | Sync references and update README status        | S    | 3        | done |
| T-004 | Add eval prompts for Engineer agent              | S    | 4        | done |
