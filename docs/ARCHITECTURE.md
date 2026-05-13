# Architecture

This document explains how the codebase and asset workflow are put together. Keep it current when the runtime, asset directories, build pipeline, export process, CI, or integration ownership changes.

## Current State

The repo currently contains documentation scaffolding only. No runtime, engine project, generated assets, source asset directories, or CI workflow has been committed yet.

## Expected Ownership Boundaries

Use clear directory ownership when the project grows:

- `assets/source/`: editable canonical source assets, if source files belong in git.
- `assets/reference/`: references, moodboards, sketches, or prompt outputs that are allowed to be stored in the repo.
- `assets/export/`: generated character exports that are intended to be consumed by a runtime.
- `src/`: runtime or tool code, if this becomes a software project.
- `scripts/`: repeatable project automation.
- `docs/`: project specification, architecture, design notes, and checklists.

Only add these directories when there is real content or workflow behind them.

## Asset Flow

The intended asset flow is still undecided. Once chosen, document:

1. Canonical source format.
2. Editing tools and versions.
3. Export command or manual export steps.
4. Generated file locations.
5. Runtime import path.
6. Validation steps.

Avoid committing large generated binaries without first deciding whether Git LFS or another storage path is needed.

## Runtime Flow

No runtime has been selected yet. If a runtime is added, document:

- How to install dependencies.
- How to start local development.
- How to run checks.
- How character assets are loaded.
- Which files are hand-authored versus generated.
- Which outputs are safe to delete and regenerate.

## Variant Ownership

Shared foundations should stay on `main`: documentation, asset conventions, scripts, CI, and runtime infrastructure.

Experimental visual directions, rigs, shaders, animation systems, and interaction models should happen on short-lived branches until they are selected. When a variant becomes canonical, update `docs/DESIGN.md`, this architecture document, and the checklist in the same change.

## Documentation Ownership

- `README.md`: setup and onboarding.
- `docs/PROJECT_SPEC.md`: product and creative intent.
- `docs/ARCHITECTURE.md`: codebase structure, ownership, and integration details.
- `docs/DESIGN.md`: current design direction and variant notes.
- `docs/DEVELOPMENT_STEPS.md`: working checklist.

Operational docs may live beside the system they explain once those systems exist.
