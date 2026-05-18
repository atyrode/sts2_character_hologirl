# sts2_character_hologirl

Slay the Spire 2 playable character mod project.

## Current Shape

- Persistent agent/contributor workflow rules: [AGENTS.md](AGENTS.md).
- Confirmed project goal and current research live in [docs/](docs/).
- STS2 character mod scaffold: `Hologirl.csproj`, `HologirlCode/`, and `Hologirl/`.
- Current prototype: Hologirl starter deck, Prism Pendant starter relic, `Fans`, `Singing`, and `Livestream` chat-overlay mechanics. `Shapeshift` remains a deferred design term; the old form reward cards are removed from the active source set.

## Development

Before committing, branching, merging, or deploying, fetch the remote branch state and check whether the local branch is ahead, behind, or diverged:

```sh
git fetch
git status --short --branch
```

Current local toolchain state:

- Shared STS2 game files are installed at `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2`.
- Shared `.NET 9 SDK` is installed at `/mnt/HC_Volume_105232828/shared/tools/dotnet`.
- Shared Godot/MegaDot `4.5.1` is installed at `/mnt/HC_Volume_105232828/shared/tools/godot/godot-4.5.1`.
- BaseLib `v3.1.3` is installed at `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/mods/BaseLib`.
- The Hologirl build copies `Hologirl.dll`, `Hologirl.pdb`, `Hologirl.json`, and `Hologirl.pck` to `/mnt/HC_Volume_105232828/shared/games/slay-the-spire-2/mods/Hologirl`.
- Headless game launch reaches startup, but gameplay testing is blocked on the VPS because Steamworks still requires a running Steam client.

Create local build settings in ignored `Directory.Build.props` when needed:

```xml
<Project>
  <PropertyGroup>
    <Sts2Path>/path/to/Slay the Spire 2</Sts2Path>
  </PropertyGroup>
</Project>
```

When project tooling is added, document the setup, run commands, generated outputs, and validation steps here.

Build:

```sh
scripts/build.sh
```

Package with the default Godot/MegaDot PCK exporter:

```sh
scripts/package.sh
```

Release:

```sh
git fetch
git status --short --branch
git add -A
git commit -m "Prepare Hologirl vX.Y.Z"
git push origin main
scripts/release.sh
```

`scripts/release.sh` intentionally refuses to run unless `main` is clean and exactly matches `origin/main`. A release must always be backed by committed, pushed source so the GitHub release artifact, tag, and repository history stay in sync.

Before preparing a release, review open GitHub issues and pull any in-scope fixes into the release. When new feedback is real but not part of the current work, record it as a GitHub issue instead of keeping a local scratch list.

For emergency simple-asset-only packages, the old quick packer can still be selected explicitly:

```sh
HOLOGIRL_PCK_EXPORTER=quick \
scripts/package.sh
```

Run the character-select scene smoke check:

```sh
scripts/godot-smoke-character-select.sh
```

Run the local spine rig tuner web app:

```sh
cd docs/design/tools/spine-rig-tuner
npm install
npm run dev
```

Validate the tuner web app:

```sh
cd docs/design/tools/spine-rig-tuner
npm run build
```

Inspect a packed Godot scene in the exported PCK when debugging placeholder asset routing:

```sh
godot --headless --script scripts/inspect-packed-scene.gd -- \
  /path/to/Hologirl.pck \
  res://Hologirl/scenes/creature_visuals/hologirl.tscn
```

Godot and `.NET` paths are resolved by `scripts/godot-env.sh`. Override `GODOT_BIN`, `DOTNET_ROOT`, `STS2_MODS_DIR`, or `HOLOGIRL_SHARED_ROOT` when working from a different install.

## Documents

- [AGENTS.md](AGENTS.md): persistent workflow rules for future agents and contributors.
- [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md): confirmed project intent.
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md): confirmed codebase structure, ownership, and integration points.
- [docs/DESIGN.md](docs/DESIGN.md): confirmed design direction and variant notes.
- [docs/design/](docs/design/): per-card, per-form, per-effect, art direction, terminology, and asset pipeline notes.
- [docs/DEVELOPMENT_STEPS.md](docs/DEVELOPMENT_STEPS.md): working checklist.
