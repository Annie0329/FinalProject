package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Guy extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(80, 80, FlxColor.BROWN);
	}
}
