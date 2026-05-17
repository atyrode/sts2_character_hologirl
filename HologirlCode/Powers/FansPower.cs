using MegaCrit.Sts2.Core.Combat;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Powers;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;

namespace Hologirl.HologirlCode.Powers;

public sealed class FansPower : HologirlPower
{
    public override PowerType Type => PowerType.Buff;
    public override PowerStackType StackType => PowerStackType.Counter;

    public override async Task AfterTurnEnd(PlayerChoiceContext choiceContext, CombatSide side)
    {
        if (Owner.Player?.Creature.Side != side || Amount <= 0)
            return;

        if (Owner.Powers.OfType<SingingPower>().Any(power => power.Amount > 0))
            return;

        var amountToLose = Amount - Math.Floor(Amount / 2m);
        if (amountToLose <= 0)
            return;

        await PowerCmd.ModifyAmount(this, -amountToLose, null, null);
        Flash();
    }
}
