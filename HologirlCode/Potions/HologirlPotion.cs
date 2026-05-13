using BaseLib.Abstracts;
using BaseLib.Utils;
using Hologirl.HologirlCode.Character;

namespace Hologirl.HologirlCode.Potions;

[Pool(typeof(HologirlPotionPool))]
public abstract class HologirlPotion : CustomPotionModel;