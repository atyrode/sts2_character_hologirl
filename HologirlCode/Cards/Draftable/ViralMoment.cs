using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using Hologirl.HologirlCode.UI.Livestream;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Localization.DynamicVars;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Draftable;

[Pool(typeof(HologirlCardPool))]
public sealed class ViralMoment() : HologirlCard(2, CardType.Skill, CardRarity.Rare, TargetType.Self)
{
    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new PowerVar<FansPower>(6),
        new EnergyVar(2),
        new CardsVar(2),
        new PowerVar<SingingPower>(2)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<FansPower>(),
        HoverTipFactory.FromPower<SingingPower>(),
        HoverTipFactory.FromPower<LivestreamPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        if (!await SpendExactFans(DynamicVars["FansPower"].IntValue, LivestreamChatEvent.ViralMoment))
            return;

        await PlayerCmd.GainEnergy(DynamicVars.Energy.IntValue, Owner);
        await CardPileCmd.Draw(choiceContext, DynamicVars.Cards.IntValue, Owner, false);
        await ApplyOrIncreasePower<SingingPower>(DynamicVars["SingingPower"].IntValue);
    }

    protected override void OnUpgrade()
    {
        DynamicVars.Cards.UpgradeValueBy(1);
    }
}
