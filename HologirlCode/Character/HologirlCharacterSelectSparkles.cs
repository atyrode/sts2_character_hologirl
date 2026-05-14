using Godot;

namespace Hologirl.HologirlCode.Character;

public partial class HologirlCharacterSelectSparkles : Control
{
    private static readonly Sparkle[] Sparkles =
    [
        new(0.48f, 0.22f, 0.0f, 1.5f, 12, -8),
        new(0.52f, 0.16f, 1.8f, 1.2f, -10, 7),
        new(0.56f, 0.20f, 3.1f, 1.3f, 8, 10),
        new(0.60f, 0.31f, 2.4f, 1.1f, -12, -6),
        new(0.52f, 0.46f, 4.2f, 1.2f, 10, 8),
        new(0.69f, 0.69f, 0.9f, 1.6f, -14, 6),
        new(0.76f, 0.73f, 2.7f, 1.4f, 9, -9),
        new(0.83f, 0.78f, 4.0f, 1.2f, -8, 12),
        new(0.90f, 0.84f, 1.3f, 1.3f, 13, -7),
        new(0.80f, 0.91f, 3.5f, 1.0f, -10, -10),
    ];

    private double time;

    public HologirlCharacterSelectSparkles()
    {
        Name = "WhipSparkles";
        MouseFilter = MouseFilterEnum.Ignore;
        SetAnchorsAndOffsetsPreset(LayoutPreset.FullRect);
        ZIndex = 10;
    }

    public override void _Ready()
    {
        SetAnchorsAndOffsetsPreset(LayoutPreset.FullRect);
    }

    public override void _Process(double delta)
    {
        time += delta;
        QueueRedraw();
    }

    public override void _Draw()
    {
        foreach (var sparkle in Sparkles)
        {
            var pulse = 0.5f + 0.5f * Mathf.Sin((float)time * 4.2f + sparkle.Phase);
            var alpha = 0.35f + 0.65f * pulse;
            var radius = (3.0f + 4.5f * pulse) * sparkle.Scale;
            var drift = new Vector2(
                Mathf.Sin((float)time * 1.7f + sparkle.Phase) * sparkle.DriftX,
                Mathf.Cos((float)time * 1.35f + sparkle.Phase) * sparkle.DriftY
            );
            var center = new Vector2(Size.X * sparkle.X, Size.Y * sparkle.Y) + drift;
            var color = new Color(1.0f, 0.78f, 0.25f, alpha);
            var glow = new Color(1.0f, 0.72f, 0.14f, alpha * 0.48f);

            DrawCircle(center, radius * 3.2f, glow);
            DrawLine(center + new Vector2(-radius, 0), center + new Vector2(radius, 0), color, 2.8f);
            DrawLine(center + new Vector2(0, -radius), center + new Vector2(0, radius), color, 2.8f);
        }
    }

    private readonly record struct Sparkle(float X, float Y, float Phase, float Scale, float DriftX, float DriftY);
}
