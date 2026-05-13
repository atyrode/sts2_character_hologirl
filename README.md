# sts2_character_hologirl

Repository for the `hologirl` character project in the `sts2_character` workspace.

The project is currently a clean documentation foundation. No runtime, engine project, asset pipeline, or delivery format has been committed yet.

## Current Shape

- Persistent agent/contributor workflow rules live in [AGENTS.md](AGENTS.md).
- Project intent lives in [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md).
- Repo structure and future asset-flow ownership live in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).
- Current visual direction and variant notes live in [docs/DESIGN.md](docs/DESIGN.md).
- The working checklist lives in [docs/DEVELOPMENT_STEPS.md](docs/DEVELOPMENT_STEPS.md).
- Stakeholder-facing notes can live in [docs/client/](docs/client/).

## Development

Before committing, branching, merging, or deploying, fetch the remote branch state and check whether the local branch is ahead, behind, or diverged:

```sh
git fetch
git status --short --branch
```

When a runtime, engine project, or asset pipeline is added, document the setup, run commands, generated outputs, and validation steps here.

## Documents

- [AGENTS.md](AGENTS.md): persistent workflow rules for future agents and contributors.
- [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md): product and creative intent.
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md): codebase structure, ownership, and integration points.
- [docs/DESIGN.md](docs/DESIGN.md): current design direction and variant notes.
- [docs/DEVELOPMENT_STEPS.md](docs/DEVELOPMENT_STEPS.md): working checklist.
- [docs/client/NOTES.md](docs/client/NOTES.md): stakeholder-facing notes placeholder.
