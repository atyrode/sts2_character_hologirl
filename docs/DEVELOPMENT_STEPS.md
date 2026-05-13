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
- [x] Declare BaseLib minimum version in `Hologirl.json`.
- [x] Generate `.pck` through `BSchneppe.StS2.PckPacker` for the initial simple asset/localization pack.
- [ ] Confirm the installed game branch/version beyond local runtime/depot files.
- [ ] Find a reliable gameplay test path: local Steam client, remote desktop Steam session, or proven headless launch flow.

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

- [ ] Define Hologirl's character fantasy in `docs/DESIGN.md`.
- [ ] Define the first small mechanical hook.
- [ ] Decide whether the first hook needs a power, relic, secondary resource, card tag, or only normal card effects.
- [ ] Replace the smoke-test starter deck with a first intentional starter kit.
- [ ] Add one basic attack, one basic defend, and one mechanic card.
- [ ] Test the first combat loop locally.

## Debugging Workflow

- [ ] Enable BaseLib's log window on startup, or use the dev console `showlog` command.
- [ ] Use the dev console to inspect commands with `help`.
- [ ] Use saved logs from the platform log directory when crashes or softlocks occur.
- [ ] Record every successful test step and every failure mode in this checklist.
