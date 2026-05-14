#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: scripts/shift-image-content.sh <source-png> <output-png> <shift-y-px>" >&2
  exit 1
fi

source_png="$1"
output_png="$2"
shift_y="$3"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dotnet_bin="${DOTNET_BIN:-/home/alex/.dotnet/dotnet}"
tool_dir="${TMPDIR:-/tmp}/hologirl-image-shift"

if [[ ! -f "$source_png" ]]; then
  echo "Source image not found: $source_png" >&2
  exit 1
fi

mkdir -p "$tool_dir"

cat > "$tool_dir/hologirl-image-shift.csproj" <<'CSProj'
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net9.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="SixLabors.ImageSharp" Version="3.1.11" />
  </ItemGroup>
</Project>
CSProj

cat > "$tool_dir/Program.cs" <<'CS'
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;

if (args.Length != 3)
{
    Console.Error.WriteLine("Usage: <source-png> <output-png> <shift-y-px>");
    return 1;
}

var src = args[0];
var output = args[1];
var shiftY = int.Parse(args[2]);

using var image = Image.Load<Rgba32>(src);
using var shifted = image.Clone(ctx =>
{
    ctx.DrawImage(image, new Point(0, shiftY), 1f);
});

if (shiftY > 0)
{
    var fillHeight = Math.Min(shiftY, image.Height);
    using var topFill = image.Clone(ctx => ctx.Crop(new Rectangle(0, 0, image.Width, 1)).Resize(image.Width, fillHeight));
    shifted.Mutate(ctx => ctx.DrawImage(topFill, new Point(0, 0), 1f));
}
else if (shiftY < 0)
{
    var fillHeight = Math.Min(-shiftY, image.Height);
    using var bottomFill = image.Clone(ctx => ctx.Crop(new Rectangle(0, image.Height - 1, image.Width, 1)).Resize(image.Width, fillHeight));
    shifted.Mutate(ctx => ctx.DrawImage(bottomFill, new Point(0, image.Height - fillHeight), 1f));
}

Directory.CreateDirectory(Path.GetDirectoryName(output)!);
shifted.SaveAsPng(output);
Console.WriteLine($"{output}: shifted y {shiftY}px");
return 0;
CS

"$dotnet_bin" run --project "$tool_dir/hologirl-image-shift.csproj" -- "$source_png" "$repo_root/$output_png" "$shift_y"
