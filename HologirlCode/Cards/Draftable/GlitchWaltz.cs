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
public sealed class GlitchWaltz() : HologirlCard(1, CardType.Skill, CardRarity.Uncommon, TargetType.Self)
{
    public override bool GainsBlock => true;

    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new BlockVar(8m, ValueProp.Move),
        new PowerVar<SingingPower>(1),
        new CardsVar(1)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<SingingPower>(),
        HoverTipFactory.FromPower<LivestreamPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await CreatureCmd.GainBlock(Owner.Creature, DynamicVars.Block, cardPlay);
        await ApplyOrIncreasePower<SingingPower>(DynamicVars["SingingPower"].IntValue);
        if (PowerAmount<LivestreamPower>() > 0)
        {
            await CardPileCmd.Draw(choiceContext, DynamicVars.Cards.IntValue, Owner, false);
            PushLivestreamChat(LivestreamChatEvent.GlitchWaltz, 2);
        }
    }

    protected override void OnUpgrade()
    {
        DynamicVars.Block.UpgradeValueBy(3m);
    }
}
