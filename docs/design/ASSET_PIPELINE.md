# Asset Pipeline

## Card Portrait Sizes

Card portraits must be added in both sizes:

- Big portrait: `Hologirl/images/card_portraits/big/<card_id>.png`, `1000x760`
- Small portrait: `Hologirl/images/card_portraits/<card_id>.png`, `250x190`

Avoid adding portrait/tall generations and hoping the card crop works. Regenerate or crop deliberately to the target landscape aspect before committing.

## Runtime UI Assets To Replace

The current roadmap includes replacing or validating these non-card-portrait assets:

- Card frame/color treatment: Hologirl periwinkle/accent direction.
- Energy symbol and energy text.
- Runtime energy assets are derived from the selected archived concept with `scripts/create-energy-assets.sh <source-png>`, which exports `Hologirl/images/charui/big_energy.png` at 74x74 and `Hologirl/images/charui/text_energy.png` at 24x24.
- Character icon.
- Character-select button and locked portrait.
- Map marker.
- Starting relic icon and outline.
- Power placeholder art.
- Mod image.

Record final dimensions and source paths here as each asset is confirmed in-game.

## Naming

`HologirlCard.CustomPortraitPath` resolves portraits from the lower-case card id after the `Hologirl` prefix.

- `HoloStrike` -> `holo_strike.png`
- `HoloDefend` -> `holo_defend.png`
- `Concert` -> `concert.png`
- `Livestream` -> `livestream.png`

## Release Notes

Every GitHub release should have a matching changelog at `docs/releases/<version>.md`. `scripts/release.sh` uses that file as the release notes when it exists.

## Art Archive

All generated art attempts that influence design should be copied into `docs/design/art_archive/` before the conversation context becomes the only record. Keep selected and rejected attempts. Each attempt should include the generated image and a metadata README with timestamp, source filename, prompt status, design notes, and selection status.

Use `scripts/archive-art-attempt.sh` for future generated attempts:

```bash
scripts/archive-art-attempt.sh <archive-key> <source-png> [prompt-file]
```

When `<archive-key>` has no slash, it is stored under `docs/design/art_archive/cards/<archive-key>/`.
When it has a slash, it is stored directly under `docs/design/art_archive/<archive-key>/`, such as `menu/character_select_splash`.

Use `scripts/resize-card-art.sh` to prepare selected art for the game:

```bash
scripts/resize-card-art.sh <source-png> Hologirl/images/card_portraits/big/<card_id>.png Hologirl/images/card_portraits/<card_id>.png
```

Use `scripts/resize-image.sh` for non-card assets:

```bash
scripts/resize-image.sh <source-png> <output-png> <width> <height> [cover|contain]
```

Use `scripts/shift-image-content.sh` for small runtime framing tweaks to an already accepted generated image:

```bash
scripts/shift-image-content.sh <source-png> <output-png> <shift-y-px>
```

Use `scripts/remove-chroma-key.sh` for generated cutout sources that were created on a flat chroma-key background:

```bash
scripts/remove-chroma-key.sh <source-png> <output-png> [#rrggbb]
```

Use `scripts/preview-alpha.sh` to make a checkerboard preview and alpha-pixel summary for transparent PNGs:

```bash
scripts/preview-alpha.sh <source-png> <output-png>
```
