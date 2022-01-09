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
	house1Sign;
	p1;
	mathChart;
	p1BaToCoMach;
	p1CoToApMach;
	p1ApToCoMach;
	house2Sign;
	p2;
	p2Mach;
	house3Sign;
	p3;
	p3Mach;
	house4Sign;
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
			case house1Sign:
				loadGraphic(AssetPaths.house1Sign__png);
			case p1:
				loadGraphic(AssetPaths.p1__png);
			case mathChart:
				makeGraphic(80, 80, FlxColor.TRANSPARENT);
			case p1BaToCoMach:
				loadGraphic(AssetPaths.p1BaToCoMach__png);
			case p1CoToApMach:
				loadGraphic(AssetPaths.p1CoToApMach__png);
			case p1ApToCoMach:
				loadGraphic(AssetPaths.p1CoToApMach__png);

			case house2Sign:
				loadGraphic(AssetPaths.house2Sign__png);
			case p2:
				loadGraphic(AssetPaths.p2__png);
			case p2Mach:
				loadGraphic(AssetPaths.p2Mach__png);
			case house3Sign:
				loadGraphic(AssetPaths.house3Sign__png);
			case p3Mach:
				loadGraphic(AssetPaths.p3Mach__png);
			case p3:
				loadGraphic(AssetPaths.p3__png);
			case house4Sign:
				loadGraphic(AssetPaths.house4Sign__png);
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
