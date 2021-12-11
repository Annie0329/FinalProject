package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

enum NpcType
{
	doge;
	ming;
	sbRed;
	sbBlue;
	sbGreen;
	monument;
	lake;
	saveStone;

	spartan;
	
	sign;
	p1;
	p2;
	p3;
}

class NPC extends FlxSprite
{
	public var type(default, null):NpcType;

	public function new(x:Float, y:Float, type:NpcType)
	{
		super(x, y);
		this.type = type;

		switch (type)
		{
			case doge:
				loadGraphic(AssetPaths.doge__png);

			case ming:
				loadGraphic(AssetPaths.sbWhite__png);
			case sbRed:
				loadGraphic(AssetPaths.sbRed__png);
			case sbBlue:
				loadGraphic(AssetPaths.sbBlue__png);
			case sbGreen:
				loadGraphic(AssetPaths.sbGreen__png);

			case monument:
				loadGraphic(AssetPaths.monument__png);
			case lake:
				makeGraphic(80, 160, FlxColor.TRANSPARENT);
			case saveStone:
				loadGraphic(AssetPaths.saveStone__png, true, 80, 80);
				animation.add("shine", [0, 1, 2, 3, 4, 5], 6, true);
			case spartan:
				loadGraphic(AssetPaths.spartan__png);

			case sign:
				makeGraphic(80, 80, FlxColor.BROWN);
			case p1:
				loadGraphic(AssetPaths.p1__png);
			case p2:
				makeGraphic(80, 80, FlxColor.BLUE);
			case p3:
				makeGraphic(80, 80, FlxColor.GREEN);
		}

		immovable = true;
	}

	// 記得要加super.update(elapsed);啊不然動畫不會跑噢
	override function update(elapsed:Float)
	{
		if (type == saveStone)
			animation.play("shine");
		super.update(elapsed);
	}
}
