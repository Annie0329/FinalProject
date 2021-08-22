package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Banana extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(40, 40, FlxColor.YELLOW);
		immovable = true;
	}
}
