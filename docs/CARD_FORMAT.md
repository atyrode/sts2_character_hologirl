# STS2 Modded Card Format

Last verified: 2026-05-18.

This document describes the current preferred card format for Slay the Spire 2 mods that use BaseLib. It is intentionally mod-agnostic: replace names such as `<ModId>`, `<ModCode>`, `<CardPool>`, `<CardName>`, and `<MOD_ID>-<ENTRY>` with the identifiers used by a specific mod.

It is based on the current public BaseLib wiki, the current `Alchyr/ModTemplate-StS2` template, current public character mod examples, observed implementation patterns, and the installed `Alchyr.Sts2.BaseLib` `3.1.3` API XML.

## Summary

Confirmed: a modded card is primarily a C# class, not a JSON row. JSON is used for localization, and image files are used for card portraits.

The current preferred structure is:

- One `CustomCardModel` subclass per card.
- One `CustomCardPoolModel` subclass for the card color/pool.
- A `[Pool(typeof(...CardPool))]` attribute connecting cards to their pool.
- A character model whose `CardPool` returns `ModelDb.CardPool<...>()`.
- Localization entries in `<ModId>/localization/<lang>/cards.json`.
- Portrait assets under `<ModId>/images/card_portraits/` and `<ModId>/images/card_portraits/big/`.

Minimal card shape:

```csharp
[Pool(typeof(ExampleCardPool))]
public sealed class StrikeExample() : ExampleCard(1, CardType.Attack, CardRarity.Basic, TargetType.AnyEnemy)
{
    protected override HashSet<CardTag> CanonicalTags => [CardTag.Strike];

    protected override IEnumerable<DynamicVar> CanonicalVars => [new DamageVar(6m, ValueProp.Move)];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        ArgumentNullException.ThrowIfNull(cardPlay.Target);
        await DamageCmd.Attack(DynamicVars.Damage.BaseValue)
            .FromCard(this)
            .Targeting(cardPlay.Target)
            .WithHitFx("vfx/vfx_attack_blunt")
            .Execute(choiceContext);
    }

    protected override void OnUpgrade()
    {
        DynamicVars.Damage.UpgradeValueBy(3m);
    }
}
```

## Source Of Truth And Stale Risk

STS2 modding APIs are still moving. Before changing card architecture, re-check:

- BaseLib wiki: `https://alchyr.github.io/BaseLib-Wiki/`
- BaseLib custom-card page: `https://alchyr.github.io/BaseLib-Wiki/docs/models/custom-card.html`
- BaseLib localization pages:
  - `https://alchyr.github.io/BaseLib-Wiki/docs/localization/simplified-loc.html`
  - `https://alchyr.github.io/BaseLib-Wiki/docs/utilities/var-loc.html`
- Current template: `https://github.com/Alchyr/ModTemplate-StS2`
- Current working public mods.
- Installed package docs after restore: `/home/alex/.nuget/packages/alchyr.sts2.baselib/<version>/lib/net9.0/BaseLib.xml`

Confirmed local package version while writing: `Alchyr.Sts2.BaseLib` `3.1.3`.

## Required Pieces

### Card Class

Each card should be a concrete sealed class unless there is a strong reason to subclass it. It should inherit from the mod's shared card base class, which should inherit from `CustomCardModel`.

Generic shared card base:

```csharp
[Pool(typeof(ExampleCardPool))]
public abstract class ExampleCard(int cost, CardType type, CardRarity rarity, TargetType target) :
    CustomCardModel(cost, type, rarity, target)
{
    public override string CustomPortraitPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".BigCardImagePath();
    public override string PortraitPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".CardImagePath();
    public override string BetaPortraitPath => $"beta/{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".CardImagePath();
}
```

This keeps naming and portrait paths consistent across all cards in the mod.

### Constructor Parameters

The `CustomCardModel` constructor shape used by the current template and observed implementations is:

```csharp
CustomCardModel(int cost, CardType type, CardRarity rarity, TargetType target)
```

Use:

- `cost`: energy cost. Known normal values include `0`, `1`, `2`, `3`; use current game/API conventions before representing special costs.
- `CardType`: examples include `Attack`, `Skill`, and `Power`.
- `CardRarity`: examples are `Basic`, `Common`, `Uncommon`, `Rare`.
- `TargetType`: examples are `Self`, `AnyEnemy`, and other game/BaseLib target types.

### Pool Attribute

Cards must be associated with the correct pool:

```csharp
[Pool(typeof(ExampleCardPool))]
public sealed class SignalJab() : ExampleCard(...)
```

The current BaseLib XML says `CustomCardPoolModel.GenerateAllCards` does not need to be overridden when using `CustomCardModel`; content is added through BaseLib's model concatenation. The `[Pool]` attribute is therefore the main format hook.

Current template and public examples often place `[Pool(typeof(<CardPool>))]` on both the shared base card and each concrete card. That is explicit and has been observed to work. Re-check BaseLib docs before relying on only one location.

### Card Pool

The pool defines the card color/frame behavior and energy icons:

```csharp
public class ExampleCardPool : CustomCardPoolModel
{
    public override string Title => ExampleCharacter.CharacterId;
    public override string BigEnergyIconPath => "charui/big_energy.png".ImagePath();
    public override string TextEnergyIconPath => "charui/text_energy.png".ImagePath();
    public override Color ShaderColor => ExampleCharacter.Color;
    public override Color DeckEntryCardColor => ExampleCharacter.Color;
    public override bool IsColorless => false;
}
```

Notes:

- `Title` is an internal pool identifier, not display text.
- For a character-specific colored pool, `IsColorless` should usually be `false`.
- BaseLib supports shader-colored vanilla-style frames via `ShaderColor`, `H/S/V`, or custom frame overrides.
- Override `CustomFrame(CustomCardModel card)` only when a shader-colored frame is insufficient.
- `BigEnergyIconPath` and `TextEnergyIconPath` can point to `.png` assets.

### Character Integration

The character model must return the card pool:

```csharp
public override CardPoolModel CardPool => ModelDb.CardPool<ExampleCardPool>();
```

Starter deck entries are explicit `CardModel` instances:

```csharp
public override IEnumerable<CardModel> StartingDeck => [
    ModelDb.Card<StrikeExample>(),
    ModelDb.Card<DefendExample>()
];
```

Do not assume `Basic` rarity alone puts a card into the starter deck. Starter deck inclusion is controlled by `StartingDeck`.

## Card Identity

### Model Id

BaseLib builds IDs from the model type and namespace/pool conventions. Localization keys should use the generated model ID:

```json
"<MOD_ID>-STRIKE_EXAMPLE.title": "Strike"
```

Do not hand-write ID strings inside card classes unless required. Prefer:

```csharp
ModelDb.Card<StrikeExample>()
```

and asset paths derived from `Id.Entry.RemovePrefix().ToLowerInvariant()`.

### File Names

A common shared card base maps an entry like `STRIKE_EXAMPLE` to:

- `<ModId>/images/card_portraits/big/strike_example.png`
- `<ModId>/images/card_portraits/strike_example.png`
- `<ModId>/images/card_portraits/beta/strike_example.png` if beta art exists

The template notes these sizes:

- Normal big card art: `1000x760`; `500x380` should also scale.
- Smaller normal art: `250x190`.
- Full art: `606x852`.
- Smaller full art: `250x350`.

For the normal-art path, card portrait workflow should produce:

- `<ModId>/images/card_portraits/big/<card_id>.png` at `1000x760`.
- `<ModId>/images/card_portraits/<card_id>.png` at `250x190`.

## Localization Format

Card localization lives in:

```text
<ModId>/localization/eng/cards.json
```

Each card needs:

```json
{
  "<MOD_ID>-STRIKE_EXAMPLE.title": "Strike",
  "<MOD_ID>-STRIKE_EXAMPLE.description": "Deal {Damage:diff()} damage."
}
```

Confirmed formatting:

- Use `\n` for line breaks.
- Use `[gold]...[/gold]` for gold-highlighted terms.
- Use dynamic variable placeholders such as `{Damage:diff()}`.
- Keep names matched to the card model ID.

BaseLib's simplified localization support documents variable forms such as:

- `{Damage}` for the normal value.
- `{Damage:diff()}` for upgraded/diff-aware display.
- Inverse/diff/pluralize helpers exist; verify exact syntax in the BaseLib localization docs before using uncommon formatters.

## Dynamic Variables

Use `CanonicalVars` to declare numbers the card text and game logic both need:

```csharp
protected override IEnumerable<DynamicVar> CanonicalVars =>
[
    new DamageVar(6m, ValueProp.Move),
    new BlockVar(5m),
    new PowerVar<ExamplePower>(3),
    new CardsVar(1),
    new EnergyVar(1)
];
```

Current observed variable classes:

- `DamageVar`
- `BlockVar`
- `CardsVar`
- `EnergyVar`
- `HealVar`
- `PowerVar<TPower>`
- calculated variants through BaseLib helpers such as `MakeCalculatedDamage` and `MakeCalculatedBlock`

Access variables through `DynamicVars`:

```csharp
DynamicVars.Damage.BaseValue
DynamicVars.Block.IntValue
DynamicVars["ExamplePower"].IntValue
```

Upgrade variables in `OnUpgrade`:

```csharp
DynamicVars.Damage.UpgradeValueBy(3m);
DynamicVars["ExamplePower"].UpgradeValueBy(1);
```

Guidelines:

- Every number shown in card text should usually be a `DynamicVar`.
- Use named power variables when the localization placeholder should be explicit, such as `{ExamplePower:diff()}`.
- Avoid hard-coded numbers in descriptions that can drift from `OnPlay`.
- Use `ValueProp.Move` for normal attack damage that should participate in attack move behavior.

## Tags

Use `CanonicalTags` for semantic compatibility:

```csharp
protected override HashSet<CardTag> CanonicalTags => [CardTag.Strike];
```

Use tags when the game should understand the card as a known family, such as Strike. Do not create broad/global custom tags until there is a confirmed API need and collision risk is documented.

## Playing A Card

Implement card behavior by overriding:

```csharp
protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
```

Use command APIs so the game can handle visuals, logging, combat sequencing, relic/power hooks, and multiplayer context:

```csharp
await DamageCmd.Attack(DynamicVars.Damage.BaseValue)
    .FromCard(this)
    .Targeting(cardPlay.Target)
    .WithHitFx("vfx/vfx_attack_blunt")
    .Execute(choiceContext);
```

Other common command patterns:

```csharp
await ApplyOrIncreasePower<ExamplePower>(DynamicVars["ExamplePower"].IntValue);
await CardPileCmd.Draw(choiceContext, DynamicVars.Cards.IntValue, Owner);
```

Rules:

- For targeted enemy cards, guard target access with `ArgumentNullException.ThrowIfNull(cardPlay.Target)`.
- Use `choiceContext` in command execution.
- Prefer game command APIs over directly mutating creature/card state.
- Keep async command order explicit with `await`.

## Upgrades

Implement upgrade behavior in:

```csharp
protected override void OnUpgrade()
```

Typical upgrades:

- Increase damage/block/power/draw/energy vars.
- Reduce cost through BaseLib helpers if using `ConstructedCardModel`, or verify the current `CardModel` cost-upgrade API before direct mutation.
- Add or change keywords only using confirmed current APIs.

Variable increment example:

```csharp
protected override void OnUpgrade()
{
    DynamicVars.Block.UpgradeValueBy(3m);
}
```

Do not duplicate upgraded text manually. Let localization and dynamic vars render the diff where possible.

## Hover Tips

Use `ExtraHoverTips` when descriptions mention custom powers, keywords, or concepts that need hover text:

```csharp
protected override IEnumerable<IHoverTip> ExtraHoverTips =>
[
    HoverTipFactory.FromPower<ExamplePower>()
];
```

`PowerVar<TPower>` can also add a power tooltip in BaseLib helper paths, but explicit tips can make card behavior easier to audit.

## Rewards And Pools

A card appears in reward pools when:

- Its class is registered into a non-shared character card pool through `[Pool]`.
- Its rarity and pool allow it to appear.
- Any pool filtering allows it.

Basic starter cards can be in the pool, but starter deck inclusion is separate. To avoid reward pollution:

- Be deliberate about `CardRarity.Basic`.
- If a card should never appear as a normal reward, verify whether BaseLib or `CardModel` exposes a current override/filter for this before relying on rarity alone.
- Pool-level filtering can be implemented by overriding `CustomCardPoolModel` methods such as `FilterThroughEpochs` when needed.

## Assets And Packing

Card art must be included as Godot assets under `<ModId>/` so it is packed into the mod `.pck`.

Expected paths for the shared card base shown above:

```text
<ModId>/images/card_portraits/big/<card_id>.png
<ModId>/images/card_portraits/<card_id>.png
```

Godot import metadata is generated during editor/export operations:

```text
<ModId>/images/card_portraits/big/<card_id>.png.import
<ModId>/images/card_portraits/<card_id>.png.import
```

If a new card compiles but art is missing, expect placeholder/missing texture behavior or runtime load failures depending on the call path. Treat art paths as part of the card format.

## Validation

Before release, run the mod's normal validation path. For example, a repository may expose:

```bash
scripts/package.sh
```

Focused card checks:

- C# compiles.
- `<ModId>/localization/eng/cards.json` is valid JSON.
- Every card class has `title` and `description` localization entries.
- Every placeholder in description has a matching `CanonicalVars` entry or a confirmed formatter.
- Every card portrait path resolved by the shared card base exists.
- Starter deck uses `ModelDb.Card<T>()`.
- Cards are in the intended `<CardPool>`.
- New custom powers used by cards have power model, localization, and hover tip coverage.

If the project uses `Alchyr.Sts2.ModAnalyzers`, keep localization files in the `.csproj` `AdditionalFiles` item so analyzer coverage remains available:

```xml
<AdditionalFiles Include="<ModId>/localization/**/*.json"/>
```

## Minimal New Card Checklist

1. Add `<ModCode>/Cards/<group>/<CardName>.cs`.
2. Inherit from the mod's shared card base, such as `ExampleCard(cost, type, rarity, target)`.
3. Add `[Pool(typeof(<CardPool>))]`.
4. Add `CanonicalVars` for every number shown in text.
5. Add `CanonicalTags` only when the game should treat the card as a known family.
6. Implement `OnPlay`.
7. Implement `OnUpgrade` if the card upgrades.
8. Add `ExtraHoverTips` for custom powers/keywords/concepts.
9. Add localization:
   - `<MOD_ID>-<ENTRY>.title`
   - `<MOD_ID>-<ENTRY>.description`
10. Add art:
    - `<ModId>/images/card_portraits/big/<entry>.png`
    - `<ModId>/images/card_portraits/<entry>.png`
11. Add to `StartingDeck` only if it is a starter card.
12. Run package/build validation.

## Recommended Naming Conventions

Use stable local conventions unless the modding API forces a change:

- Card IDs use a unique mod namespace prefix, such as `<MOD_ID>-`.
- Source code class names are PascalCase.
- Asset names are lowercase snake_case derived from `Id.Entry.RemovePrefix()`.
- Use one shared base card class for art paths and common helpers.
- Use one `CustomCardPoolModel` subclass per custom card color/pool.
- Keep JSON localization flat, with one key per title/description.
- Prefer local card/power behavior over global hooks.
- Document any broad compatibility-affecting card mechanic before implementing it.

## Unknowns To Re-Verify Before Advanced Cards

These are intentionally not locked down here:

- Exact current API for special energy costs.
- Whether there is a preferred per-card reward-exclusion override beyond pool filtering.
- Current complete enum values for `TargetType`, `CardType`, and `CardRarity`.
- Current best API for custom keywords beyond localization and hover tips.
- Current APIs for exhaust/ethereal/retain/equivalent behavior.
- Whether future BaseLib versions change automatic card-pool registration or localization loading.

When one of these matters, inspect the installed package XML and at least one current working mod before coding.
