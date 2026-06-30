# stagehands

A suite of Claude skills that act as a virtual engineering team for a
**Backstage Internal Developer Platform** — each skill is an agent with a
defined persona, input contract, and output contract.

```
Raw Request → [Product Owner] → User Story → [Architect] → ADR → [Engineer*] → Implementation
```
\* planned, not yet built — see [Roadmap](#roadmap)

## Repo Layout

```
stagehands/
├── README.md
├── references/                        # Shared source of truth
│   └── backstage-idp-conventions.md   # Entity model, naming, templates, GitOps
│
├── skills/
│   ├── idp-product-owner/
│   │   ├── SKILL.md
│   │   └── references/                # Synced copy — do not edit directly
│   ├── idp-architect/
│   │   ├── SKILL.md
│   │   └── references/
│   └── idp-engineer/                  # Phase 2 — placeholder
│       ├── SKILL.md
│       └── references/
│
├── evals/                             # Test prompts per skill
│   ├── idp-product-owner/evals.json
│   └── idp-architect/evals.json
│
├── examples/                          # Sample input → output, for docs/onboarding
│   └── golang-service-walkthrough.md
│
├── scripts/
│   ├── sync-references.sh             # references/ → skills/*/references/
│   └── package-all.sh                 # sync + package every skill into dist/*.skill
│
└── dist/                              # Generated .skill files (gitignored)
```

## Why references are duplicated

Each packaged `.skill` file must be self-contained — the packager only bundles
what's inside that skill's folder. To avoid maintaining the conventions doc in
multiple places by hand, `references/` at the repo root is the single source
of truth, and `scripts/sync-references.sh` copies it into each skill before
you commit or package. Never hand-edit a skill's local `references/` folder —
edit the root copy and re-sync.

## Setup

```bash
git clone <this-repo>
cd stagehands
./scripts/sync-references.sh
```

## Packaging

```bash
./scripts/package-all.sh
# → dist/idp-product-owner.skill
# → dist/idp-architect.skill
```

By default this looks for Anthropic's `package_skill.py` at
`/mnt/skills/examples/skill-creator/scripts/package_skill.py` (the path inside
a Claude.ai/Cowork sandbox). Point `SKILL_PACKAGER` at a different path if
you're running this elsewhere.

## Agents

| Agent               | Status   | Consumes      | Produces |
|----------------------|----------|---------------|----------|
| IDP Product Owner    | ✅ Active | Raw request    | User story |
| IDP Architect        | ✅ Active | User story     | ADR |
| IDP Engineer         | 🚧 Planned | ADR          | Implementation |
| IDP QA               | 🗒️ Idea  | Code + story  | Test results |
| IDP Tech Writer      | 🗒️ Idea  | ADR + code    | TechDocs |

## Roadmap

- **Phase 1** (done): Product Owner + Architect — highest ROI, establishes the pipeline and shared conventions.
- **Phase 2**: Engineer agent — implements templates/plugins from an ADR.
- **Phase 3**: QA + Tech Writer agents — close the loop on verification and documentation.

## Customizing for your org

Edit `references/backstage-idp-conventions.md` to match your Git provider,
GitOps tool, CI system, and naming conventions, then run
`./scripts/sync-references.sh`. All agents inherit the change automatically.

## Contributing a new agent

1. `mkdir -p skills/<agent-name>/references`
2. Write `skills/<agent-name>/SKILL.md` — frontmatter must include `name`,
   `description` (with trigger phrases), and `metadata.pipeline-position`.
3. `./scripts/sync-references.sh`
4. Add eval prompts to `evals/<agent-name>/evals.json`.
5. Update the table above.
