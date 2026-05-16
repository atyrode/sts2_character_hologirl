using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Cards.Tokens;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using Hologirl.HologirlCode.Powers.Forms;
using Hologirl.HologirlCode.Relics;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Models;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Basic;

[Pool(typeof(HologirlCardPool))]
public sealed class Livestream() : HologirlCard(2, CardType.Skill, CardRarity.Basic, TargetType.Self)
{
    protected override IEnumerable<IHoverTip> ExtraHoverTips =>
    [
        HoverTipFactory.FromPower<ShapeshiftPower>(),
        HoverTipFactory.FromPower<FaunaFormPower>(),
        HoverTipFactory.FromPower<AmeliaFormPower>(),
        HoverTipFactory.FromPower<GuraFormPower>(),
        HoverTipFactory.FromPower<KroniiFormPower>()
    ];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        switch (Random.Shared.Next(4))
        {
            case 0:
                await Shapeshift<FaunaFormPower, FaunaBloom>();
                break;
            case 1:
                await Shapeshift<AmeliaFormPower, AmeliaClue>();
                break;
            case 2:
                await Shapeshift<GuraFormPower, GuraChomp>();
                break;
            default:
                await Shapeshift<KroniiFormPower, KroniiTick>();
                break;
        }
    }

    private async Task Shapeshift<TPower, TCard>()
        where TPower : HologirlFormPower
        where TCard : CardModel
    {
        await PowerCmd.Apply<TPower>(Owner.Creature, 1m, Owner.Creature, this);
        foreach (PrismPendant prismPendant in Owner.Relics.OfType<PrismPendant>())
            await prismPendant.AfterShapeshift<TCard>();
    }
}
