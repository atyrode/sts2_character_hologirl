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
public sealed class PrimeTime() : HologirlCard(2, CardType.Skill, CardRarity.Rare, TargetType.Self)
{
    public override bool GainsBlock => true;

    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new PowerVar<FansPower>(99),
        new BlockVar(0m, ValueProp.Move),
        new EnergyVar(1)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<FansPower>(),
        HoverTipFactory.FromPower<LivestreamPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        var spent = await SpendFans(DynamicVars["FansPower"].IntValue, LivestreamChatEvent.PrimeTime);
        if (spent <= 0)
            return;

        await CreatureCmd.GainBlock(Owner.Creature, spent * 2, ValueProp.Move, cardPlay);
        var energyGain = Math.Min(3, spent / 5 * DynamicVars.Energy.IntValue);
        if (energyGain > 0)
            await PlayerCmd.GainEnergy(energyGain, Owner);
    }

    protected override void OnUpgrade()
    {
        DynamicVars.Energy.UpgradeValueBy(1);
    }
}
