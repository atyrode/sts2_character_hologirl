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
public sealed class Livestream() : HologirlCard(2, CardType.Power, CardRarity.Rare, TargetType.Self)
{
    protected override IEnumerable<DynamicVar> CanonicalVars => [new PowerVar<LivestreamPower>(1)];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<LivestreamPower>(),
        HoverTipFactory.FromPower<FansPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await ApplyOrIncreasePower<LivestreamPower>(DynamicVars["LivestreamPower"].IntValue);
        LivestreamChatOverlayManager.PushEvent(LivestreamChatEvent.Start, 5);
    }

    protected override void OnUpgrade()
    {
        DynamicVars["LivestreamPower"].UpgradeValueBy(1);
    }
}
