using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.Entities.Relics;
using MegaCrit.Sts2.Core.Models;

namespace Hologirl.HologirlCode.Relics;

public sealed class PrismPendant : HologirlRelic
{
    public override RelicRarity Rarity => RelicRarity.Starter;

    public async Task AfterShapeshift<TCard>()
        where TCard : CardModel
    {
        Flash();
        await CardPileCmd.AddToCombatAndPreview<TCard>(
            Owner.Creature,
            PileType.Hand,
            count: 1,
            addedByPlayer: true,
            CardPilePosition.Top);
    }
}
