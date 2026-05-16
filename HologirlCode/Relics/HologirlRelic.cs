using BaseLib.Abstracts;
using BaseLib.Extensions;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Extensions;

namespace Hologirl.HologirlCode.Relics;

/// <summary>
/// Base class for Hologirl-owned relics. The inherited pool attribute keeps
/// derived relics in Hologirl's relic pool, and the icon overrides map each
/// relic id to the standard mod asset layout:
/// Hologirl/images/relics/{relic_id}.png,
/// Hologirl/images/relics/{relic_id}_outline.png, and
/// Hologirl/images/relics/big/{relic_id}.png.
/// </summary>
[Pool(typeof(HologirlRelicPool))]
public abstract class HologirlRelic : CustomRelicModel
{
    public override string PackedIconPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".RelicImagePath();
    protected override string PackedIconOutlinePath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}_outline.png".RelicImagePath();
    protected override string BigIconPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".BigRelicImagePath();
}
