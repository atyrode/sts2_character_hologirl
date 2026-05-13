using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Cards.Tokens;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers.Forms;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.Models;
using MegaCrit.Sts2.Core.Models.Cards;

namespace Hologirl.HologirlCode.Cards.Basic;

[Pool(typeof(HologirlCardPool))]
public sealed class Livestream() : HologirlCard(2, CardType.Skill, CardRarity.Basic, TargetType.Self)
{
    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        switch (Random.Shared.Next(4))
        {
            case 0:
                await Transform<FaunaFormPower, FaunaBloom>();
                break;
            case 1:
                await Transform<AmeliaFormPower, AmeliaClue>();
                break;
            case 2:
                await Transform<GuraFormPower, GuraChomp>();
                break;
            default:
                await Transform<KroniiFormPower, KroniiTick>();
                break;
        }
    }

    private async Task Transform<TPower, TCard>()
        where TPower : HologirlFormPower
        where TCard : CardModel
    {
        await PowerCmd.Apply<TPower>(Owner.Creature, 1m, Owner.Creature, this);
        await CardPileCmd.Add([ModelDb.Card<TCard>()], PileType.Hand.GetPile(Owner), CardPilePosition.Top, this);
    }
}
