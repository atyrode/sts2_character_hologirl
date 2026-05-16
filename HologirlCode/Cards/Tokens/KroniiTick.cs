using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;
using Hologirl.HologirlCode.Powers;
using MegaCrit.Sts2.Core.Commands;
using MegaCrit.Sts2.Core.Entities.Cards;
using MegaCrit.Sts2.Core.GameActions.Multiplayer;
using MegaCrit.Sts2.Core.HoverTips;
using MegaCrit.Sts2.Core.Localization.DynamicVars;
using MegaCrit.Sts2.Core.Models.Powers;

namespace Hologirl.HologirlCode.Cards.Tokens;

[Pool(typeof(HologirlCardPool))]
public sealed class KroniiTick() : HologirlCard(0, CardType.Skill, CardRarity.Basic, TargetType.Self)
{
    protected override IEnumerable<DynamicVar> CanonicalVars => [new PowerVar<SingingPower>(1)];

    protected override IEnumerable<IHoverTip> ExtraHoverTips => [HoverTipFactory.FromPower<SingingPower>()];

    protected override async Task OnPlay(PlayerChoiceContext choiceContext, CardPlay cardPlay)
    {
        var existingPower = Owner.Creature.Powers.OfType<SingingPower>().FirstOrDefault();
        if (existingPower != null)
            await PowerCmd.ModifyAmount(existingPower, DynamicVars["SingingPower"].IntValue, null, null);
        else
            await PowerCmd.Apply<SingingPower>(Owner.Creature, DynamicVars["SingingPower"].IntValue, Owner.Creature, null);
    }
}
