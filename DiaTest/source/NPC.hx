package;

import flixel.FlxSprite;

enum NpcType
{
	doge;
	ming;
	sbRed;
	sbBlue;
	sbGreen;
	monument;
}

class NPC extends FlxSprite
{
	public var type(default, null):NpcType;

	public function new(x:Float, y:Float, type:NpcType)
	{
		super(x, y);
		this.type = type;

		var graphic:String;
		switch (type)
		{
			case doge:
				graphic = AssetPaths.doge__png;

			case ming:
				graphic = AssetPaths.sbWhite__png;
			case sbRed:
				graphic = AssetPaths.sbRed__png;
			case sbBlue:
				graphic = AssetPaths.sbBlue__png;
			case sbGreen:
				graphic = AssetPaths.sbGreen__png;

			case monument:
				graphic = AssetPaths.monument__png;
		}
		loadGraphic(graphic);
		immovable = true;
	}

	override function update(elapsed:Float) {}
}
