using BaseLib.Abstracts;
using Hologirl.HologirlCode.Extensions;
using Godot;

namespace Hologirl.HologirlCode.Character;

public class HologirlCardPool : CustomCardPoolModel
{
    public override string Title => Hologirl.CharacterId; //This is not a display name.
    
    public override string BigEnergyIconPath => "charui/big_energy.png".ImagePath();
    public override string TextEnergyIconPath => "charui/text_energy.png".ImagePath();

    public override Color ShaderColor => Hologirl.Color;
    
    //Alternatively, leave these values at 1 and provide a custom frame image.
    /*public override Texture2D CustomFrame(CustomCardModel card)
    {
        //This will attempt to load Hologirl/images/cards/frame.png
        return PreloadManager.Cache.GetTexture2D("cards/frame.png".ImagePath());
    }*/

    public override Color DeckEntryCardColor => Hologirl.Color;
    
    public override bool IsColorless => false;
}
