using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Localization.DynamicVars;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Basic;

[Pool(typeof(HologirlCardPool))]
public sealed class Concert() : HologirlCard(1, CardType.Skill, CardRarity.Basic, TargetType.Self)
{
    private const int FansBase = 3;
    private const int FansUpgraded = 5;
    private const int SingingTurns = 2;

    protected override IEnumerable<DynamicVar> CanonicalVars =>
    [
        new PowerVar<FansPower>(FansBase),
        new PowerVar<SingingPower>(SingingTurns)
    ];

    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<FansPower>(),
        HoverTipFactory.FromPower<SingingPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await ApplyOrIncreasePower<FansPower>(DynamicVars["FansPower"].IntValue);
        await ApplyOrIncreasePower<SingingPower>(DynamicVars["SingingPower"].IntValue);
    }

    protected override void OnUpgrade()
    {
        DynamicVars["FansPower"].UpgradeValueBy(FansUpgraded - FansBase);
    }

    private async Task ApplyOrIncreasePower<TPower>(int amount)
        where TPower : HologirlPower
    {
        var existingPower = Owner.Creature.Powers.OfType<TPower>().FirstOrDefault();
        if (existingPower != null)
            await PowerCmd.ModifyAmount(existingPower, amount, null, null);
        else
            await PowerCmd.Apply<TPower>(Owner.Creature, amount, Owner.Creature, null);
    }
}
