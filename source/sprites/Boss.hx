package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite
	{ private var vidaboss:Int = 50;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{ 
		super(X, Y, SimpleGraphic);
		if (FlxG.overlap(this, Personaje.bala))
		   {
			   Personaje.bala.destroy();
			   vidaboss -= 1;
			   
		   }
			if (vidaboss < 0)
			this.destroy();
	}

	public function setVida (v:Int): Void
		{
			vidaboss = v;
		}
		
		public function getVida ():Int
		{
			return vidaboss;
		}
	
}