# Asset Pipeline

## Card Portrait Sizes

Card portraits must be added in both sizes:

- Big portrait: `Hologirl/images/card_portraits/big/<card_id>.png`, `1000x760`
- Small portrait: `Hologirl/images/card_portraits/<card_id>.png`, `250x190`

Avoid adding portrait/tall generations and hoping the card crop works. Regenerate or crop deliberately to the target landscape aspect before committing.

## Naming

`HologirlCard.CustomPortraitPath` resolves portraits from the lower-case card id after the `Hologirl` prefix.

- `HoloStrike` -> `holo_strike.png`
- `HoloDefend` -> `holo_defend.png`
- `Concert` -> `concert.png`
- `Livestream` -> `livestream.png`

## Release Notes

Every GitHub release should have a matching changelog at `docs/releases/<version>.md`. `scripts/release.sh` uses that file as the release notes when it exists.

## Art Archive

All generated card-art attempts that influence design should be copied into `docs/design/art_archive/` before the conversation context becomes the only record. Keep selected and rejected attempts. Each attempt should include the generated image and a metadata README with timestamp, source filename, prompt status, design notes, and selection status.

Use `scripts/archive-art-attempt.sh` for future generated attempts:

```bash
scripts/archive-art-attempt.sh <card-id> <source-png> [prompt-file]
```

Use `scripts/resize-card-art.sh` to prepare selected art for the game:

```bash
scripts/resize-card-art.sh <source-png> Hologirl/images/card_portraits/big/<card_id>.png Hologirl/images/card_portraits/<card_id>.png
```
