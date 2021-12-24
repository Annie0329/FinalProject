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
	signDefi;
	signApple;
	p1;
	mathChart;
	p1BaToCoMach;
	p1CoToApMach;
	p1ApToCoMach;
	p2;
	p2Mach;
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

			case signDefi:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case signApple:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p1:
				loadGraphic(AssetPaths.p1__png);
			case mathChart:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p1BaToCoMach:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p1CoToApMach:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p1ApToCoMach:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p2:
				makeGraphic(80, 80, FlxColor.BLUE);
			case p2Mach:
				makeGraphic(80, 80, FlxColor.GRAY);
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
