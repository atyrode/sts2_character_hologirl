using Godot;

namespace Hologirl.HologirlCode.Character;

public partial class HologirlCharacterSelectSparkles : Control
{
    private static readonly Sparkle[] Sparkles =
    [
        new(0.49f, 0.17f, 0.0f, 1.4f),
        new(0.53f, 0.11f, 1.8f, 1.1f),
        new(0.58f, 0.15f, 3.1f, 1.2f),
        new(0.62f, 0.27f, 2.4f, 1.0f),
        new(0.53f, 0.41f, 4.2f, 1.2f),
        new(0.71f, 0.64f, 0.9f, 1.5f),
        new(0.78f, 0.68f, 2.7f, 1.3f),
        new(0.85f, 0.73f, 4.0f, 1.1f),
        new(0.91f, 0.80f, 1.3f, 1.2f),
        new(0.81f, 0.86f, 3.5f, 0.9f),
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
            var pulse = 0.5f + 0.5f * Mathf.Sin((float)time * 4.2f + sparkle.Phase);
            var alpha = 0.35f + 0.65f * pulse;
            var radius = (3.0f + 4.5f * pulse) * sparkle.Scale;
            var center = new Vector2(Size.X * sparkle.X, Size.Y * sparkle.Y);
            var color = new Color(1.0f, 0.78f, 0.25f, alpha);
            var glow = new Color(1.0f, 0.72f, 0.14f, alpha * 0.32f);

            DrawCircle(center, radius * 2.8f, glow);
            DrawLine(center + new Vector2(-radius, 0), center + new Vector2(radius, 0), color, 2.2f);
            DrawLine(center + new Vector2(0, -radius), center + new Vector2(0, radius), color, 2.2f);
        }
    }

    private readonly record struct Sparkle(float X, float Y, float Phase, float Scale);
}
