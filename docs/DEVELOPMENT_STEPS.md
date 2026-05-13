# Development Checklist

## Research

- [x] Confirm the project is a Slay the Spire 2 playable character mod.
- [x] Check current STS2 modding sources online.
- [x] Identify the current likely stack: C#, Godot/Megadot `.pck`, BaseLib, Alchyr templates.
- [x] Find a working playable character reference mod.
- [x] Record initial sources and constraints in docs.
- [ ] Re-check sources immediately before scaffolding, because STS2 modding is changing quickly.

## Local Prerequisites

- [x] Install or locate `.NET SDK`.
- [x] Locate the local Slay the Spire 2 install path.
- [x] Install BaseLib into the game's `mods/BaseLib/` folder.
- [x] Declare BaseLib dependency in `Hologirl.json` using the game-compatible string-list schema.
- [x] Generate `.pck` through `BSchneppe.StS2.PckPacker` for the initial simple asset/localization pack.
- [ ] Confirm the installed game branch/version beyond local runtime/depot files.
- [ ] Find a reliable gameplay test path: local Steam client, remote desktop Steam session, or proven headless launch flow.

## Build And Release Workflow

- [x] Use `scripts/build.sh` to compile the mod, generate `Hologirl.pck`, and copy outputs into the local STS2 `mods/Hologirl/` folder.
- [x] Use `scripts/package.sh` to build and create `dist/Hologirl-<version>.zip` from the installed mod outputs.
- [x] Use `scripts/release.sh` to package and publish a normal GitHub release for the version in `Hologirl.json`.
- [ ] After each release, test the downloaded mod through the local mod manager before expanding the prototype further.

## Scaffold

- [x] Generate or copy the `Slay the Spire 2 Character` template.
- [x] Set mod id and display name.
- [x] Keep template placeholder assets until the first card is proven in-game.
- [x] Build the DLL.
- [x] Generate the PCK.
- [x] Copy the mod folder outputs into the game `mods/` directory.
- [x] Confirm the mod appears in the local game.

## First Playable Card Test

- [x] Add a single custom basic card to the character card pool.
- [x] Add English localization for the card.
- [x] Put the card in the character starting deck.
- [x] Start a run as the custom character.
- [x] Draw the custom card.
- [x] Play the custom card against an enemy.
- [x] Verify the effect resolves and the combat continues.

## Character Direction

- [x] Define Hologirl's character fantasy in `docs/DESIGN.md`.
- [x] Define the first small mechanical hook.
- [x] Decide whether `Fans` should be implemented first as a power, player resource, or custom state.
- [x] Decide whether transformations should be implemented first as powers, stances, or custom player state.
- [x] Decide whether fan decay is linear or tiered for the first prototype.
- [x] Replace the smoke-test starter deck with a first intentional starter kit.
- [x] Add Strike-style and Defend-style Hologirl starter cards.
- [x] Add `Concert!`: gain 3 Fans and Singing for 2 turns.
- [x] Add `Livestream`: transform into a random form.
- [x] Add a placeholder starting relic that documents transformation reward cards.
- [x] Add one placeholder 0-cost transformation reward card per form.
- [x] Add power hover tips and rich text coloring for the first Hologirl resource/form terms.
- [x] Rename the player-facing transformation term to `Shapeshift` and move the 0-cost card bonus onto the starter relic.
- [ ] Test the first combat loop locally.

## Design Risks

- [ ] Decide how to handle public naming/art/IP references for Hololive-inspired forms.
- [ ] Ensure `Fans` decay is predictable from card/relic/power text before expanding the card pool.
- [x] Establish a compatibility policy: prefer local behavior and avoid global hooks/custom enums unless justified.
- [ ] Review new mechanics for collision risk before each release.

## Debugging Workflow

- [ ] Enable BaseLib's log window on startup, or use the dev console `showlog` command.
- [ ] Use the dev console to inspect commands with `help`.
- [ ] Use saved logs from the platform log directory when crashes or softlocks occur.
- [ ] Record every successful test step and every failure mode in this checklist.
