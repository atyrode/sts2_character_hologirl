using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;

namespace Hologirl.HologirlCode.Cards.Tokens;

[Pool(typeof(HologirlCardPool))]
public sealed class KroniiTick() : HologirlCard(0, CardType.Skill, CardRarity.Basic, TargetType.Self)
{
    protected override Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        return Task.CompletedTask;
    }
}
