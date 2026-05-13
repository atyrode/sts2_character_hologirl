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
- Transform into a random idol form with `Livestream`.
- Maintaining a form consumes `Fans`.
- If Hologirl cannot sustain the fan cost, she returns to base hologram form.
- Transforming creates a form-specific 0-cost card in hand.

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
- Transform into a random idol form.

Transformation should create the relevant form's 0-cost transformation card in hand. The form card specifics are not designed yet.

## Starting Relic Direction

The starting relic should explain and support the transformation system.

Current concept:

- Theme: shapeshifting / idol projection / form switching.
- When Hologirl transforms, she gets a form-specific 0-cost card in hand.
- The relic text should document this behavior.

The exact relic name, stats, icon, and form-card behavior are undecided.

## Open Questions

- What should `Fans` do besides paying form upkeep?
- Should fan decay be linear, tiered, or based on current fan count?
- How should fan loss be shown clearly enough that the player can predict it?
- Does `Singing` pause all fan loss, reduce fan loss, or only pause passive decay while still allowing form upkeep?
- Is transformation random among all forms, random among unlocked/available forms, or influenced by cards?
- What does each idol form do mechanically?
- Should forms behave like STS stances, Defect-style orb slots, powers, or a custom player state?
- What should the first form-specific 0-cost card do?
- How much Hololive-specific naming/art should remain in a public release?
