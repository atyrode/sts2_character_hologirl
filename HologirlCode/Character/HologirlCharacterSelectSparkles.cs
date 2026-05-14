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
    private Vector2 explicitBounds;

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
        RefreshBounds();
    }

    public override void _Process(double delta)
    {
        time += delta;
        RefreshBounds();
        QueueRedraw();
    }

    public void SetExplicitBounds(Vector2 bounds)
    {
        explicitBounds = bounds;
        Size = bounds;
        CustomMinimumSize = bounds;
        SetAnchorsAndOffsetsPreset(LayoutPreset.FullRect);
        QueueRedraw();
    }

    public override void _Draw()
    {
        var bounds = GetDrawBounds();
        if (bounds.X < 1 || bounds.Y < 1)
        {
            return;
        }

        DrawHologramBands(bounds);

        foreach (var sparkle in Sparkles)
        {
            var pulse = 0.5f + 0.5f * Mathf.Sin((float)time * 4.2f + sparkle.Phase);
            var alpha = 0.35f + 0.65f * pulse;
            var radius = (3.0f + 4.5f * pulse) * sparkle.Scale;
            var drift = new Vector2(
                Mathf.Sin((float)time * 1.7f + sparkle.Phase) * sparkle.DriftX,
                Mathf.Cos((float)time * 1.35f + sparkle.Phase) * sparkle.DriftY
            );
            var center = new Vector2(bounds.X * sparkle.X, bounds.Y * sparkle.Y) + drift;
            var color = new Color(1.0f, 0.78f, 0.25f, alpha);
            var glow = new Color(1.0f, 0.72f, 0.14f, alpha * 0.48f);

            DrawCircle(center, radius * 3.2f, glow);
            DrawLine(center + new Vector2(-radius, 0), center + new Vector2(radius, 0), color, 2.8f);
            DrawLine(center + new Vector2(0, -radius), center + new Vector2(0, radius), color, 2.8f);
        }
    }

    private void RefreshBounds()
    {
        if (Size.X >= 1 && Size.Y >= 1)
        {
            return;
        }

        var viewportSize = GetViewportRect().Size;
        if (viewportSize.X < 1 || viewportSize.Y < 1)
        {
            return;
        }

        Size = viewportSize;
        CustomMinimumSize = viewportSize;
    }

    private Vector2 GetDrawBounds()
    {
        if (Size.X >= 1 && Size.Y >= 1)
        {
            return Size;
        }

        if (explicitBounds.X >= 1 && explicitBounds.Y >= 1)
        {
            return explicitBounds;
        }

        return GetViewportRect().Size;
    }

    private void DrawHologramBands(Vector2 bounds)
    {
        var xStart = bounds.X * 0.52f;
        var xEnd = bounds.X * 0.93f;
        var yStart = bounds.Y * 0.17f;
        var yEnd = bounds.Y * 0.86f;

        for (var i = 0; i < 8; i++)
        {
            var y = Mathf.Lerp(yStart, yEnd, i / 7f) + Mathf.Sin((float)time * 1.8f + i) * 7f;
            var alpha = 0.08f + 0.07f * (0.5f + 0.5f * Mathf.Sin((float)time * 2.6f + i * 1.7f));
            var color = new Color(0.28f, 0.95f, 1.0f, alpha);
            DrawLine(new Vector2(xStart, y), new Vector2(xEnd, y + 3f), color, 1.5f);
        }
    }

    private readonly record struct Sparkle(float X, float Y, float Phase, float Scale, float DriftX, float DriftY);
}
