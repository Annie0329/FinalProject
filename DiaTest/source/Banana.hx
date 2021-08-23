package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Banana extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.banana__png);
		immovable = true;
	}
}
