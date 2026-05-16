using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Players;
using MegaCrit.Sts2.Core.Entities.Powers;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;

namespace Hologirl.HologirlCode.Powers;

public sealed class BroadcastLoopPower : HologirlPower
{
    public override PowerType Type => PowerType.Buff;
    public override PowerStackType StackType => PowerStackType.Counter;

    public override async Task AfterPlayerTurnStart(PlayerChoiceContext choiceContext, Player player)
    {
        if (player.Creature != Owner || Amount <= 0)
            return;

        var fans = Owner.Powers.OfType<FansPower>().FirstOrDefault();
        if (fans != null)
            await PowerCmd.ModifyAmount(fans, Amount, null, null);
        else
            await PowerCmd.Apply<FansPower>([Owner], Amount, Owner, null);
    }
}
