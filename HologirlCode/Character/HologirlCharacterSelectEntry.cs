using BaseLib.Abstracts;
using Godot;
using Hologirl.HologirlCode.Extensions;
using MegaCrit.Sts2.Core.Models;

namespace Hologirl.HologirlCode.Character;

public class HologirlCharacterSelectEntry : CustomCharacterSelectEntry
{
    private static readonly ParticleSpec[] Particles =
    [
        new(0.48f, 0.22f, 0.0f, 12, -8, new Color(1.0f, 0.78f, 0.25f, 0.95f)),
        new(0.52f, 0.16f, 1.8f, -10, 7, new Color(1.0f, 0.72f, 0.18f, 0.88f)),
        new(0.56f, 0.20f, 3.1f, 8, 10, new Color(1.0f, 0.84f, 0.34f, 0.9f)),
        new(0.60f, 0.31f, 2.4f, -12, -6, new Color(1.0f, 0.78f, 0.25f, 0.86f)),
        new(0.52f, 0.46f, 4.2f, 10, 8, new Color(1.0f, 0.72f, 0.18f, 0.82f)),
        new(0.69f, 0.69f, 0.9f, -14, 6, new Color(1.0f, 0.82f, 0.28f, 0.94f)),
        new(0.76f, 0.73f, 2.7f, 9, -9, new Color(1.0f, 0.74f, 0.18f, 0.9f)),
        new(0.83f, 0.78f, 4.0f, -8, 12, new Color(1.0f, 0.84f, 0.34f, 0.9f)),
        new(0.90f, 0.84f, 1.3f, 13, -7, new Color(1.0f, 0.72f, 0.18f, 0.84f)),
        new(0.80f, 0.91f, 3.5f, -10, -10, new Color(1.0f, 0.78f, 0.25f, 0.86f)),
    ];

    public override string EntryId => Hologirl.CharacterId;
    public override string ButtonIconPath => "char_select_char_name.png".CharacterUiPath();
    public override string EntryTitle => "Hologirl";
    public override string EntryDescription => "A holographic idol who gathers Fans and Shapeshifts through idol forms.";
    public override bool VisibleInCharacterSelect => true;
    public override bool UnlockedInCharacterSelect => true;
    public override CharacterModel InitialCharacter => ModelDb.Character<Hologirl>();
    public override bool ShowVanillaInfoPanelWhenResolved => true;

    public override Control CreateCharacterSelectScene()
    {
        var root = new Control { Name = "HologirlCharacterSelectBg", ClipContents = false };
        root.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        var splash = new TextureRect
        {
            Name = "Splash",
            Texture = GD.Load<Texture2D>("character_select_bg.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.KeepAspectCovered
        };
        splash.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        var particles = new Control
        {
            Name = "ParticleLayer",
            MouseFilter = Control.MouseFilterEnum.Ignore,
            ClipContents = false,
            ZIndex = 20
        };
        particles.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        root.AddChild(splash);
        root.AddChild(particles);
        return root;
    }

    public override void RegisterScene(Control scene, CustomCharacterSelectContext context)
    {
        scene.Position = Vector2.Zero;

        var shake = scene.CreateTween();
        shake.TweenProperty(scene, "position", new Vector2(8, -3), 0.035f);
        shake.TweenProperty(scene, "position", new Vector2(-5, 3), 0.045f);
        shake.TweenProperty(scene, "position", new Vector2(3, -2), 0.04f);
        shake.TweenProperty(scene, "position", Vector2.Zero, 0.06f);

        var size = scene.GetViewportRect().Size;
        if (scene.GetNodeOrNull<Control>("ParticleLayer") is { } particles)
        {
            ConfigureParticles(particles, size);
        }
    }

    private static void ConfigureParticles(Control layer, Vector2 bounds)
    {
        layer.Size = bounds;
        layer.CustomMinimumSize = bounds;
        layer.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        if (layer.GetChildCount() > 0)
        {
            return;
        }

        for (var i = 0; i < Particles.Length; i++)
        {
            var spec = Particles[i];
            var glow = CreateParticleRect($"WhipParticleGlow{i}", spec.Color with { A = 0.18f }, new Vector2(18, 18));
            var spark = CreateParticleRect($"WhipParticle{i}", spec.Color, new Vector2(8, 8));
            var basePosition = new Vector2(bounds.X * spec.X, bounds.Y * spec.Y);

            layer.AddChild(glow);
            layer.AddChild(spark);

            AnimateParticle(glow, basePosition, spec, 1.8f, 0.45f);
            AnimateParticle(spark, basePosition + new Vector2(5, 5), spec, 1.0f, 0.9f);
        }
    }

    private static ColorRect CreateParticleRect(string name, Color color, Vector2 size)
    {
        return new ColorRect
        {
            Name = name,
            Color = color,
            Size = size,
            PivotOffset = size / 2,
            MouseFilter = Control.MouseFilterEnum.Ignore
        };
    }

    private static void AnimateParticle(ColorRect particle, Vector2 basePosition, ParticleSpec spec, float scale, float alpha)
    {
        particle.Position = basePosition - particle.PivotOffset;
        particle.Rotation = Mathf.Pi / 4f;
        particle.Modulate = new Color(1, 1, 1, alpha);

        var tween = particle.CreateTween();
        tween.SetLoops();
        tween.SetParallel();
        tween.TweenProperty(particle, "position", basePosition + new Vector2(spec.DriftX, spec.DriftY) - particle.PivotOffset, 0.75f + spec.Phase * 0.03f);
        tween.TweenProperty(particle, "scale", Vector2.One * scale, 0.75f);
        tween.TweenProperty(particle, "modulate", new Color(1, 1, 1, alpha * 0.25f), 0.75f);
        tween.Chain().TweenProperty(particle, "position", basePosition - particle.PivotOffset, 0.75f);
        tween.TweenProperty(particle, "scale", Vector2.One * 0.65f, 0.75f);
        tween.TweenProperty(particle, "modulate", new Color(1, 1, 1, alpha), 0.75f);
    }

    private readonly record struct ParticleSpec(float X, float Y, float Phase, float DriftX, float DriftY, Color Color);
}
