using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Creatures;
using MegaCrit.Sts2.Core.Entities.Powers;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.Models;
using MegaCrit.Sts2.Core.ValueProps;
using Hologirl.HologirlCode.UI.Livestream;
using MegaCrit.Sts2.Core.Combat;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.Rooms;

namespace Hologirl.HologirlCode.Powers;

public sealed class LivestreamPower : HologirlPower
{
    private const int BigDamageThreshold = 18;
    private int ambientTurnsUntilNextMessage = 1;
    private int turnsStarted;
    private int cardsPlayedThisTurn;
    private int cardsDrawnThisTurn;
    private int cardsExhaustedThisTurn;
    private bool keepOverlayAfterCombat;

    public override PowerType Type => PowerType.Buff;
    public override PowerStackType StackType => PowerStackType.Counter;

    public override Task AfterPlayerTurnStart(PlayerChoiceContext choiceContext, MegaCrit.Sts2.Core.Entities.Players.Player player)
    {
        if (player.Creature != Owner || Amount <= 0)
            return Task.CompletedTask;

        turnsStarted++;
        cardsPlayedThisTurn = 0;
        cardsDrawnThisTurn = 0;
        cardsExhaustedThisTurn = 0;
        UpdateLivestreamChatContext();
        if (turnsStarted > 1 && GetAudienceProfile().Roll(0.42f))
            PushCosmeticChat(LivestreamChatEvent.TurnStart);

        ambientTurnsUntilNextMessage--;
        if (ambientTurnsUntilNextMessage <= 0)
        {
            var audience = GetAudienceProfile();
            LivestreamChatOverlayManager.PushNeutral(audience.AmbientMessageCount());
            ambientTurnsUntilNextMessage = audience.AmbientDelayTurns();
        }

        return Task.CompletedTask;
    }

    public override async Task AfterPotionUsed(PotionModel potion, Creature? target)
    {
        if (potion.Owner?.Creature == Owner)
            await GainFansFromHypeMoment(LivestreamChatEvent.Potion);
    }

    public override async Task AfterDamageGiven(
        PlayerChoiceContext choiceContext,
        Creature? dealer,
        DamageResult result,
        ValueProp props,
        Creature target,
        CardModel? cardSource)
    {
        if (dealer == Owner && target != Owner && result.UnblockedDamage >= BigDamageThreshold)
            await GainFansFromHypeMoment(LivestreamChatEvent.BigDamage);

        if (dealer == Owner && target.IsMonster && result.WasTargetKilled)
            PushCosmeticChat(LivestreamChatEvent.MonsterDeath);
    }

    public override async Task AfterDamageReceived(
        PlayerChoiceContext choiceContext,
        Creature target,
        DamageResult result,
        ValueProp props,
        Creature? dealer,
        CardModel? cardSource)
    {
        if (target == Owner &&
            dealer != Owner &&
            result.WasFullyBlocked &&
            (result.BlockedDamage > 0 || result.TotalDamage > 0))
        {
            await GainFansFromHypeMoment(LivestreamChatEvent.FullBlock);
            return;
        }

        if (target == Owner && dealer != Owner && result.UnblockedDamage > 0)
            PushCosmeticChat(LivestreamChatEvent.DamageTaken);
    }

    public override async Task AfterCurrentHpChanged(Creature creature, decimal delta)
    {
        if (creature == Owner)
            UpdateLivestreamChatContext();

        if (creature == Owner && delta > 0)
            await GainFansFromHypeMoment(LivestreamChatEvent.Heal);
    }

    public override async Task AfterPowerAmountChanged(PowerModel power, decimal amount, Creature? applier, CardModel? cardSource)
    {
        if (amount > 0 && applier == Owner && power.Owner != Owner && power.Type == PowerType.Debuff)
            await GainFansFromHypeMoment(LivestreamChatEvent.Debuff);

        if (amount > 0 && power is SingingPower && power.Owner == Owner && applier == Owner)
            PushCosmeticChat(LivestreamChatEvent.Singing, GetAudienceProfile().CosmeticReactionCount());

        if (amount > 0 && power.Owner == Owner && applier != Owner && power.Type == PowerType.Debuff)
            PushCosmeticChat(LivestreamChatEvent.DebuffReceived);
    }

    public override Task BeforeTurnEnd(PlayerChoiceContext choiceContext, CombatSide side)
    {
        if (side == Owner.Side && Amount > 0 && GetAudienceProfile().Roll(0.42f))
            PushCosmeticChat(LivestreamChatEvent.TurnEnd);

        return Task.CompletedTask;
    }

    public override Task AfterCombatVictory(CombatRoom room)
    {
        keepOverlayAfterCombat = true;
        UpdateLivestreamChatContext();
        LivestreamChatOverlayManager.PushEvent(LivestreamChatEvent.CombatVictory, GetAudienceProfile().VictoryReactionCount());
        return Task.CompletedTask;
    }

    public override Task AfterCombatEnd(CombatRoom room)
    {
        if (keepOverlayAfterCombat)
            return Task.CompletedTask;

        if (ReadCreatureNumber("CurrentHp", "CurrentHealth", "Hp") <= 0m)
            return Task.CompletedTask;

        LivestreamChatOverlayManager.Clear();
        return Task.CompletedTask;
    }

    public override Task AfterCardPlayed(PlayerChoiceContext context, CardPlay cardPlay)
    {
        if (Amount <= 0 || cardPlay.Card?.Owner?.Creature != Owner)
            return Task.CompletedTask;

        cardsPlayedThisTurn++;
        if (cardPlay.Card.Type == CardType.Curse)
            PushCosmeticChat(LivestreamChatEvent.CursePlayed, 1);
        else if (cardPlay.Card.Type == CardType.Status)
            PushCosmeticChat(LivestreamChatEvent.StatusPlayed, 1);
        else if (cardPlay.Card.Rarity == CardRarity.Rare && GetAudienceProfile().Roll(0.44f))
            PushCosmeticChat(LivestreamChatEvent.RareCardPlayed, 1);

        if (cardPlay.Card.Type == CardType.Attack && GetAudienceProfile().Roll(0.22f))
            PushCosmeticChat(LivestreamChatEvent.AttackPlayed, 1);
        else if (cardPlay.Card.GainsBlock && GetAudienceProfile().Roll(0.26f))
            PushCosmeticChat(LivestreamChatEvent.BlockPlayed, 1);

        if (Random.Shared.NextSingle() < GetAudienceProfile().RepeatedEventChance(0.14f, cardsPlayedThisTurn))
            PushCosmeticChat(LivestreamChatEvent.CardPlayed);

        return Task.CompletedTask;
    }

    public override Task AfterCardDrawn(PlayerChoiceContext choiceContext, CardModel card, bool fromHandDraw)
    {
        if (Amount <= 0 || card.Owner?.Creature != Owner)
            return Task.CompletedTask;

        cardsDrawnThisTurn++;
        if (card.Type == CardType.Curse && GetAudienceProfile().Roll(0.58f))
            PushCosmeticChat(LivestreamChatEvent.CursePlayed, 1);
        else if (card.Type == CardType.Status && GetAudienceProfile().Roll(0.48f))
            PushCosmeticChat(LivestreamChatEvent.StatusPlayed, 1);
        else if (card.Rarity == CardRarity.Rare && GetAudienceProfile().Roll(0.24f))
            PushCosmeticChat(LivestreamChatEvent.RareCardPlayed, 1);

        if (!fromHandDraw && Random.Shared.NextSingle() < GetAudienceProfile().RepeatedEventChance(0.14f, cardsDrawnThisTurn))
            PushCosmeticChat(LivestreamChatEvent.CardDrawn);

        return Task.CompletedTask;
    }

    public override Task AfterCardExhausted(PlayerChoiceContext choiceContext, CardModel card, bool causedByEthereal)
    {
        if (Amount <= 0 || card.Owner?.Creature != Owner)
            return Task.CompletedTask;

        cardsExhaustedThisTurn++;
        if (Random.Shared.NextSingle() < GetAudienceProfile().RepeatedEventChance(0.16f, cardsExhaustedThisTurn))
            PushCosmeticChat(LivestreamChatEvent.CardExhausted);

        return Task.CompletedTask;
    }

    public override Task AfterDeath(PlayerChoiceContext choiceContext, Creature creature, bool wasRemovalPrevented, float deathAnimLength)
    {
        if (creature == Owner && !wasRemovalPrevented)
        {
            UpdateLivestreamChatContext();
            LivestreamChatOverlayManager.PushEvent(LivestreamChatEvent.HologirlDeath, GetAudienceProfile().DeathReactionCount());
        }

        return Task.CompletedTask;
    }

    private async Task GainFansFromHypeMoment(LivestreamChatEvent eventKind)
    {
        if (Amount <= 0)
            return;

        var fans = Owner.Powers.OfType<FansPower>().FirstOrDefault();
        if (fans != null)
            await PowerCmd.ModifyAmount(fans, Amount, null, null);
        else
            await PowerCmd.Apply<FansPower>([Owner], Amount, Owner, null);

        Flash();
        UpdateLivestreamChatContext();
        var audience = GetAudienceProfile();
        LivestreamChatOverlayManager.PushEvent(eventKind, audience.HypeReactionCount());
        if (audience.Roll(0.72f))
            LivestreamChatOverlayManager.PushEvent(LivestreamChatEvent.FansGained, audience.CosmeticReactionCount());
    }

    private void PushCosmeticChat(LivestreamChatEvent eventKind, int? reactionCount = null)
    {
        if (Amount <= 0)
            return;

        UpdateLivestreamChatContext();
        LivestreamChatOverlayManager.PushEvent(eventKind, reactionCount ?? GetAudienceProfile().CosmeticReactionCount());
    }

    private void UpdateLivestreamChatContext()
    {
        LivestreamChatOverlayManager.SetAmbientFanAmount(GetFanAmount());
        LivestreamChatOverlayManager.SetCombatMood(GetCombatMood());
    }

    private LivestreamChatMood GetCombatMood()
    {
        var currentHp = ReadCreatureNumber("CurrentHp", "CurrentHealth", "Hp");
        var maxHp = ReadCreatureNumber("MaxHp", "MaxHealth");
        if (currentHp <= 0m || maxHp <= 0m)
            return LivestreamChatMood.Stable;

        var ratio = currentHp / maxHp;
        return ratio switch
        {
            <= 0.3m => LivestreamChatMood.Critical,
            <= 0.58m => LivestreamChatMood.Tense,
            _ => LivestreamChatMood.Stable
        };
    }

    private decimal ReadCreatureNumber(params string[] propertyNames)
    {
        var type = Owner.GetType();
        foreach (var propertyName in propertyNames)
        {
            var property = type.GetProperty(propertyName);
            if (property?.GetValue(Owner) is { } value)
                return Convert.ToDecimal(value);
        }

        return 0m;
    }

    private int GetFanAmount()
    {
        return Owner.Powers.OfType<FansPower>().FirstOrDefault()?.Amount ?? 0;
    }

    private LivestreamAudienceProfile GetAudienceProfile()
    {
        return LivestreamAudienceProfile.FromFanAmount(GetFanAmount());
    }
}
