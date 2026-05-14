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
        var root = new HologirlCharacterSelectScene
        {
            Name = "HologirlCharacterSelectScene"
        };
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
        ProcessMode = ProcessModeEnum.Always;

        _canvas = new Control
        {
            Name = "VirtualCanvas",
            ClipContents = false,
            MouseFilter = MouseFilterEnum.Ignore,
            ProcessMode = ProcessModeEnum.Always,
            Size = VirtualSize,
            CustomMinimumSize = VirtualSize
        };

        var background = new HologirlCharacterSelectBackground
        {
            Name = "Background",
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
            Size = new Vector2(1180f, 787f),
            Position = new Vector2(1240f, 345f),
            Material = CreateChromaKeyMaterial(),
            MouseFilter = MouseFilterEnum.Ignore,
            ZIndex = 10
        };

        _effects = new HologirlCharacterSelectEffects
        {
            Name = "HologirlEffects",
            MouseFilter = MouseFilterEnum.Ignore,
            ClipContents = false,
            ProcessMode = ProcessModeEnum.Always,
            Size = VirtualSize,
            CustomMinimumSize = VirtualSize,
            ZIndex = 20
        };

        _canvas.AddChild(background);
        _canvas.AddChild(character);
        _canvas.AddChild(_effects);
        AddChild(_canvas);

        _effects.Configure(VirtualSize, character.Position, character.Size);
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
        _effects.Configure(VirtualSize, new Vector2(1240f, 345f), new Vector2(1180f, 787f));
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
        _effects.Configure(VirtualSize, new Vector2(1240f, 345f), new Vector2(1180f, 787f));
    }

    private static ShaderMaterial CreateChromaKeyMaterial()
    {
        return new ShaderMaterial
        {
            Shader = new Shader
            {
                Code = """
                    shader_type canvas_item;
                    uniform vec4 key_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
                    uniform float threshold = 0.46;
                    uniform float softness = 0.08;

                    void fragment() {
                        vec4 tex = texture(TEXTURE, UV);
                        float keyed = smoothstep(threshold, threshold + softness, distance(tex.rgb, key_color.rgb));
                        tex.a *= keyed;
                        COLOR = tex;
                    }
                    """
            }
        };
    }
}

public sealed partial class HologirlCharacterSelectBackground : Control
{
    public override void _Draw()
    {
        var size = Size;
        DrawRect(new Rect2(Vector2.Zero, size), new Color(0.29f, 0.18f, 0.31f));
        DrawRect(new Rect2(0f, size.Y * 0.55f, size.X, size.Y * 0.45f), new Color(0.19f, 0.13f, 0.23f));
        DrawPolygon(
            [
                new Vector2(size.X * 0.44f, 0f),
                new Vector2(size.X, 0f),
                new Vector2(size.X, size.Y),
                new Vector2(size.X * 0.62f, size.Y)
            ],
            [new Color(0.36f, 0.20f, 0.34f)]
        );
        DrawPolygon(
            [
                new Vector2(size.X * 0.05f, size.Y),
                new Vector2(size.X * 0.38f, size.Y * 0.18f),
                new Vector2(size.X * 0.52f, size.Y * 0.24f),
                new Vector2(size.X * 0.28f, size.Y)
            ],
            [new Color(0.21f, 0.15f, 0.27f, 0.65f)]
        );
        DrawLine(new Vector2(size.X * 0.08f, size.Y * 0.72f), new Vector2(size.X * 0.95f, size.Y * 0.42f), new Color(0.86f, 0.63f, 0.21f, 0.18f), 10f);
        DrawLine(new Vector2(size.X * 0.12f, size.Y * 0.78f), new Vector2(size.X * 0.90f, size.Y * 0.50f), new Color(0.33f, 0.86f, 1.0f, 0.14f), 7f);
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
    private Vector2 _characterPosition;
    private Vector2 _characterSize;
    private float _sparkTimer;
    private float _driftTimer;

    public void Configure(Vector2 bounds, Vector2 characterPosition, Vector2 characterSize)
    {
        _bounds = bounds;
        _characterPosition = characterPosition;
        _characterSize = characterSize;
        Size = bounds;
        CustomMinimumSize = bounds;
        ProcessMode = ProcessModeEnum.Always;
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
        var anchor = _characterPosition + WhipEmitterPoints[_rng.RandiRange(0, WhipEmitterPoints.Length - 1)] * _characterSize;
        var jitter = new Vector2(_rng.RandfRange(-18f, 18f), _rng.RandfRange(-14f, 14f));
        var lifetime = _rng.RandfRange(0.85f, burst ? 1.35f : 1.05f);
        var color = new Color(1.0f, 0.78f, 0.18f, _rng.RandfRange(0.72f, 1.0f));
        var size = new Vector2(_rng.RandfRange(12f, 22f), _rng.RandfRange(12f, 22f));
        SpawnParticleNode(anchor + jitter, new Vector2(_rng.RandfRange(-18f, 28f), _rng.RandfRange(-34f, -8f)), size, lifetime, color, true);

    }

    private void SpawnHologramDrift(bool burst)
    {
        var x = _characterPosition.X + _rng.RandfRange(0.08f, 0.90f) * _characterSize.X;
        var y = _characterPosition.Y + _rng.RandfRange(0.08f, 0.86f) * _characterSize.Y;
        var width = _rng.RandfRange(42f, 110f);
        var height = _rng.RandfRange(6f, 12f);
        var lifetime = _rng.RandfRange(0.7f, burst ? 1.3f : 0.95f);
        var color = new Color(0.24f, 0.88f, 1.0f, _rng.RandfRange(0.28f, 0.52f));
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
