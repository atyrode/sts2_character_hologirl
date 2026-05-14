using Godot;

namespace Hologirl.HologirlCode.Character;

public partial class HologirlCharacterSelectSparkles : Control
{
    private static readonly Sparkle[] Sparkles =
    [
        new(0.52f, 0.18f, 0.0f, 1.2f),
        new(0.57f, 0.12f, 1.8f, 0.9f),
        new(0.61f, 0.22f, 3.1f, 1.0f),
        new(0.54f, 0.37f, 2.4f, 0.8f),
        new(0.74f, 0.64f, 0.9f, 1.3f),
        new(0.80f, 0.68f, 2.7f, 1.1f),
        new(0.86f, 0.73f, 4.0f, 0.9f),
        new(0.77f, 0.82f, 3.5f, 0.7f),
    ];

    private double time;

    public HologirlCharacterSelectSparkles()
    {
        Name = "WhipSparkles";
        MouseFilter = MouseFilterEnum.Ignore;
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
            var pulse = 0.5f + 0.5f * Mathf.Sin((float)time * 3.4f + sparkle.Phase);
            var alpha = 0.18f + 0.58f * pulse;
            var radius = (2.0f + 2.8f * pulse) * sparkle.Scale;
            var center = new Vector2(Size.X * sparkle.X, Size.Y * sparkle.Y);
            var color = new Color(1.0f, 0.78f, 0.25f, alpha);
            var glow = new Color(1.0f, 0.72f, 0.14f, alpha * 0.18f);

            DrawCircle(center, radius * 2.4f, glow);
            DrawLine(center + new Vector2(-radius, 0), center + new Vector2(radius, 0), color, 1.4f);
            DrawLine(center + new Vector2(0, -radius), center + new Vector2(0, radius), color, 1.4f);
        }
    }

    private readonly record struct Sparkle(float X, float Y, float Phase, float Scale);
}
