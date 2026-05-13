using MegaCrit.Sts2.Core.Entities.Powers;

namespace Hologirl.HologirlCode.Powers;

public sealed class ShapeshiftPower : HologirlPower
{
    public override PowerType Type => PowerType.Buff;
    public override PowerStackType StackType => PowerStackType.Single;
}
