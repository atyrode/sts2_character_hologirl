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
        var root = new Control { Name = "HologirlCharacterSelectBg" };
        root.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        var splash = new TextureRect
        {
            Name = "Splash",
            Texture = GD.Load<Texture2D>("character_select_bg.png".CharacterUiPath()),
            ExpandMode = TextureRect.ExpandModeEnum.IgnoreSize,
            StretchMode = TextureRect.StretchModeEnum.KeepAspectCovered
        };
        splash.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);

        root.AddChild(splash);
        root.AddChild(new HologirlCharacterSelectSparkles());
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

        if (scene.GetNodeOrNull<TextureRect>("Splash") is not { } splash)
        {
            return;
        }

        var idle = splash.CreateTween();
        idle.SetLoops();
        idle.SetParallel();
        idle.TweenProperty(splash, "modulate", new Color(0.86f, 1.0f, 1.0f, 0.94f), 1.2f);
        idle.TweenProperty(splash, "position", new Vector2(0, 4), 1.2f);
        idle.Chain().TweenProperty(splash, "modulate", Colors.White, 1.2f);
        idle.TweenProperty(splash, "position", Vector2.Zero, 1.2f);
    }
}
