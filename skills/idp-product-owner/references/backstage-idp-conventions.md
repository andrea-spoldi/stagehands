# Backstage IDP Conventions

This reference defines the shared vocabulary, architecture patterns, and conventions
that all IDP team agents use when producing artifacts.

## Backstage Core Concepts

- **Software Catalog**: The central registry of all entities (components, APIs, resources, systems, domains).
- **Software Templates (Scaffolder)**: YAML-based templates that automate golden-path creation of new services, libraries, and infrastructure.
- **TechDocs**: Documentation-as-code rendered inside the portal from Markdown in each repo.
- **Plugins**: Frontend and backend extensions that add capabilities to the portal (CI/CD views, cost dashboards, security scorecards).

## Entity Model

All catalog entries follow the Backstage descriptor format:

```yaml
apiVersion: backstage.io/v1alpha1
kind: Component | API | Resource | System | Domain | Group | User
metadata:
  name: <kebab-case-name>
  namespace: default
  annotations: {}
  tags: []
  labels: {}
spec:
  type: service | library | website | documentation
  lifecycle: production | experimental | deprecated
  owner: <group:team-name>
  system: <system-name>
  dependsOn: []
  providesApis: []
  consumesApis: []
```

## Naming Conventions

| Entity        | Pattern                          | Example                    |
|---------------|----------------------------------|----------------------------|
| Component     | `<team>-<service-name>`          | `platform-auth-service`    |
| System        | `<domain>-system`                | `identity-system`          |
| API           | `<service>-api`                  | `auth-service-api`         |
| Template      | `create-<what>`                  | `create-golang-service`    |
| Namespace     | `<team>-<env>`                   | `platform-production`      |
| Repository    | `<org>/<team>-<service-name>`    | `acme/platform-auth`       |

## Template Structure (Scaffolder)

```yaml
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: create-golang-service
  title: Create a Golang Microservice
  description: ...
  tags: ['golang', 'microservice', 'recommended']
spec:
  owner: group:platform-engineering
  type: service
  parameters:
    - title: Service Details
      required: [name, owner, system]
      properties:
        name:
          title: Service Name
          type: string
          pattern: '^[a-z][a-z0-9-]*$'
        owner:
          title: Owner
          type: string
          ui:field: OwnerPicker
        system:
          title: System
          type: string
          ui:field: EntityPicker
          ui:options:
            catalogFilter:
              kind: System
  steps:
    - id: fetch-skeleton
      name: Fetch Skeleton
      action: fetch:template
      input:
        url: ./skeleton
        values:
          name: ${{ parameters.name }}
    - id: publish
      name: Publish to GitLab
      action: publish:gitlab
      input:
        repoUrl: ...
    - id: register
      name: Register in Catalog
      action: catalog:register
      input:
        catalogInfoUrl: ...
  output:
    links:
      - title: Repository
        url: ${{ steps.publish.output.remoteUrl }}
      - title: Open in Catalog
        icon: catalog
        entityRef: ${{ steps.register.output.entityRef }}
```

## GitOps / Flux Conventions

- Flux `GitRepository` and `Kustomization` resources live in a dedicated `fleet-infra` repo.
- Each team has a directory: `clusters/<cluster>/teams/<team>/`.
- Namespace creation is handled by a `Kustomization` that applies a namespace YAML.
- `HelmRelease` resources reference charts from the organization's Helm registry.

## CI/CD Pipeline Conventions

- Pipelines are defined in the service repository (`.gitlab-ci.yml` or `.github/workflows/`).
- Standard stages: lint → test → build → publish → deploy.
- The Scaffolder template seeds the initial pipeline file from a shared template.
- Deployment uses GitOps (Flux reconciliation), not pipeline-driven `kubectl apply`.

## ADR (Architecture Decision Record) Format

```markdown
# ADR-NNN: <Title>

**Status**: Proposed | Accepted | Deprecated | Superseded by ADR-NNN
**Date**: YYYY-MM-DD
**Authors**: <agent-name> (IDP Team Agent)
**Context**: <what prompted this decision>

## Decision

<what we decided and why>

## Components

<Backstage components, plugins, templates, or infrastructure pieces involved>

## Consequences

### Positive
- ...

### Negative / Risks
- ...

### Mitigations
- ...

## Future Evolution

- <what we expect to revisit or extend>
```

## User Story Format (IDP-specific)

```markdown
# <STORY-ID>: <Short Title>

## User Story

As a <persona>,
I want to <action via the IDP>,
So that <business/developer value>.

## Acceptance Criteria

- [ ] <observable, testable criterion>
- [ ] <observable, testable criterion>
- [ ] <observable, testable criterion>

## IDP Touchpoints

- **Catalog impact**: <new entity types, annotations, or relations>
- **Template impact**: <new or modified scaffolder template>
- **Plugin impact**: <new or modified plugin>
- **TechDocs impact**: <documentation changes>
- **GitOps impact**: <Flux/Argo changes>

## Out of Scope

- <explicit exclusions to prevent scope creep>

## Open Questions

- <anything unresolved that needs input>
```

## Personas

| Persona               | Description                                               |
|------------------------|-----------------------------------------------------------|
| Developer              | Builds and deploys services daily                         |
| Tech Lead              | Approves architecture, sets team standards                |
| Platform Engineer      | Maintains IDP infrastructure, templates, plugins          |
| Engineering Manager    | Tracks team health, onboarding, compliance                |
| Security Engineer      | Reviews access, policies, vulnerability posture           |
| SRE                    | Monitors reliability, on-call, incident response          |

## Quality Gates

Every IDP feature should satisfy:

1. **Self-service**: No tickets or manual approvals for the happy path.
2. **Golden path, not golden cage**: Opinionated defaults, but escape hatches exist.
3. **Catalog-first**: Every resource the feature creates must appear in the Software Catalog.
4. **Observable**: The feature surfaces its status in the portal (not hidden in CI logs).
5. **Documented**: TechDocs page exists before the feature goes to production.
