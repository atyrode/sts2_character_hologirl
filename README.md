# sts2_character_hologirl

Slay the Spire 2 playable character mod project.

## Current Shape

- Persistent agent/contributor workflow rules: [AGENTS.md](AGENTS.md).
- Confirmed project goal and current research live in [docs/](docs/).
- STS2 character mod scaffold: `Hologirl.csproj`, `HologirlCode/`, and `Hologirl/`.
- First custom card: `HoloStrike`, currently added to the starting deck.

## Development

Before committing, branching, merging, or deploying, fetch the remote branch state and check whether the local branch is ahead, behind, or diverged:

```sh
git fetch
git status --short --branch
```

Current VPS state:

- STS2 game files are installed at `/home/alex/games/slay-the-spire-2`.
- `.NET 9 SDK` is installed at `/home/alex/.dotnet`.
- BaseLib `v3.1.3` is installed at `/home/alex/games/slay-the-spire-2/mods/BaseLib`.
- The Hologirl build copies `Hologirl.dll`, `Hologirl.pdb`, `Hologirl.json`, and `Hologirl.pck` to `/home/alex/games/slay-the-spire-2/mods/Hologirl`.
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
/home/alex/.dotnet/dotnet build Hologirl.csproj
```

## Documents

- [AGENTS.md](AGENTS.md): persistent workflow rules for future agents and contributors.
- [docs/PROJECT_SPEC.md](docs/PROJECT_SPEC.md): confirmed project intent.
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md): confirmed codebase structure, ownership, and integration points.
- [docs/DESIGN.md](docs/DESIGN.md): confirmed design direction and variant notes.
- [docs/design/](docs/design/): per-card, per-form, per-effect, art direction, terminology, and asset pipeline notes.
- [docs/DEVELOPMENT_STEPS.md](docs/DEVELOPMENT_STEPS.md): working checklist.
