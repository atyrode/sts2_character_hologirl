using Godot;
using HarmonyLib;
using Hologirl.HologirlCode.Character;
using MegaCrit.Sts2.Core.Modding;
using System.Reflection;

namespace Hologirl.HologirlCode;

[ModInitializer(nameof(Initialize))]
public partial class MainFile : Node
{
    public const string ModId = "Hologirl"; //Used for resource filepath
    public const string ResPath = $"res://{ModId}";

    public static MegaCrit.Sts2.Core.Logging.Logger Logger { get; } = new(ModId, MegaCrit.Sts2.Core.Logging.LogType.Generic);

    public static void Initialize()
    {
        //If you want to use scripts defined in your mod for Godot scenes, uncomment the following line.
        //Godot.Bridge.ScriptManagerBridge.LookupScriptsInAssembly(Assembly.GetExecutingAssembly());
        RegisterCustomCharacterSelectEntry();
        
        Harmony harmony = new(ModId);

        harmony.PatchAll();
    }

    private static void RegisterCustomCharacterSelectEntry()
    {
        // BaseLib 3.1.3 exposes CustomCharacterSelectEntry, but its registry type is internal.
        // Keep this reflection call narrow so the custom entry can be removed cleanly if BaseLib later opens the API.
        var registryType = typeof(BaseLib.Abstracts.CustomCharacterSelectEntry).Assembly.GetType("BaseLib.Abstracts.CustomCharacterSelectEntryRegistry");
        var register = registryType?.GetMethod("Register", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
        register?.Invoke(null, [new HologirlCharacterSelectEntry()]);
    }
}
