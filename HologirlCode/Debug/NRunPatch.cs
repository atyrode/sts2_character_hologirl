using Godot;
using HarmonyLib;
using MegaCrit.Sts2.Core.Nodes;

namespace Hologirl.HologirlCode.Debug;

[HarmonyPatch(typeof(NRun), nameof(NRun._Ready))]
public static class NRunPatch
{
    public static HologirlDebugPanel? CurrentPanel { get; private set; }

    public static void Postfix(NRun __instance)
    {
        if (__instance.GetNodeOrNull<HologirlDebugPanel>("HologirlDebugPanel") != null)
            return;

        HologirlDebugPanel panel = new();
        __instance.AddChild(panel);
        CurrentPanel = panel;
        panel.TreeExiting += () =>
        {
            if (CurrentPanel == panel)
                CurrentPanel = null;
        };
    }
}
