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

Stabilize the first real version of Hologirl's character identity and combat loop, then move from prototype visuals into coherent character UI.

Current direction: Hologirl builds `Fans`, uses `Singing` to preserve the audience, spends `Fans` for immediate combat value, and uses `Livestream` to gain more `Fans` from explicit combat triggers plus a reactive chat overlay. `Shapeshift` and form reward cards are deferred prototype mechanics until they receive complete behavior, art, and deck integration.

Near-term order:

- Confirm the current release in-game through the mod manager.
- Test the first Fan-spending draftable pool in normal combat, reward, merchant, and boss scenarios.
- Replace or validate core UI assets: card color treatment, energy symbol, character icons, map marker, relic/power placeholders, and mod image.
- Decide whether the Unknown/Popular, Unreal/Real, and Chaos/Order axis idea remains flavor language or becomes a small prototype mechanic later.
