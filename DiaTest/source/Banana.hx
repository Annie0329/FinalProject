package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Banana extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(20, 20, FlxColor.YELLOW);
		immovable = true;
	}
}
