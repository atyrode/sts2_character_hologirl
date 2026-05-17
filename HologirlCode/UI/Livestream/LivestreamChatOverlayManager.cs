using Godot;
using Hologirl.HologirlCode;

namespace Hologirl.HologirlCode.UI.Livestream;

public static class LivestreamChatOverlayManager
{
    private const string OverlayName = "HologirlLivestreamChatOverlay";

    public static void PushEvent(LivestreamChatEvent eventKind, int reactionCount = 1)
    {
        var overlay = GetOrCreateOverlay();
        overlay?.PushEvent(eventKind, reactionCount);
        if (overlay == null)
            MainFile.Logger.Info("Livestream chat overlay event skipped because no SceneTree root was available.");
    }

    public static void PushNeutral(int messageCount = 1)
    {
        var overlay = GetOrCreateOverlay();
        overlay?.PushNeutral(messageCount);
        if (overlay == null)
            MainFile.Logger.Info("Livestream neutral chat skipped because no SceneTree root was available.");
    }

    public static void SetAmbientFanAmount(int fanAmount)
    {
        var overlay = GetOrCreateOverlay();
        overlay?.SetAmbientFanAmount(fanAmount);
        if (overlay == null)
            MainFile.Logger.Info("Livestream ambient chat skipped because no SceneTree root was available.");
    }

    public static void SetCombatMood(LivestreamChatMood mood)
    {
        var overlay = GetOrCreateOverlay();
        overlay?.SetCombatMood(mood);
        if (overlay == null)
            MainFile.Logger.Info("Livestream combat mood skipped because no SceneTree root was available.");
    }

    public static void Clear()
    {
        if (Engine.GetMainLoop() is not SceneTree tree)
            return;

        var cleared = false;
        foreach (var overlay in FindExistingOverlays(tree.Root).ToArray())
        {
            overlay.QueueFree();
            cleared = true;
        }

        if (cleared)
            MainFile.Logger.Info("Cleared Livestream chat overlay.");
    }

    private static LivestreamChatOverlay? GetOrCreateOverlay()
    {
        if (Engine.GetMainLoop() is not SceneTree tree)
            return null;

        var root = tree.CurrentScene ?? tree.Root;
        var parent = FindPlayerCreatureVisualParent(root) ?? FindCombatParent(root) ?? root;

        if (parent.GetNodeOrNull<LivestreamChatOverlay>(OverlayName) is { } overlay)
        {
            overlay.SetCombatCanvasPosition();
            return overlay;
        }

        overlay = new LivestreamChatOverlay
        {
            Name = OverlayName
        };
        parent.AddChild(overlay);
        overlay.SetCombatCanvasPosition();
        MainFile.Logger.Info($"Created Livestream chat overlay under {parent.GetPath()}.");
        return overlay;
    }

    private static Node? FindPlayerCreatureVisualParent(Node root)
    {
        var candidates = new List<CanvasItem>();
        CollectCreatureVisualCandidates(root, candidates);

        var playerVisual = candidates
            .Where(IsProbablyPlayerVisual)
            .OrderBy(GetGlobalX)
            .FirstOrDefault();

        if (playerVisual == null)
            return null;

        var parent = playerVisual.GetParent();
        MainFile.Logger.Info($"Livestream chat using creature visual layer: visual={playerVisual.GetPath()} parent={parent?.GetPath()}.");
        return parent;
    }

    private static void CollectCreatureVisualCandidates(Node root, List<CanvasItem> candidates)
    {
        if (root is CanvasItem canvasItem &&
            canvasItem.IsVisibleInTree() &&
            IsCreatureVisualNode(root))
        {
            candidates.Add(canvasItem);
        }

        foreach (var child in root.GetChildren())
        {
            if (child is not Node childNode)
                continue;

            CollectCreatureVisualCandidates(childNode, candidates);
        }
    }

    private static bool IsCreatureVisualNode(Node node)
    {
        var typeName = node.GetType().Name;
        var nodeName = node.Name.ToString();

        return typeName.Contains("CreatureVisual", StringComparison.OrdinalIgnoreCase) ||
            nodeName.Contains("CreatureVisual", StringComparison.OrdinalIgnoreCase);
    }

    private static bool IsProbablyPlayerVisual(CanvasItem visual)
    {
        var path = visual.GetPath().ToString();
        return !path.Contains("Intent", StringComparison.OrdinalIgnoreCase) &&
            !path.Contains("Power", StringComparison.OrdinalIgnoreCase) &&
            !path.Contains("Relic", StringComparison.OrdinalIgnoreCase);
    }

    private static float GetGlobalX(CanvasItem visual)
    {
        return visual.GetGlobalTransformWithCanvas().Origin.X;
    }

    private static Node? FindCombatParent(Node root)
    {
        if (root.GetType().Name.Contains("Combat", StringComparison.OrdinalIgnoreCase))
            return root;

        foreach (var child in root.GetChildren())
        {
            if (child is not Node childNode)
                continue;

            var match = FindCombatParent(childNode);
            if (match != null)
                return match;
        }

        return null;
    }

    private static IEnumerable<LivestreamChatOverlay> FindExistingOverlays(Node root)
    {
        if (root is LivestreamChatOverlay currentOverlay && currentOverlay.Name == OverlayName)
            yield return currentOverlay;

        foreach (var child in root.GetChildren())
        {
            if (child is not Node childNode)
                continue;

            foreach (var nestedOverlay in FindExistingOverlays(childNode))
                yield return nestedOverlay;
        }
    }
}
