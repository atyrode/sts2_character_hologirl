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
        return root;
    }
}
