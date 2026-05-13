# Project Spec

## Project Summary

`hologirl` is a character project under the `sts2_character` workspace. The repository should hold the shared source of truth for the character's design, implementation assets, runtime integration, and documentation.

The exact delivery target is not yet encoded in the repo. Until it is chosen, keep this project neutral enough to support possible outputs such as a game-ready character, interactive web character, realtime avatar, rendered asset pack, or animation prototype.

## Core Goals

- Define the character clearly enough that future visual, rigging, animation, and runtime work stays consistent.
- Keep source assets separate from generated exports and runtime integration files.
- Preserve notes about design decisions, constraints, references, and approval status.
- Make it easy for another developer or artist to understand what is canonical and what is experimental.

## Current Known Scope

- Character name/workstream: `hologirl`.
- Parent workspace: `sts2_character`.
- GitHub repository: `atyrode/sts2_character_hologirl`.
- Current repo state: documentation foundation only.

## Open Product Questions

- What is the final target runtime or renderer?
- Is the character 2D, 3D, shader-driven, video-based, or a hybrid?
- What source asset formats are canonical?
- What generated/export formats are needed?
- Are there constraints from a host game, app, stream overlay, website, or engine?
- Does the project need facial animation, lip sync, procedural motion, physics, or interactive states?
- What licensing, attribution, or provenance rules apply to references and generated assets?

## Documentation Expectations

When answers become clear, record them here or in the linked documents:

- `docs/ARCHITECTURE.md` for repo structure, toolchain, asset flow, and runtime integration.
- `docs/DESIGN.md` for visual direction, character rules, variants, and approval status.
- `docs/DEVELOPMENT_STEPS.md` for the working checklist.
- `docs/client/` for client-facing or stakeholder-facing notes when needed.
