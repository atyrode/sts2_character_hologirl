using BaseLib.Abstracts;
using BaseLib.Utils.NodeFactories;
using Hologirl.HologirlCode.Cards.Basic;
using Hologirl.HologirlCode.Extensions;
using Hologirl.HologirlCode.Relics;
using Godot;
using MegaCrit.Sts2.Core.Entities.Characters;
using MegaCrit.Sts2.Core.Helpers;
using MegaCrit.Sts2.Core.Models;
using MegaCrit.Sts2.Core.Models.Cards;
using MegaCrit.Sts2.Core.Models.Relics;

namespace Hologirl.HologirlCode.Character;

public class Hologirl : CustomCharacterModel
{
    public const string CharacterId = "Hologirl";
    private const string TemporaryBaseCharacterId = "ironclad";
    
    public static readonly Color Color = new("aab2ff");

    public override Color NameColor => Color;
    public override CharacterGender Gender => CharacterGender.Neutral;
    public override int StartingHp => 70;
    public override bool HideFromVanillaCharacterSelect => false;
    public override bool AllowInVanillaRandomCharacterSelect => true;
    public override string CharacterSelectSfx => "";

    // Hologirl has custom select/menu assets, but not a full run/combat rig yet.
    // Keep this explicit while using CustomCharacterModel so missing run-start
    // surfaces do not silently fall through template placeholder inheritance.
    public override string CustomVisualPath => SceneHelper.GetScenePath($"creature_visuals/{TemporaryBaseCharacterId}");
    public override string CustomTrailPath => SceneHelper.GetScenePath($"vfx/card_trail_{TemporaryBaseCharacterId}");
    public override string CustomEnergyCounterPath => SceneHelper.GetScenePath($"combat/energy_counters/{TemporaryBaseCharacterId}_energy_counter");
    public override string CustomRestSiteAnimPath => SceneHelper.GetScenePath($"rest_site/characters/{TemporaryBaseCharacterId}_rest_site");
    public override string CustomMerchantAnimPath => SceneHelper.GetScenePath($"merchant/characters/{TemporaryBaseCharacterId}_merchant");
    public override string CustomArmPointingTexturePath => ImageHelper.GetImagePath($"ui/hands/multiplayer_hand_{TemporaryBaseCharacterId}_point.png");
    public override string CustomArmRockTexturePath => ImageHelper.GetImagePath($"ui/hands/multiplayer_hand_{TemporaryBaseCharacterId}_rock.png");
    public override string CustomArmPaperTexturePath => ImageHelper.GetImagePath($"ui/hands/multiplayer_hand_{TemporaryBaseCharacterId}_paper.png");
    public override string CustomArmScissorsTexturePath => ImageHelper.GetImagePath($"ui/hands/multiplayer_hand_{TemporaryBaseCharacterId}_scissors.png");
    public override string CustomCharacterSelectTransitionPath => $"res://materials/transitions/{TemporaryBaseCharacterId}_transition_mat.tres";
    public override string CharacterTransitionSfx => $"event:/sfx/ui/wipe_{TemporaryBaseCharacterId}";
    public override string CustomAttackSfx => $"event:/sfx/characters/{TemporaryBaseCharacterId}/{TemporaryBaseCharacterId}_attack";
    public override string CustomCastSfx => $"event:/sfx/characters/{TemporaryBaseCharacterId}/{TemporaryBaseCharacterId}_cast";
    public override string CustomDeathSfx => $"event:/sfx/characters/{TemporaryBaseCharacterId}/{TemporaryBaseCharacterId}_die";
    public override List<string> GetArchitectAttackVfx() =>
    [
        "vfx/vfx_attack_blunt",
        "vfx/vfx_heavy_blunt",
        "vfx/vfx_attack_slash",
        "vfx/vfx_bloody_impact",
        "vfx/vfx_rock_shatter"
    ];
    
    public override IEnumerable<CardModel> StartingDeck => [
        ModelDb.Card<HoloStrike>(),
        ModelDb.Card<HoloStrike>(),
        ModelDb.Card<HoloStrike>(),
        ModelDb.Card<HoloStrike>(),
        ModelDb.Card<HoloDefend>(),
        ModelDb.Card<HoloDefend>(),
        ModelDb.Card<HoloDefend>(),
        ModelDb.Card<HoloDefend>(),
        ModelDb.Card<Concert>(),
        ModelDb.Card<Livestream>()
    ];

    public override IReadOnlyList<RelicModel> StartingRelics =>
    [
        ModelDb.Relic<PrismPendant>()
    ];
    
    public override CardPoolModel CardPool => ModelDb.CardPool<HologirlCardPool>();
    public override RelicPoolModel RelicPool => ModelDb.RelicPool<HologirlRelicPool>();
    public override PotionPoolModel PotionPool => ModelDb.PotionPool<HologirlPotionPool>();
    
    public override Control CustomIcon
    {
        get
        {
            var icon = NodeFactory<Control>.CreateFromResource(CustomIconTexturePath);
            icon.SetAnchorsAndOffsetsPreset(Control.LayoutPreset.FullRect);
            return icon;
        }
    }
    public override string CustomIconTexturePath => "character_icon_char_name.png".CharacterUiPath();
    public override string CustomCharacterSelectIconPath => "char_select_char_name.png".CharacterUiPath();
    public override string CustomCharacterSelectLockedIconPath => "char_select_char_name_locked.png".CharacterUiPath();
    public override string CustomCharacterSelectBg => $"{MainFile.ResPath}/scenes/character_select/hologirl_character_select_bg.tscn";
    public override string CustomMapMarkerPath => "map_marker_char_name.png".CharacterUiPath();
}
