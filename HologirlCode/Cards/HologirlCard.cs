using BaseLib.Abstracts;
using BaseLib.Extensions;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Extensions;
using Hologirl.HologirlCode.Powers;
using Hologirl.HologirlCode.UI.Livestream;
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

    protected int PowerAmount<TPower>()
        where TPower : HologirlPower
    {
        return Owner.Creature.Powers.OfType<TPower>().FirstOrDefault()?.Amount ?? 0;
    }

    protected async Task<int> SpendFans(int maxAmount, LivestreamChatEvent? eventKind = null)
    {
        var fans = Owner.Creature.Powers.OfType<FansPower>().FirstOrDefault();
        if (fans == null || fans.Amount <= 0 || maxAmount <= 0)
            return 0;

        var spent = Math.Min(maxAmount, (int)Math.Floor((decimal)fans.Amount));
        if (spent <= 0)
            return 0;

        await PowerCmd.ModifyAmount(fans, -spent, Owner.Creature, this);
        PushLivestreamChat(eventKind ?? LivestreamChatEvent.FansSpent, 1 + Math.Min(3, spent / 3));
        return spent;
    }

    protected async Task<bool> SpendExactFans(int amount, LivestreamChatEvent? eventKind = null)
    {
        if (PowerAmount<FansPower>() < amount)
            return false;

        return await SpendFans(amount, eventKind) == amount;
    }

    protected void PushLivestreamChat(LivestreamChatEvent eventKind, int reactionCount = 1)
    {
        if (PowerAmount<LivestreamPower>() <= 0)
            return;

        LivestreamChatOverlayManager.SetAmbientFanAmount(PowerAmount<FansPower>());
        LivestreamChatOverlayManager.PushEvent(eventKind, reactionCount);
    }
}
