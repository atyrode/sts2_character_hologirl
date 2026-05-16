using BaseLib.Abstracts;
using BaseLib.Extensions;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Extensions;
using Hologirl.HologirlCode.Powers;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;

namespace Hologirl.HologirlCode.Cards;

[Pool(typeof(HologirlCardPool))]
public abstract class HologirlCard(int cost, CardType type, CardRarity rarity, TargetType target) :
    CustomCardModel(cost, type, rarity, target)
{
    public override string CustomPortraitPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".BigCardImagePath();
    public override string PortraitPath => $"{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".CardImagePath();
    public override string BetaPortraitPath => $"beta/{Id.Entry.RemovePrefix().ToLowerInvariant()}.png".CardImagePath();

    protected async Task ApplyOrIncreasePower<TPower>(int amount)
        where TPower : HologirlPower
    {
        var existingPower = Owner.Creature.Powers.OfType<TPower>().FirstOrDefault();
        if (existingPower != null)
            await PowerCmd.ModifyAmount(existingPower, amount, null, null);
        else
            await PowerCmd.Apply<TPower>(Owner.Creature, amount, Owner.Creature, null);
    }
}
