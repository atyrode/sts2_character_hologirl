#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dotnet_bin="${DOTNET_BIN:-/mnt/HC_Volume_105232828/shared/tools/dotnet/dotnet}"
tool_dir="${TMPDIR:-/tmp}/hologirl-flat-character-bg"

archive_dir="$repo_root/docs/design/art_archive/menu/character_select_background/flat-variants-2026-05-15"
preview_dir="$archive_dir/runtime-size-previews"

mkdir -p "$tool_dir" "$archive_dir" "$preview_dir"

cat > "$tool_dir/hologirl-flat-character-bg.csproj" <<'CSProj'
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net9.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="SixLabors.ImageSharp" Version="3.1.11" />
    <PackageReference Include="SixLabors.ImageSharp.Drawing" Version="2.1.6" />
  </ItemGroup>
</Project>
CSProj

cat > "$tool_dir/Program.cs" <<'CS'
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Drawing;
using SixLabors.ImageSharp.Drawing.Processing;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;

if (args.Length != 2)
{
    Console.Error.WriteLine("Usage: <archive-dir> <preview-dir>");
    return 1;
}

var archiveDir = args[0];
var previewDir = args[1];
Directory.CreateDirectory(archiveDir);
Directory.CreateDirectory(previewDir);

const int archiveWidth = 2564;
const int archiveHeight = 1204;
const int runtimeWidth = 1282;
const int runtimeHeight = 602;

var variants = new[]
{
    new Variant("01-cyan-lightning", "Cyan Lightning", "#34C8E8", "#1392B4", "#86EAF7", DrawLightning),
    new Variant("02-cobalt-flame", "Cobalt Flame", "#3F74FF", "#2142B8", "#86A8FF", DrawFlames),
    new Variant("03-rose-curtain", "Rose Curtain", "#F45AA1", "#BE2B70", "#FF91C5", DrawCurtain),
    new Variant("04-mint-signal", "Mint Signal", "#4EDB79", "#249A4E", "#93F0AD", DrawSignal),
    new Variant("05-gold-halo", "Gold Halo", "#FFC247", "#D88415", "#FFE080", DrawHalo),
};

foreach (var variant in variants)
{
    using var image = new Image<Rgba32>(archiveWidth, archiveHeight, Color.ParseHex(variant.Base));
    image.Mutate(ctx =>
    {
        variant.Draw(ctx, variant);
    });

    var archivePath = System.IO.Path.Combine(archiveDir, $"{variant.Slug}.png");
    image.SaveAsPng(archivePath);

    using var runtime = image.Clone(ctx => ctx.Resize(runtimeWidth, runtimeHeight));
    var runtimeSlug = variant.Slug.Replace("-", "_");
    var previewPath = System.IO.Path.Combine(previewDir, $"bg_{runtimeSlug}.png");
    runtime.SaveAsPng(previewPath);
    Console.WriteLine($"{variant.Name}: {previewPath}");
}

return 0;

static void DrawFlames(IImageProcessingContext ctx, Variant v)
{
    var dark = Color.ParseHex(v.Dark);
    var light = Color.ParseHex(v.Light);

    ctx.Fill(dark, Path(
        P(1460, 1204), P(1510, 930), P(1590, 740), P(1680, 510), P(1745, 250),
        P(1845, 600), P(1960, 360), P(2025, 95), P(2130, 515), P(2240, 345),
        P(2220, 720), P(2400, 600), P(2325, 920), P(2440, 1204)));
    ctx.Fill(dark, Path(
        P(530, 1204), P(610, 965), P(730, 810), P(770, 560), P(900, 845),
        P(1015, 620), P(1080, 900), P(1250, 710), P(1190, 1204)));
    ctx.Draw(light, 22, Path(
        P(1520, 1204), P(1660, 790), P(1750, 400), P(1865, 710), P(2020, 190),
        P(2135, 610), P(2260, 430), P(2240, 830), P(2385, 675)));
}

static void DrawLightning(IImageProcessingContext ctx, Variant v)
{
    var dark = Color.ParseHex(v.Dark);
    var light = Color.ParseHex(v.Light);

    ctx.Fill(dark, Polygon(
        P(320, 0), P(780, 0), P(590, 360), P(900, 360), P(455, 930), P(570, 520), P(260, 520)));
    ctx.Fill(dark, Polygon(
        P(1780, 160), P(2140, 160), P(1980, 475), P(2240, 475), P(1845, 1010), P(1970, 635), P(1690, 635)));
    ctx.Draw(light, 18, OpenPath(P(420, 50), P(660, 50), P(500, 420), P(810, 420), P(490, 850)));
    ctx.Draw(light, 16, OpenPath(P(1870, 205), P(2070, 205), P(1910, 545), P(2160, 545), P(1900, 910)));
}

static void DrawCurtain(IImageProcessingContext ctx, Variant v)
{
    var dark = Color.ParseHex(v.Dark);
    var light = Color.ParseHex(v.Light);

    ctx.Fill(dark, Path(
        P(0, 0), P(410, 0), P(350, 250), P(445, 575), P(295, 850), P(355, 1204), P(0, 1204)));
    ctx.Fill(dark, Path(
        P(2564, 0), P(2120, 0), P(2180, 300), P(2060, 610), P(2220, 890), P(2140, 1204), P(2564, 1204)));
    ctx.Draw(light, 18, Path(P(210, 0), P(310, 250), P(255, 560), P(330, 875), P(275, 1204)));
    ctx.Draw(light, 18, Path(P(2320, 0), P(2220, 300), P(2290, 610), P(2195, 900), P(2255, 1204)));
}

static void DrawSignal(IImageProcessingContext ctx, Variant v)
{
    var dark = Color.ParseHex(v.Dark);
    var light = Color.ParseHex(v.Light);

    ctx.Draw(dark, 56, ArcPath(P(1820, 630), 260, -58, 72));
    ctx.Draw(dark, 56, ArcPath(P(1820, 630), 455, -54, 68));
    ctx.Draw(dark, 56, ArcPath(P(1820, 630), 650, -51, 64));
    ctx.Fill(dark, EllipsePolygon(1628, 520, 170, 170));
    ctx.Fill(dark, Path(P(0, 840), P(330, 650), P(710, 780), P(990, 610), P(1240, 720), P(1320, 1204), P(0, 1204)));
    ctx.Draw(light, 18, ArcPath(P(1820, 630), 455, -54, 68));
}

static void DrawHalo(IImageProcessingContext ctx, Variant v)
{
    var dark = Color.ParseHex(v.Dark);
    var light = Color.ParseHex(v.Light);

    ctx.Draw(dark, 120, EllipsePath(1560, 170, 760, 760));
    ctx.Draw(light, 22, EllipsePath(1560, 170, 760, 760));
    ctx.Fill(dark, Path(P(0, 930), P(360, 760), P(760, 845), P(1110, 710), P(1510, 855), P(2564, 765), P(2564, 1204), P(0, 1204)));
    ctx.Fill(dark, Polygon(P(190, 90), P(350, 155), P(250, 245), P(80, 190)));
    ctx.Fill(dark, Polygon(P(520, 230), P(700, 310), P(595, 410), P(420, 335)));
}

static IPath Path(params PointF[] points)
{
    var builder = BuildLines(points);
    builder.CloseFigure();
    return builder.Build();
}

static IPath Polygon(params PointF[] points) => Path(points);

static IPath OpenPath(params PointF[] points)
{
    return BuildLines(points).Build();
}

static PathBuilder BuildLines(params PointF[] points)
{
    var builder = new PathBuilder();
    if (points.Length == 0)
    {
        return builder;
    }

    builder.StartFigure();
    for (var i = 1; i < points.Length; i++)
    {
        builder.AddLine(points[i - 1], points[i]);
    }

    return builder;
}

static IPath EllipsePath(float x, float y, float width, float height)
{
    return new EllipsePolygon(x + width / 2, y + height / 2, width / 2, height / 2);
}

static IPath EllipsePolygon(float x, float y, float width, float height)
{
    return new EllipsePolygon(x + width / 2, y + height / 2, width / 2, height / 2);
}

static IPath ArcPath(PointF center, float radius, float startDegrees, float sweepDegrees)
{
    var builder = new PathBuilder();
    const int segments = 28;
    for (var i = 0; i <= segments; i++)
    {
        var angle = (startDegrees + sweepDegrees * i / segments) * Math.PI / 180.0;
        var point = P(center.X + MathF.Cos((float)angle) * radius, center.Y + MathF.Sin((float)angle) * radius);
        if (i > 0)
        {
            var previousAngle = (startDegrees + sweepDegrees * (i - 1) / segments) * Math.PI / 180.0;
            var previous = P(center.X + MathF.Cos((float)previousAngle) * radius, center.Y + MathF.Sin((float)previousAngle) * radius);
            builder.AddLine(previous, point);
        }
    }
    return builder.Build();
}

static PointF P(float x, float y) => new(x, y);

record Variant(string Slug, string Name, string Base, string Dark, string Light, Action<IImageProcessingContext, Variant> Draw);
CS

"$dotnet_bin" run --project "$tool_dir/hologirl-flat-character-bg.csproj" -- "$archive_dir" "$preview_dir"
