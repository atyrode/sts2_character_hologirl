using BaseLib.Abstracts;
using Hologirl.HologirlCode.Extensions;
using Godot;

namespace Hologirl.HologirlCode.Character;

public class HologirlRelicPool : CustomRelicPoolModel
{
    public override Color LabOutlineColor => Hologirl.Color;

    public override string BigEnergyIconPath => "charui/big_energy.png".ImagePath();
    public override string TextEnergyIconPath => "charui/text_energy.png".ImagePath();
}