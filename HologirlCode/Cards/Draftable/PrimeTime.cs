using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Localization.DynamicVars;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Draftable;

[Pool(typeof(HologirlCardPool))]
public sealed class PrimeTime() : HologirlCard(3, CardType.Power, CardRarity.Rare, TargetType.Self)
{
    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new PowerVar<BroadcastLoopPower>(3),
        new PowerVar<FansPower>(3)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<BroadcastLoopPower>(),
        HoverTipFactory.FromPower<FansPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await ApplyOrIncreasePower<BroadcastLoopPower>(DynamicVars["BroadcastLoopPower"].IntValue);
        await ApplyOrIncreasePower<FansPower>(DynamicVars["FansPower"].IntValue);
    }

    protected override void OnUpgrade()
    {
        DynamicVars["BroadcastLoopPower"].UpgradeValueBy(1);
    }
}
