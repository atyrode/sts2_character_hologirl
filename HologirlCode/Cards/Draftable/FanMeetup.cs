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
using MegaCrit.Sts2.Core.ValueProps;

namespace Hologirl.HologirlCode.Cards.Draftable;

[Pool(typeof(HologirlCardPool))]
public sealed class FanMeetup() : HologirlCard(1, CardType.Skill, CardRarity.Common, TargetType.Self)
{
    public override bool GainsBlock => true;

    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new BlockVar(5m, ValueProp.Move),
        new PowerVar<FansPower>(2)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<FansPower>(),
        HoverTipFactory.FromPower<LivestreamPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        var spent = await SpendFans(3, LivestreamChatEvent.FanMeetup);
        await CreatureCmd.GainBlock(Owner.Creature, DynamicVars.Block.BaseValue + spent * 3, ValueProp.Move, cardPlay);
        if (spent == 0)
            await ApplyOrIncreasePower<FansPower>(DynamicVars["FansPower"].IntValue);
    }

    protected override void OnUpgrade()
    {
        DynamicVars.Block.UpgradeValueBy(2m);
    }
}
