using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using Hologirl.HologirlCode.UI.Livestream;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Localization.DynamicVars;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Draftable;

[Pool(typeof(HologirlCardPool))]
public sealed class EncoreEngine() : HologirlCard(2, CardType.Power, CardRarity.Uncommon, TargetType.Self)
{
    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new PowerVar<BroadcastLoopPower>(1),
        new PowerVar<SingingPower>(2)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<BroadcastLoopPower>(),
        HoverTipFactory.FromPower<FansPower>(),
        HoverTipFactory.FromPower<SingingPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await ApplyOrIncreasePower<BroadcastLoopPower>(DynamicVars["BroadcastLoopPower"].IntValue);
        await ApplyOrIncreasePower<SingingPower>(DynamicVars["SingingPower"].IntValue);
        PushLivestreamChat(LivestreamChatEvent.EncoreEngine, 2);
    }

    protected override void OnUpgrade()
    {
        DynamicVars["SingingPower"].UpgradeValueBy(1);
    }
}
