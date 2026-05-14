using BaseLib.Abstracts;
using Godot;
using Hologirl.HologirlCode.Extensions;
using MegaCrit.Sts2.Core.Models;

namespace Hologirl.HologirlCode.Character;

public class HologirlCharacterSelectEntry : CustomCharacterSelectEntry
{
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
        var root = new Control { Name = "HologirlCharacterSelectScene", ClipContents = false };
        root.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        var background = new TextureRect
        {
            Name = "Background",
            Texture = GD.Load<Texture2D>("character_select_bg.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.KeepAspectCovered
        };
        background.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        var character = new TextureRect
        {
            Name = "HologirlLayer",
            Texture = GD.Load<Texture2D>("character_select_hologirl.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.KeepAspect,
            MouseFilter = Control.MouseFilterEnum.Ignore,
            ZIndex = 10
        };

        var effects = new HologirlCharacterSelectEffects
        {
            Name = "HologirlEffects",
            MouseFilter = Control.MouseFilterEnum.Ignore,
            ClipContents = false,
            ZIndex = 30
        };
        effects.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        root.AddChild(background);
        root.AddChild(character);
        root.AddChild(effects);
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

        var bounds = scene.GetViewportRect().Size;
        if (scene.GetNodeOrNull<TextureRect>("HologirlLayer") is { } character)
        {
            ConfigureCharacterLayer(character, bounds);
        }

        if (scene.GetNodeOrNull<HologirlCharacterSelectEffects>("HologirlEffects") is { } effects)
        {
            effects.Configure(bounds);
            effects.StartSelectionBurst();
        }
    }

    private static void ConfigureCharacterLayer(TextureRect character, Vector2 bounds)
    {
        var height = bounds.Y * 1.08f;
        var width = height * 1.5f;
        character.Size = new Vector2(width, height);
        character.Position = new Vector2(bounds.X * 0.26f, bounds.Y * -0.06f);
        character.CustomMinimumSize = character.Size;
        character.PivotOffset = character.Size / 2f;
    }
}

public sealed partial class HologirlCharacterSelectEffects : Control
{
    private static readonly Vector2[] WhipEmitterPoints =
    [
        new(0.39f, 0.53f),
        new(0.48f, 0.42f),
        new(0.57f, 0.33f),
        new(0.67f, 0.26f),
        new(0.77f, 0.24f),
        new(0.86f, 0.32f),
        new(0.90f, 0.44f),
        new(0.82f, 0.62f),
        new(0.71f, 0.76f),
    ];

    private readonly List<Particle> _particles = [];
    private readonly RandomNumberGenerator _rng = new();
    private Vector2 _bounds;
    private float _sparkTimer;
    private float _driftTimer;

    public void Configure(Vector2 bounds)
    {
        _bounds = bounds;
        Size = bounds;
        CustomMinimumSize = bounds;
        SetAnchorsAndOffsetsPreset(LayoutPreset.FullRect);
        SetProcess(true);
    }

    public void StartSelectionBurst()
    {
        for (var i = 0; i < 18; i++)
        {
            EmitWhipSpark(true);
        }

        for (var i = 0; i < 10; i++)
        {
            EmitHologramDrift(true);
        }
    }

    public override void _Process(double delta)
    {
        var dt = (float)delta;
        _sparkTimer -= dt;
        _driftTimer -= dt;

        while (_sparkTimer <= 0f)
        {
            EmitWhipSpark(false);
            _sparkTimer += 0.055f;
        }

        while (_driftTimer <= 0f)
        {
            EmitHologramDrift(false);
            _driftTimer += 0.18f;
        }

        for (var i = _particles.Count - 1; i >= 0; i--)
        {
            var particle = _particles[i];
            particle.Age += dt;
            particle.Position += particle.Velocity * dt;
            particle.Rotation += particle.RotationSpeed * dt;

            if (particle.Age >= particle.Lifetime)
            {
                _particles.RemoveAt(i);
            }
            else
            {
                _particles[i] = particle;
            }
        }

        QueueRedraw();
    }

    public override void _Draw()
    {
        foreach (var particle in _particles)
        {
            var t = particle.Age / particle.Lifetime;
            var alpha = particle.Color.A * (1f - t);
            var color = new Color(particle.Color.R, particle.Color.G, particle.Color.B, alpha);
            var size = particle.Size * (1f + t * particle.Grow);

            if (particle.Kind == ParticleKind.Spark)
            {
                DrawSetTransform(particle.Position, particle.Rotation, Vector2.One);
                DrawRect(new Rect2(-size / 2f, size), color);
                DrawRect(new Rect2(new Vector2(-size.X, -1.5f), new Vector2(size.X * 2f, 3f)), color with { A = alpha * 0.45f });
                DrawSetTransform(Vector2.Zero, 0f, Vector2.One);
            }
            else
            {
                DrawRect(new Rect2(particle.Position, size), color);
            }
        }
    }

    private void EmitWhipSpark(bool burst)
    {
        var anchor = WhipEmitterPoints[_rng.RandiRange(0, WhipEmitterPoints.Length - 1)] * _bounds;
        var jitter = new Vector2(_rng.RandfRange(-18f, 18f), _rng.RandfRange(-14f, 14f));
        _particles.Add(new Particle(
            ParticleKind.Spark,
            anchor + jitter,
            new Vector2(_rng.RandfRange(-18f, 28f), _rng.RandfRange(-34f, -8f)),
            new Vector2(_rng.RandfRange(5f, 10f), _rng.RandfRange(5f, 10f)),
            _rng.RandfRange(0.42f, burst ? 0.85f : 0.62f),
            0f,
            _rng.RandfRange(-Mathf.Pi, Mathf.Pi),
            _rng.RandfRange(-2.8f, 2.8f),
            _rng.RandfRange(0.25f, 0.8f),
            new Color(1.0f, 0.78f, 0.18f, _rng.RandfRange(0.55f, 0.95f))));
    }

    private void EmitHologramDrift(bool burst)
    {
        var x = _rng.RandfRange(0.38f, 0.87f) * _bounds.X;
        var y = _rng.RandfRange(0.12f, 0.88f) * _bounds.Y;
        var width = _rng.RandfRange(18f, 56f);
        var height = _rng.RandfRange(3f, 7f);
        _particles.Add(new Particle(
            ParticleKind.Drift,
            new Vector2(x, y),
            new Vector2(_rng.RandfRange(-48f, 42f), _rng.RandfRange(-8f, 8f)),
            new Vector2(width, height),
            _rng.RandfRange(0.38f, burst ? 0.86f : 0.58f),
            0f,
            0f,
            0f,
            0.15f,
            new Color(0.24f, 0.88f, 1.0f, _rng.RandfRange(0.16f, 0.34f))));
    }

    private enum ParticleKind
    {
        Spark,
        Drift
    }

    private record struct Particle(
        ParticleKind Kind,
        Vector2 Position,
        Vector2 Velocity,
        Vector2 Size,
        float Lifetime,
        float Age,
        float Rotation,
        float RotationSpeed,
        float Grow,
        Color Color);
}
