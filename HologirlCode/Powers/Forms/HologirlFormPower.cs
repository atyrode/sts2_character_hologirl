using MegaCrit.Sts2.Core.Combat;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Powers;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;

namespace Hologirl.HologirlCode.Powers.Forms;

public abstract class HologirlFormPower : HologirlPower
{
    public override PowerType Type => PowerType.Buff;
    public override PowerStackType StackType => PowerStackType.Counter;

    public override async Task AfterTurnEnd(PlayerChoiceContext choiceContext, CombatSide side)
    {
        if (Owner.Player?.Creature.Side != side || Amount <= 0)
            return;

        var fans = Owner.Powers.OfType<FansPower>().FirstOrDefault(power => power.Amount > 0);
        if (fans == null)
        {
            await PowerCmd.ModifyAmount(this, -Amount, null, null);
            return;
        }

        await PowerCmd.ModifyAmount(fans, -1m, null, null);
        Flash();
    }
}
