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
        var root = new HologirlCharacterSelectScene { Name = "HologirlCharacterSelectScene" };
        root.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);
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

        if (scene is HologirlCharacterSelectScene hologirlScene)
        {
            hologirlScene.StartSelectionBurst();
        }
    }
}

public sealed partial class HologirlCharacterSelectScene : Control
{
    private static readonly Vector2 VirtualSize = new(2564f, 1204f);
    private readonly Control _canvas;
    private readonly HologirlCharacterSelectEffects _effects;

    public HologirlCharacterSelectScene()
    {
        ClipContents = true;
        MouseFilter = MouseFilterEnum.Ignore;

        _canvas = new Control
        {
            Name = "VirtualCanvas",
            ClipContents = false,
            MouseFilter = MouseFilterEnum.Ignore,
            Size = VirtualSize,
            CustomMinimumSize = VirtualSize
        };

        var background = new TextureRect
        {
            Name = "Background",
            Texture = GD.Load<Texture2D>("character_select_bg.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.Scale,
            Size = VirtualSize,
            MouseFilter = MouseFilterEnum.Ignore,
            ZIndex = 0
        };

        var character = new TextureRect
        {
            Name = "HologirlLayer",
            Texture = GD.Load<Texture2D>("character_select_hologirl.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.Scale,
            Size = new Vector2(1080f, 720f),
            Position = new Vector2(1180f, 160f),
            MouseFilter = MouseFilterEnum.Ignore,
            ZIndex = 10
        };

        _effects = new HologirlCharacterSelectEffects
        {
            Name = "HologirlEffects",
            MouseFilter = MouseFilterEnum.Ignore,
            ClipContents = false,
            Size = VirtualSize,
            CustomMinimumSize = VirtualSize,
            ZIndex = 20
        };

        _canvas.AddChild(background);
        _canvas.AddChild(character);
        _canvas.AddChild(_effects);
        AddChild(_canvas);
    }

    public override void _Ready()
    {
        ApplyLayout();
    }

    public override void _Notification(int what)
    {
        if (what == NotificationResized)
        {
            ApplyLayout();
        }
    }

    public void StartSelectionBurst()
    {
        _effects.StartSelectionBurst();
    }

    private void ApplyLayout()
    {
        var bounds = Size;
        if (bounds.X <= 0f || bounds.Y <= 0f)
        {
            bounds = GetParent<Control>()?.Size ?? GetViewportRect().Size;
        }

        var scale = Mathf.Max(bounds.X / VirtualSize.X, bounds.Y / VirtualSize.Y);
        _canvas.Scale = Vector2.One * scale;
        _canvas.Position = (bounds - VirtualSize * scale) / 2f;
        _effects.Configure(VirtualSize);
    }
}

public sealed partial class HologirlCharacterSelectEffects : Control
{
    private static readonly Vector2[] WhipEmitterPoints =
    [
        new(0.50f, 0.50f),
        new(0.58f, 0.41f),
        new(0.66f, 0.32f),
        new(0.76f, 0.28f),
        new(0.84f, 0.33f),
        new(0.86f, 0.46f),
        new(0.78f, 0.61f),
        new(0.67f, 0.72f),
    ];

    private readonly RandomNumberGenerator _rng = new();
    private Vector2 _bounds;
    private float _sparkTimer;
    private float _driftTimer;

    public void Configure(Vector2 bounds)
    {
        _bounds = bounds;
        Size = bounds;
        CustomMinimumSize = bounds;
        SetProcess(true);
    }

    public void StartSelectionBurst()
    {
        for (var i = 0; i < 18; i++)
        {
            SpawnWhipSpark(true);
        }

        for (var i = 0; i < 10; i++)
        {
            SpawnHologramDrift(true);
        }
    }

    public override void _Process(double delta)
    {
        var dt = (float)delta;
        _sparkTimer -= dt;
        _driftTimer -= dt;

        while (_sparkTimer <= 0f)
        {
            SpawnWhipSpark(false);
            _sparkTimer += 0.055f;
        }

        while (_driftTimer <= 0f)
        {
            SpawnHologramDrift(false);
            _driftTimer += 0.18f;
        }

    }

    private void SpawnWhipSpark(bool burst)
    {
        var anchor = WhipEmitterPoints[_rng.RandiRange(0, WhipEmitterPoints.Length - 1)] * _bounds;
        var jitter = new Vector2(_rng.RandfRange(-18f, 18f), _rng.RandfRange(-14f, 14f));
        var lifetime = _rng.RandfRange(0.42f, burst ? 0.85f : 0.62f);
        var color = new Color(1.0f, 0.78f, 0.18f, _rng.RandfRange(0.55f, 0.95f));
        var size = new Vector2(_rng.RandfRange(5f, 10f), _rng.RandfRange(5f, 10f));
        SpawnParticleNode(anchor + jitter, new Vector2(_rng.RandfRange(-18f, 28f), _rng.RandfRange(-34f, -8f)), size, lifetime, color, true);

    }

    private void SpawnHologramDrift(bool burst)
    {
        var x = _rng.RandfRange(0.38f, 0.87f) * _bounds.X;
        var y = _rng.RandfRange(0.12f, 0.88f) * _bounds.Y;
        var width = _rng.RandfRange(18f, 56f);
        var height = _rng.RandfRange(3f, 7f);
        var lifetime = _rng.RandfRange(0.38f, burst ? 0.86f : 0.58f);
        var color = new Color(0.24f, 0.88f, 1.0f, _rng.RandfRange(0.16f, 0.34f));
        SpawnParticleNode(new Vector2(x, y), new Vector2(_rng.RandfRange(-48f, 42f), _rng.RandfRange(-8f, 8f)), new Vector2(width, height), lifetime, color, false);

    }

    private void SpawnParticleNode(Vector2 position, Vector2 velocity, Vector2 size, float lifetime, Color color, bool sparkle)
    {
        var particle = new ColorRect
        {
            Color = color,
            Size = size,
            Position = position - size / 2f,
            PivotOffset = size / 2f,
            Rotation = sparkle ? _rng.RandfRange(-Mathf.Pi, Mathf.Pi) : 0f,
            MouseFilter = MouseFilterEnum.Ignore
        };

        AddChild(particle);

        var tween = particle.CreateTween();
        tween.SetParallel();
        tween.TweenProperty(particle, "position", particle.Position + velocity * lifetime, lifetime);
        tween.TweenProperty(particle, "modulate", new Color(1f, 1f, 1f, 0f), lifetime);
        tween.TweenProperty(particle, "scale", Vector2.One * (sparkle ? 1.75f : 1.1f), lifetime);
        tween.TweenCallback(Callable.From(particle.QueueFree)).SetDelay(lifetime);
    }

}
