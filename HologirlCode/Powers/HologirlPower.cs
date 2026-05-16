using BaseLib.Abstracts;
using BaseLib.Extensions;
using Hologirl.HologirlCode.Extensions;
using MegaCrit.Sts2.Core.Entities.Powers;

namespace Hologirl.HologirlCode.Powers;

/// <summary>
/// Base class for Hologirl-owned powers. Inheriting from this class keeps power
/// icon paths consistent with the mod asset layout:
/// Hologirl/images/powers/{power_id}.png and Hologirl/images/powers/big/{power_id}.png.
/// </summary>
public abstract class HologirlPower : CustomPowerModel
{
    public override string CustomPackedIconPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".PowerImagePath();
    public override string CustomBigIconPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".BigPowerImagePath();

    /// <summary>
    /// Whether this power is displayed and treated as a buff or debuff.
    /// </summary>
    public abstract override PowerType Type { get; }

    /// <summary>
    /// How repeated applications of this power combine. Most Hologirl counters
    /// use Counter; form identity powers should be explicit about their stacking behavior.
    /// </summary>
    public abstract override PowerStackType StackType { get; }
}
