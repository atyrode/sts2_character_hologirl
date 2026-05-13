# Design Direction

## Combat Fantasy

Hologirl is a ghostly hologram performer who builds an audience, then uses that audience's support to sustain temporary idol transformations.

The baseline form is the original Hologirl: a simple, ghostly hologram girl. Her distinctive resource is `Fans`, representing the crowd forming around her. Visually, the long-term goal is to show fans stacking discreetly on the far left/back of the combat scene, like a crowd forming behind the action.

## Core Mechanical Idea

Hologirl can shift from her base hologram form into idol-inspired stances/forms:

- Ceres Fauna
- Amelia Watson
- Gawr Gura
- Ouro Kronii

These are currently design references for stance identities. Exact naming, art usage, and presentation should be treated carefully before public release, because they reference real Hololive talents and related IP.

The stance loop:

- Gain `Fans`.
- Shapeshift into a random idol form with `Livestream`.
- Maintaining a form consumes `Fans`.
- If Hologirl cannot sustain the fan cost, she returns to base hologram form.
- `Prism Pendant` creates a form-specific 0-cost card in hand when Hologirl shapeshifts.

The exact benefits of having more fans are undecided. Fans may be a currency, scaling stat, maintenance cost, visual crowd meter, or some combination of those.

## Starter Kit Direction

Initial starter deck direction:

- 4 Strike-style cards.
- 4 Defend-style cards.
- `Concert!`
- `Livestream`

### Concert!

Initial concept:

- Cost: 1
- Gain 3 `Fans`.
- Gain `Singing` for 2 turns.

`Singing` means Hologirl does not lose fans while singing.

### Livestream

Initial concept:

- Cost: 2
- Shapeshift into a random idol form.

The form card specifics are not designed yet. The bonus form card is a `Prism Pendant` effect, not part of the base `Shapeshift` action.

## Starting Relic Direction

The starting relic should explain and support the transformation system.

Current concept:

- Theme: shapeshifting / idol projection / form switching.
- When Hologirl shapeshifts, she gets a form-specific 0-cost card in hand.
- The relic text should document this behavior.

The exact relic name, stats, icon, and form-card behavior are undecided.

## Term Dictionary

- `Fans`: Hologirl's audience resource. Fans decay by 1 at end of turn unless Hologirl is Singing. Idol Forms spend Fans to stay active.
- `Singing`: temporary protection from normal Fan decay.
- `Shapeshift`: Hologirl's core ability. Shapeshifting enters an Idol Form. Idol Forms spend 1 Fan at end of turn to remain active; if Hologirl cannot pay, she returns to base form.
- `Idol Form`: one of Hologirl's form powers. The form itself owns passive identity and upkeep text.
- `Prism Pendant`: starter relic. This relic adds the form-specific 0-cost card when Hologirl Shapeshifts; that bonus card is not part of Shapeshift itself.

## Mod Compatibility Policy

Hologirl should aim to be highly compatible with other mods.

- Prefer local card, power, relic, and character behavior over global hooks or patches.
- Avoid custom enum entries, shared keyword registration, global description overrides, and broad Harmony patches unless there is a concrete need and the collision risk is documented.
- Prefix all custom ids, localization keys, assets, and generated concepts with the mod namespace already used by the template (`HOLOGIRL` / `Hologirl`).
- Keep manifest fields compatible with the user's current game build and mod manager. In particular, `dependencies` currently uses the string-list schema expected by STS2 `v0.103.2`.
- If a future feature needs global behavior, document why it is needed, what it touches, and how it avoids colliding with other mods before implementing it.

## Open Questions

- What should `Fans` do besides paying form upkeep?
- Should fan decay be linear, tiered, or based on current fan count?
- How should fan loss be shown clearly enough that the player can predict it?
- Does `Singing` pause all fan loss, reduce fan loss, or only pause passive decay while still allowing form upkeep?
- Is Shapeshift random among all forms, random among unlocked/available forms, or influenced by cards?
- What does each idol form do mechanically?
- Should forms behave like STS stances, Defect-style orb slots, powers, or a custom player state?
- What should the first form-specific 0-cost card do?
- How much Hololive-specific naming/art should remain in a public release?
