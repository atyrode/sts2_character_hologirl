using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.Localization.DynamicVars;

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

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        await PowerCmd.Apply<FansPower>(Owner.Creature, DynamicVars["FansPower"].IntValue, Owner.Creature, this);
        await PowerCmd.Apply<SingingPower>(Owner.Creature, DynamicVars["SingingPower"].IntValue, Owner.Creature, this);
    }

    protected override void OnUpgrade()
    {
        DynamicVars["FansPower"].UpgradeValueBy(FansUpgraded - FansBase);
    }
}
