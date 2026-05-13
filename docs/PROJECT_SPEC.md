# Project Spec

## Goal

Create a Slay the Spire 2 playable character mod.

The first milestone was intentionally small: start a run and play one custom card belonging to the custom character. This passed locally with `Holo Strike` from release `v0.1.1`.

## Working Assumption

We assume we do not already know how Slay the Spire 2 modding works. The game is new, the API is changing, and older information may be wrong. Implementation choices should come from current sources and working examples.

## Research Sources To Prefer

- Current GitHub repositories for STS2 modding tools and templates.
- Source code of working playable character mods.
- Nexus Mods pages for install requirements, version notes, and breakage reports.
- Decompilation of local game assemblies when implementing behavior similar to base game content.

## Today Target

- Establish the current modding stack.
- Document the minimum build/install/test path.
- Lay down incremental test cases.
- If local prerequisites are available, scaffold the character mod and create one playable custom card.

Status: complete.

## Next Target

Define the first real version of Hologirl's character identity and combat loop, then replace the smoke-test starting deck with a tiny intentional starter kit.

Current direction: Hologirl builds `Fans`, uses `Livestream` to transform into a random idol-inspired form, and spends or loses fans to maintain that form. `Concert!` is the first fan-generation card and `Singing` temporarily prevents fan loss.
