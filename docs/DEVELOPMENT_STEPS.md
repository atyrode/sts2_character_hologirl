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
- [x] Move the character model off BaseLib's placeholder character class once Hologirl-owned select art and audio exist.
- [x] Keep temporary in-run Ironclad asset routing explicit on `CustomCharacterModel` until Hologirl-owned combat/rest/transition assets exist.
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

## Current Roadmap

### 1. Lock The Current Prototype Baseline

- [x] Confirm a run can start and a custom Hologirl card can be played.
- [x] Replace pure template visuals with Hologirl starter card art and character-select art.
- [x] Keep character select on the stable PNG cutout path.
- [x] Hide the temporary character-select tuner behind `F3`.
- [ ] Test the latest release through the mod manager and in-game character-select screen.
- [ ] Test the current starter deck in at least one full Act 1 combat.

### 2. Make The Character Read Correctly In The UI

- [ ] Change the actual card frame/color treatment to Hologirl's chosen periwinkle/accent direction.
- [ ] Design and add Hologirl's energy symbol.
  - [ ] Revisit energy symbol selection from the archived deep one-element batch before replacing the current runtime energy gem.
- [ ] Audit remaining placeholder character UI assets: character icon, map marker, locked portrait, energy text, relic placeholder, power placeholder, and mod image.
- [x] Decide which character-select background and PNG cutout are the default, then remove comparison-only variants from normal player-facing builds.
- [ ] Use F3 tuner feedback to lock final character-select hologram shader values for tearing, tear speed, shimmer, and scanline behavior.
- [ ] Remove or disable temporary tuner UI once final character-select values are locked.

### 3. Stabilize The Starter Gameplay Loop

- [x] Define Hologirl's character fantasy in `docs/DESIGN.md`.
- [x] Define the first small mechanical hook.
- [x] Decide whether `Fans` should be implemented first as a power, player resource, or custom state.
- [x] Decide whether transformations should be implemented first as powers, stances, or custom player state.
- [x] Decide whether fan decay is linear or tiered for the first prototype.
- [x] Replace the smoke-test starter deck with a first intentional starter kit.
- [x] Add Strike-style and Defend-style Hologirl starter cards.
- [x] Add `Concert!`: gain 3 Fans and Singing for 2 turns.
- [x] Add `Livestream` as a rare power that turns explicit combat triggers into `Fans`.
- [x] Add a placeholder starting relic for early transformation exploration.
- [x] Remove the early 0-cost transformation reward cards from the active source set.
- [x] Add power hover tips and rich text coloring for the first Hologirl resource/form terms.
- [x] Rename the player-facing transformation term to `Shapeshift`, then defer the old form/token direction until it can be rebuilt as a complete mechanic.
- [ ] Test the first combat loop locally with `Concert!`, Fans, and Singing.
- [ ] Decide whether Shapeshift returns as a complete mechanic or Prism Pendant is replaced.
- [ ] Tune starter deck numbers after actual combat testing: `Concert!` fan gain, `Singing` duration, Fan decay, and Livestream usefulness.
- [ ] Make fan loss and Livestream trigger text predictable before expanding the card pool further.

### 4. Decide The First Real Mechanical Identity

- [ ] Decide whether the first release identity stays focused on `Fans` + `Singing`/`Livestream`, or whether `Shapeshift` returns as a complete second mechanic.
- [ ] If using axes, define only one minimal prototype axis first; do not implement three axes at once.
- [ ] Decide what each form does passively.
- [x] Replace placeholder form reward cards with simple, testable effects.
- [x] Add a small Common/Uncommon/Rare draftable card pool so merchant and reward generation have valid Hologirl card options.
- [ ] Add focused tests or manual test cases for each form and reward card.

### 5. Expand Into A Small Card Pool

- [ ] Create a first batch of common cards around the confirmed mechanic.
- [ ] Add per-card design docs before implementation when a card introduces a new behavior.
- [ ] Add card art only after the card's gameplay role is stable enough to keep.
- [ ] Test draft/deckbuilding feel by adding cards gradually, not as one large batch.

### 6. Polish Toward A Playable Public Build

- [ ] Replace remaining placeholder relic, power, and UI art.
- [ ] Replace explicit temporary Ironclad in-run routing with Hologirl-owned combat visual, transition, energy counter, rest/merchant animation, hand textures, and combat sounds.
- [ ] Review all wording for keywords, tooltips, and line breaks.
- [ ] Review mod compatibility risks before adding global hooks or patches.
- [ ] Test install/update through GitHub release and the mod manager.
- [ ] Do a final pass on docs so confirmed behavior, setup, and design direction match the build.

## Design Risks

- [ ] Decide how to handle public naming/art/IP references for Hololive-inspired forms.
- [ ] Ensure `Fans` decay is predictable from card/relic/power text before expanding the card pool.
- [x] Establish a compatibility policy: prefer local behavior and avoid global hooks/custom enums unless justified.
- [ ] Review new mechanics for collision risk before each release.

## Debugging Workflow

- [ ] Enable BaseLib's log window on startup, or use the dev console `showlog` command.
- [ ] Use the dev console to inspect commands with `help`.
- [x] Remove Hologirl's in-run F3 debug panel after adopting DevMode for broad manual testing.
- [ ] Use saved logs from the platform log directory when crashes or softlocks occur.
- [ ] Record every successful test step and every failure mode in this checklist.
