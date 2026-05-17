# Gameplay Identity

Hologirl is a hologram performer who builds a live audience, preserves it through performance, then spends that audience's support for tempo, defense, and burst damage.

## Core Loop

- Gain `Fans` from setup cards and `Livestream`'s explicit combat triggers.
- `Fans` decay by half at the end of turn unless Hologirl is `Singing`.
- Use `Singing` to preserve a large audience across turns.
- Spend `Fans` for immediate combat value: damage, block, draw, and energy.
- Use `Livestream` as the signature engine: it generates `Fans` from listed combat events and makes the combat feel watched by a reactive chat overlay.

`Shapeshift`, Idol Forms, and form reward cards are removed from the active card implementation for now. They should not be treated as part of the active balance target until they are rebuilt with complete card art, power behavior, and deck integration.

## Exploratory Axis Model

An exploratory identity model frames Hologirl around three thematic axes:

- `Unknown` to `Popular`
- `Unreal` to `Real`
- `Chaos` to `Order`

Current status: design prompt only, not a committed mechanic.

The idea fits Hologirl's baseline fantasy: she starts as an unknown, unreal hologram, then cards, Fans, forms, and deckbuilding could move her identity along those axes. This may be too complex for the first playable build. If it becomes gameplay, prototype one axis first and prove it creates clear decisions before adding additional axes.

Possible low-risk use before mechanics:

- Use the axes as flavor/design language for card names, form identities, and art direction.
- Map existing mechanics loosely: Fans trend toward `Popular`, base hologram trends toward `Unreal`, and Shapeshift/form control could explore `Chaos` versus `Order`.
- Avoid adding visible meters, state machines, or deckbuilding rules until the current Fans/Shapeshift loop is stable.

## Starter Kit

- 4 `Strike`
- 4 `Defend`
- 1 `Concert!`
- 1 `Livestream` temporarily for overlay/mechanic testing. Remove this before treating the starter kit as a balance target.
- 1 starting relic: `Prism Pendant`

## Draftable Pool

The current draftable pool is the first real combat pass. Cards should either generate enough `Fans` to fuel later decisions, protect `Fans` with `Singing`, spend `Fans` for immediate value, or make `Livestream` more exciting.

- Common: `Signal Jab`, `Fan Meetup`, `Broadcast Loop`
- Uncommon: `Lightwhip Flourish`, `Glitch Waltz`, `Encore Engine`
- Rare: `Radiant Whip`, `Viral Moment`, `Prime Time`, `Livestream`

Form reward cards from `Prism Pendant` have been removed from the active source set. `Prism Pendant` itself remains a prototype relic until Hologirl's core loop is redesigned.

## Weapon

Base Hologirl uses a faint yellow/gold holographic light-whip. The whip should be the visual focus for base attack art and future base attack animation.

## Open Design Questions

- Whether Fan spend rates need caps once longer runs reveal real audience totals.
- Whether Shapeshift returns as a complete mechanic or Prism Pendant is replaced entirely.
- Whether the Unknown/Popular, Unreal/Real, and Chaos/Order axis model should remain flavor-only or become a real mechanic.
